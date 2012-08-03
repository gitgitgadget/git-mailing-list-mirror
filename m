From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] tests: Introduce test_seq
Date: Fri,  3 Aug 2012 22:04:50 +0200
Message-ID: <1344024290-9197-1-git-send-email-michal.kiedrowicz@gmail.com>
References: <20120803160229.GA13094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:05:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxO7J-00007F-N6
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 22:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab2HCUE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 16:04:57 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51656 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab2HCUE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 16:04:56 -0400
Received: by wibhr14 with SMTP id hr14so994325wib.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1VndY/p4voTI2qoTvz0IoEJDn0L31VblHyg6epVHniQ=;
        b=0fFSKEU3l7h0axFPKub4EkQBHIFTxFsv570Crlo5VsM6Hi74WtF42fHZFfCD0vppzY
         60zKBUMcvZIBuTOYUjda+yVvh3kUp+j38R6JEw0c/Sy4zMoA4vs/lfuJpB/L0bu9I+uJ
         4tCyUa7MR4cl5tFGEqH9A5uriywGPmbKMA37kZZqB7CtgF8WE8yLUw3MXkeTV00KnaKu
         qIHCPPhbFp/GdNiOZjKarEEfU5dU6PKejmwC/cfPhE2hkONZ7MyMyxoM+zs9t6cuFjMN
         vTfpQ5f5M8I88buzXjOfrdzJUPDjj/xIrLSMDjBIUNs4Tk5+EDVkKv2VBltfxuPQnbex
         kQhQ==
Received: by 10.217.0.75 with SMTP id k53mr1367640wes.214.1344024295247;
        Fri, 03 Aug 2012 13:04:55 -0700 (PDT)
Received: from localhost (94-178-78-94.net.stream.pl. [94.78.178.94])
        by mx.google.com with ESMTPS id ck9sm28512606wib.2.2012.08.03.13.04.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 13:04:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc0.212.g37218b0.dirty
In-Reply-To: <20120803160229.GA13094@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202856>

Jeff King wrote:

	The seq command is GNU-ism, and is missing at least in older BSD
	releases and their derivatives, not to mention antique
	commercial Unixes.

	We already purged it in b3431bc (Don't use seq in tests, not
	everyone has it, 2007-05-02), but a few new instances have crept
	in. They went unnoticed because they are in scripts that are not
	run by default.

This commit replaces them with test_seq that is implemented with a Perl
snippet (proposed by Jeff).  This is better than inlining this snippet
everywhere it's needed because it's easier to read and it's easier to
change the implementation (e.g. to C) if we ever decide to remove Perl
from the test suite.

Note that test_seq is not a complete replacement for seq(1).  It just
has what we need now.

There are also many places that do `for i in 1 2 3 ...` but I'm not sur=
e
if it's worth converting them to test_seq.  That would introduce runnin=
g
more processes of Perl.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
Previous patch didn't support `test_seq 1 50` (I removed it accidentall=
y).

 t/perf/perf-lib.sh      |  2 +-
 t/t5551-http-fetch.sh   |  2 +-
 t/test-lib-functions.sh | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 5580c22..a1361e5 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -163,7 +163,7 @@ test_perf () {
 		else
 			echo "perf $test_count - $1:"
 		fi
-		for i in $(seq 1 $GIT_PERF_REPEAT_COUNT); do
+		for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
 			say >&3 "running: $2"
 			if test_run_perf_ "$2"
 			then
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index fadf2f2..91eaf53 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -114,7 +114,7 @@ test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSI=
VE
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
 	(
 	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	for i in `seq 50000`
+	for i in `test_seq 50000`
 	do
 		echo "commit refs/heads/too-many-refs"
 		echo "mark :$i"
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 80daaca..9456e65 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -530,6 +530,21 @@ test_cmp() {
 	$GIT_TEST_CMP "$@"
 }
=20
+# test_seq is a portable replacement for seq(1).
+# It may be used like:
+#
+#	for i in `test_seq 100`; do
+#		echo $i
+#	done
+
+test_seq () {
+	test $# =3D 2 && { first=3D$1; shift; } || first=3D1
+	test $# =3D 1 ||
+	error "bug in the test script: not 1 or 2 parameters to test_seq"
+	last=3D$1
+	"$PERL_PATH" -le "print for $first..$last"
+}
+
 # This function can be used to schedule some commands to be run
 # unconditionally at the end of the test to restore sanity:
 #
--=20
1.7.11.rc0.212.g37218b0.dirty
