From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] run-command: do not pass child process data into callbacks
Date: Mon, 29 Feb 2016 13:57:06 -0800
Message-ID: <1456783026-3328-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 29 22:57:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVod-0004V8-35
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbcB2V5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:57:13 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33377 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbcB2V5K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:57:10 -0500
Received: by mail-pf0-f169.google.com with SMTP id 124so37689935pfg.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 13:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Hk4Tmn4T2sqxGjjvKhoYZ4RLRnRTuLMaFa0UvBC13sU=;
        b=IaWgZ2CyZnDL0RoZcL2XTuAwG652HUZjldAjr+1TozeXHmnufM0g9gqSXIJEEBwu+D
         stBUjRGNcuc2D3DBh0nHLog9WCcEfVrvSIvoKNmxYVwU/mGf1kbeuUgfLGqoEvsWA3Vg
         apSGxOTjh8FlauQadJyhwSSySngs5MZfT9SxdzNm8ThLjTDKDJqg+YJzibe2iyffl6G0
         AFIy4SkyiJyrCMzUxzlJ4FcaZBbI9P6khzznPDKX3VC7ZicdqMERnhcHIgYjY+wYn+Ae
         uNrb8kxtCVeRjpgVtfJcdMKpuWovxKV2nuGwHW07VkbddylQwDYer+NB++0EpLMY2eUA
         Gyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hk4Tmn4T2sqxGjjvKhoYZ4RLRnRTuLMaFa0UvBC13sU=;
        b=TB4fOav49mm82keBlunOKmLAAn6EoRf+sqKfhhZQbL6Pcq8peAohUJWvgrltPJyJMX
         z3XWFCo2go0VHH+HxhVOhrR0M+UoGwYn/eXUOqbxSmXZiVQ/Nyf/Ha17f12tUplIFW3a
         YaaaCd8oL3/oCqgGAqTh+oxvEeN1JUt62ESus04/kjuLlUOwVFEEHnYcnuX9hqUdl4LE
         8vZEERAH4osHSWF4mZmw7HHYpk/6VCt+bPNAnDv3ZdXNsggW2zYJDOd18YGDhbokHtnI
         w1NdD28Wvcg7+unTCMt0ANX2be8ciYopXYBc2xx1ezG/LDpasyah/7+X5/Rijhiy8z3m
         IIAw==
X-Gm-Message-State: AD7BkJIG5QHUXJfG+VmAEeEsqsN3cG0qyZMrHxBDR3tEWNZZVQjToUv57blmungHCjE0Pn8D
X-Received: by 10.98.69.1 with SMTP id s1mr25275151pfa.120.1456783029880;
        Mon, 29 Feb 2016 13:57:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id r87sm40275501pfa.61.2016.02.29.13.57.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 13:57:09 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g68b4e3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287915>

The expected way to pass data into the callback is to pass them via
the customizable callback pointer. The error reporting in
default_{start_failure, task_finished} is not user friendly enough, that
we want to encourage using the child data for such purposes.

Furthermore the struct child data is cleaned by the run-command API,
before we access them in the callbacks, leading to use-after-free
situations.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This is the proper fix to not access memory after freeing.

 run-command.c      | 24 +++---------------------
 run-command.h      |  4 +---
 submodule.c        |  7 +++----
 test-run-command.c |  1 -
 4 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/run-command.c b/run-command.c
index 863dad5..c726010 100644
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
index 42917e8..c6a3e42 100644
--- a/run-command.h
+++ b/run-command.h
@@ -159,8 +159,7 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
  * To send a signal to other child processes for abortion, return
  * the negative signal number.
  */
-typedef int (*start_failure_fn)(struct child_process *cp,
-				struct strbuf *err,
+typedef int (*start_failure_fn)(struct strbuf *err,
 				void *pp_cb,
 				void *pp_task_cb);
 
@@ -179,7 +178,6 @@ typedef int (*start_failure_fn)(struct child_process *cp,
  * the negative signal number.
  */
 typedef int (*task_finished_fn)(int result,
-				struct child_process *cp,
 				struct strbuf *err,
 				void *pp_cb,
 				void *pp_task_cb);
diff --git a/submodule.c b/submodule.c
index 24fb81a..62c4356 100644
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
