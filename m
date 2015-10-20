From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/8] run-command: Fix missing output from late callbacks
Date: Tue, 20 Oct 2015 15:43:48 -0700
Message-ID: <1445381030-23912-7-git-send-email-sbeller@google.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 00:44:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZofeE-0002RO-AD
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 00:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbbJTWo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 18:44:27 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34286 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbbJTWoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 18:44:04 -0400
Received: by padhk11 with SMTP id hk11so33928455pad.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 15:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V3L6kDSihGJzoc4blu48aDxABHL6P9KrP7rXVlLlBFQ=;
        b=pPs/RlYucx3Zm7vyOUD3r1H8UWLHAwfmMDtFsoQ0MHJe2GpP7Eu+UfFOxU1yAkg2HL
         K0I7qILGFu4O34sOU5Qa5FRHRvqPEr5l66pJauGtEIK+KnAv0QFYNckgfnxUKmiiPnX9
         0t2XIGb6j9GH9p6arwlLn1QZ4ntiOfA0BZiINm8nVHscrxjwX6zfTjPJjh/esQR2qdO3
         Fwctxf81nBt6KDG/7DsrpKJNRQrGLhFV/EDLX1zvkr5HEw6I1vsE6Ndlzy0JmwljDkZJ
         fzPBaapl3uuTGGnZe8gv79Qdof6L4MXTKTRnwPzR6NH6AoPudnB9xtUks5V88G95ZIrz
         2Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V3L6kDSihGJzoc4blu48aDxABHL6P9KrP7rXVlLlBFQ=;
        b=SidNNWTpuuyGZ6p4cu2HKVmR+zEdYrvOctgK319m5oMXZRCOiwpFKQqW74T5Iyrs6D
         c/sRqsfFn0pE0Oq1ljmYWe2L7AYtANG3TVfIAQ1OAkjWRq6rf22393jgU+6paouBc0Oq
         yo3RuE2xqsFPv1PJ9CWqEJ6971xIy0NseOaIJAwPARNrGwzyvaZWXm4+kx7jYeVmnr8X
         9klDprN/0vih1clGKWIC4JN49ONuS6nb/GOct6iHFw3c8saMQLnuUOJK5OT7coTiTNgU
         VyCdZdxxm10ZjVqVBvFFuFf1PJH2fSoWQ2eLl7GVyr6Z0aKPOfcwOu9Vy61esENMjy2t
         Spfg==
X-Gm-Message-State: ALoCoQnP0+45yo9tODuWZ1Hjfg6eAvQ7CTlbfc2Wv4yQX/JG2vhehodk4M5L4Vd2A1DDJdbp3xg7
X-Received: by 10.66.131.81 with SMTP id ok17mr6411680pab.150.1445381043553;
        Tue, 20 Oct 2015 15:44:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:95b6:4bcd:ddcd:b6a3])
        by smtp.gmail.com with ESMTPSA id fe8sm5604699pab.40.2015.10.20.15.44.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Oct 2015 15:44:03 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gbfc1651.dirty
In-Reply-To: <1445381030-23912-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279953>

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
 run-command.c          | 11 ++++++++++-
 t/t0061-run-command.sh |  9 +++++++++
 test-run-command.c     | 13 +++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index d354c01..fa73dae 100644
--- a/run-command.c
+++ b/run-command.c
@@ -988,6 +988,12 @@ static void pp_cleanup(struct parallel_processes *pp)
 
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
@@ -1023,8 +1029,11 @@ static int pp_start_one(struct parallel_processes *pp)
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
index c8770c2..13e5d44 100644
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
2.5.0.275.gbfc1651.dirty
