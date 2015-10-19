From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] test-run-command: test for gracefully aborting
Date: Mon, 19 Oct 2015 11:24:45 -0700
Message-ID: <1445279086-31066-5-git-send-email-sbeller@google.com>
References: <1445279086-31066-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 19 20:25:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoF7J-0007Vr-QS
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 20:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbbJSSZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 14:25:00 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36356 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbbJSSY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 14:24:58 -0400
Received: by pacfv9 with SMTP id fv9so102543610pac.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=szXMlOyLWlO2wcTYTqlVt9hS2Msja6LNpO1L2axo2SM=;
        b=LSFovDTVYZFSMdjYsJQHmPllxxK/HsQy8UeRAmWK8yb9D1fGYzLcTce7DM8Y3W4AaB
         oaqlElgL9j+cZCe+aoHOwaTnnGNc68RmclQfHVCC4icQEtflwnfcK+xNww5xpGVlBhM7
         AFx78Dkg2LV0e7ErV73SMuhunCzJc3DshXfqd/rFA34njwm1JSkl435J2t1x9ST4gMGA
         FLnYjpZ0xsGwT54zL6Xb0B+xGl2APArmbq50LWi+XT2kmP8XtE1RJF+xStVDV/qbJRkv
         /N25gAUZ71rHtufTQuCn6RlJrjZwhyTxd4s5LVONH0nhhAZYusT/nNVDXst/DG/ZSEiY
         O9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=szXMlOyLWlO2wcTYTqlVt9hS2Msja6LNpO1L2axo2SM=;
        b=TiXhGNa5Av7UsARJj9kqs1zsl2NYxdYJKxOiPozMge6jXQR4427ypHmwtpUD/moQy6
         sWos+AXPh6TXlP3yD42sVsmls9jndDo0YBGb7xYy23MDt6yBH5AS2eFg6boqxBE5fEW9
         Mts4Hmyf0qP7WEqyGKEsdoFUgmhO/6dr8dLTes4hcmFBEN2kqOUjQwgNSm729kG6+VJ1
         WthoNAQ0lCuw/tcKr1R2cb2l1+R4QWdD6J0wKspCRHN3GpCB8XWTPn8CwG5Dm/Ozys0J
         GOf9mPoLFQOMmsWRPjZbv/DvKmgvV8Rs1IyH9W3zX8r0tGLQR5ZJ1UdkXQBZ+s6BVOpH
         bQtw==
X-Gm-Message-State: ALoCoQkCbYLX2uQCp2Uj/c/FfwDK7b03Eu+uoMaG48H2Md5ntRV8gY1RCUzMpNAxXZbMOT/XnJUY
X-Received: by 10.68.139.100 with SMTP id qx4mr28572459pbb.149.1445279097610;
        Mon, 19 Oct 2015 11:24:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e1e6:ddb6:de02:325])
        by smtp.gmail.com with ESMTPSA id sn9sm37898015pac.16.2015.10.19.11.24.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 11:24:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.285.g8fe9b61.dirty
In-Reply-To: <1445279086-31066-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279883>

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
2.5.0.285.g8fe9b61.dirty
