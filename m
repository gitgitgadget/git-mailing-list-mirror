From: imyousuf@gmail.com
Subject: [PATCH] - git submodule subcommand parsing modified.
Date: Mon, 14 Jan 2008 09:22:36 +0600
Message-ID: <1200280956-19920-1-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 04:23:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEFvE-0004ZZ-JA
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 04:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbYANDW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 22:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbYANDW7
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 22:22:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:47182 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbYANDW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 22:22:57 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2100299fga.17
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 19:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=pBsJghJ3oji6Ozim9soomyI835rUOxRip+WyKWJq/PI=;
        b=KWe0OEwmWKPyc6h9vyNvzj4qxX3WnvcR4TAv2aMBYIYv2lx1FyyCOSc+3Ur0qjL+grSDI57cUv73c4VpPQX97OUpMUky7IpmcMrp43fp2ScJ1NeIJT6273LRmPVQeMStdfs4lktvdOwW2noJRMbPeBt8oGYrTWux3M/Lmg+Rhnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=B9o+nBPSJ2ddkmkQPiHrXiERpzrh9HUY/7xNXX+OGidzRnGI//kKWYacPsoTAYyiqMkRXrUfzQIMll+euIm5i1WoEOVrwH7uzQFnBAeX5Prz4oKGdJ5gtvmwzau5xkkSnWThf8Bgzbeu6NrM081TMJsKl++mKlRmWKEPO6asCnk=
Received: by 10.86.78.4 with SMTP id a4mr5781651fgb.3.1200280975828;
        Sun, 13 Jan 2008 19:22:55 -0800 (PST)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id e11sm4652057fga.5.2008.01.13.19.22.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 19:22:55 -0800 (PST)
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70434>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

- manual page of git-submodule and usage mentioned in git-subcommand.sh
were not same, thus synchronized them. In doing so also had to change the
way the subcommands were parsed.

- Previous version did not allow commands such as
	git-submodule add init update
as the command parser incorrectly made subcommand names reserve.
Thus refusing them to be used as parameters to subcommands. As a result it
was impossible to add a submodule whose (symbolic) name is "init" and that
resides at path "update" was refused. For more details the following case
can be considered -

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

- Status currently is implemented to show list only but later
implementation might change and list and status could coexists. Thus
status module is introduced. The module is also used to parse its
arguments

- Subcommands will also parse their own commands; thus enabling command
specific arguments to be passed after the command. For example,
	git-submodule -q add -b master module_a
	git-submodule -q status -c
It is to be noted that -q or --quiet is specified before the subcommand
since it is for the submodule command in general rather than the
subcommand. It is mention worthy that backward compatibility exists and
thus commands like git submodule --cached status will also work as expected

- Subcommands that currently do not take any arguments (init and update)
has a case which is introduced just to ensure that no argument is
deliberately sent as the first argument and also to serve the purpose of
providing a future extension point for its arguments.

- Though ther was short and long version for quiet (-q or --quiet and
branch (-b or --branch) but there was no short version for cached. Thus
it is now introduced (-c or --cached).

- Added 3 specific messages for usage error related to branch and cached

- Simplified subcommand action invocation by simply invoking the action if
all conditions are fulfilled. Excepting for parsing command line arguments
case statements are avoided and instead more direct if statement is
introduced.
---
 git-submodule.sh |  158 +++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 114 insertions(+), 44 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ad9fe62..22e7e5f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,18 +4,23 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
+# Synopsis of this commands are as follows
+# git-submodule [-q|--quiet] add [-b|--branch branch] <repository> [<path>]
+# git-submodule [-q|--quiet] [status] [-c|--cached] [--] [<path>...]
+# git-submodule [-q|--quiet] init [--] [<path>...]
+# git-submodule [-q|--quiet] update [--] [<path>...]
+USAGE='[-q|--quiet] [[[add [-b|--branch branch] <repo>]|[[[status [-c|--cached]]|init|update] [--]]]  [<path>...]]'
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
@@ -114,6 +119,17 @@ module_clone()
 	die "Clone of '$url' into submodule path '$path' failed"
 }
 
+# Parses the branch name and exits if not present
+parse_branch_name()
+{
+	branch="$1"; 
+	if test -z "$branch"
+	then
+		echo Branch name must me specified	
+		usage
+	fi
+}
+
 #
 # Add a new submodule to the working tree, .gitmodules and the index
 #
@@ -123,6 +139,16 @@ module_clone()
 #
 module_add()
 {
+	case "$1" in
+		-b|--branch)
+			shift
+			parse_branch_name "$@" &&
+			shift
+			;;
+		-*)
+			usage
+			;;
+	esac
 	repo=$1
 	path=$2
 
@@ -176,6 +202,14 @@ module_add()
 #
 modules_init()
 {
+	# Added here to ensure that no argument is passed to be treated as
+	# parameter to the sub command. This will be used to parse any 
+	# to the subcommand
+	case "$1" in
+		-*)
+			usage
+			;;
+	esac
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
@@ -209,6 +243,14 @@ modules_init()
 #
 modules_update()
 {
+	# Added here to ensure that no argument is passed to be treated as
+	# parameter to the sub command. This will be used to parse any 
+	# to the subcommand
+	case "$1" in
+		-*)
+			usage
+			;;
+	esac
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
@@ -293,36 +335,69 @@ modules_list()
 	done
 }
 
+# Delgates to modules_list after parsing its arguments
+modules_status()
+{
+	case "$1" in
+		-c|--cached)
+			shift
+			cached=1
+			;;
+		-*)
+			usage
+			;;
+	esac
+	"$MODULES_LIST" "$@"
+}
+
+# If there is '--' as the first argument simply ignores it and thus shifts
+check_for_terminator()
+{
+	if test -n "$1" && test "$1" = "--"
+	then
+		shift
+	fi
+}
+
+
+
+# Command synopsis clearly shows that all arguments after
+# subcommand are arguments to the command itself. Thus
+# there lies no command that has configuration argument
+# after the mention of the subcommand. Thus once the
+# subcommand is found and the separator ('--') is ignored
+# rest can be safely sent the subcommand action
+# It is to be noted that pre-subcommand arguments are parsed
+# just to have backward compatibility.
 while test $# != 0
 do
 	case "$1" in
 	add)
 		add=1
+		command="module_$1"
+		shift
+		break
 		;;
-	init)
-		init=1
-		;;
-	update)
-		update=1
-		;;
-	status)
-		status=1
+	init|update|status)
+		command="modules_$1"
+		shift
+		check_for_terminator "$1"
+		break
 		;;
 	-q|--quiet)
 		quiet=1
 		;;
 	-b|--branch)
-		case "$2" in
-		'')
-			usage
-			;;
-		esac
-		branch="$2"; shift
+		shift
+		parse_branch_name "$@"
 		;;
-	--cached)
+	-c|--cached)
 		cached=1
 		;;
 	--)
+		# It is shifted so that it is not passed
+		# as an argument to the default subcommand
+		shift
 		break
 		;;
 	-*)
@@ -335,30 +410,25 @@ do
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
+# If no command is specified then default command
+# is - git submodule status
+test -z "$command" && command="modules_status"
+
+# Throws usage if --cached is used by other than status, init or update
+# that is used with add command
+if test -n "$cached" &&
+   test "$command" != "modules_status"
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
