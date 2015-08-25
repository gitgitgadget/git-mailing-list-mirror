From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] index-pack: Use the new worker pool
Date: Tue, 25 Aug 2015 10:28:25 -0700
Message-ID: <1440523706-23041-5-git-send-email-sbeller@google.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Tue Aug 25 19:28:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUI1Z-0006ce-2D
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbbHYR2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 13:28:37 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34804 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756AbbHYR2f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:28:35 -0400
Received: by pabzx8 with SMTP id zx8so39780680pab.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bilqYdzYKnHRqUl63EJUTNtblV9hKBR4pj186RzgmYI=;
        b=CcmpWI06607iil0SKtrb3gEC+s2JA5sR6FU8Tqi85eS3WembXMTNQmutQkNDd3nx83
         kGe15NVgirWiuhfHPzKhfCy1X1MdiRFVAKtHaWBpmx0hUS+VhW+azhR5axAMPddeSDNd
         oAk+ePxHYIMKvk81fvdXlYOBZ+5/7WvIKieG8Tpi7WotPC4C+zHmuafAy/S7C3oGCHAl
         W7E3WnMmhhQ9qDmDHU2JE0HgyJT0jV+Z+xzOw2A1/IaYnGzfAjds5q4VA0O7MLhzbhZ9
         uRuv33Mgzobpxi/Ti1X9T72gHZSJqQt2NuPJA3UOFAMwEDiKTBOXcS2w6gmjf5up+x2x
         cFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bilqYdzYKnHRqUl63EJUTNtblV9hKBR4pj186RzgmYI=;
        b=jLjBapw0aULjsI4pmCevd+OruPgQuwBe4eSvqZGdQbpm0D/0JB1INAnPO3xDvUIO6w
         cl2YvMxvRrjxI9eeQqBG+ixAQMF1nTgFJ5ovMeAk+cKwhH45A3LzdPxPlgEuTJNWmkUi
         HJ468KRTSNlwLlZLhQrQpSWRuNv5fceZ1jBk60al88J5deKSFzi+YpHxeWvhiXPxr+QW
         NhXvdAQgcFwvB8Yvaf0M8+KvaKnTPGtuuaW7yVjySdPZAB9M++/nkJTY6Vrvi696QOyX
         +BSJlqlsFbd8DskKMPSx54MvNyRAuBTaZqK3C2yik2FI4iXMKmo3Gu9ao8gcn5AXO+Ce
         qfmA==
X-Gm-Message-State: ALoCoQnL6xwIJvDcADN99ePC8W2AevSO7h7nq7QHtTpA9y9E7kqUYsN60HvomXrMaohySv8vfsY+
X-Received: by 10.68.247.226 with SMTP id yh2mr59453143pbc.12.1440523715162;
        Tue, 25 Aug 2015 10:28:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:ccb:1c59:dd72:7a5c])
        by smtp.gmail.com with ESMTPSA id v9sm21722567pdn.69.2015.08.25.10.28.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Aug 2015 10:28:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.400.gff86faf
In-Reply-To: <1440523706-23041-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276543>

By treating each object as its own task the workflow is easier to follow
as the function used in the worker threads doesn't need any control logic
any more.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/index-pack.c | 71 +++++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3f10840..826bd22 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -11,6 +11,7 @@
 #include "exec_cmd.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "run-command.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -95,7 +96,6 @@ static const char *curr_pack;
 #ifndef NO_PTHREADS
 
 static struct thread_local *thread_data;
-static int nr_dispatched;
 static int threads_active;
 
 static pthread_mutex_t read_mutex;
@@ -106,10 +106,6 @@ static pthread_mutex_t counter_mutex;
 #define counter_lock()		lock_mutex(&counter_mutex)
 #define counter_unlock()	unlock_mutex(&counter_mutex)
 
-static pthread_mutex_t work_mutex;
-#define work_lock()		lock_mutex(&work_mutex)
-#define work_unlock()		unlock_mutex(&work_mutex)
-
 static pthread_mutex_t deepest_delta_mutex;
 #define deepest_delta_lock()	lock_mutex(&deepest_delta_mutex)
 #define deepest_delta_unlock()	unlock_mutex(&deepest_delta_mutex)
@@ -140,7 +136,6 @@ static void init_thread(void)
 	int i;
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&counter_mutex, NULL);
-	pthread_mutex_init(&work_mutex, NULL);
 	pthread_mutex_init(&type_cas_mutex, NULL);
 	if (show_stat)
 		pthread_mutex_init(&deepest_delta_mutex, NULL);
@@ -163,7 +158,6 @@ static void cleanup_thread(void)
 	threads_active = 0;
 	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&counter_mutex);
-	pthread_mutex_destroy(&work_mutex);
 	pthread_mutex_destroy(&type_cas_mutex);
 	if (show_stat)
 		pthread_mutex_destroy(&deepest_delta_mutex);
@@ -181,9 +175,6 @@ static void cleanup_thread(void)
 #define counter_lock()
 #define counter_unlock()
 
-#define work_lock()
-#define work_unlock()
-
 #define deepest_delta_lock()
 #define deepest_delta_unlock()
 
@@ -1075,28 +1066,29 @@ static void resolve_base(struct object_entry *obj)
 }
 
 #ifndef NO_PTHREADS
-static void *threaded_second_pass(void *data)
+static int threaded_second_pass(struct task_queue *tq, void *data)
 {
-	set_thread_data(data);
-	for (;;) {
-		int i;
-		counter_lock();
-		display_progress(progress, nr_resolved_deltas);
-		counter_unlock();
-		work_lock();
-		while (nr_dispatched < nr_objects &&
-		       is_delta_type(objects[nr_dispatched].type))
-			nr_dispatched++;
-		if (nr_dispatched >= nr_objects) {
-			work_unlock();
-			break;
-		}
-		i = nr_dispatched++;
-		work_unlock();
+	if (!get_thread_data()) {
+		struct thread_local *t = xmalloc(sizeof(*t));
+		t->pack_fd = open(curr_pack, O_RDONLY);
+		if (t->pack_fd == -1)
+			die_errno(_("unable to open %s"), curr_pack);
 
-		resolve_base(&objects[i]);
+		set_thread_data(t);
 	}
-	return NULL;
+
+	resolve_base(data);
+
+	counter_lock();
+	display_progress(progress, nr_resolved_deltas);
+	counter_unlock();
+	return 0;
+}
+
+void cleanup_threaded_second_pass(struct task_queue *aq)
+{
+	struct thread_local *t = get_thread_data();
+	free(t);
 }
 #endif
 
@@ -1195,18 +1187,19 @@ static void resolve_deltas(void)
 					  nr_ref_deltas + nr_ofs_deltas);
 
 #ifndef NO_PTHREADS
-	nr_dispatched = 0;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
+		struct task_queue *tq;
+
 		init_thread();
-		for (i = 0; i < nr_threads; i++) {
-			int ret = pthread_create(&thread_data[i].thread, NULL,
-						 threaded_second_pass, thread_data + i);
-			if (ret)
-				die(_("unable to create thread: %s"),
-				    strerror(ret));
-		}
-		for (i = 0; i < nr_threads; i++)
-			pthread_join(thread_data[i].thread, NULL);
+		tq = create_task_queue(nr_threads);
+
+		for (i = 0; i < nr_objects; i++)
+			if (!is_delta_type(objects[i].type))
+				add_task(tq, threaded_second_pass, &objects[i]);
+
+		if (finish_task_queue(tq, cleanup_threaded_second_pass))
+			die("Not all threads have finished");
+
 		cleanup_thread();
 		return;
 	}
-- 
2.5.0.400.gff86faf
