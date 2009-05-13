From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: [PATCH v2 2/7] Add support functions for tests in core.autocrlf=true
Date: Wed, 13 May 2009 15:35:43 -0400
Message-ID: <1242243348-6690-3-git-send-email-Don.Slutz@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-1-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-2-git-send-email-Don.Slutz@SierraAtlantic.com>
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 21:36:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4KFc-0005kd-UM
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 21:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbZEMTgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 15:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755362AbZEMTgL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 15:36:11 -0400
Received: from krl.krl.com ([192.147.32.3]:59290 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbZEMTgH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 15:36:07 -0400
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4DJa4tm006792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 15:36:04 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4DJa4Kg006791;
	Wed, 13 May 2009 15:36:04 -0400
X-Mailer: git-send-email 1.6.3.15.g49878
In-Reply-To: <1242243348-6690-2-git-send-email-Don.Slutz@SierraAtlantic.com>
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119093>

test_external_with_only_warning() -- Ignore CRLF warnings
test_eq_cat() -- like "test foo = $(cat bar)" but works in any setting of
                 core.autocrlf
test_ne_cat() -- like "test foo != $(cat bar)"
test_cat_eq() -- like "test $(cat foo) = bar"

Signed-off-by: Don Slutz <Don.Slutz@SierraAtlantic.com>
---
 t/test-lib.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6178e8c..2e0fd43 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -453,6 +453,35 @@ test_external_without_stderr () {
 	fi
 }
 
+# Like test_external, but in addition tests that the command generated
+# only "warning: LF will be replaced by CRLF" output on stderr.
+test_external_with_only_warning () {
+	# The temporary file has no (and must have no) security
+	# implications.
+	tmp="$TMPDIR"; if [ -z "$tmp" ]; then tmp=/tmp; fi
+	stderr="$tmp/git-external-stderr.$$.tmp"
+	test_external "$@" 4> "$stderr"
+	[ -f "$stderr" ] || error "Internal error: $stderr disappeared."
+	descr="only warning: $1"
+	shift
+	say >&3 "expecting only warnings from previous command"
+	output=$(grep -v "warning: LF will be replaced by CRLF in" $stderr)
+	test_debug "echo non-warning: $output"
+	if [ -z "$output" ]; then
+		rm "$stderr"
+		test_ok_ "$descr"
+	else
+		if [ "$verbose" = t ]; then
+			output=`echo; echo Stderr is:; cat "$stderr"`
+		else
+			output=
+		fi
+		# rm first in case test_failure exits.
+		rm "$stderr"
+		test_failure_ "$descr" "$@" "$output"
+	fi
+}
+
 # This is not among top-level (test_expect_success | test_expect_failure)
 # but is a prefix that can be used in the test script, like:
 #
@@ -487,6 +516,30 @@ test_cmp() {
 	$GIT_TEST_CMP "$@"
 }
 
+# test_eq_cat is a helper function to compare a 1 word file
+# with a string.
+# It almost the same as: test foo = $(cat bar)
+# for: test_eq_cat foo bar
+#
+# However it works when core.autocrlf = true.
+
+test_eq_cat() {
+	test "$1" = "$(tr '\015' '\012' < "$2")"
+}
+
+# the but not-equal -- may not catch all cases
+
+test_ne_cat() {
+	test "$1" != "$(tr '\015' '\012' < "$2")"
+}
+
+# the same as test_eq_cat, but file is 1st.
+
+test_cat_eq() {
+	test "$(tr '\015' '\012' < "$1")" = "$2"
+}
+
+
 # Most tests can use the created repository, but some may need to create more.
 # Usage: test_create_repo <directory>
 test_create_repo () {
-- 
1.6.3.15.g49878
