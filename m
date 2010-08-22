From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] shell: Rewrite documentation and improve error message
Date: Sun, 22 Aug 2010 13:34:02 +0530
Message-ID: <20100822080359.GB15561@kytes>
References: <1282333452-25278-1-git-send-email-artagnon@gmail.com>
 <AANLkTi=u7VUhz4VrU2hdd3SXK7rMvMrijL-X9qXCG1vs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Aug 22 10:16:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On5j7-0000XR-75
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 10:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab0HVIGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 04:06:07 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55392 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab0HVIF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 04:05:59 -0400
Received: by pzk26 with SMTP id 26so1887081pzk.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6qPSf/jYmX7ZwC2zYRGcvD/mD1ewFCdiNLXzURZE1cw=;
        b=FfFTrwZegmsedlXWBZzPnBzS2bmBJ51SvM3fkk5pi//GzpZt/TpqWiYD1RgFprsTdv
         Cf5fwJ5E+Y3e7uKKc6Aks72z3NhDCjhmR+8d7A5vAl0LFEMteUHGuAmA+s5sd1g2HdQl
         hB/LtvRkF9U5kp3ykw9vZC1Kcxhl1NTYTDupA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tqEPjpvEYnOJw3ctHO25VTLDy4WzSpLkTQz6LzcURbnzgQOMTgbJh5vD7LHAp2k5AA
         hsKFGDzGzG6Z5qEykK2kqUZzthh/aqCofO2ArStvFXhV5RPTxlbNUr63ukUcr0ZQ5H8i
         s4Uate+tfyjl29eJKuzXRiixLdX3WikeeoQUo=
Received: by 10.142.230.18 with SMTP id c18mr2931588wfh.226.1282464358681;
        Sun, 22 Aug 2010 01:05:58 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id n32sm9446692wag.11.2010.08.22.01.05.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Aug 2010 01:05:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=u7VUhz4VrU2hdd3SXK7rMvMrijL-X9qXCG1vs@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154177>

Hi Greg,

Thanks for the review. Here's the inter-diff.

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index c9f1dc9..e7c226e 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -18,14 +18,15 @@ A login shell for SSH accounts to provide restricted Git access. When
 <command> can be one of 'git receive-pack', 'git upload-pack', 'git
 upload-archive', 'cvs server', or a command in COMMAND_DIR. The shell
 is started in interactive mode when no arguments are given; in this
-case, COMMAND_DIR must exist, and any of the executables in them can
-be invoked.
+case, COMMAND_DIR must exist, and any of the executables in it can be
+invoked.
 
 'cvs server' is a special command which executes git-cvsserver.
 
-COMMAND_DIR is the path 'git-shell-commands' in the user's home
-directory. The user must have read and execute permissions to the
-directory for it to be useful.
+COMMAND_DIR is the path "$HOME/git-shell-commands". The user must have
+read and execute permissions to the directory in order to execute the
+programs in it. The programs are executed with a cwd of $HOME, and
+<argument> is passed to them as a command-line argument.
 
 Author
 ------

diff --git a/shell.c b/shell.c
index 3fb804e..0903ac8 100644
--- a/shell.c
+++ b/shell.c
@@ -153,8 +153,8 @@ int main(int argc, char **argv)
 		/* Allow the user to run an interactive shell */
 		cd_to_homedir();
 		if (access(COMMAND_DIR, R_OK | X_OK) == -1) {
-			die("Inteactive git shell is not enabled.\n"
-			    "hint: " COMMAND_DIR " should exist "
+			die("Interactive git shell is not enabled.\n"
+			    "hint: ~/$COMMAND_DIR should exist "
 			    "and have read and execute access.");
 		}
 		run_shell();

-- >8 --
From 01ff9085867ae6be558927cb4d905c441ffedb41 Mon Sep 17 00:00:00 2001
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Fri, 20 Aug 2010 14:30:06 +0530
Subject: [PATCH v2] shell: Rewrite documentation and improve error message

Update the documentation of 'git shell' to mention the interactive
mode and COMMAND_DIR. Also provide a hint when interactive mode is not
available in the shell.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Greg Brockman <gdb@MIT.EDU>
---
 Documentation/git-shell.txt |   28 +++++++++++++++++-----------
 shell.c                     |    7 +++++--
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 0f3ad81..1e38c70 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -3,24 +3,30 @@ git-shell(1)
 
 NAME
 ----
-git-shell - Restricted login shell for GIT-only SSH access
+git-shell - Restricted login shell for Git-only SSH access
 
 
 SYNOPSIS
 --------
-'$(git --exec-path)/git-shell' -c <command> <argument>
+'git shell' [-c <command> <argument>]
 
 DESCRIPTION
 -----------
-This is meant to be used as a login shell for SSH accounts you want
-to restrict to GIT pull/push access only. It permits execution only
-of server-side GIT commands implementing the pull/push functionality.
-The commands can be executed only by the '-c' option; the shell is not
-interactive.
-
-Currently, only four commands are permitted to be called, 'git-receive-pack'
-'git-upload-pack' and 'git-upload-archive' with a single required argument, or
-'cvs server' (to invoke 'git-cvsserver').
+
+A login shell for SSH accounts to provide restricted Git access. When
+'-c' is given, the program executes <command> non-interactively;
+<command> can be one of 'git receive-pack', 'git upload-pack', 'git
+upload-archive', 'cvs server', or a command in COMMAND_DIR. The shell
+is started in interactive mode when no arguments are given; in this
+case, COMMAND_DIR must exist, and any of the executables in it can be
+invoked.
+
+'cvs server' is a special command which executes git-cvsserver.
+
+COMMAND_DIR is the path "$HOME/git-shell-commands". The user must have
+read and execute permissions to the directory in order to execute the
+programs in it. The programs are executed with a cwd of $HOME, and
+<argument> is passed to them as a command-line argument.
 
 Author
 ------
diff --git a/shell.c b/shell.c
index ffed615..0903ac8 100644
--- a/shell.c
+++ b/shell.c
@@ -152,8 +152,11 @@ int main(int argc, char **argv)
 	} else if (argc == 1) {
 		/* Allow the user to run an interactive shell */
 		cd_to_homedir();
-		if (access(COMMAND_DIR, R_OK | X_OK) == -1)
-			die("Sorry, the interactive git-shell is not enabled");
+		if (access(COMMAND_DIR, R_OK | X_OK) == -1) {
+			die("Interactive git shell is not enabled.\n"
+			    "hint: ~/$COMMAND_DIR should exist "
+			    "and have read and execute access.");
+		}
 		run_shell();
 		exit(0);
 	} else if (argc != 3 || strcmp(argv[1], "-c")) {
-- 
1.7.2.2.409.gdbb11.dirty
