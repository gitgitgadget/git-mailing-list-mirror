From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] run-command: do not pass child process data into callbacks
Date: Tue,  1 Mar 2016 09:55:26 -0800
Message-ID: <1456854926-13838-1-git-send-email-sbeller@google.com>
References: <xmqqd1re856r.fsf@gitster.mtv.corp.google.com>
Cc: Stefan Beller <sbeller@google.com>
To: j6t@kdbg.org, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 18:55:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaoWF-0006q7-7o
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 18:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbcCARzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 12:55:31 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35747 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbcCARza (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 12:55:30 -0500
Received: by mail-pa0-f47.google.com with SMTP id bj10so47104037pad.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 09:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SLr5PFkf5/YtU1yrnb+BqAo+STP6/ZyziiDKpK6XxP4=;
        b=HLBF7kyejBy2sZPRz45h9kwnG+SN/m8iB3FJVCNYUqF8zpxcY6zGc8hBUKUeeAfjwb
         9BIpqXNyxQ1wfHJ8brobe1Rx+C+gwjuYS8fknTvUQ37V5DkvyoUSM2n3ZSUMArf2MhaH
         xLweXshgIxTQ1Vcm6DE53hF96kUpJCQIvWS7KHxzy2Wbu2Y+rXfnnytX8nxYRoQUmQ9c
         jKDolkZTHGTlfdUs0tBIeIyVFC7cAFD+DyKKsqmYgpdl7obJPr3EMnxONHK/k4X43EXV
         1vbwyE5YxRp/bse2HEMoRMLc+FqHBH5TLzDBHqJnoIgjZMPiLu/wLhpzdWuxmMK7p39I
         GwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SLr5PFkf5/YtU1yrnb+BqAo+STP6/ZyziiDKpK6XxP4=;
        b=aJalc+W7s7SEdlg5kGZULdLyee/8dX+yzsbJUE32WmwDPl9p2zyQ/sdGnxXuxmH8P4
         VJPNDgkNZSA+5MK+TuaSn7/rKHg2fd04MUMtUUkV5RYy+X24G6r3G+BTmPdkujO7e0R4
         ix+/O/PBFlNtSS7L/hcplcAAGYttL9G8w75pSdtQDv1XWJswVYXt5wCMQFTw/HrKbQN2
         Mh/ya0zcMQWhR0w0dsTlp8xIpNJd9gLUJqQOV93mZIN+a06us28kwHxLe4Fp5shuraPW
         nBs2jwN4OhzaCQiGYjkowmYJsS0bD+QWHDk2/M7gxFbz9ig1jPHPclwWqRSMJgnuXrYA
         y0cQ==
X-Gm-Message-State: AD7BkJIyVMJnxiIA50QQ4qemtJDY1pNEXBx1j6p1P09x1EC/ZL5fx6uxgZWjkO+oKAubTEdj
X-Received: by 10.66.90.136 with SMTP id bw8mr31850241pab.52.1456854929276;
        Tue, 01 Mar 2016 09:55:29 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:81bf:e731:7a4d:b983])
        by smtp.gmail.com with ESMTPSA id cq4sm47099998pad.28.2016.03.01.09.55.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 09:55:28 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g68b4e3f
In-Reply-To: <xmqqd1re856r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288046>

The expected way to pass data into the callback is to pass them via
the customizable callback pointer. The error reporting in
default_{start_failure, task_finished} is not user friendly enough, that
we want to encourage using the child data for such purposes.

Furthermore the struct child data is cleaned by the run-command API,
before we access them in the callbacks, leading to use-after-free
situations.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Thanks Johannes for reviewing and double checking. I squashed in your
 proposed documentation change.
 
 This applies on 2.8.0-rc0.
 
 Thanks,
 Stefan

 run-command.c      | 24 +++---------------------
 run-command.h      |  9 +++------
 submodule.c        |  7 +++----
 test-run-command.c |  1 -
 4 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/run-command.c b/run-command.c
