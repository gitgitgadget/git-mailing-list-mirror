From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/8] test-run-command: Test for gracefully aborting
Date: Tue, 20 Oct 2015 15:43:46 -0700
Message-ID: <1445381030-23912-5-git-send-email-sbeller@google.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 00:44:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zofde-0001oW-D9
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 00:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbbJTWoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 18:44:07 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36105 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbbJTWoB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 18:44:01 -0400
Received: by pacfv9 with SMTP id fv9so35146292pac.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sp5mpDCe6G643zfe5YiJQ39HdsJa5+GULkamOP4Xrv8=;
        b=DU9TzU8c8Ae7EeurRFXElDnGBixvGXPTuYPjgkn+didNIxXZtOGA6+FkzuqJHc9Fm2
         1V0APT2WBR9BloHt2UP5eqe3SowT3vHeRFWr4zYsJ78VdBXf3MFRos0RkxVtV2K4xbd1
         Pm+E1Fk+B5ZMZZqjDKQhUttNCmeywdb+0OEE5wY59IH4uKX36pdK2B/raUVd6mbEQ6ua
         2PBZu+MQJU3DgYOEdY5suXs2klAZhev27WgwP3AsEalchtkzCDh5FOyX9IzKP9tT2Ztr
         oTkg/SdvBeXlkOdMjVrp4p313Sij8bWq1jHHp393oIY9oASmasv7V13DGTFbxdPgpp9Y
         47OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sp5mpDCe6G643zfe5YiJQ39HdsJa5+GULkamOP4Xrv8=;
        b=X2+TLwEC5Yp25pDncT31uPt8kBcs/K6Y9Bpmu1stKz6ZTxMyeeZTNft99/jhFIuCu3
         +rBofR9LoBPEhgG33HtI87/KJ5UZhAqWENAoyDVXrl4Y+WLn2AxL1E3cvMAr9GkG2G8c
         iomL4FglNkWvyRQ1Cad2VNAdWK0W+bgwTbBGN/FTk16GK9PZeJCIXXMM87dV5fW3M7lX
         dfokQ73Ka5c4n4EwpM9DL7OSAL+HLgPeX6R0mFaRJGJCWVyIISF7qnGpEB15qOUCWg6V
         JDMX4tWOijZPiJRcIYSgMn+SJ2qqKX7z6DbgRbhhxZgmfNnHyoz3FfHWolOeeIk06o29
         51OQ==
X-Gm-Message-State: ALoCoQlF3DAcksZuBlyc0FULOWv8PLOO5OYVFd4yGpKhVxtLj5rznjxBgk5jwT8MyfSQKCZvWOK1
X-Received: by 10.68.136.103 with SMTP id pz7mr6677679pbb.114.1445381041330;
        Tue, 20 Oct 2015 15:44:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:95b6:4bcd:ddcd:b6a3])
        by smtp.gmail.com with ESMTPSA id rc5sm5574102pbc.95.2015.10.20.15.44.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Oct 2015 15:44:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gbfc1651.dirty
In-Reply-To: <1445381030-23912-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279948>

We reuse the get_next_task callback which would stop after invoking the
test program 4 times. However as we have only 3 parallel processes started
(We pass in 3 as max parallel processes and 3 is smaller than the spawn
cap in run-command, so we will start the 3 processes in the first run
deterministically), then the abort logic from the new task_finished
callback kicks in and prevents the parallel processing engine to start
any more processes.

As the task_finished is unconditional, we will see its output 3 times, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t0061-run-command.sh | 14 ++++++++++++++
 test-run-command.c     | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 49aa3db..0af77cd 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -67,4 +67,18 @@ test_expect_success 'run_command runs in parallel' '
 	test_cmp expect actual
 '
 
+cat >expect <<-EOF
+preloaded output of a child
+asking for a quick stop
+preloaded output of a child
+asking for a quick stop
+preloaded output of a child
+asking for a quick stop
+EOF
+
+test_expect_success 'run_command is asked to abort gracefully' '
+	test-run-command run-command-abort-3 false 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/test-run-command.c b/test-run-command.c
index 699d9e9..4b59482 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -34,6 +34,16 @@ static int parallel_next(void** task_cb,
 	return 1;
 }
 
+static int task_finished(int result,
+			 struct child_process *cp,
+			 struct strbuf *err,
+			 void *pp_cb,
+			 void *pp_task_cb)
+{
+	strbuf_addf(err, "asking for a quick stop\n");
+	return 1;
+}
+
 int main(int argc, char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
@@ -55,6 +65,10 @@ int main(int argc, char **argv)
 		exit(run_processes_parallel(4, parallel_next,
 					    NULL, NULL, &proc));
 
+	if (!strcmp(argv[1], "run-command-abort-3"))
+		exit(run_processes_parallel(3, parallel_next,
+					    NULL, task_finished, &proc));
+
 	fprintf(stderr, "check usage\n");
 	return 1;
 }
-- 
2.5.0.275.gbfc1651.dirty
