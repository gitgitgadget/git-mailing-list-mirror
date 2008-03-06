From: imyousuf@gmail.com
Subject: [PATCH] - Added 'recurse' subcommand to git submodule
Date: Thu,  6 Mar 2008 13:33:34 +0600
Message-ID: <1204788817-22720-2-git-send-email-imyousuf@gmail.com>
References: <1204788817-22720-1-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 08:34:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXAcq-00080a-O7
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 08:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbYCFHeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 02:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755015AbYCFHeH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 02:34:07 -0500
Received: from hu-out-0506.google.com ([72.14.214.236]:41464 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918AbYCFHeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 02:34:05 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1229660hue.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 23:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eARaXvUlq8XadwbBP3Zl6JVOBocV9Xix/d13EhV4X88=;
        b=Ls4xzoM68W7t6Mb7XNk5AZzphjnDh/CNrdFoYCPQVQ9lCYFbrywjV1fE5KfdNwObDyhzTEdmh0AB75+ePtK4QOLfxRopzFBkb9TI2hdOHz7TGRV+M4CUZkVGVU8cpD8jplOjbsAPoB8BPCD/ndUvdvlSyjqbGeC5gicUr7jhyuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Gz3QP7qArbzFozgysEiV8AaAJLHy/CdZjQ4scKl45fvWnD2fDw3EZ4Ql9jmcBgP81DQUCfZ180PSgluYJlrWV5nXlfheeUTCsZW/aFJF72vp+unnXBud6yB9lEJ7QOTGjL1dHo6fFPXMJIE9ukVA+xChXyLpHr1X4LQygYOMN4s=
Received: by 10.86.1.1 with SMTP id 1mr4310517fga.2.1204788843970;
        Wed, 05 Mar 2008 23:34:03 -0800 (PST)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id q9sm3126752gve.10.2008.03.05.23.33.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 23:34:03 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1204788817-22720-1-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76348>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

The purpose of the recurse command in the git submodule is to recurse
a command in its submodule. For example if one wants to do a diff on its
project with submodules at once, one can simply do
	git-submodule recurse diff HEAD
and would see the diff for all the modules it contains.

The recurse commands behavior can be customized with several arguments
that it accepts. The synopsis for the recurse command is:

	git-submodule [-q|--quiet] recurse [-i|--initialize]
	[-e|--exit-after-error] [-d|--depth <recursion depth>]
	[-df|--depth-first] [-ca|--customized-argument] [-p|--pre-command]
	<command> [<arguments> ...]

When traversing modules, a module could be uninitialized that is git
submodule init and update has not been called for it; if [-i|--initialize]
option is specified, it will initialize any module that is not initialized;
else if the module is not initialized it will simply skip it.

There are commands that can fail for a certain submodule but succeed for
others; if one wants to stop execution once the top level module's execution
fails, one can specify [-e|--exit-after-error]. It will ensure that once
execution of git <command> fails in the top level module it will not recurse
into its submodules.

If the project has submodule hierarchy upto n depth and we want to restrict
recursion to (n-p) depth; we can use the [-d|--depth <recursion depth>] option.
Value has to be greater than 0 and command will at least recurse into the first
depth. If depth is specified to p than all depths <= p will be recursed over.

While discussion on the recurse command one thing which was put forward
in several occassions is that there might be scenario where a command should be
executed over the child module before the parent module. For such scenario
[-df|--depth-first] option can be used; one use case in particualar presented
as an example is git commit; where almost everybody mentioned that they prefer
to commit the child module before the parent and -df will enable just that.
E.g. p -> a, b, c, e; a ->d is a module structure. If the following command is
used,
	git submodule recurse -df commit -a
it will execute git commit -a in the following sequence - d, a, b, c, e, p.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 git-submodule.sh |  162 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 257be4c..ee3c928 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,7 +8,8 @@
 # git-submodule [-q|--quiet] add [-b|--branch branch] <repository> [<path>]
 # git-submodule [-q|--quiet] [status] [-c|--cached] [--] [<path>...]
 # git-submodule [-q|--quiet] init|update [--] [<path>...]
-USAGE='[-q|--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
+# git-submodule [-q|--quiet] recurse [-i|--initialize] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-df|--depth-first] <command> [<arguments> ...]
+USAGE='[-q|--quiet] [[[add [-b|--branch branch] <repo>]|[[[status [-c|--cached]]|init|update] [--]]]  [<path>...]]|[recurse [-i|--initialize] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-df|--depth-first] <command> [<arguments> ...]]'
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -17,6 +18,11 @@ command=
 branch=
 quiet=
 cached=
+depth=0
+current_depth=0
+auto_initialize=
+depth_first=
+on_error=
 
 #
 # print stuff on stdout unless -q was specified
@@ -386,6 +392,157 @@ cmd_status()
 	done
 }
 