index 51fd72c..8e3ad07 100644
--- a/run-command.c
+++ b/run-command.c
@@ -902,35 +902,18 @@ struct parallel_processes {
 	struct strbuf buffered_output; /* of finished children */
 };
 
-static int default_start_failure(struct child_process *cp,
-				 struct strbuf *err,
+static int default_start_failure(struct strbuf *err,
 				 void *pp_cb,
 				 void *pp_task_cb)
 {
-	int i;
-
-	strbuf_addstr(err, "Starting a child failed:");
-	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(err, " %s", cp->argv[i]);
-
 	return 0;
 }
 
 static int default_task_finished(int result,
-				 struct child_process *cp,
 				 struct strbuf *err,
 				 void *pp_cb,
 				 void *pp_task_cb)
 {
-	int i;
-
-	if (!result)
-		return 0;
-
-	strbuf_addf(err, "A child failed with return code %d:", result);
-	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(err, " %s", cp->argv[i]);
-
 	return 0;
 }
 
@@ -1048,8 +1031,7 @@ static int pp_start_one(struct parallel_processes *pp)
 	pp->children[i].process.no_stdin = 1;
 
 	if (start_command(&pp->children[i].process)) {
-		code = pp->start_failure(&pp->children[i].process,
-					 &pp->children[i].err,
+		code = pp->start_failure(&pp->children[i].err,
 					 pp->data,
 					 &pp->children[i].data);
 		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
@@ -1117,7 +1099,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 
 		code = finish_command(&pp->children[i].process);
 
-		code = pp->task_finished(code, &pp->children[i].process,
+		code = pp->task_finished(code,
 					 &pp->children[i].err, pp->data,
 					 &pp->children[i].data);
 
diff --git a/run-command.h b/run-command.h
index d5a57f9..6e17894 100644
--- a/run-command.h
+++ b/run-command.h
@@ -158,8 +158,7 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
  * To send a signal to other child processes for abortion, return
  * the negative signal number.
  */
-typedef int (*start_failure_fn)(struct child_process *cp,
-				struct strbuf *err,
+typedef int (*start_failure_fn)(struct strbuf *err,
 				void *pp_cb,
 				void *pp_task_cb);
 
@@ -178,7 +177,6 @@ typedef int (*start_failure_fn)(struct child_process *cp,
  * the negative signal number.
  */
 typedef int (*task_finished_fn)(int result,
-				struct child_process *cp,
 				struct strbuf *err,
 				void *pp_cb,
 				void *pp_task_cb);
@@ -192,9 +190,8 @@ typedef int (*task_finished_fn)(int result,
  * (both stdout and stderr) is routed to stderr in a manner that output
  * from different tasks does not interleave.
  *
- * If start_failure_fn or task_finished_fn are NULL, default handlers
- * will be used. The default handlers will print an error message on
- * error without issuing an emergency stop.
+ * start_failure_fn and task_finished_fn can be NULL to omit any
+ * special handling.
  */
 int run_processes_parallel(int n,
 			   get_next_task_fn,
diff --git a/submodule.c b/submodule.c
index b83939c..916fc84 100644
--- a/submodule.c
+++ b/submodule.c
@@ -705,8 +705,7 @@ static int get_next_submodule(struct child_process *cp,
 	return 0;
 }
 
-static int fetch_start_failure(struct child_process *cp,
-			       struct strbuf *err,
+static int fetch_start_failure(struct strbuf *err,
 			       void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
@@ -716,8 +715,8 @@ static int fetch_start_failure(struct child_process *cp,
 	return 0;
 }
 
-static int fetch_finish(int retvalue, struct child_process *cp,
-			struct strbuf *err, void *cb, void *task_cb)
+static int fetch_finish(int retvalue, struct strbuf *err,
+			void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
 
diff --git a/test-run-command.c b/test-run-command.c
index fbe0a27..30a64a9 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -41,7 +41,6 @@ static int no_job(struct child_process *cp,
 }
 
 static int task_finished(int result,
-			 struct child_process *cp,
 			 struct strbuf *err,
 			 void *pp_cb,
 			 void *pp_task_cb)
-- 
2.8.0.rc0.1.g68b4e3f
