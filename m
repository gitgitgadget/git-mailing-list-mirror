From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv16 0/7] Expose submodule parallelism to the user
Date: Wed, 24 Feb 2016 17:41:58 -0800
Message-ID: <1456364525-21190-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 02:42:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYkwa-0000DG-5q
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 02:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbcBYBmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 20:42:10 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35657 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbcBYBmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 20:42:09 -0500
Received: by mail-pf0-f172.google.com with SMTP id c10so23915180pfc.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 17:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0M4cuO4XUkifQm0te5V/Ay2LgQxU+/2oxCDQXUZjeCY=;
        b=Zd/KhQdpNBU9A9EMqj8PRjFdm1xlObd9FBXvQCB9sQAyr1p6i1R15LuLox6shN9sVb
         XljtB7cItEAc19BSpWNrSUWfC+fxAgIqdpVUE8mPy6SFQv/0GlMFXjt+ZQgrYUIVSkDq
         eqdPj0y/NkThgoNKRrsvnaSqX+BxGCiFMIbZ+HoXe9zHeuwzT8i+ry8Pj5ab0+yVWYfX
         RMgiyz2n8yNnH1AadNrVfkxHmnvmt4w95Ojp4xDOZ+XcWHHQAFrIdArtyoM8O4wIRHMa
         a3n5yMomZVv4+c5arjyTv+ILPfSMj7ECSpujXHj8RJ6RCgc3CNzOVBRABokmyeYpDlo8
         zQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0M4cuO4XUkifQm0te5V/Ay2LgQxU+/2oxCDQXUZjeCY=;
        b=NEl+ynafPKthEU0sKaMl0X3OlT7WQ5R24RVnPnMf3V5khYJJqHJ+XoXcIf4E1Edq3d
         ptjQqLLXDVPDfeOxQ2vLoXXwft4qZm3TpXv985F0qFGqREC/JH0FqVB0OGkWYAnaUMS6
         0hDE/vYbEy+/8UnXLhWsjQnorUNZmU1So9yYntPEyTD1QsyJU27I4EO2A42Wg3dltXaL
         VARYBn8q3FQ+ukf0j8XBTtoD4imuh2ZReg0NAI+N1JEXC/xOt/UB6wu/f/P/qiXz+fiw
         diHZ8sH+SXJnYf/ZIy31NdZxqXOw9Sm8y1AGEUSfWlgR6PLBWUctA7nE3n+9vkzSf7K7
         OFhQ==
X-Gm-Message-State: AG10YOQr34NtyIlOGkF3r41VZEPQ9iXQOy1cQtKFUL7VyDZK/Bw7Dzn8D4jjumYmLsPVxpiv
X-Received: by 10.98.89.139 with SMTP id k11mr11007306pfj.56.1456364528351;
        Wed, 24 Feb 2016 17:42:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id 3sm7704025pfn.59.2016.02.24.17.42.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 17:42:07 -0800 (PST)
X-Mailer: git-send-email 2.7.2.335.g3f96d05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287304>

This build on top of 163b9b1f919c762a4bfb693b3aa05ef1aa627fee
(origin/sb/submodule-parallel-update~5) and replace the series from there on.

Thanks Jonathan and Junio for discussion!

* instead of sophisticatedly adding \n's, require the callbacks to be sane.
* rename strbuf 'err' to 'out'.
* no changes to the largest patch of introducing a submodule--helper for cloning

Thanks,
Stefan

