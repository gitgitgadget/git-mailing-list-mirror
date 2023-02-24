Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187CFC61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBXGk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBXGkA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:40:00 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A065D63540
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:47 -0800 (PST)
Received: (qmail 3713 invoked by uid 109); 24 Feb 2023 06:39:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31137 invoked by uid 111); 24 Feb 2023 06:39:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:46 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 20/21] run_processes_parallel: mark unused callback parameters
Message-ID: <Y/hbssWC1mtAZN4j@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our parallel process API takes several callbacks via function pointers
in the run_process_paralell_opts struct. Not every callback needs every
parameter; let's mark the unused ones to make -Wunused-parameter happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c             |  6 ++++--
 builtin/submodule--helper.c |  4 ++--
 hook.c                      | 12 ++++++------
 submodule.c                 |  4 ++--
 t/helper/test-run-command.c | 14 +++++++-------
 5 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a21ce89312..c6b1845429 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1890,7 +1890,8 @@ struct parallel_fetch_state {
 	int next, result;
 };
 
-static int fetch_next_remote(struct child_process *cp, struct strbuf *out,
+static int fetch_next_remote(struct child_process *cp,
+			     struct strbuf *out UNUSED,
 			     void *cb, void **task_cb)
 {
 	struct parallel_fetch_state *state = cb;
@@ -1912,7 +1913,8 @@ static int fetch_next_remote(struct child_process *cp, struct strbuf *out,
 	return 1;
 }
 
-static int fetch_failed_to_start(struct strbuf *out, void *cb, void *task_cb)
+static int fetch_failed_to_start(struct strbuf *out UNUSED,
+				 void *cb, void *task_cb)
 {
 	struct parallel_fetch_state *state = cb;
 	const char *remote = task_cb;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4c173d8b37..ad272a0d93 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2132,9 +2132,9 @@ static int update_clone_get_next_task(struct child_process *child,
 	return 0;
 }
 
-static int update_clone_start_failure(struct strbuf *err,
+static int update_clone_start_failure(struct strbuf *err UNUSED,
 				      void *suc_cb,
-				      void *idx_task_cb)
+				      void *idx_task_cb UNUSED)
 {
 	struct submodule_update_clone *suc = suc_cb;
 
diff --git a/hook.c b/hook.c
index 1a84831863..866ef0408b 100644
--- a/hook.c
+++ b/hook.c
@@ -43,9 +43,9 @@ int hook_exists(const char *name)
 }
 
 static int pick_next_hook(struct child_process *cp,
-			  struct strbuf *out,
+			  struct strbuf *out UNUSED,
 			  void *pp_cb,
-			  void **pp_task_cb)
+			  void **pp_task_cb UNUSED)
 {
 	struct hook_cb_data *hook_cb = pp_cb;
 	const char *hook_path = hook_cb->hook_path;
@@ -77,9 +77,9 @@ static int pick_next_hook(struct child_process *cp,
 	return 1;
 }
 
-static int notify_start_failure(struct strbuf *out,
+static int notify_start_failure(struct strbuf *out UNUSED,
 				void *pp_cb,
-				void *pp_task_cp)
+				void *pp_task_cp UNUSED)
 {
 	struct hook_cb_data *hook_cb = pp_cb;
 
@@ -89,9 +89,9 @@ static int notify_start_failure(struct strbuf *out,
 }
 
 static int notify_hook_finished(int result,
-				struct strbuf *out,
+				struct strbuf *out UNUSED,
 				void *pp_cb,
-				void *pp_task_cb)
+				void *pp_task_cb UNUSED)
 {
 	struct hook_cb_data *hook_cb = pp_cb;
 	struct run_hooks_opt *opt = hook_cb->options;
diff --git a/submodule.c b/submodule.c
index 3a0dfc417c..a24269db71 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1739,7 +1739,7 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 	return 0;
 }
 
-static int fetch_start_failure(struct strbuf *err,
+static int fetch_start_failure(struct strbuf *err UNUSED,
 			       void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
@@ -1760,7 +1760,7 @@ static int commit_missing_in_sub(const struct object_id *oid, void *data)
 	return type != OBJ_COMMIT;
 }
 
-static int fetch_finish(int retvalue, struct strbuf *err,
+static int fetch_finish(int retvalue, struct strbuf *err UNUSED,
 			void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 3ecb830f4a..98fa224640 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -24,7 +24,7 @@ static int number_callbacks;
 static int parallel_next(struct child_process *cp,
 			 struct strbuf *err,
 			 void *cb,
-			 void **task_cb)
+			 void **task_cb UNUSED)
 {
 	struct child_process *d = cb;
 	if (number_callbacks >= 4)
@@ -40,10 +40,10 @@ static int parallel_next(struct child_process *cp,
 	return 1;
 }
 
-static int no_job(struct child_process *cp,
+static int no_job(struct child_process *cp UNUSED,
 		  struct strbuf *err,
-		  void *cb,
-		  void **task_cb)
+		  void *cb UNUSED,
+		  void **task_cb UNUSED)
 {
 	if (err)
 		strbuf_addstr(err, "no further jobs available\n");
@@ -52,10 +52,10 @@ static int no_job(struct child_process *cp,
 	return 0;
 }
 
-static int task_finished(int result,
+static int task_finished(int result UNUSED,
 			 struct strbuf *err,
-			 void *pp_cb,
-			 void *pp_task_cb)
+			 void *pp_cb UNUSED,
+			 void *pp_task_cb UNUSED)
 {
 	if (err)
 		strbuf_addstr(err, "asking for a quick stop\n");
-- 
2.39.2.981.g6157336f25

