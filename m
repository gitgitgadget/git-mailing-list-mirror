Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D1CCD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 22:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjIRWdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 18:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRWdu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 18:33:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C164A8F
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 15:33:44 -0700 (PDT)
Received: (qmail 13118 invoked by uid 109); 18 Sep 2023 22:33:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Sep 2023 22:33:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4749 invoked by uid 111); 18 Sep 2023 22:33:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Sep 2023 18:33:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Sep 2023 18:33:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: [PATCH 8/8] run-command: mark unused parameters in start_bg_wait
 callbacks
Message-ID: <20230918223343.GH2659298@coredump.intra.peff.net>
References: <20230918222908.GA2659096@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918222908.GA2659096@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The start_bg_command() function takes a callback to tell when the
background-ed process is "ready". The callback receives the
child_process struct as well as an extra void pointer. But curiously,
neither of the two users of this interface look at either parameter!

This makes some sense. The only non-test user of the API is fsmonitor,
which uses fsmonitor_ipc__get_state() to connect to a single global
fsmonitor daemon (i.e., the one we just started!).

So we could just drop these parameters entirely. But it seems like a
pretty reasonable interface for the "wait" callback to have access to
the details of the spawned process, and to have room for passing extra
data through a void pointer. So let's leave these in place but mark the
unused ones so that -Wunused-parameter does not complain.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsmonitor--daemon.c | 3 ++-
 t/helper/test-simple-ipc.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index ce511c3ed6..5d01db5c02 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1443,7 +1443,8 @@ static int try_to_run_foreground_daemon(int detach_console MAYBE_UNUSED)
 
 static start_bg_wait_cb bg_wait_cb;
 
-static int bg_wait_cb(const struct child_process *cp, void *cb_data)
+static int bg_wait_cb(const struct child_process *cp UNUSED,
+		      void *cb_data UNUSED)
 {
 	enum ipc_active_state s = fsmonitor_ipc__get_state();
 
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 3d1436da59..941ae7e3bc 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -278,7 +278,8 @@ static int daemon__run_server(void)
 
 static start_bg_wait_cb bg_wait_cb;
 
-static int bg_wait_cb(const struct child_process *cp, void *cb_data)
+static int bg_wait_cb(const struct child_process *cp UNUSED,
+		      void *cb_data UNUSED)
 {
 	int s = ipc_get_active_state(cl_args.path);
 
-- 
2.42.0.671.g43fbf3903a
