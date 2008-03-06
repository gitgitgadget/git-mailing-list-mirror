From: imyousuf@gmail.com
Subject: [PATCH] - Added pre command and custom argument support to git submodule recurse command
Date: Thu,  6 Mar 2008 13:33:35 +0600
Message-ID: <1204788817-22720-3-git-send-email-imyousuf@gmail.com>
References: <1204788817-22720-1-git-send-email-imyousuf@gmail.com>
 <1204788817-22720-2-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 08:35:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXAd4-00083r-UU
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 08:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbYCFHeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 02:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758167AbYCFHeQ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 02:34:16 -0500
Received: from hu-out-0506.google.com ([72.14.214.236]:41464 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015AbYCFHeP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 02:34:15 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1229660hue.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 23:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5E8Q96Yltp0odHjgtm56Sjl0UNtiQwfZLq5G9lMZbSk=;
        b=ghGTooEHjSpF1pGlJaRPPku5FJ9vgAa9Axdk1hfg/x8YPRG3jBTsie77zoYCC9kkl2MiSvsPxUt4zolgHlV6BIqrXA34b3Pji7LcDJKQ3Y0FDZT4nfIrtzzArfDc1/pQWubvaQDGTAaLeIPc7p1ihMIWmeHeRugGpz9MdLpRK7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H7rt86w376DodXUzdKXMTIGfOGW5gFTYdEHGDh5flwK0ETrG2/JBBillsOCKlXPq0yedqjuLVmznOU+wOqevT6xI6Uub4GnJXPz8hzOWQ0zkw2FsHE/wzTW+tJJNTUNCPmlrz+3sd2thPVqNhstvMUXPogYtyIH3kIMn+pYBHUI=
Received: by 10.86.89.4 with SMTP id m4mr4295124fgb.14.1204788854702;
        Wed, 05 Mar 2008 23:34:14 -0800 (PST)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id t12sm3138995gvd.2.2008.03.05.23.34.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 23:34:13 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1204788817-22720-2-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76349>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

There is one scenario that has been put forward several times in
discussion over the recurse command - it is that commands can have
different arguments for different modules. For example for the same example
mentioned above, one wants to check a_1 for submdoule a, while it wants to
checkout d_2 for d. It can be achieved by using [-ca|--customized-argument].
This results the script to prompt for user input, which will be passed as
argument to the command for that module.
	git submodule recurse -ca checkout
	Working in mod a .......
	Please provide arguments for this module: a_1
	Working in mod d .......
	Please provide arguments for this module: a_1

It is usually helpful that when typing a command, being able to see some options
come in handy. For example if I can see the available branches before checking
out a branch that would be useful, IOW, if one could git branch before git
checkout; it is now possible using the [-p|--pre-command] option. Using this
command you can actually execute other git commands before specifying the
arguments to the original command. E.g. if the above command is changed to,
	git submodule recurse -ca -p checkout
it will prompt the user for the pre command until one is satisfied and later
the user can actually use them in the argument.

As these two options get along well together it made sense to me
to group them together.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 git-submodule.sh |   33 +++++++++++++++++++++++++++++----
 1 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ee3c928..05fd1d2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,8 +8,8 @@
 # git-submodule [-q|--quiet] add [-b|--branch branch] <repository> [<path>]
 # git-submodule [-q|--quiet] [status] [-c|--cached] [--] [<path>...]
 # git-submodule [-q|--quiet] init|update [--] [<path>...]
-# git-submodule [-q|--quiet] recurse [-i|--initialize] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-df|--depth-first] <command> [<arguments> ...]
-USAGE='[-q|--quiet] [[[add [-b|--branch branch] <repo>]|[[[status [-c|--cached]]|init|update] [--]]]  [<path>...]]|[recurse [-i|--initialize] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-df|--depth-first] <command> [<arguments> ...]]'
+# git-submodule [-q|--quiet] recurse [-i|--initialize] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-df|--depth-first] [-ca|--customized-argument] [-p|--pre-command] <command> [<arguments> ...]
+USAGE='[-q|--quiet] [[[add [-b|--branch branch] <repo>]|[[[status [-c|--cached]]|init|update] [--]]]  [<path>...]]|[recurse [-i|--initialize] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-df|--depth-first] [-ca|--customized-argument] [-p|--pre-command] <command> [<arguments> ...]]'
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -392,6 +392,30 @@ cmd_status()
 	done
 }
 
+do_pre_command()
+{
+	say "Starting pre-comamnd execution!"
+	while :
+	do
+		(
+			read -p "Please provide a git command: " pre_command
+			test -z "$pre_command" || git "$pre_command"
+		)
+		read -p "Press y to continue with another git command... " keypress
+		if test "$keypress" != "y" &&
+			test "$keypress" != "Y"
+		then
+			break
+		fi
+	done
+}
+
+# Take arguments from user to pass as custom arguments
+get_custom_args()
+{
+	read -p "Please provide arguments for this module: " custom_args
+}
+
 # Initializes the submodule if already not initialized
 # and auto initialize is enabled
 initialize_sub_module()
@@ -460,8 +484,10 @@ traverse_module()
 		# pwd is mentioned in order to enable the ser to distinguish
 		# between same name modules, e.g. a/lib and b/lib.
 		say "Working in mod $submod_path" @ `pwd` "with $@ ($#)"
+		test -n "$pre_cmd" && do_pre_command
+		test -n "$use_custom_args" && get_custom_args
 		cmd_status=
-		git "$@" || cmd_status=1
+		git "$@" "$custom_args" || cmd_status=1
 		# if exit on error is specifed than script will exit if any
 		# command fails. As there is no transaction there will be
 		# no rollback either
@@ -598,4 +624,3 @@ then
 fi
 
 "cmd_$command" "$@"
