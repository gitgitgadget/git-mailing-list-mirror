Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050E51F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 16:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935153AbcIVQ4R (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 12:56:17 -0400
Received: from avasout02.plus.net ([212.159.14.17]:39176 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935051AbcIVQ4P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 12:56:15 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout02 with smtp
        id mgw61t00B0zhorE01gw77o; Thu, 22 Sep 2016 17:56:08 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=G/5eKJs5 c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=GAj3AVI_n7FsPzfEt7YA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] run-command: async_exit no longer needs to be public
Message-ID: <78f2bdd0-f6ad-db5c-f9f2-f90528bc4f77@ramsayjones.plus.com>
Date:   Thu, 22 Sep 2016 17:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Lars,

If you need to re-roll your 'ls/filter-process' branch, could you please
squash this into the relevant commit c42a4cbc ("run-command: move check_pipe()
from write_or_die to run_command", 20-09-2016).

[Note that commit 9658846c ("write_or_die: handle EPIPE in async threads",
24-02-2016) introduced async_exit() specifically for use in the implementation
of check_pipe(). Now that you have moved check_pipe() into run-command.c,
it no longer needs to be public.]

Thanks!

ATB,
Ramsay Jones

 run-command.c | 30 +++++++++++++++---------------
 run-command.h |  3 +--
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/run-command.c b/run-command.c
index b72f6d1..3269362 100644
--- a/run-command.c
+++ b/run-command.c
@@ -6,19 +6,6 @@
 #include "thread-utils.h"
 #include "strbuf.h"
 
-void check_pipe(int err)
-{
-	if (err == EPIPE) {
-		if (in_async())
-			async_exit(141);
-
-		signal(SIGPIPE, SIG_DFL);
-		raise(SIGPIPE);
-		/* Should never happen, but just in case... */
-		exit(141);
-	}
-}
-
 void child_process_init(struct child_process *child)
 {
 	memset(child, 0, sizeof(*child));
@@ -647,7 +634,7 @@ int in_async(void)
 	return !pthread_equal(main_thread, pthread_self());
 }
 
-void NORETURN async_exit(int code)
+static void NORETURN async_exit(int code)
 {
 	pthread_exit((void *)(intptr_t)code);
 }
@@ -697,13 +684,26 @@ int in_async(void)
 	return process_is_async;
 }
 
-void NORETURN async_exit(int code)
+static void NORETURN async_exit(int code)
 {
 	exit(code);
 }
 
 #endif
 
+void check_pipe(int err)
+{
+	if (err == EPIPE) {
+		if (in_async())
+			async_exit(141);
+
+		signal(SIGPIPE, SIG_DFL);
+		raise(SIGPIPE);
+		/* Should never happen, but just in case... */
+		exit(141);
+	}
+}
+
 int start_async(struct async *async)
 {
 	int need_in, need_out;
diff --git a/run-command.h b/run-command.h
index e7c5f71..bb89c30 100644
--- a/run-command.h
+++ b/run-command.h
@@ -54,7 +54,6 @@ int finish_command(struct child_process *);
 int finish_command_in_signal(struct child_process *);
 int run_command(struct child_process *);
 
-void check_pipe(int err);
 
 /*
  * Returns the path to the hook file, or NULL if the hook is missing
@@ -141,7 +140,7 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 int in_async(void);
-void NORETURN async_exit(int code);
+void check_pipe(int err);
 
 /**
  * This callback should initialize the child process and preload the
-- 
2.10.0
