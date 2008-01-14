From: imyousuf@gmail.com
Subject: [PATCH] - Introduced 'recurse' command for git-submodule
Date: Mon, 14 Jan 2008 09:23:00 +0600
Message-ID: <1200280980-20081-1-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 04:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEFvd-0004bp-JH
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 04:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbYANDXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 22:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640AbYANDXW
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 22:23:22 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:47182 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbYANDXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 22:23:20 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2100299fga.17
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 19:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=UIZzI1viVKq12EK6q1J9HTn/t6tTt4+vtevU/EUnOkg=;
        b=Rz6Ldq6VxtlsoV6H/GD2nfnCKpO3zYsKWTQh+4rDje4iy8ps6clqcmF5N1BobpUeYTbvA/YHfvWvGJ0AXkvmX4l+D/06r0Io+8zPOYE+a3HDeoXfp3fWYuuaNUD2590C+N1jjt4Sv786taokQ83hpdT3lLE4v++J/PzNE7/IdDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Rz4zOiPYLyXvP4jYMMA42T8THhk/1Zy58Ip61J5ZYu99EQpt5FYHbSHBNFJHuAXgOK6MpbtHdkj5Hzh5EvwdrynxuIgP4f/GdZIjSy8z518xiaRnVA85+GJAPLy4jcMh5SYKHacgmHFm+4az+kxwuDp0XFk3bvJSzy8SyliVV+c=
Received: by 10.86.54.3 with SMTP id c3mr1871850fga.18.1200280999965;
        Sun, 13 Jan 2008 19:23:19 -0800 (PST)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id 3sm5902611fge.7.2008.01.13.19.23.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 19:23:19 -0800 (PST)
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70435>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

- The purpose of the recurse command in the git submodule is to recurse
a command in its submodule. For example if one wants to do a diff on its
project with submodules at once, one can simply do
	git-submodule recurse diff HEAD
and would see the diff for all the modules it contains.

- The recurse commands behavior can be customized with several arguments
that it accepts. The synopsis for the recurse command is:

	git-submodule [-q|--quiet] recurse [-i|--initialize]
	[-e|--exit-after-error] [-d|--depth <recursion depth>]
	[-df|--depth-first] [-ca|--customized-argument] [-p|--pre-command]
	<command> [<arguments> ...]

- When traversing modules, a module could be uninitialized that is git
submodule init and update has not been called for it; if [-i|--initialize]
option is specified, it will initialize any module that is not initialized;
else if the module is not initialized it will simply skip it.

- There are commands that can fail for a certain submodule but succeed for
others; if one wants to stop execution once the top level module's execution
fails, one can specify [-e|--exit-after-error]. It will ensure that once
execution of git <command> fails in the top level module it will not recurse
into its submodules.

- If the project has submodule hierarchy upto n depth and we want to restrict
recursion to (n-p) depth; we can use the [-d|--depth <recursion depth>] option.
Value has to be greater than 0 and command will at least recurse into the first
depth. If depth is specified to p than all depths <= p will be recursed over.

- While discussion on the recurse command one thing which was put forward
in several occassions is that there might be scenario where a command should be
executed over the child module before the parent module. For such scenario
[-df|--depth-first] option can be used; one use case in particualar presented
as an example is git commit; where almost everybody mentioned that they prefer
to commit the child module before the parent and -df will enable just that.
E.g. p -> a, b, c, e; a ->d is a module structure. If the following command is
used,
	git submodule recurse -df commit -a
it will execute git commit -a in the following sequence - d, a, b, c, e, p.

- There is also another scenario which has been put forward several times in
discussion over the recurse command and it is that commands chould have
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

- I usually found that when typing a command being able to see some options
come in handy. For example if I can see the available branches before checking
out a branch that would be useful, IOW, if I could git branch before git
checkout; it is now possible using the [-p|--pre-command] option. Using this
command you can actually execute other git commands before specifying the
arguments to the original command. E.g. if the above command is changed to,
	git submodule recurse -ca -p checkout
it will prompt the user for the pre command until one is satisfied and later
the user can actually use them in the argument.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 git-submodule.sh |  183 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 182 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 22e7e5f..ceca985 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,8 @@
 # git-submodule [-q|--quiet] [status] [-c|--cached] [--] [<path>...]
 # git-submodule [-q|--quiet] init [--] [<path>...]
 # git-submodule [-q|--quiet] update [--] [<path>...]
