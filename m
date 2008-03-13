From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 1/4] git-submodule summary: --for-status option
Date: Thu, 13 Mar 2008 21:48:02 +0800
Message-ID: <1205416085-23431-2-git-send-email-pkufranky@gmail.com>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 14:49:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZnnf-0002ba-Ci
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbYCMNsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 09:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbYCMNsL
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 09:48:11 -0400
Received: from mail.qikoo.org ([60.28.205.235]:36327 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752449AbYCMNsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 09:48:10 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 33208470AB; Thu, 13 Mar 2008 21:48:06 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77083>

The --for-status option is mainly used by builtin-status/commit.
It adds 'Modified submodules:' line at top and  '# ' prefix to all
following lines.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh             |   17 ++++++++++++++++-
 t/t7401-submodule-summary.sh |   13 +++++++++++++
 2 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5f1d5ef..4baafba 100755
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
1.5.4.3.347.g5314c
