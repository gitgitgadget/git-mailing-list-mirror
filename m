From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3] shell: Rewrite documentation and improve error message
Date: Tue, 24 Aug 2010 11:06:51 +0530
Message-ID: <20100824053647.GA2037@kytes>
References: <1282333452-25278-1-git-send-email-artagnon@gmail.com>
 <AANLkTi=u7VUhz4VrU2hdd3SXK7rMvMrijL-X9qXCG1vs@mail.gmail.com>
 <20100822080359.GB15561@kytes>
 <AANLkTintw7=25nsr-7NjE_-xJqMab_HggjPOtSHBf109@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Aug 24 07:38:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnmDk-0003jN-KW
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 07:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab0HXFis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 01:38:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56432 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab0HXFiq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 01:38:46 -0400
Received: by iwn5 with SMTP id 5so4218129iwn.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 22:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cAmiRAY5SWwyMLBs00tY7cgLiDRBqu/U68MqQWampe8=;
        b=IYMmzcezVHOua1Tgw7BEn8BsiLAEMfrNCG9/2Ve4/c74L5ZOVgjQAxjRNV4ctC8eHr
         TfRopOGdlyJMUhtyZEP9MOBzZtXb91ZR0lSnu+giz82JSl8IyBL6H52dwmeF3+ndJBg0
         aQIRk3jrf811OmiUdKA7C4VIGwMYAdT3WbbCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gFaaDMu8es/b44Xh86bOVpfmV0aig/k+nOSnP3PQ5Pdltu5LdcHGfTc5X6Z0CE+t6K
         e13pwNqdZwtYPfDhv6HKOSNogJi81z4fd4qTcwhOBcFUyNqughCaZeg4yFDxHrBqFFCJ
         3MOp8prj8bW2lZiQPEOiChl1OcYf9Om4gIpfk=
Received: by 10.231.147.131 with SMTP id l3mr8068881ibv.74.1282628325407;
        Mon, 23 Aug 2010 22:38:45 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id n20sm6982727ibe.17.2010.08.23.22.38.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 22:38:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTintw7=25nsr-7NjE_-xJqMab_HggjPOtSHBf109@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154293>

Update the documentation of 'git shell' to mention the interactive
mode and COMMAND_DIR. Also provide a hint when interactive mode is not
available in the shell.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Greg Brockman <gdb@MIT.EDU>
---
 Interdiff:
 diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
 index 1e38c70..6403126 100644
 --- a/Documentation/git-shell.txt
 +++ b/Documentation/git-shell.txt
 @@ -26,7 +26,7 @@ invoked.
  COMMAND_DIR is the path "$HOME/git-shell-commands". The user must have
  read and execute permissions to the directory in order to execute the
  programs in it. The programs are executed with a cwd of $HOME, and
 -<argument> is passed to them as a command-line argument.
 +<argument> is parsed as a command-line string.
  
  Author
  ------
 	Modified shell.c
 diff --git a/shell.c b/shell.c
 index 0903ac8..6aade3d 100644
 --- a/shell.c
 +++ b/shell.c
 @@ -154,7 +154,7 @@ int main(int argc, char **argv)
  		cd_to_homedir();
  		if (access(COMMAND_DIR, R_OK | X_OK) == -1) {
  			die("Interactive git shell is not enabled.\n"
 -			    "hint: ~/$COMMAND_DIR should exist "
 +			    "hint: ~/" $COMMAND_DIR " should exist "
  			    "and have read and execute access.");
  		}
  		run_shell();

 Documentation/git-shell.txt |   28 +++++++++++++++++-----------
 shell.c                     |    7 +++++--
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 0f3ad81..6403126 100644
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
+<argument> is parsed as a command-line string.
 
 Author
 ------
diff --git a/shell.c b/shell.c
index ffed615..6aade3d 100644
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
+			    "hint: ~/" $COMMAND_DIR " should exist "
+			    "and have read and execute access.");
+		}
 		run_shell();
 		exit(0);
 	} else if (argc != 3 || strcmp(argv[1], "-c")) {
-- 
1.7.2.2.409.gdbb11.dirty
