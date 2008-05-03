From: imyousuf@gmail.com
Subject: [PATCH 2/5] Add recurse subcommand with basic options
Date: Sat,  3 May 2008 19:53:30 +0600
Message-ID: <1209822813-12237-2-git-send-email-imyousuf@gmail.com>
References: <1209822813-12237-1-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 15:55:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsICu-0005Uk-VG
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 15:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbYECNyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754976AbYECNyK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 09:54:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:60977 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925AbYECNyI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 09:54:08 -0400
Received: by ug-out-1314.google.com with SMTP id h3so301813ugf.16
        for <git@vger.kernel.org>; Sat, 03 May 2008 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9pR/Ota9Tti/WM9mM3tvcwbBUVIzzw8dWPHrB2AnOaY=;
        b=qkb4qis1phYrtFEirwLUnHotmluqkv3+D9teCMh6BRkmVH1N/kxYd/B1vzNRN7Fkxr3dG2m24rZjzZTb+H/XbODwRkjGmjU3QeQ8y6AM0xHOBuA9/7gjFrUGlmrCnZzlG38YL8uXDj2iio/Wva0QUGWTRKULFnfATClAJdeFKEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qFZKiSx4p2awxjEnrPfHBE31Whixfd4KZyQn5t0zPyoA0c+CiCNCrz+vuZg9eM3gYTq/EhURgkD6+XSw/g6bIGlwwxj7CDgDCPfvfy3SBcV5EqWx6xckzWqb4ImTDDDd8jjsih37WA28KKWP0YDKYW2hUfRr49PcJx0Ugo4cZQ8=
Received: by 10.67.115.17 with SMTP id s17mr1508315ugm.56.1209822846617;
        Sat, 03 May 2008 06:54:06 -0700 (PDT)
Received: from localhost ( [122.248.32.83])
        by mx.google.com with ESMTPS id g30sm2455326ugd.54.2008.05.03.06.54.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 May 2008 06:54:06 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1209822813-12237-1-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81084>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

The purpose of the recurse command in the git submodule is to recurse
a command in its submodule. For example if one wants to do a diff on its
project with submodules at once, one can simply do
	git-submodule recurse diff HEAD
and would see the diff for all the modules it contains.

The recurse commands behavior can be customized with several arguments
that it accepts. The synopsis for the recurse command is:

	git-submodule recurse [-q|--quiet] [-e|--exit-after-error]
	[-d|--depth <recursion depth>] [-b|--breadth-first]
	<git command> [<arguments> ...]

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
executed over the child module before the parent module.

	For such scenario [-b|--breadth-first] option can be used; one use case
in particular presented as an example is git commit; where almost everybody
mentioned that they prefer to commit the child module before the parent and
default will enable just that.

	E.g. p -> a, b, c, e; a ->d is a module structure. If the following command is
used,

	git submodule recurse commit -a

it will execute git commit -a in the following sequence - d, a, b, c, e, p.

	Now if one want to instead go in a breadth first manner then one can
specify -b option. E.g. if the above command is -

	git submodule recurse -b commit -a

it will execute git commit -a in the following sequence - p, a, d, b, c, e.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 git-submodule.sh |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a5ee2e5..e0ea21f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -11,7 +11,8 @@ Use $0 -h for more details"
 LONG_USAGE="$0 add [-q|--quiet] [-b|--branch branch] <repository> [<path>]
 $0 [status] [-q|--quiet] [-c|--cached] [--] [<path>...]
 $0 init|update [-q|--quiet] [--] [<path>...]
-$0 summary [--cached] [-n|--summary-limit <n>] [<commit>]"
+$0 summary [--cached] [-n|--summary-limit <n>] [<commit>]
+$0 recurse [-q|--quiet] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-b|--breadth-first] <git command> [<args> ...]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -20,6 +21,10 @@ command=
 branch=
 quiet=
 cached=
+depth=0
+current_depth=0
+depth_first=1
+on_error=
 
 #
 # print stuff on stdout unless -q was specified
@@ -580,6 +585,130 @@ cmd_status()
 	done
 }
 
+# Check whether the submodule is initialized or not
+initialize_sub_module()
+{
+	if test ! -d "$1"/.git 
+	then
+		say "Submodule $1 is not initialized and skipped"
+		return 1
+	# Returns true if submodule is already initialized
+	elif test -d "$1"/.git
+	then
+		return 0
+	fi
+	
+}
+
+# This function simply checks whether the depth is traverseable in terms of
+# depth and if so then it sequentially traverses its submodules
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
+		# the current submodule
+		current_depth=$(($current_depth - 1))
+	fi
+}
+
+# This actually traverses a submodule; checks whether the its initialized
+# or not, does nothing if not initialized.
+traverse_module()
+{
+	# Will work in the submodule if and only if its initialized
+	initialize_sub_module "$1" &&
+	(
+		submod_path="$1"
+		shift
+		cd "$submod_path"
+		# If depth-first is specified in that case submodules are
+		# are traversed before executing the command on this submodule
+		test -n "$depth_first" && traverse_submodules "$@"
+		# pwd is mentioned in order to enable the ser to distinguish
+		# between same name modules, e.g. a/lib and b/lib.
+		say "git submodule recurse $submod_path $*"
+		git "$@"
+		# if exit on error is specifed than script will exit if any
+		# command fails. As there is no transaction there will be
+		# no rollback either
+		# TODO - If possible facilitate transaction
+		if test "$?" -ne 0 && test -n "$on_error"
+		then
+			die "FAILED: git submodule $submod_path $*"
+		fi
+		# If depth-first is not specified in that case submodules are
+		# are traversed after executing the command on this submodule
+		test -z "$depth_first" && traverse_submodules "$@"
+	)
+}
+
+# Propagates or recurses over all the submodules at any depth with any
+# git command, e.g. git-clone, git-status, git-commit etc., with the
+# arguments supplied exactly as it would have been supplied to the command
+# otherwise. This actually starts the recursive propagation.
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
+			# thus chose to check intergerness with regular expression.
+			# $1 is underquoted becuase the expr is in quotation
+			elif test "$(expr $1 : '[1-9][0-9]*')" -eq "$(expr $1 : '.*')"
+			then
+				depth="$1"
+			else
+				echo "<recursion depth> not an integer"
+				usage
+			fi
+			;;
+		-b|--breadth-first)
+			depth_first=
+			;;
+		-e|--exit-after-error)
+			on_error=1
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
+	if test -d "$project_home"/.git/
+	then
+		traverse_module . "$@"
+	else
+		die "$project_home not a git repo thus exiting"
+	fi
+}
+
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
 # options are primarily done by the subcommand implementations.
@@ -589,7 +718,7 @@ cmd_status()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | init | update | status | summary)
+	add | init | update | status | summary |recurse)
 		command=$1
 		;;
 	-q|--quiet)
-- 
1.5.4.2
