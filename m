Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4900C207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757956AbdDRXSa (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:18:30 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36799 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757970AbdDRXSX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:18:23 -0400
Received: by mail-pf0-f175.google.com with SMTP id 194so3377286pfv.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jUTzvKrg09pN7ttMYVm0n5+31dEWfeSY/yGxX35Gwlw=;
        b=lfEguTPuYwdVgJ0cborUyAWMPOzhqN6Mkbz6yq+f/6BUpmHDQeIqy8jvpYiKyGjJt6
         Wpj/VCmSBeSSR+8F3TI0kyJ91lfLCiH8BLjBCpvfmTxAcIcgwUyfLtmPdUwPb/VQE1pm
         yVO064LErHhg8pH/eFkn/tIDkEMRfWzLHheUbGo/skd8ZQmMUygmPJT4HtDrgGL9AUpL
         /B/A2m16IBnLYMgv8AKAaBo/RMzk8NiW9kKxIkfbAMjR7xVF1YmqQfvT8VuK7pADqsSx
         Cndbzaea+29ry3AkyeDt2TzYfCR16zi+FwIo7fgqW95DDZN/Fu2PdzkGmfrx9aqGZCib
         HZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jUTzvKrg09pN7ttMYVm0n5+31dEWfeSY/yGxX35Gwlw=;
        b=bPXsEP7PR6Do/sCDvl0NbRqCFmJAJpa67EnRI73zTMkYHEbMleyem96VN8Z4EUPZHU
         Oy0sEmz7G4EegcG8hOtXtTkeI67m0T1rx5MAj4i5eeXqUq5XUYAB94kDE4CWynMLK1By
         WzzXQ1+sQ0+LZ8r+Iw+YRca3GY1vgzeuNbSU2CV+zgwmF4/qE+tRm+rmGQFhQl/hlRUI
         mRzp2av8onc40vW0HDfpbwJPzxkkiBA0eYFsJDLWDaO9yX2lKs9lbOvC97pA/ST1oNgQ
         AqSMxLPduo2p/G3lDtnkB44yZ8ZPLDgucMQLHclyYC8ARSfn6wvsxmmweWS7V+pQlBoA
         gm1g==
X-Gm-Message-State: AN3rC/7yq76LwcOs/vHAryRXN8Wsskx1NRpwVM2zb9lOuuY9blhe2fnF
        SGUxSyFiET5yaLDjbRbE+Q==
X-Received: by 10.98.131.197 with SMTP id h188mr19935084pfe.99.1492557496718;
        Tue, 18 Apr 2017 16:18:16 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id z21sm492764pfk.95.2017.04.18.16.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:18:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, e@80x24.org,
        jrnieder@gmail.com
Subject: [PATCH v5 04/11] run-command: use the async-signal-safe execv instead of execvp
Date:   Tue, 18 Apr 2017 16:17:58 -0700
Message-Id: <20170418231805.61835-5-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170418231805.61835-1-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the function used to exec from 'execvp()' to 'execv()' as the (p)
variant of exec isn't async-signal-safe and has the potential to call malloc
during the path resolution it performs.  Instead we simply do the path
resolution ourselves during the preparation stage prior to forking.  There also
don't exist any portable (p) variants which also take in an environment to use
in the exec'd process.  This allows easy migration to using 'execve()' in a
future patch.

Also, as noted in [1], in the event of an ENOEXEC the (p) variants of
exec will attempt to execute the command by interpreting it with the
'sh' utility.  To maintain this functionality, if 'execv()' fails with
ENOEXEC, start_command will atempt to execute the command by
interpreting it with 'sh'.

[1] http://pubs.opengroup.org/onlinepubs/009695399/functions/exec.html

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index d8d143795..1c7a3b611 100644
--- a/run-command.c
+++ b/run-command.c
@@ -238,6 +238,12 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 	if (!cmd->argv[0])
 		die("BUG: command is empty");
 
+	/*
+	 * Add SHELL_PATH so in the event exec fails with ENOEXEC we can
+	 * attempt to interpret the command with 'sh'.
+	 */
+	argv_array_push(out, SHELL_PATH);
+
 	if (cmd->git_cmd) {
 		argv_array_push(out, "git");
 		argv_array_pushv(out, cmd->argv);
@@ -246,6 +252,20 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 	} else {
 		argv_array_pushv(out, cmd->argv);
 	}
+
+	/*
+	 * If there are no '/' characters in the command then perform a path
+	 * lookup and use the resolved path as the command to exec.  If there
+	 * are no '/' characters or if the command wasn't found in the path,
+	 * have exec attempt to invoke the command directly.
+	 */
+	if (!strchr(out->argv[1], '/')) {
+		char *program = locate_in_PATH(out->argv[1]);
+		if (program) {
+			free((char *)out->argv[1]);
+			out->argv[1] = program;
+		}
+	}
 }
 #endif
 
@@ -445,7 +465,15 @@ int start_command(struct child_process *cmd)
 			}
 		}
 
-		sane_execvp(argv.argv[0], (char *const *) argv.argv);
+		/*
+		 * Attempt to exec using the command and arguments starting at
+		 * argv.argv[1].  argv.argv[0] contains SHELL_PATH which will
+		 * be used in the event exec failed with ENOEXEC at which point
+		 * we will try to interpret the command using 'sh'.
+		 */
+		execv(argv.argv[1], (char *const *) argv.argv + 1);
+		if (errno == ENOEXEC)
+			execv(argv.argv[0], (char *const *) argv.argv);
 
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
-- 
2.12.2.816.g2cccc81164-goog

