Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2362ACD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 22:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjIRWaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 18:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjIRWaI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 18:30:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D363FBC
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 15:30:02 -0700 (PDT)
Received: (qmail 12972 invoked by uid 109); 18 Sep 2023 22:30:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Sep 2023 22:30:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4712 invoked by uid 111); 18 Sep 2023 22:30:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Sep 2023 18:30:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Sep 2023 18:30:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: [PATCH 2/8] fsmonitor/win32: drop unused parameters
Message-ID: <20230918223001.GB2659298@coredump.intra.peff.net>
References: <20230918222908.GA2659096@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918222908.GA2659096@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few helper functions (centered around file-watch events) take extra
fsmonitor state parameters that they don't use. These are static helpers
local to the win32 implementation, and don't need to conform to any
particular interface. We can just drop the extra parameters, which
simplifies the code and silences -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/fsmonitor/fsm-listen-win32.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index a361a7db20..90a2412284 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -289,8 +289,7 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 	SetEvent(state->listen_data->hListener[LISTENER_SHUTDOWN]);
 }
 
-static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
-				      const char *path)
+static struct one_watch *create_watch(const char *path)
 {
 	struct one_watch *watch = NULL;
 	DWORD desired_access = FILE_LIST_DIRECTORY;
@@ -361,8 +360,7 @@ static void destroy_watch(struct one_watch *watch)
 	free(watch);
 }
 
-static int start_rdcw_watch(struct fsm_listen_data *data,
-			    struct one_watch *watch)
+static int start_rdcw_watch(struct one_watch *watch)
 {
 	DWORD dwNotifyFilter =
 		FILE_NOTIFY_CHANGE_FILE_NAME |
@@ -735,11 +733,11 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 
 	state->listen_error_code = 0;
 
-	if (start_rdcw_watch(data, data->watch_worktree) == -1)
+	if (start_rdcw_watch(data->watch_worktree) == -1)
 		goto force_error_stop;
 
 	if (data->watch_gitdir &&
-	    start_rdcw_watch(data, data->watch_gitdir) == -1)
+	    start_rdcw_watch(data->watch_gitdir) == -1)
 		goto force_error_stop;
 
 	for (;;) {
@@ -755,15 +753,15 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 			}
 			if (result == -2) {
 				/* retryable error */
-				if (start_rdcw_watch(data, data->watch_worktree) == -1)
+				if (start_rdcw_watch(data->watch_worktree) == -1)
 					goto force_error_stop;
 				continue;
 			}
 
 			/* have data */
 			if (process_worktree_events(state) == LISTENER_SHUTDOWN)
 				goto force_shutdown;
-			if (start_rdcw_watch(data, data->watch_worktree) == -1)
+			if (start_rdcw_watch(data->watch_worktree) == -1)
 				goto force_error_stop;
 			continue;
 		}
@@ -776,15 +774,15 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 			}
 			if (result == -2) {
 				/* retryable error */
-				if (start_rdcw_watch(data, data->watch_gitdir) == -1)
+				if (start_rdcw_watch(data->watch_gitdir) == -1)
 					goto force_error_stop;
 				continue;
 			}
 
 			/* have data */
 			if (process_gitdir_events(state) == LISTENER_SHUTDOWN)
 				goto force_shutdown;
-			if (start_rdcw_watch(data, data->watch_gitdir) == -1)
+			if (start_rdcw_watch(data->watch_gitdir) == -1)
 				goto force_error_stop;
 			continue;
 		}
@@ -821,16 +819,14 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 
 	data->hEventShutdown = CreateEvent(NULL, TRUE, FALSE, NULL);
 
-	data->watch_worktree = create_watch(state,
-					    state->path_worktree_watch.buf);
+	data->watch_worktree = create_watch(state->path_worktree_watch.buf);
 	if (!data->watch_worktree)
 		goto failed;
 
 	check_for_shortnames(data->watch_worktree);
 
 	if (state->nr_paths_watching > 1) {
-		data->watch_gitdir = create_watch(state,
-						  state->path_gitdir_watch.buf);
+		data->watch_gitdir = create_watch(state->path_gitdir_watch.buf);
 		if (!data->watch_gitdir)
 			goto failed;
 	}
-- 
2.42.0.671.g43fbf3903a

