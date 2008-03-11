From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v5 3/5] git-submodule summary: limit summary size
Date: Tue, 11 Mar 2008 21:52:17 +0800
Message-ID: <1205243539-797-4-git-send-email-pkufranky@gmail.com>
References: <1205243539-797-1-git-send-email-pkufranky@gmail.com>
 <1205243539-797-2-git-send-email-pkufranky@gmail.com>
 <1205243539-797-3-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 11 14:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ4ul-0006eX-Rq
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbYCKNw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbYCKNw1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:52:27 -0400
Received: from mail.qikoo.org ([60.28.205.235]:57652 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752335AbYCKNwY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:52:24 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 0EF94470B0; Tue, 11 Mar 2008 21:52:19 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1205243539-797-3-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76852>

This patch teaches git-submodule an option '--summary-limit|-n <number>'
to limit number of commits in total for the summary of each submodule in
the modified case (only a single commit is shown in other cases).

Giving 0 will disable the summary; a negative number means unlimted, which
is the default.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b90e132..3f76b15 100755
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
@@ -339,6 +341,8 @@ set_name_rev () {
 # $@ = [commit (default 'HEAD'),] requested paths (default all)
 #
 cmd_summary() {
+	summary_limit=-1
+
 	# parse $args after "submodule ... summary".
 	while test $# -ne 0
 	do
@@ -346,6 +350,15 @@ cmd_summary() {
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
@@ -360,6 +373,8 @@ cmd_summary() {
 		shift
 	done
 
+	test $summary_limit = 0 && return
+
 	if rev=$(git rev-parse --verify "$1^0" 2>/dev/null)
 	then
 		head=$rev
@@ -462,8 +477,10 @@ cmd_summary() {
 		else
 			if test $mod_src = 160000 -a $mod_dst = 160000
 			then
+				limit=
+				test $summary_limit -gt 0 && limit="-$summary_limit"
 				GIT_DIR="$name/.git" \
-				git log --pretty='format:  %m %s' \
+				git log $limit --pretty='format:  %m %s' \
 				--first-parent $sha1_src...$sha1_dst
 			elif test $mod_dst = 160000
 			then
-- 
1.5.4.3.347.g5314c
