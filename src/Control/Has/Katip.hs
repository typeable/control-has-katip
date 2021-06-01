{-# LANGUAGE CPP #-}
{-# OPTIONS -Wno-orphans #-}
module Control.Has.Katip where

#ifndef ghcjs_HOST_OS

import           Control.EnvT
import           Control.Has
import           Control.Lens
import           Katip
import           Katip.Monadic

makeLensesFor
  [ ("ltsLogEnv", "_ltsLogEnv")
  , ("ltsContext", "_ltsContext")
  , ("ltsNamespace", "_ltsNamespace")
  ] ''KatipContextTState

instance (Has KatipContextTState r, MonadIO m)
  => KatipContext (EnvT r m) where
  getKatipContext = view $ part . _ltsContext
  localKatipContext f = local (part . _ltsContext %~ f)
  getKatipNamespace = view $ part . _ltsNamespace
  localKatipNamespace f = local (part . _ltsNamespace %~ f)

instance (Has KatipContextTState r, MonadIO m)
  => Katip (EnvT r m) where
  getLogEnv = view $ part . _ltsLogEnv
  localLogEnv f = local (part . _ltsLogEnv %~ f)

#endif