Interdiff to v15:
diff --git a/run-command.c b/run-command.c
index 8abaae4..6fad42f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -897,29 +897,29 @@ struct parallel_processes {
 	struct pollfd *pfd;
 
 	unsigned shutdown : 1;
-	unsigned ended_with_newline: 1;
 
 	int output_owner;
 	struct strbuf buffered_output; /* of finished children */
 };
 
 int default_start_failure(struct child_process *cp,
-			  struct strbuf *err,
+			  struct strbuf *out,
 			  void *pp_cb,
 			  void *pp_task_cb)
 {
 	int i;
 
-	strbuf_addstr(err, "Starting a child failed:");
+	strbuf_addstr(out, "Starting a child failed:");
 	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(err, " %s", cp->argv[i]);
+		strbuf_addf(out, " %s", cp->argv[i]);
+	strbuf_addch(out, '\n');
 
 	return 0;
 }
 
 int default_task_finished(int result,
 			  struct child_process *cp,
-			  struct strbuf *err,
+			  struct strbuf *out,
 			  void *pp_cb,
 			  void *pp_task_cb)
 {
@@ -928,9 +928,10 @@ int default_task_finished(int result,
 	if (!result)
 		return 0;
 
-	strbuf_addf(err, "A child failed with return code %d:", result);
+	strbuf_addf(out, "A child failed with return code %d:", result);
 	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(err, " %s", cp->argv[i]);
+		strbuf_addf(out, " %s", cp->argv[i]);
+	strbuf_addch(out, '\n');
 
 	return 0;
 }
@@ -980,7 +981,6 @@ static void pp_init(struct parallel_processes *pp,
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
 	pp->shutdown = 0;
-	pp->ended_with_newline = 1;
 	pp->children = xcalloc(n, sizeof(*pp->children));
 	pp->pfd = xcalloc(n, sizeof(*pp->pfd));
 	strbuf_init(&pp->buffered_output, 0);
@@ -1013,7 +1013,7 @@ static void pp_cleanup(struct parallel_processes *pp)
 	 * When get_next_task added messages to the buffer in its last
 	 * iteration, the buffered output is non empty.
 	 */
-	fputs(pp->buffered_output.buf, stderr);
+	strbuf_write(&pp->buffered_output, stderr);
 	strbuf_release(&pp->buffered_output);
 
 	sigchain_pop_common();
@@ -1055,7 +1055,6 @@ static int pp_start_one(struct parallel_processes *pp)
 					 pp->data,
 					 &pp->children[i].data);
 		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
-		strbuf_addch(&pp->buffered_output, '\n');
 		strbuf_reset(&pp->children[i].err);
 		if (code)
 			pp->shutdown = 1;
@@ -1098,11 +1097,9 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 static void pp_output(struct parallel_processes *pp)
 {
 	int i = pp->output_owner;
-	size_t len = pp->children[i].err.len;
-	if (pp->children[i].state == GIT_CP_WORKING && len) {
-		fputs(pp->children[i].err.buf, stderr);
-		pp->ended_with_newline =
-			(pp->children[i].err.buf[len - 1] == '\n');
+	if (pp->children[i].state == GIT_CP_WORKING &&
+	    pp->children[i].err.len) {
+		strbuf_write(&pp->children[i].err, stderr);
 		strbuf_reset(&pp->children[i].err);
 	}
 }
@@ -1112,7 +1109,6 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	int i, code;
 	int n = pp->max_processes;
 	int result = 0;
-	ssize_t len;
 
 	while (pp->nr_processes > 0) {
 		for (i = 0; i < pp->max_processes; i++)
@@ -1137,22 +1133,15 @@ static int pp_collect_finished(struct parallel_processes *pp)
 		pp->pfd[i].fd = -1;
 		child_process_init(&pp->children[i].process);
 
-		len = pp->children[i].err.len - 1;
-		if (len >= 0 && pp->children[i].err.buf[len] != '\n')
-			strbuf_addch(&pp->children[i].err, '\n');
-
 		if (i != pp->output_owner) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		} else {
-			if (len == -1 && !pp->ended_with_newline)
-				strbuf_addch(&pp->children[i].err, '\n');
-			fputs(pp->children[i].err.buf, stderr);
+			strbuf_write(&pp->children[i].err, stderr);
 			strbuf_reset(&pp->children[i].err);
-			pp->ended_with_newline = 1;
 
 			/* Output all other finished child processes */
-			fputs(pp->buffered_output.buf, stderr);
+			strbuf_write(&pp->buffered_output, stderr);
 			strbuf_reset(&pp->buffered_output);
 
 			/*
diff --git a/run-command.h b/run-command.h
index a054fa6..c8c64bb 100644
--- a/run-command.h
+++ b/run-command.h
@@ -159,7 +159,7 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
  * the negative signal number.
  */
 typedef int (*start_failure_fn)(struct child_process *cp,
-				struct strbuf *err,
+				struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
@@ -168,7 +168,7 @@ typedef int (*start_failure_fn)(struct child_process *cp,
  * exact command which failed.
  */
 int default_start_failure(struct child_process *cp,
-			  struct strbuf *err,
+			  struct strbuf *out,
 			  void *pp_cb,
 			  void *pp_task_cb);
 
@@ -188,7 +188,7 @@ int default_start_failure(struct child_process *cp,
  */
 typedef int (*task_finished_fn)(int result,
 				struct child_process *cp,
-				struct strbuf *err,
+				struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
@@ -198,7 +198,7 @@ typedef int (*task_finished_fn)(int result,
  */
 int default_task_finished(int result,
 			  struct child_process *cp,
-			  struct strbuf *err,
+			  struct strbuf *out,
 			  void *pp_cb,
 			  void *pp_task_cb);
 
diff --git a/strbuf.c b/strbuf.c
index 38686ff..71345cd 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -395,6 +395,12 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
 	return cnt;
 }
 
+ssize_t strbuf_write(struct strbuf *sb, FILE *f)
+{
+	return fwrite(sb->buf, 1, sb->len, f);
+}
+
+
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
diff --git a/strbuf.h b/strbuf.h
index 2bf90e7..d4f2aa1 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -387,6 +387,12 @@ extern ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint
 extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 
 /**
+ * Write the whole content of the strbuf to the stream not stopping at
+ * NUL bytes.
+ */
+extern ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
+
+/**
  * Read a line from a FILE *, overwriting the existing contents
  * of the strbuf. The second argument specifies the line
  * terminator character, typically `'\n'`.
diff --git a/submodule.c b/submodule.c
index 8fbc847..051f722 100644
--- a/submodule.c
+++ b/submodule.c
@@ -219,7 +219,7 @@ void gitmodules_config(void)
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst)
 {
-	free((void *)dst->command);
+	free((void*)dst->command);
 	dst->command = NULL;
 	if (!strcmp(value, "none"))
 		dst->type = SM_UPDATE_NONE;
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 5c6822c..12228b4 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -77,32 +77,6 @@ test_expect_success 'run_command runs in parallel with more tasks than jobs avai
 	test_cmp expect actual
 '
 
-test_expect_success 'run_command ensures each command ends in LF' '
-	test-run-command run-command-parallel 3 sh -c "printf \"%s\n%s\" Hello World" 2>actual &&
-	test_cmp expect actual
-'
-
-cat >expect <<-EOF
-preloaded output of a child
-preloaded output of a child
-preloaded output of a child
-preloaded output of a child
-EOF
-
-test_expect_success 'run_command ensures each command ends in LF when output is only in starting cb' '
-	test-run-command run-command-parallel 3 sh -c true  2>actual &&
-	test_cmp expect actual
-'
-
-cat >expect <<-EOF
-EOF
-
-test_expect_success 'run_command ensures each command ends in LF except when there is no output' '
-	test-run-command run-command-parallel-silent 3 sh -c true  2>actual &&
-	test_cmp expect actual
-'
-
-
 cat >expect <<-EOF
 preloaded output of a child
 asking for a quick stop
diff --git a/test-run-command.c b/test-run-command.c
index ca1ee97..fbe0a27 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -31,20 +31,6 @@ static int parallel_next(struct child_process *cp,
 	return 1;
 }
 
-static int parallel_next_silent(struct child_process *cp,
-			 struct strbuf *err,
-			 void *cb,
-			 void **task_cb)
-{
-	struct child_process *d = cb;
-	if (number_callbacks >= 4)
-		return 0;
-
-	argv_array_pushv(&cp->args, d->argv);
-	number_callbacks++;
-	return 1;
-}
-
 static int no_job(struct child_process *cp,
 		  struct strbuf *err,
 		  void *cb,
@@ -85,10 +71,6 @@ int main(int argc, char **argv)
 	jobs = atoi(argv[2]);
 	proc.argv = (const char **)argv + 3;
 
-	if (!strcmp(argv[1], "run-command-parallel-silent"))
-		exit(run_processes_parallel(jobs, parallel_next_silent,
-					    NULL, NULL, &proc));
-
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, NULL, &proc));

Stefan Beller (7):
  run_processes_parallel: treat output of children as byte array
  run-command: expose default_{start_failure, task_finished}
  run_processes_parallel: rename parameters for the callbacks
  run_processes_parallel: correctly terminate callbacks with an LF
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 ++-
 builtin/submodule--helper.c     | 251 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  56 ++++-----
 run-command.c                   |  36 +++---
 run-command.h                   |  23 +++-
 strbuf.c                        |   6 +
 strbuf.h                        |   6 +
 t/t7406-submodule-update.sh     |  27 +++++
 10 files changed, 376 insertions(+), 61 deletions(-)

-- 
2.7.2.335.g3f96d05
