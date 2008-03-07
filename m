From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 1/4] git-submodule summary: code framework
Date: Sat,  8 Mar 2008 02:27:16 +0800
Message-ID: <1204914439-23145-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 07 19:29:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXhJL-0006ub-1O
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 19:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbYCGS1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 13:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbYCGS1Y
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 13:27:24 -0500
Received: from mail.qikoo.org ([60.28.205.235]:43651 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932283AbYCGS1X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 13:27:23 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 4FA02470AE; Sat,  8 Mar 2008 02:27:19 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76510>

Following patches will teach git-submodule a new subcommand 'summary' to
show commit summary of user-cared (i.e. checked out) submodules between
a given super project commit (default to HEAD) and working tree
(or index, switched by --cached).

This patch just introduces the framework and find submodules which has
summary to show. A submodule will have summary if it fits into any one of
following cases.

  - type 'M': modified and checked out    (1)
  - type 'A': added and checked out       (2)
  - type 'D': deleted
  - type 'T': typechanged (blob <-> submodule)

Note:
  1. There may be modified but not checked out cases. In the case of a
     merge conflict, even if the submodule is not checked out, there may
	 be still a diff between index and HEAD on the submodule entry
	 (i.e. modified). The summary will not be show for such a submodule.
  2. A similar explanation applies to the added but not checked out case.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   61 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a6aaf40..0a48f57 100755
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
@@ -320,7 +320,58 @@ set_name_rev () {
 	) )
 	test -z "$revname" || revname=" ($revname)"
 }
+#
+# Show commit summary for submodules in index or working tree
+#
+# If '--cached' is given, show summary between index and given commit,
+# or between working tree and given commit
+#
+# $@ = [commit (default 'HEAD'),] requested paths (default all)
+#
+cmd_summary() {
+	# parse $args after "submodule ... summary".
+	while test $# -ne 0
+	do
+		case "$1" in
+		--cached)
+			cached="$1"
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
 
+	if rev=$(git rev-parse --verify "$1^0" 2>/dev/null)
+	then
+		head=$rev
+		shift
+	else
+		head=HEAD
+	fi
+
+	cd_to_toplevel
+	# Get modified modules cared by user
+	modules=$(git diff-index $cached --raw $head -- "$@" |
+		grep -e '^:160000' -e '^:[0-7]* 160000' |
+		while read mod_src mod_dst sha1_src sha1_dst status name
+		do
+			# Always show modules deleted or type-changed (blob<->module)
+			test $status = D -o $status = T && echo "$name" && continue
+			# Also show added or modified modules which are checked out
+			GIT_DIR="$name/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
+			echo "$name"
+		done
+	)
+}
 #
 # List all submodules, prefixed with:
 #  - submodule not initialized
@@ -391,7 +442,7 @@ cmd_status()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | init | update | status)
+	add | init | update | status | summary)
 		command=$1
 		;;
 	-q|--quiet)
@@ -406,7 +457,7 @@ do
 		branch="$2"; shift
 		;;
 	--cached)
-		cached=1
+		cached="$1"
 		;;
 	--)
 		break
@@ -430,8 +481,8 @@ then
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