-USAGE='[-q|--quiet] [[[add [-b|--branch branch] <repo>]|[[[status [-c|--cached]]|init|update] [--]]]  [<path>...]]'
+# git-submodule [-q|--quiet] recurse [-i|--initialize] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-df|--depth-first] [-ca|--customized-argument] [-p|--pre-command] <command> [<arguments> ...]
+USAGE='[-q|--quiet] [[[add [-b|--branch branch] <repo>]|[[[status [-c|--cached]]|init|update] [--]]]  [<path>...]]|[recurse [-i|--initialize] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-df|--depth-first] [-ca|--customized-argument] [-p|--pre-command] <command> [<arguments> ...]]'
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -21,6 +22,14 @@ branch=
 quiet=
 cached=
 command=
+depth=0
+current_depth=0
+auto_initialize=
+depth_first=
+use_custom_args=
+custom_args=
+pre_cmd=
+on_error=
 
 #
 # print stuff on stdout unless -q was specified
@@ -359,7 +368,174 @@ check_for_terminator()
 	fi
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
+# Take command from user and execute it until user wants to discontinue
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
 
+# Take arguments from user to pass as custom arguments
+get_custom_args()
+{
+	read -p "Please provide arguments for this module: " custom_args
+}
+
+traverse_submodule()
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
+# This actually traverses the module; checks
+# whether the module is initialized or not.
+# if not initialized, then done so and then the
+# intended command is evaluated. Then it
+# recursively goes into it modules.
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
+		test -n "$depth_first" && traverse_submodule "$@"
+		# pwd is mentioned in order to enable the ser to distinguish
+		# between same name modules, e.g. a/lib and b/lib.
+		say "Working in mod $submod_path" @ `pwd` "with $@ ($#)"
+		test -n "$pre_cmd" && do_pre_command
+		test -n "$use_custom_args" && get_custom_args
+		cmd_status=
+		git "$@" "$custom_args" || cmd_status=1
+		# if exit on error is specifed than script will exit if any
+		# command fails. As there is no transaction there will be
+		# no rollback either
+		if  test -n "$cmd_status" && test -n "$on_error"
+		then
+			die "git $@ failed in module $submod_path @ $(pwd)"
+		fi
+		# If depth-first is not specified in that case submodules are
+		# are traversed after executing the command on this module
+		test -z "$depth_first" && traverse_submodule "$@"
+	)
+}
+
+# Propagates or recurses over all the submodules at any
+# depth with any git command, e.g. git-clone, git-status,
+# git-commit etc., with the arguments supplied exactly as
+# it would have been supplied to the command otherwise.
+# This actually starts the recursive propagation
+modules_recurse() {
+	while :
+	do
+		case "$1" in
+			-d|--depth)
+				shift
+				if test -z "$1"
+				then
+					echo "No <recursion depth> specified"
+					usage
+				# Arithmatic operation will give an error if depth is not number
+				# thus chose to check intergerness with regular expression
+				elif test "$(expr $1 : '[1-9][0-9]*')" -eq "$(expr $1 : '.*')"
+				then
+					depth="$1"
+				else
+					echo "<recursion depth> not an integer"
+					usage
+				fi
+				;;
+			-df|--depth-first)
+				depth_first=1
+				;;
+			-e|--exit-after-error)
+				on_error=1
+				;;
+			-i|--initialize)
+				auto_initialize=1
+				;;
+			-p|--pre-command)
+				pre_cmd=1
+				;;
+			-ca|--customized-argument)
+				use_custom_args=1
+				;;
+			-*)
+				usage
+				;;
+			*)
+				break
+				;;
+		esac
+		shift
+	done
+	test "$#" -le 0 && die "No git command specified"
+	project_home="$(pwd)"
+	say "Project Home: $project_home"
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
 
 # Command synopsis clearly shows that all arguments after
 # subcommand are arguments to the command itself. Thus
@@ -394,6 +570,11 @@ do
 	-c|--cached)
 		cached=1
 		;;
+	recurse)
+		command="modules_$1"
+		shift
+		break
+		;;
 	--)
 		# It is shifted so that it is not passed
 		# as an argument to the default subcommand
-- 
1.5.3.7
