From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] tests: Introduce test_seq
Date: Fri,  3 Aug 2012 21:57:15 +0200
Message-ID: <1344023835-8947-1-git-send-email-michal.kiedrowicz@gmail.com>
References: <20120803160229.GA13094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 21:57:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxO05-0005TC-Cr
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 21:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab2HCT51 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 15:57:27 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:44799 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab2HCT51 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 15:57:27 -0400
Received: by wgbfm10 with SMTP id fm10so790334wgb.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dbtYpsatS+Uj3bYNh5lnhM+t1geMp0eTufX8IETA4G8=;
        b=nTJatTDZBBksMI6/1Qm9O5A8Zq7xFekxeVbzpOK0JII8JuLuLa10mvSRDzQtDT4QuS
         DnkCvGZ5MTUNJDwTvArwNNsRWwpRHcvvLaucRTL9bMEAcXy40OJ+7D09CSn4m1lVi21T
         6QC3jAp+0Gc+QBFn9ILKrb/elM+HLTfYCPRl8tRJHIwV7TuImdr55tBTeAhGIgsWiQ4Z
         fj/6c/2yuos1hu83tveku5l98cIgU7+3PmWBsFqirRJIkb7ZZy644uQKMlq6BIA9KU+W
         jtNcPk/eE4Zz62tjqQ44luUl/7mXMhdpRtTRSGIxMNqBFyS9sF/fpIO+JhwtYscESzpo
         ZJ2w==
Received: by 10.216.237.25 with SMTP id x25mr1350852weq.30.1344023845582;
        Fri, 03 Aug 2012 12:57:25 -0700 (PDT)
Received: from localhost (94-178-78-94.net.stream.pl. [94.78.178.94])
        by mx.google.com with ESMTPS id fr4sm28466405wib.8.2012.08.03.12.57.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 12:57:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc0.212.g37218b0.dirty
In-Reply-To: <20120803160229.GA13094@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202853>

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
more processes of Perl during the tests and might increase the total
time tests take.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---

> I don't have a strong preference, as there are only two callsites. Do
> you want to make a patch?

Sure. Here it is.

 t/perf/perf-lib.sh      |  2 +-
 t/t5551-http-fetch.sh   |  2 +-
 t/test-lib-functions.sh | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

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
index 80daaca..7d7424d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -530,6 +530,20 @@ test_cmp() {
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
+	test $# =3D 1 ||
+	error "bug in the test script: not 1 parameter to test_seq"
+	last=3D$1
+	"$PERL_PATH" -le "print for 1..$last"
+}
+
 # This function can be used to schedule some commands to be run
 # unconditionally at the end of the test to restore sanity:
 #
--=20
1.7.11.rc0.212.g37218b0.dirty
