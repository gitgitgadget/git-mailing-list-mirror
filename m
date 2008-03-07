From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 3/4] git-submodule summary: limit summary size
Date: Sat,  8 Mar 2008 02:27:18 +0800
Message-ID: <1204914439-23145-3-git-send-email-pkufranky@gmail.com>
References: <1204914439-23145-1-git-send-email-pkufranky@gmail.com>
 <1204914439-23145-2-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 07 19:29:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXhJN-0006ub-0i
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 19:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbYCGS1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 13:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbYCGS12
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 13:27:28 -0500
Received: from mail.qikoo.org ([60.28.205.235]:43656 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932312AbYCGS1X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 13:27:23 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 5D9CB470AF; Sat,  8 Mar 2008 02:27:19 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1204914439-23145-2-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76512>

This patch teaches git-submodule an option '--summary-limit|-n <number>'
to limit number of commits in total for the summary of each submodule in
the modified case (only a single commit is shown in other cases).

Number 0 will disable summary and minus number means unlimted (the default).

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1751ab2..d0a0205 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,7 +4,9 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update|summary [<commit>]] [--] [<path>...]'
+USAGE="[--quiet] [--cached] \
+[add <repo> [-b branch]|status|init|update|summary [-n|--summary-limit <n>] [<commit>]] \
+[--] [<path>...]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -329,6 +331,8 @@ set_name_rev () {
 # $@ = [commit (default 'HEAD'),] requested paths (default all)
 #
 cmd_summary() {
+	summary_limit=-1
+
 	# parse $args after "submodule ... summary".
 	while test $# -ne 0
 	do
@@ -336,6 +340,15 @@ cmd_summary() {
 		--cached)
 			cached="$1"
 			;;
+		-n|--summary-limit)
+			if summary_limit=$(($2 + 0)) 2>/dev/null && test "$summary_limit" = "$2"
+			then
+				:
+			else
+				usage
+			fi
+			shift
+			;;
 		--)
 			shift
 			break
@@ -350,6 +363,8 @@ cmd_summary() {
 		shift
 	done
 
+	test $summary_limit = 0 && return
+
 	if rev=$(git rev-parse --verify "$1^0" 2>/dev/null)
 	then
 		head=$rev
@@ -445,8 +460,10 @@ cmd_summary() {
 		else
 			if test $mod_src = 160000 -a $mod_dst = 160000
 			then
+				limit=
+				test $summary_limit -gt 0 && limit="-$summary_limit"
 				GIT_DIR="$name/.git" \
-				git log --pretty='format:  %m %s' \
+				git log $limit --pretty='format:  %m %s' \
 				--left-right --first-parent $sha1_src...$sha1_dst
 			elif test $mod_dst = 160000
 			then
-- 
1.5.4.3.347.g5314c

