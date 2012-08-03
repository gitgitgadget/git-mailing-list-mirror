From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] tests: Introduce test_seq
Date: Sat,  4 Aug 2012 00:21:04 +0200
Message-ID: <1344032464-14104-1-git-send-email-michal.kiedrowicz@gmail.com>
References: <7v3943bsuc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 00:21:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxQFA-0007hK-Tu
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 00:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab2HCWVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 18:21:12 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38868 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab2HCWVL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 18:21:11 -0400
Received: by wibhq12 with SMTP id hq12so3014wib.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jMzGQ7W8lQNdNzM8IVGZKiCctAKpIakZ79yViAkm9d4=;
        b=L4WcL3Iab+n7yiFBDFpK+nLKNXh+nP9ux4DlIvtWbvj584dBJu7NXIczeie6Knpl8h
         zU5iVSO/BDGMYxWHAIOQydiE/3DUsDfjPGpZBNxSDL72SKnin0GhdiWfkJyMHzzqiqQ+
         RbY/R28QdHNZbNmBVNgUzDRUcvRtkbM9qu3PcYjc5fiVlK5Ih8LzzBQNpvAjPc1+QpRR
         dt02pTizs6T9V8vxVc9rYYccMBXYdG83DQ1VLR5/nG6uN/VEV+Gfcrd+BYTgiY41NmYF
         lnekvF2JDcM8DLG3pFtbBnhYCY8HWgaEtwk4/+HJg5bKqY59u5QQYd9EYs+wnK8SFMTW
         Rhng==
Received: by 10.216.241.198 with SMTP id g48mr1403805wer.164.1344032469696;
        Fri, 03 Aug 2012 15:21:09 -0700 (PDT)
Received: from localhost (94-178-78-94.net.stream.pl. [94.78.178.94])
        by mx.google.com with ESMTPS id ef5sm29406990wib.3.2012.08.03.15.21.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 15:21:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc0.212.g37218b0.dirty
In-Reply-To: <7v3943bsuc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202867>

Jeff King wrote:

	The seq command is GNU-ism, and is missing at least in older BSD
	releases and their derivatives, not to mention antique
	commercial Unixes.

	We already purged it in b3431bc (Don't use seq in tests, not
	everyone has it, 2007-05-02), but a few new instances have crept
	in. They went unnoticed because they are in scripts that are not
	run by default.

Replace them with test_seq that is implemented with a Perl snippet
(proposed by Jeff).  This is better than inlining this snippet
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
Changes since previous version:

	* Removed "This commit replaces" from commit message
	* Reworded test_seq description
	* Now $first and $last are passed to Perl as arguments

 t/perf/perf-lib.sh      |  2 +-
 t/t5551-http-fetch.sh   |  2 +-
 t/test-lib-functions.sh | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

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
index 80daaca..c8b4ae3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -530,6 +530,26 @@ test_cmp() {
 	$GIT_TEST_CMP "$@"
 }
=20
+# Print a sequence of numbers or letters in increasing order.  This is
+# similar to GNU seq(1), but the latter might not be available
+# everywhere.  It may be used like:
+#
+#	for i in `test_seq 100`; do
+#		for j in `test_seq 10 20`; do
+#			for k in `test_seq a z`; do
+#				echo $i-$j-$k
+#			done
+#		done
+#	done
+
+test_seq () {
+	test $# =3D 2 && { first=3D$1; shift; } || first=3D1
+	test $# =3D 1 ||
+	error "bug in the test script: not 1 or 2 parameters to test_seq"
+	last=3D$1
+	"$PERL_PATH" -le 'print for "$ARGV[0]".."$ARGV[1]"' "$first" "$last"
+}
+
 # This function can be used to schedule some commands to be run
 # unconditionally at the end of the test to restore sanity:
 #
--=20
1.7.11.rc0.212.g37218b0.dirty
