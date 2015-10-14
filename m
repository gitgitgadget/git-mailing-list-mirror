From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] Tracing commands includes its working directory
Date: Wed, 14 Oct 2015 14:24:17 -0700
Message-ID: <1444857857-25796-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 23:25:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmTYO-0006vr-Kd
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 23:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbbJNVZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 17:25:40 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33905 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358AbbJNVZj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 17:25:39 -0400
Received: by payp3 with SMTP id p3so17048531pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=IWgfgNs7GctE3bxSWjhUmqBMBN1kCkqJgFqIxjbGN+8=;
        b=A/qPaXDjc4AVJhwdxAqU1kqUIrDESNnX9D5MMTWMi56SVtaHf20OY1HOaPg2XPq0I6
         3agrkBzh6z8kFxZ54PxvQuFd9yXKbSnoV+z6gbGGdyY2CtwaNKoNenTvy0HTtChaKyee
         Q4j+Z4Urm8Ly7ExIaRjzzhbgfvvcnXg3X8yBt7Kl9l1sfrlBB/h+Mu6WDAzQXBaQpu1F
         sBlJIGezpsc00C3eAEBuP99XdzX8zFkwiVV9wQ2diBEi0MbcD6jdqaGff1A6bWBo1G9i
         WI7fyCtArryNrJBlcvpY3iN6LTalnLp1Gmg1hlkqLPVpBiUHIsHJLdCjJS5Wq5MsxvWq
         JuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IWgfgNs7GctE3bxSWjhUmqBMBN1kCkqJgFqIxjbGN+8=;
        b=mi+8t9cE5I4JDOl8GLK6Xbfdv2C+eL/clY6ouNcqvDd2Vjs8LqjWjiP7ZAcxuAO2eO
         PnhVLdvBLcIGrTJ3RD7KeI8Fh6c3TRiWRhyoM9WL9ILa0fjvIJASUPCaFRympWKUW5Th
         XPUZHkt9123Mylnqd03xmOLxyS1s7a//HKrHNTZZqlbGqgat3MNLjYdjJe8puBYd4KkT
         oNQSFGUIPqRSt8wuzXXA8u4O6mCYsLAMEj6UzLYBaWOMgPx/fJf4Z+P5fI4P3UzBv4uT
         tx2NZUzg7oh0ybj7xrneq0YKltNr97cIDVdbQryo7JssM/BgML+wPme7nIOq1hddu+gf
         cm1A==
X-Gm-Message-State: ALoCoQkZWh2MOCM6VWaD6WcJyUzCRZLiEXoHtNmBQqNDwvVLjtodQpzCRQWwFk2UascQijLcZL+m
X-Received: by 10.68.92.194 with SMTP id co2mr5888000pbb.147.1444857939061;
        Wed, 14 Oct 2015 14:25:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:593f:8fe7:f8de:12be])
        by smtp.gmail.com with ESMTPSA id ez2sm11386481pbb.5.2015.10.14.14.25.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 14:25:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.267.g8d6e698.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279629>

Specially when having concurrent flows of command execution,
the order of commands printed cannot be relied upon. To aid
the poor developer follow the flow of commands include the
current working directory in which the command is carried out.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 exec_cmd.c    | 2 +-
 git.c         | 8 ++++----
 run-command.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index e85f0fd..bb79933 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -125,7 +125,7 @@ const char **prepare_git_cmd(const char **argv)
 
 int execv_git_cmd(const char **argv) {
 	const char **nargv = prepare_git_cmd(argv);
-	trace_argv_printf(nargv, "trace: exec:");
+	trace_argv_printf(nargv, "(%s) trace: exec:", xgetcwd());
 
 	/* execvp() can only ever return if it fails */
 	sane_execvp("git", (char **)nargv);
diff --git a/git.c b/git.c
index deecba0..e077e2d 100644
--- a/git.c
+++ b/git.c
@@ -278,8 +278,8 @@ static int handle_alias(int *argcp, const char ***argv)
 			die("recursive alias: %s", alias_command);
 
 		trace_argv_printf(new_argv,
-				  "trace: alias expansion: %s =>",
-				  alias_command);
+				  "(%s) trace: alias expansion: %s =>",
+				  xgetcwd(), alias_command);
 
 		REALLOC_ARRAY(new_argv, count + *argcp);
 		/* insert after command name */
@@ -345,7 +345,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
-	trace_argv_printf(argv, "trace: built-in: git");
+	trace_argv_printf(argv, "(%s) trace: built-in: git", xgetcwd());
 
 	status = p->fn(argc, argv, prefix);
 	if (status)
@@ -557,7 +557,7 @@ static void execv_dashed_external(const char **argv)
 	tmp = argv[0];
 	argv[0] = cmd.buf;
 
-	trace_argv_printf(argv, "trace: exec:");
+	trace_argv_printf(argv, "(%s) trace: exec:", xgetcwd());
 
 	/*
 	 * if we fail because the command is not found, it is
diff --git a/run-command.c b/run-command.c
index ef3da27..e483bae 100644
--- a/run-command.c
+++ b/run-command.c
@@ -194,7 +194,7 @@ static const char **prepare_shell_cmd(const char **argv)
 static int execv_shell_cmd(const char **argv)
 {
 	const char **nargv = prepare_shell_cmd(argv);
-	trace_argv_printf(nargv, "trace: exec:");
+	trace_argv_printf(nargv, "(%s) trace: exec:", xgetcwd());
 	sane_execvp(nargv[0], (char **)nargv);
 	free(nargv);
 	return -1;
@@ -346,7 +346,7 @@ fail_pipe:
 		cmd->err = fderr[0];
 	}
 
-	trace_argv_printf(cmd->argv, "trace: run_command:");
+	trace_argv_printf(cmd->argv, "(%s) trace: run_command:", xgetcwd());
 	fflush(NULL);
 
 #ifndef GIT_WINDOWS_NATIVE
-- 
2.5.0.267.g8d6e698.dirty
