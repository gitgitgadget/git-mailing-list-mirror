From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv15 2/5] run_processes_parallel: add LF when caller is sloppy
Date: Tue, 23 Feb 2016 19:20:14 -0800
Message-ID: <1456284017-26141-3-git-send-email-sbeller@google.com>
References: <1456284017-26141-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 24 04:22:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYQ1u-0006ei-CZ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 04:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbcBXDWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 22:22:17 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34686 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbcBXDWN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 22:22:13 -0500
Received: by mail-pf0-f173.google.com with SMTP id x65so4371517pfb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 19:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j1sjnQpOopPHLXe27EnE8s0UxfXkSAAMP3+V4FBVjWA=;
        b=UlJKF1zsLORTJj+kudcDc7WzEepfn7EkvnexWVfoz/ZCe9lhKnqI/sCwreyXclAkgP
         0cGGE1ncYaBD0UjR9PVtlyEEeRW+q1A0YC+SAGuqJvggN+S62splwYxnb8BjROlzqn3G
         bt83MTb8zFtqlVUDA3uH0cQgvRY02mijzcFf0Eqbm3HXA8HdAjfGOK4wWQYArogCg9dD
         EtY2gNW9bFNG2vdMGi/+KTrUkloWestAm+EeotF0EwR/pm1WZwwW9J9BanN23kLF7uGU
         jUGS+Jvqc17jFiRrVdXVX+UNLFYuhpAWQqlFYUvLqV5XYA2+rlG2UEIny+wM2F9fDTON
         tBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j1sjnQpOopPHLXe27EnE8s0UxfXkSAAMP3+V4FBVjWA=;
        b=IW5VR98YxxczgvmMEa8C9FgUugLLjpFx4PEOVYwQbsIi1iZCoHTopEbXj3lhj4Blla
         TZ9ui+O5WyvbBV06sxaPK0v+q3rnDlQLQZTvor4bx+BgAnj2BU0rDMJl+EFMFKPUbW1q
         0qqDDRFts/faKOWKxLLhbiEzCcAyZANJzwYjy1yYbWpRLXtuqb3mt42t+niIxxyxb0yJ
         om6RB8UjWEScMuQDdUDYqTbztzn9mOyS1w/diwNIJbtI7oCEmY7aLT1Qzk0EBGzvhZZp
         ZwW/NmIgLlo+ays7ffcY+r3oEETH0iUBsIuWaX0diBiJRJE3tKIhpRoCcBxh9/a2u/GC
         H7IQ==
X-Gm-Message-State: AG10YORT9Xa8idv4s0m8UzqlHvBPZWwowX7TIx0rpQ/O/M+IULGtWL9YvMgSNuTMDpXPlixN
X-Received: by 10.98.93.2 with SMTP id r2mr51581527pfb.64.1456284133156;
        Tue, 23 Feb 2016 19:22:13 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a8b2:5b44:5b58:45af])
        by smtp.gmail.com with ESMTPSA id 79sm725013pfq.65.2016.02.23.19.22.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 Feb 2016 19:22:12 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
In-Reply-To: <1456284017-26141-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287163>

When the callers of parallel processing machine are sloppy with their
messages, make sure the output is terminated with LF after one child
process is handled. This will not mess with the internal state of the
output, i.e. after all messages for one child process are process
including the callbacks as well as the actual output of the child
we may add an LF if the output is not ended with an LF.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

