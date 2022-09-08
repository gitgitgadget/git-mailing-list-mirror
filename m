Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E199ECAAD5
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 05:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIHFaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 01:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIHFaB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 01:30:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFB22CE38
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 22:29:59 -0700 (PDT)
Received: (qmail 24687 invoked by uid 109); 8 Sep 2022 05:30:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 05:30:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18090 invoked by uid 111); 8 Sep 2022 05:30:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 01:30:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 01:29:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: LSan curiosity in t1300
Message-ID: <Yxl91jfycCo7O7Pp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I run:

  make SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true CFLAGS=-O0

locally, then all tests pass or are skipped. But if switch to -O2, then
t1300 starts failing!

The command that supposedly leaks is this:

  git --config-env=foo.flag= config --bool foo.flag

and the backtrace looks like:

  Direct leak of 9 byte(s) in 1 object(s) allocated from:
      #0 0x56195ae6dc62 in __interceptor_malloc (git+0x78c62) (BuildId: a5cfeb484fd14b6120fa26ff364fa2313fd23168)
      #1 0x56195b0ad6b6 in do_xmalloc wrapper.c
      #2 0x56195b0ad7bd in xmemdupz (git+0x2b87bd) (BuildId: a5cfeb484fd14b6120fa26ff364fa2313fd23168)
      #3 0x56195af6f8d0 in git_config_push_env (git+0x17a8d0) (BuildId: a5cfeb484fd14b6120fa26ff364fa2313fd23168)
      #4 0x56195ae71689 in handle_options git.c
      #5 0x56195ae7060f in cmd_main (git+0x7b60f) (BuildId: a5cfeb484fd14b6120fa26ff364fa2313fd23168)
      #6 0x56195af370c6 in main (git+0x1420c6) (BuildId: a5cfeb484fd14b6120fa26ff364fa2313fd23168)
      #7 0x7f45b9029209 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
      #8 0x7f45b90292bb in __libc_start_main csu/../csu/libc-start.c:389:3
      #9 0x56195ae420c0 in _start (git+0x4d0c0) (BuildId: a5cfeb484fd14b6120fa26ff364fa2313fd23168)

But here's the weird part. The function looks like this:

  void git_config_push_env(const char *spec)
  {
          char *key;
          const char *env_name;
          const char *env_value;
  
          env_name = strrchr(spec, '=');
          if (!env_name)
                  die(_("invalid config format: %s"), spec);
          key = xmemdupz(spec, env_name - spec);
          env_name++;
          if (!*env_name)
                  die(_("missing environment variable name for configuration '%.*s'"),
                      (int)(env_name - spec - 1), spec);
  
          env_value = getenv(env_name);
          if (!env_value)
                  die(_("missing environment variable '%s' for configuration '%.*s'"),
                      env_name, (int)(env_name - spec - 1), spec);
  
          git_config_push_split_parameter(key, env_value);
          free(key);
  }

And it is complaining that we've leaked "key". But as you can see, we
always free it. The problem is that for this particular invocation we
die("missing environment variable name"), so of course we don't make it
to the free(). Normally this is OK, though. The "key" variable is still
on the stack, so the leak-checker should realize that it's still
reachable.

But if you run this in a debugger, you'll find that under -O2 the "key"
variable has been optimized out! So LSan is producing the wrong result
due to the optimization. It doesn't know that "key" is conceptually
still reachable.

Maybe this is a known problem, but it was certainly surprising to me.
I'm not sure if we should do anything about it or not. It doesn't seem
to trigger in CI, even though I don't see us taking any steps there to
use -O0 or similar. So we can perhaps ignore it for now, and this
message can serve as a warning. But if we think LSan isn't reliable
under higher optimizations, we could perhaps teach the Makefile to
prefer -O0 when it sees SANITIZE=leak.

-Peff
