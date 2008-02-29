From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 1/3] git-submodule: New subcommand 'summary' (1) - code framework
Date: Sat,  1 Mar 2008 01:34:45 +0800
Message-ID: <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 19:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV9cI-0005g1-6g
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 19:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbYB2SE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 13:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756860AbYB2SEy
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 13:04:54 -0500
Received: from mail.qikoo.org ([60.28.205.235]:54461 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756321AbYB2SEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 13:04:51 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 3D5DE470AD; Sat,  1 Mar 2008 01:34:47 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75546>

Following patches teach git-submodule a new subcommand 'summary' to show
commit summary of user-cared (i.e. checked out) submodules since a given
commit (default HEAD) of super project.

For a submodule in question, a series of commits will be shown as the path
from the src commit to the dst commit, where the src commit is from the given
super project commit, and the dst commit is from the index or working tree
(switched by --cached).

.Example: a super project with modified/deleted/typechanged submodules sm1 to sm5.
--------------------------------------------
 $ git submodule summary
 # Submodules modifiled: sm1 sm2 sm3 sm4 sm5
 #
 # * sm1 354cd45...3f751e5:
 #   <one line message for C
 #   <one line message for B
 #   >one line message for D
 #   >one line message for E
 #
 # * sm2 5c8bfb5...000000:
 #   <one line message for F
 #
 # * sm3 354cd45...3f751e5:
 #   Warn: sm3 doesn't contain commit 354cd45
 #
 # * sm4 354cd34(submodule)->235efa(blob):
 #   <one line message for G
 #
 # * sm5 354cd34(blob)->235efa(submodule):
 #   >one line message for H
 #
--------------------------------------------

sm1 has commit C as src (given commit or HEAD) and commit E as dst (index
or working tree) as following picture shows.
	--A-->B-->C (in src:354cd45)
	  \
	   -->D-->E (in dst:3f751e5)

The 'Submodules modified' section for sm1 shows how to change sm1 from
src commit C to dst commit E: firstly backward (<) to commit A from
commit C via commit B, and then forward (>) to commit E via commit D.

Illustration for output of deleted sm2 is similar.

sm3 and sm4 are submodules with typechanging (blob<->submodule).

If the src/dst commit for a submodule is not found in the work tree (say
the submodule respository in the work tree), a warning will be issued.
sm3 falls into this case.

This patch just gives the framework. It just finds the submodules to be
shown as follows.

--------------------------------------------
 $ git submodule summary
 # Submodules modifiled: sm1 sm2 sm3 sm4 sm5
 #
--------------------------------------------

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a6aaf40..8009a8d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,7 +4,7 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
+USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update|summary [<commit>]] [--] [<path>...]'
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -320,7 +320,69 @@ set_name_rev () {
 	) )
 	test -z "$revname" || revname=" ($revname)"
 }
+#
+# Show commit summary for submodules in index or working tree relative to the given commit
+#
+# If '--cached' is given, show summary between index and given commit,
+# or between working tree and given commit
+#
+# @ = [head counting commits from (default 'HEAD'),] requested paths (default to all)
+#
+cmd_summary()
+{
+	# parse $args after "submodule ... summary".
+	while test $# -ne 0
+	do
+		case "$1" in
+		--cached)
+			cached=1
+			;;
+		--)
+			shift
+			break
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
 
+	cache_option=${cached:+--cached}
+
+	if rev=$(git rev-parse --verify "$1^0" 2>/dev/null)
+	then
+		head=$rev
+		shift
+	else
+		head=HEAD
+	fi
+
+	cwd=$(pwd)
+	cd_to_toplevel
+
+	# Get modified modules cared by user
+	modules=$(git diff $cache_option --raw $head -- "$@" |
+		grep '^:160000\|:[0-9]\+ 160000' |
+		while read mod_src mod_dst sha1_src sha1_dst status name
+		do
+			# Always show modules deleted or type-changed (blob<->module)
+			test $status = D -o $status = T && echo "$name" && continue
+			# Also show added or modified modules which are checked out
+			GIT_DIR="$name/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
+			echo "$name"
+		done
+	)
+
+	# TODO: quote module names containing space or tab
+	test -n "$modules" &&
+	echo "# Submodules modified: "$modules &&
+	echo "#"
+	cd "$cwd"
+}
 #
 # List all submodules, prefixed with:
 #  - submodule not initialized
@@ -391,7 +453,7 @@ cmd_status()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | init | update | status)
+	add | init | update | status | summary)
 		command=$1
 		;;
 	-q|--quiet)
@@ -430,8 +492,8 @@ then
 	usage
 fi
 
-# "--cached" is accepted only by "status"
-if test -n "$cached" && test "$command" != status
+# "--cached" is accepted only by "status" and "summary"
+if test -n "$cached" && test "$command" != status -a "$command" != summary
 then
 	usage
 fi
-- 
1.5.4.3.347.g5314c

