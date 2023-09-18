Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0F4C46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 22:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjIRWb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 18:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjIRWbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 18:31:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E59F8F
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 15:31:49 -0700 (PDT)
Received: (qmail 13027 invoked by uid 109); 18 Sep 2023 22:31:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Sep 2023 22:31:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4718 invoked by uid 111); 18 Sep 2023 22:31:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Sep 2023 18:31:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Sep 2023 18:31:48 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: [PATCH 3/8] fsmonitor: mark some maybe-unused parameters
Message-ID: <20230918223148.GC2659298@coredump.intra.peff.net>
References: <20230918222908.GA2659096@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918222908.GA2659096@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a bit of conditionally-compiled code in fsmonitor, so some
function parameters may be unused depending on the build options:

  - in fsmonitor--daemon.c's try_to_run_foreground_daemon(), we take a
    detach_console argument, but it's only used on Windows. This seems
    intentional (and not mistakenly missing other platforms) based on
    the discussion in c284e27ba7 (fsmonitor--daemon: implement 'start'
    command, 2022-03-25), which introduced it.

  - in fsmonitor-setting.c's check_for_incompatible(), we pass the "ipc"
    flag down to the system-specific fsm_os__incompatible() helper. But
    we can only do so if our platform has such a helper.

In both cases we can mark the argument as MAYBE_UNUSED. That annotates
it enough to suppress the compiler's -Wunused-parameter warning, but
without making it impossible to use the variable, as a regular UNUSED
annotation would.

Signed-off-by: Jeff King <peff@peff.net>
---
For a similar case in 2c3c3d88fc (imap-send: mark unused parameters with
NO_OPENSSL, 2023-08-29), I used the old:

  (void)some_parameter_that_might_not_be_used;

trick. But I realized while writing this one that MAYBE_UNUSED fits the
bill a little more nicely, and I don't see any reason we would have
portability problems with it.

 builtin/fsmonitor--daemon.c | 2 +-
 fsmonitor-settings.c        | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 7e99c4d61b..7c4130c981 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1412,7 +1412,7 @@ static int fsmonitor_run_daemon(void)
 	return err;
 }
 
-static int try_to_run_foreground_daemon(int detach_console)
+static int try_to_run_foreground_daemon(int detach_console MAYBE_UNUSED)
 {
 	/*
 	 * Technically, we don't need to probe for an existing daemon
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index b62acf44ae..a6a9e6bc19 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -62,7 +62,8 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 }
 #endif
 
-static enum fsmonitor_reason check_for_incompatible(struct repository *r, int ipc)
+static enum fsmonitor_reason check_for_incompatible(struct repository *r,
+						    int ipc MAYBE_UNUSED)
 {
 	if (!r->worktree) {
 		/*
-- 
2.42.0.671.g43fbf3903a