>From a discussion on a later patch, Jonathan said:
> It looks like pp_start_one takes the content of err without adding
> a \n.  That's a bug in pp_start_one and pp_collect_finished IMHO.

 run-command.c          | 17 +++++++++++++++--
 t/t0061-run-command.sh | 26 ++++++++++++++++++++++++++
 test-run-command.c     | 18 ++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index d03ecaa..8abaae4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -897,6 +897,7 @@ struct parallel_processes {
 	struct pollfd *pfd;
 
 	unsigned shutdown : 1;
+	unsigned ended_with_newline: 1;
 
 	int output_owner;
 	struct strbuf buffered_output; /* of finished children */
@@ -979,6 +980,7 @@ static void pp_init(struct parallel_processes *pp,
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
 	pp->shutdown = 0;
+	pp->ended_with_newline = 1;
 	pp->children = xcalloc(n, sizeof(*pp->children));
 	pp->pfd = xcalloc(n, sizeof(*pp->pfd));
 	strbuf_init(&pp->buffered_output, 0);
@@ -1053,6 +1055,7 @@ static int pp_start_one(struct parallel_processes *pp)
 					 pp->data,
 					 &pp->children[i].data);
 		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
+		strbuf_addch(&pp->buffered_output, '\n');
 		strbuf_reset(&pp->children[i].err);
 		if (code)
 			pp->shutdown = 1;
@@ -1095,9 +1098,11 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 static void pp_output(struct parallel_processes *pp)
 {
 	int i = pp->output_owner;
-	if (pp->children[i].state == GIT_CP_WORKING &&
-	    pp->children[i].err.len) {
+	size_t len = pp->children[i].err.len;
+	if (pp->children[i].state == GIT_CP_WORKING && len) {
 		fputs(pp->children[i].err.buf, stderr);
+		pp->ended_with_newline =
+			(pp->children[i].err.buf[len - 1] == '\n');
 		strbuf_reset(&pp->children[i].err);
 	}
 }
@@ -1107,6 +1112,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	int i, code;
 	int n = pp->max_processes;
 	int result = 0;
+	ssize_t len;
 
 	while (pp->nr_processes > 0) {
 		for (i = 0; i < pp->max_processes; i++)
@@ -1131,12 +1137,19 @@ static int pp_collect_finished(struct parallel_processes *pp)
 		pp->pfd[i].fd = -1;
 		child_process_init(&pp->children[i].process);
 
+		len = pp->children[i].err.len - 1;
+		if (len >= 0 && pp->children[i].err.buf[len] != '\n')
+			strbuf_addch(&pp->children[i].err, '\n');
+
 		if (i != pp->output_owner) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		} else {
+			if (len == -1 && !pp->ended_with_newline)
+				strbuf_addch(&pp->children[i].err, '\n');
 			fputs(pp->children[i].err.buf, stderr);
 			strbuf_reset(&pp->children[i].err);
+			pp->ended_with_newline = 1;
 
 			/* Output all other finished child processes */
 			fputs(pp->buffered_output.buf, stderr);
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 12228b4..5c6822c 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -77,6 +77,32 @@ test_expect_success 'run_command runs in parallel with more tasks than jobs avai
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command ensures each command ends in LF' '
+	test-run-command run-command-parallel 3 sh -c "printf \"%s\n%s\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<-EOF
+preloaded output of a child
+preloaded output of a child
+preloaded output of a child
+preloaded output of a child
+EOF
+
+test_expect_success 'run_command ensures each command ends in LF when output is only in starting cb' '
+	test-run-command run-command-parallel 3 sh -c true  2>actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<-EOF
+EOF
+
+test_expect_success 'run_command ensures each command ends in LF except when there is no output' '
+	test-run-command run-command-parallel-silent 3 sh -c true  2>actual &&
+	test_cmp expect actual
+'
+
+
 cat >expect <<-EOF
 preloaded output of a child
 asking for a quick stop
diff --git a/test-run-command.c b/test-run-command.c
index fbe0a27..ca1ee97 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -31,6 +31,20 @@ static int parallel_next(struct child_process *cp,
 	return 1;
 }
 
+static int parallel_next_silent(struct child_process *cp,
+			 struct strbuf *err,
+			 void *cb,
+			 void **task_cb)
+{
+	struct child_process *d = cb;
+	if (number_callbacks >= 4)
+		return 0;
+
+	argv_array_pushv(&cp->args, d->argv);
+	number_callbacks++;
+	return 1;
+}
+
 static int no_job(struct child_process *cp,
 		  struct strbuf *err,
 		  void *cb,
@@ -71,6 +85,10 @@ int main(int argc, char **argv)
 	jobs = atoi(argv[2]);
 	proc.argv = (const char **)argv + 3;
 
+	if (!strcmp(argv[1], "run-command-parallel-silent"))
+		exit(run_processes_parallel(jobs, parallel_next_silent,
+					    NULL, NULL, &proc));
+
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, NULL, &proc));
-- 
2.7.0.rc0.34.ga06e0b3.dirty
