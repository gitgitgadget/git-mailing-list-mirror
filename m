From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/5] run-command: Fix missing output from late callbacks
Date: Tue, 20 Oct 2015 10:51:00 -0700
Message-ID: <1445363460-17616-1-git-send-email-sbeller@google.com>
References: <1445279086-31066-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 20 19:51:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zob45-0005Y9-TY
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 19:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbbJTRvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 13:51:10 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34610 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbbJTRvH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 13:51:07 -0400
Received: by padhk11 with SMTP id hk11so27803824pad.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47IxbFTV2+ep7zNUXSksigCMVrQRmtCaiD9fkHX1/gY=;
        b=NarJq+KixkFTeiz74VF/VDvCBn0Z4egkFnaBX+LubUSNolk8G0A5nW6Aig7Yfddz8X
         ynntZDn0DJDQqmZU+JlIeJ0YlAsqizXkWtPW218S3cOjx17+EXdYsrNSBcpUoocXiIvY
         2KtwFlgsTG4Pry5kUYOrFbMBbob5w336CI+whzLROVNMYmboUEdFHCN4ffHoBKy8Nxx7
         s9rJobZQ0LsFWHFZWOrGYtL3EU7JahtgGuxfAO2CW4kQEfP7lJzr+RZyP6snCU8h7QMv
         2589HjQd1TyhRGfTqVkrQIdULegjttDwCbQE3PnzmL5CxB8jfJ05jFJTD2jjulDkMs/K
         8Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=47IxbFTV2+ep7zNUXSksigCMVrQRmtCaiD9fkHX1/gY=;
        b=R+oP+aoGKu246nu4d9BLr6nRLk9o9ZuifwzgTk1xSk7GIquDS9pOJZYtvpAc2KyS55
         plK0Yc557XaetL8rUGBkEVZSR2i/+3G20DanOnUKgOwHi/o5BZKhyHzBwGpXRmmfaZYA
         gp6e7eRuTuv4pgChAy1gw0p+ABCCla60ZsM2b945TDiUKtbbVZcnnAfHnQKvBX6ZJAT+
         LdaZnJHOaqGO5G8G7ZjUjbqbgBCd4zsdmBR23cEV4OP788TcZFYY7n+UG/7EMrL2G3Aw
         taPvcUu0QLDQ1AawIc389bPqJVxnjTc7Na4/j8DqxmKvKT1lmPR97HHutsCQLn5ZW/bc
         9lZA==
X-Gm-Message-State: ALoCoQkUUw85dEFAHa0Hy0gHo80T785GueE/k7htljhYaXoePvzNNJv1Pd1MB5Yr81zcnQTTIlDa
X-Received: by 10.68.105.164 with SMTP id gn4mr5419096pbb.44.1445363466182;
        Tue, 20 Oct 2015 10:51:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:95b6:4bcd:ddcd:b6a3])
        by smtp.gmail.com with ESMTPSA id yp9sm4907539pab.1.2015.10.20.10.51.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Oct 2015 10:51:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.gfd9d19f.dirty
In-Reply-To: <1445279086-31066-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279929>

The callbacks in the parallel processing API were given the contract, that
they are not allowed to print anything to stdout/err, but the API will take
care of their output needs instead.

In case a child process is started, the callback can first add its messages
to the buffer and then the child process output is buffered just in the
same buffer, and so the output will be taken care of eventually once the
child process is done.

When no child process is run, we also need to fulfill our promise to
output the buffer eventually. So when no child process is started, we need
to amend the contents of the buffer passed to the child to our buffer for
finished processes. We cannot output directly at that point in time as
another process may be in the middle of its output.

The buffer for finished child processes then also needs to be flushed in
the cleanup phase as it may contain data.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Another issue I just found. This goes on top of the series
    [PATCH 0/5] Fixes for the parallel processing
    
Thanks,
Stefan

 run-command.c          | 11 ++++++++++-
 t/t0061-run-command.sh |  9 +++++++++
 test-run-command.c     | 13 +++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 108b930..707e0a6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -979,6 +979,12 @@ static void pp_cleanup(struct parallel_processes *pp)
 
 	free(pp->children);
 	free(pp->pfd);
+
+	/*
+	 * When get_next_task added messages to the buffer in its last
+	 * iteration, the buffered output is non empty.
+	 */
+	fputs(pp->buffered_output.buf, stderr);
 	strbuf_release(&pp->buffered_output);
 
 	sigchain_pop_common();
@@ -1016,8 +1022,11 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (!pp->get_next_task(&pp->children[i].data,
 			       &pp->children[i].process,
 			       &pp->children[i].err,
-			       pp->data))
+			       pp->data)) {
+		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
+		strbuf_reset(&pp->children[i].err);
 		return 1;
+	}
 
 	if (start_command(&pp->children[i].process)) {
 		int code = pp->start_failure(&pp->children[i].process,
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index f27ada7..12228b4 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -91,4 +91,13 @@ test_expect_success 'run_command is asked to abort gracefully' '
 	test_cmp expect actual
 '
 
+cat >expect <<-EOF
+no further jobs available
+EOF
+
+test_expect_success 'run_command outputs ' '
+	test-run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/test-run-command.c b/test-run-command.c
index 44710c3..91e94e8 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -34,6 +34,15 @@ static int parallel_next(void** task_cb,
 	return 1;
 }
 
+static int no_job(void** task_cb,
+		  struct child_process *cp,
+		  struct strbuf *err,
+		  void *cb)
+{
+	strbuf_addf(err, "no further jobs available\n");
+	return 0;
+}
+
 static int task_finished(int result,
 			 struct child_process *cp,
 			 struct strbuf *err,
@@ -73,6 +82,10 @@ int main(int argc, char **argv)
 		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, task_finished, &proc));
 
+	if (!strcmp(argv[1], "run-command-no-jobs"))
+		exit(run_processes_parallel(jobs, no_job,
+					    NULL, task_finished, &proc));
+
 	fprintf(stderr, "check usage\n");
 	return 1;
 }
-- 
2.5.0.273.gfd9d19f.dirty
