From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 36/43] run-command: track total number of commands run
Date: Mon, 28 Sep 2015 18:02:11 -0400
Message-ID: <1443477738-32023-37-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWu-0001ti-QG
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbbI1WEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:04:11 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:32841 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbbI1WDd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:33 -0400
Received: by qkas79 with SMTP id s79so9406363qka.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gsIOTdCurGEy1Awj9T8ZFSRtYUfeTYL/CtFgLFvQuzA=;
        b=WMFmeo/1i/tJE3ji0X2oR7Pa8+vtzRfnjfAm04aOvYcT1Zst/3zhiKhpjsBnPIvwHa
         T65rsd4gC6rq9k9lfD5o4KRyifEioSqefGZeZ4V1nwO09sMts8JkKMqQ4f+u5sW7Jozd
         Z/0hWsXBD9KMgjx/NXJdCfxQuTY/X7wN5o2HWr/ebtiRFKAObEfVvmAqF9yLfHJ+CNh2
         nllR3j71z64ISUykN3OPwv9d+3GPqPlNG2WSXAXI2fZ2HnaFow4gmQx70b/E5dTJXgIZ
         yUiIUzCAIbJABRBCowyhnoJ3NsXVAboEY3MxjErG1mV6HBwXax7CNRB4s87sGQsWzgzc
         m1Sg==
X-Gm-Message-State: ALoCoQk9HRwrPlBbQANTJ57hx49Gd0NCjqVokZ9i9Hn8NzOPFvODZrt+eVw5iZc1xVmyYolEJ9oV
X-Received: by 10.55.40.41 with SMTP id o41mr20864392qkh.74.1443477812464;
        Mon, 28 Sep 2015 15:03:32 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278778>

Soon, the db refs backend will use this to restart read transactions
after subcommands which might have modified the refs database.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 run-command.c | 2 ++
 run-command.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/run-command.c b/run-command.c
index ceee5d1..9ee6c85 100644
--- a/run-command.c
+++ b/run-command.c
@@ -19,6 +19,7 @@ struct child_to_clean {
 };
 static struct child_to_clean *children_to_clean;
 static int installed_child_cleanup_handler;
+int total_commands_run = 0;
 
 static void cleanup_children(int sig, int in_signal)
 {
@@ -349,6 +350,7 @@ fail_pipe:
 		cmd->err = fderr[0];
 	}
 
+	total_commands_run++;
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 	fflush(NULL);
 
diff --git a/run-command.h b/run-command.h
index aa2a528..ef7ae7a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -158,4 +158,5 @@ int run_processes_parallel(int n, void *data,
 			   start_failure_fn,
 			   return_value_fn);
 
+extern int total_commands_run;
 #endif
-- 
2.4.2.644.g97b850b-twtrsrc