+# Initializes the submodule if already not initialized
+# and auto initialize is enabled
+initialize_sub_module()
+{
+	if test ! -d "$1"/.git &&
+	   test -n "$auto_initialize"
+	then
+		say "Initializing and updating $1"
+		git-submodule init "$1" &&
+		git-submodule update "$1" &&
+		return 0
+	# Returns true if module is already initialized
+	elif test -d "$1"/.git
+	then
+		return 0
+	fi
+	say "Module $1 is not initialized and skipped"
+	return 1
+}
+
+# This module simply checks whether the depth is traverseable
+# in terms of depth and if so then it sequentially traverses
+# its submodules
+traverse_submodules()
+{
+	# If current depth is the range specified than it will continue
+	# else return with success
+	if test "$depth" -gt 0 &&
+		test "$current_depth" -ge "$depth"
+	then
+		return 0;
+	fi
+	# If submodules exists than it will traverse over them
+	if test -f .gitmodules
+	then
+		# Incrementing the depth for the next level of submodules
+		current_depth=$(($current_depth + 1))
+                for mod_path in `sed -n -e 's/path = //p' .gitmodules`; do
+                        traverse_module "$mod_path" "$@"
+                done
+		# Decremented the depth to bring it back to the depth of
+		# the current module
+		current_depth=$(($current_depth - 1))
+	fi
+}
+
+# This actually traverses a module; checks
+# whether the module is initialized or not.
+# if not initialized, then tries to do so 
+# based on the user preference and then the
+# intended command is evaluated in the 
+# traversal manner requested - breadth first 
+# or depth first. Then it# recursively goes 
+# into it modules.
+traverse_module()
+{
+	# Will work in the module if and only if the module is initialized
+	initialize_sub_module "$1" &&
+	(
+		submod_path="$1"
+		shift
+		cd "$submod_path"
+		# If depth-first is specified in that case submodules are
+		# are traversed before executing the command on this module
+		test -n "$depth_first" && traverse_submodules "$@"
+		# pwd is mentioned in order to enable the ser to distinguish
+		# between same name modules, e.g. a/lib and b/lib.
+		say "Working in mod $submod_path" @ `pwd` "with $@ ($#)"
+		cmd_status=
+		git "$@" || cmd_status=1
+		# if exit on error is specifed than script will exit if any
+		# command fails. As there is no transaction there will be
+		# no rollback either
+		# TODO - If possible facilitate transaction
+		if  test -n "$cmd_status" && test -n "$on_error"
+		then
+			die "git $@ failed in module $submod_path @ $(pwd)"
+		fi
+		# If depth-first is not specified in that case submodules are
+		# are traversed after executing the command on this module
+		test -z "$depth_first" && traverse_submodules "$@"
+	)
+}
+
+# Propagates or recurses over all the submodules at any
+# depth with any git command, e.g. git-clone, git-status,
+# git-commit etc., with the arguments supplied exactly as
+# it would have been supplied to the command otherwise.
+# This actually starts the recursive propagation
+cmd_recurse() {
+	while :
+	do
+		case "$1" in
+		-q|--quiet)
+                	quiet=1
+                	;;
+		-d|--depth)
+			shift
+			if test -z "$1"
+			then
+				echo "No <recursion depth> specified"
+				usage
+			# Arithmatic operation will give an error if depth is not number
+			# thus chose to check intergerness with regular expression
+			elif test "$(expr $1 : '[1-9][0-9]*')" -eq "$(expr $1 : '.*')"
+			then
+				depth="$1"
+			else
+				echo "<recursion depth> not an integer"
+				usage
+			fi
+			;;
+		-df|--depth-first)
+			depth_first=1
+			;;
+		-e|--exit-after-error)
+			on_error=1
+			;;
+		-i|--initialize)
+			auto_initialize=1
+			;;
+		-p|--pre-command)
+			pre_cmd=1
+			;;
+		-ca|--customized-argument)
+			use_custom_args=1
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+	test "$#" -le 0 && die "No git command specified"
+	project_home="$(pwd)"
+	if test "$depth" -gt 0
+	then
+		say Command will recurse upto "$depth" depth
+	fi
+	if test -d "$project_home"/.git/
+	then
+		say "Command to recurse: git $@"
+		traverse_module . "$@"
+	else
+		die "$project_home not a git repo thus exiting"
+	fi
+}
+
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
 # options are primarily done by the subcommand implementations.
@@ -395,7 +552,7 @@ cmd_status()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | init | update | status)
+	add | init | update | status | recurse)
 		command=$1
 		;;
 	-q|--quiet)
@@ -441,3 +598,4 @@ then
 fi
 
 "cmd_$command" "$@"
+
-- 
1.5.4.2

