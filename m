From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v5 1/5] git-submodule summary: code framework
Date: Tue, 11 Mar 2008 21:52:15 +0800
Message-ID: <1205243539-797-2-git-send-email-pkufranky@gmail.com>
References: <1205243539-797-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 11 14:54:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ4uk-0006eX-IZ
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbYCKNwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbYCKNwY
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:52:24 -0400
Received: from mail.qikoo.org ([60.28.205.235]:57647 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751637AbYCKNwW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:52:22 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id C699F470AB; Tue, 11 Mar 2008 21:52:19 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1205243539-797-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76851>

These patches teach git-submodule a new subcommand 'summary' to show
commit summary of checked out submodules between a given super project
commit (defaults to HEAD) and working tree (or index, when --cached is
given).

This patch just introduces the framework to find submodules which have
summary to show. A submodule will have summary if it falls into these
cases:

  - type 'M': modified and checked out    (1)
  - type 'A': added and checked out       (2)
  - type 'D': deleted
  - type 'T': typechanged (blob <-> submodule)

Notes:

  1. There may be modified but not checked out cases. In the case of a
     merge conflict, even if the submodule is not checked out, there may
	 be still a diff between index and HEAD on the submodule entry
	 (i.e. modified). The summary will not be show for such a submodule.
  2. A similar explanation applies to the added but not checked out case.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh |   61 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7171cb6..b70ae40 100755
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
@@ -330,7 +330,58 @@ set_name_rev () {
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
@@ -401,7 +452,7 @@ cmd_status()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | init | update | status)
+	add | init | update | status | summary)
 		command=$1
 		;;
 	-q|--quiet)
@@ -416,7 +467,7 @@ do
 		branch="$2"; shift
 		;;
 	--cached)
-		cached=1
+		cached="$1"
 		;;
 	--)
 		break
@@ -440,8 +491,8 @@ then
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
