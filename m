From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: [PATCH 2/6] Fix tests to work with core.autocrlf=true
Date: Mon, 11 May 2009 15:28:57 -0400
Message-ID: <1242070141-2936-3-git-send-email-Don.Slutz@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242070141-2936-2-git-send-email-Don.Slutz@SierraAtlantic.com>
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 21:30:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3bCG-0007Nk-69
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758275AbZEKT3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 15:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757366AbZEKT3P
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:29:15 -0400
Received: from krl.krl.com ([192.147.32.3]:46844 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755860AbZEKT3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 15:29:11 -0400
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4BJT9fF002994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 May 2009 15:29:09 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4BJT9Lo002993;
	Mon, 11 May 2009 15:29:09 -0400
X-Mailer: git-send-email 1.6.3.15.g49878
In-Reply-To: <1242070141-2936-2-git-send-email-Don.Slutz@SierraAtlantic.com>
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118834>

test-lib changes.

Run the tests via:

  GIT_TEST_AUTO_CRLF=true make test

Change the default value of GIT_TEST_CMP to ignore whitespace changes
when core.autocrlf=true

Add support functions: test_external_with_only_warning, test_eq_cat,
test_cat_eq, and test_ne_cat all of which will ignore CR if it is in
the file.

Signed-off-by: Don Slutz <Don.Slutz@SierraAtlantic.com>
---
 t/test-lib.sh |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 218bd82..84846cd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -59,7 +59,6 @@ export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR VISUAL
-GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}
 
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
@@ -129,6 +128,11 @@ case $(uname -s) in
 *)
 	;;
 esac
+if test ! -z $GIT_TEST_AUTO_CRLF && test $GIT_TEST_AUTO_CRLF = true; then
+	GIT_TEST_CMP=${GIT_TEST_CMP:-diff -uw}
+else
+	GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}
+fi
 
 if test -n "$color"; then
 	say_color () {
@@ -459,6 +463,35 @@ test_external_without_stderr () {
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
@@ -493,6 +526,30 @@ test_cmp() {
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
