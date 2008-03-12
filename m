From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] git-submodule summary: --for-status option
Date: Wed, 12 Mar 2008 10:23:47 +0800
Message-ID: <1205288627-20499-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 03:24:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZGeH-0003dc-AK
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 03:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbYCLCXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 22:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbYCLCXw
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 22:23:52 -0400
Received: from mail.qikoo.org ([60.28.205.235]:55396 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751118AbYCLCXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 22:23:51 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 2298D470AE; Wed, 12 Mar 2008 10:23:47 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76912>

The --for-status option is mainly used by builtin-status/commit.
It adds 'Modified submodules:' line at top and  '# ' prefix to all
following lines.
---
 git-submodule.sh             |   17 ++++++++++++++++-
 t/t7401-submodule-summary.sh |   13 +++++++++++++
 2 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c47b364..da9d5c8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -342,6 +342,7 @@ set_name_rev () {
 #
 cmd_summary() {
 	summary_limit=-1
+	for_status=
 
 	# parse $args after "submodule ... summary".
 	while test $# -ne 0
@@ -350,6 +351,9 @@ cmd_summary() {
 		--cached)
 			cached="$1"
 			;;
+		--for-status)
+			for_status="$1"
+			;;
 		-n|--summary-limit)
 			if summary_limit=$(($2 + 0)) 2>/dev/null && test "$summary_limit" = "$2"
 			then
@@ -398,6 +402,12 @@ cmd_summary() {
 	)
 
 	test -n "$modules" &&
+	if test -n "$for_status"; then
+		echo "# Modified submodules:"
+		echo "#"
+	else
+		true
+	fi &&
 	git diff-index $cached --raw $head -- $modules |
 	grep -e '^:160000' -e '^:[0-7]* 160000' |
 	cut -c2- |
@@ -493,7 +503,12 @@ cmd_summary() {
 			echo
 		fi
 		echo
-	done
+	done |
+	if test -n "$for_status"; then
+		sed -e "s|^|# |" -e 's|^# $|#|'
+	else
+		cat
+	fi
 }
 #
 # List all submodules, prefixed with:
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 0f3c42a..1dbb39d 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -192,4 +192,17 @@ test_expect_success 'given commit' "
 EOF
 "
 
+test_expect_success '--for-status' "
+    git submodule summary --for-status HEAD^ >actual &&
+    diff actual - <<-EOF
+# Modified submodules:
+#
+# * sm1 $head6...0000000:
+#
+# * sm2 0000000...$head7 (2):
+#   > Add foo9
+#
+EOF
+"
+
 test_done
-- 
1.5.4.3.347.g5314c
