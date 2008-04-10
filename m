From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 1/3] git-submodule summary: --for-status option
Date: Thu, 10 Apr 2008 23:35:25 +0800
Message-ID: <1207841727-7840-2-git-send-email-pkufranky@gmail.com>
References: <1207841727-7840-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 10 17:37:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjyp3-0005sp-C2
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 17:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345AbYDJPfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 11:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757224AbYDJPfi
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 11:35:38 -0400
Received: from mail.qikoo.org ([60.28.205.235]:42976 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757145AbYDJPfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 11:35:34 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id C263D470AB; Thu, 10 Apr 2008 23:35:27 +0800 (CST)
X-Mailer: git-send-email 1.5.5.23.g2a5f
In-Reply-To: <1207841727-7840-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79217>

The --for-status option is mainly used by builtin-status/commit.
It adds 'Modified submodules:' line at top and  '# ' prefix to all
following lines.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh             |   17 ++++++++++++++++-
 t/t7401-submodule-summary.sh |   13 +++++++++++++
 2 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 56ec353..d7937a5 100755
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
@@ -499,7 +509,12 @@ cmd_summary() {
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
1.5.5.23.g2a5f
