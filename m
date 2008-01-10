From: imyousuf@gmail.com
Subject: [PATCH] - Updated usage and simplified sub-command action invocation
Date: Thu, 10 Jan 2008 10:07:25 +0600
Message-ID: <1199938045-16289-1-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 10 05:08:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCoiE-0006z7-0j
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 05:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbYAJEHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 23:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754249AbYAJEHj
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 23:07:39 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:25864 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189AbYAJEHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 23:07:38 -0500
Received: by fg-out-1718.google.com with SMTP id e21so522614fga.17
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 20:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=m8cG1zpHBrHMLTh5Ob618wsaf/HQygZzoYhFTKo7lRQ=;
        b=YlZugblZ27xzxDLXuqBINARWOknXlpkxF1SchPwrk+YTWSJUHJKQER6kb+9nurUgicns8o44VAIkYLC4vEW/onyL/5uDzxHdMZEuSGqYVAJhdM4eCL8A5rWNESit5ra81Qi5Ntx33ZxRXtUrOxh3TeNJe5zckBYI4gmc9V+5qKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Aqk/kysWZPF71XNrFU/AzQuz6lUS+iz1N5NHKoYxnXYwAyCjs7XCGSrMUjoqj7IG3OWEQIYSwN7TQ+GZ0bzCEUID4+VIHGWQdg5WkM/BS/qmPFRfxIGX7VtTff3PKVZmmzQ0IC1Ez4iie9V3zhso80BqGFH4OfQuZGBcyfpSybs=
Received: by 10.86.50.8 with SMTP id x8mr1364391fgx.61.1199938056145;
        Wed, 09 Jan 2008 20:07:36 -0800 (PST)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id 4sm1078880fge.8.2008.01.09.20.07.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Jan 2008 20:07:35 -0800 (PST)
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70040>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

- manual page of git-submodule and usage mentioned in git-subcommand.sh
were not same, thus synchronized them. In doing so also had to change the
way the subcommands were parsed.

- Previous version did not allow commands such as "git-submodule add init
update". Thus not satisfying the following case -

mkdir g; mkdir f; cd g/
touch g.txt; echo "sample text for g.txt" >> ./g.txt; git-init;
git-add g.txt; git-commit -a -m "First commit on g"
cd ../f/; ln -s ../g/ init
git-init; git-submodule add init update;
git-commit -a -m "With module update"
mkdir ../test; cd ../test
git-clone ../f/; cd f
git-submodule init update; git-submodule update update
cd ../..; rm -rf ./f/ ./test/ ./g/

This patch fixes this issue and allows it as well.

- Added 2 specific messages for usage error related to branch and cached

- Simplified subcommand action invocation by simply invoking the action if
all conditions are fulfilled. Excepting for parsing command line arguments
case statements are avoided and instead more direct if statement is
introduced.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 git-submodule.sh |   97 ++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ad9fe62..5d5e41d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,18 +4,23 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
+# Synopsis of this commands are as follows
+# git-submodule [--quiet] [-b branch] add <repository> [<path>]
+# git-submodule [--quiet] [--cached] [status] [--] [<path>...]
+# git-submodule [--quiet] init [--] [<path>...]
+# git-submodule [--quiet] update [--] [<path>...]
+USAGE='[--quiet] [[[[-b branch] add <repo>]|[[[[--cached] status]|init|update] [--]]]  [<path>...]]'
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
 
+MODULES_LIST='modules_list'
+
 add=
 branch=
-init=
-update=
-status=
 quiet=
 cached=
+command=
 
 #
 # print stuff on stdout unless -q was specified
@@ -293,20 +298,47 @@ modules_list()
 	done
 }
 
+# If there is '--' as the first argument simply ignores it and thus shifts
+check_for_terminator()
+{
+	if test -n "$1" && test "$1" = "--"
+	then
+		shift
+	fi
+}
+
+# Command synopsis clearly shows that all arguments after
+# subcommand are arguments to the command itself. Thus
+# there lies no command that has configuration argument
+# after the mention of the subcommand. Thus once the
+# subcommand is found and the separator ('--') is ignored
+# rest can be safely sent the subcommand action
 while test $# != 0
 do
 	case "$1" in
 	add)
 		add=1
+		command="module_$1"
+		shift
+		break
 		;;
 	init)
-		init=1
+		command="modules_$1"
+		shift
+		check_for_terminator "$1"
+		break
 		;;
 	update)
-		update=1
+		command="modules_$1"
+		shift
+		check_for_terminator "$1"
+		break
 		;;
 	status)
-		status=1
+		command="$MODULES_LIST"
+		shift
+		check_for_terminator "$1";
+		break
 		;;
 	-q|--quiet)
 		quiet=1
@@ -323,6 +355,9 @@ do
 		cached=1
 		;;
 	--)
+		# It is shifted so that it is not passed
+		# as an argument to the default subcommand
+		shift
 		break
 		;;
 	-*)
@@ -335,30 +370,28 @@ do
 	shift
 done
 
-case "$add,$branch" in
-1,*)
-	;;
-,)
-	;;
-,*)
+# Throws usage error if branch is not used with add command
+if test -n "$branch" &&
+   test -z "$add"
+then
+	echo Branch can not be specified without add subcommand
 	usage
-	;;
-esac
-
-case "$add,$init,$update,$status,$cached" in
-1,,,,)
-	module_add "$@"
-	;;
-,1,,,)
-	modules_init "$@"
-	;;
-,,1,,)
-	modules_update "$@"
-	;;
-,,,*,*)
-	modules_list "$@"
-	;;
-*)
+fi
+
+# If no command is specified than default command
+# is - git submodule status
+if test -z "$command"
+then
+	command="$MODULES_LIST"
+fi
+
+# Throws usage if --cached is used by other than status, init or update
+# that is used with add command
+if test -n "$cached" &&
+   test "$command" != "$MODULES_LIST"
+then
+	echo Cached can only be used with the status subcommand
 	usage
-	;;
-esac
+fi
+
+"$command" "$@"
-- 
1.5.3.7
