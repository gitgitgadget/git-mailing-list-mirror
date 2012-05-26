From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t5701: modernize style
Date: Fri, 25 May 2012 23:42:53 -0400
Message-ID: <20120526034253.GA14332@sigill.intra.peff.net>
References: <20120526034226.GA14287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Emeric Fermas <emeric.fermas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 05:43:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY7u8-0000Kl-3n
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 05:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105Ab2EZDm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 23:42:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56342
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754848Ab2EZDmz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 23:42:55 -0400
Received: (qmail 16109 invoked by uid 107); 26 May 2012 03:43:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 May 2012 23:43:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2012 23:42:53 -0400
Content-Disposition: inline
In-Reply-To: <20120526034226.GA14287@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198536>

This test is pretty old and did not follow some of our more
modern best practices. In particular:

  1. It chdir'd all over the place, leaving later tests to
     deal with the fallout. Do our chdirs in subshells
     instead.

  2. It did not use test_must_fail.

  3. It did not use test_line_count.

  4. It checked for the non-existence of a ref by looking in the
     .git/refs directory (since we pack refs during clone
     these days, this will always be succeed, making the
     test useless).

     Note that one call to "-e .git/refs/..." remains,
     because it is checking for the existence of a symbolic
     ref, not a ref itself.

Signed-off-by: Jeff King <peff@peff.net>
---
I mostly wanted to pull out the repo_is_hardlinked logic for tests I was
about to add, but once I got cleaning, I couldn't stop. And who can
argue with that diffstat?

 t/t5701-clone-local.sh | 73 ++++++++++++++------------------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 6972258..c6feca4 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -3,7 +3,10 @@
 test_description='test local clone'
 . ./test-lib.sh
 
-D=`pwd`
+repo_is_hardlinked() {
+	find "$1/objects" -type f -links 1 >output &&
+	test_line_count = 0 output
+}
 
 test_expect_success 'preparing origin repository' '
 	: >file && git add . && git commit -m1 &&
@@ -19,105 +22,72 @@ test_expect_success 'preparing origin repository' '
 '
 
 test_expect_success 'local clone without .git suffix' '
-	cd "$D" &&
 	git clone -l -s a b &&
-	cd b &&
+	(cd b &&
 	test "$(GIT_CONFIG=.git/config git config --bool core.bare)" = false &&
-	git fetch
+	git fetch)
 '
 
 test_expect_success 'local clone with .git suffix' '
-	cd "$D" &&
 	git clone -l -s a.git c &&
-	cd c &&
-	git fetch
+	(cd c && git fetch)
 '
 
 test_expect_success 'local clone from x' '
-	cd "$D" &&
 	git clone -l -s x y &&
-	cd y &&
-	git fetch
+	(cd y && git fetch)
 '
 
 test_expect_success 'local clone from x.git that does not exist' '
-	cd "$D" &&
-	if git clone -l -s x.git z
-	then
-		echo "Oops, should have failed"
-		false
-	else
-		echo happy
-	fi
+	test_must_fail git clone -l -s x.git z
 '
 
 test_expect_success 'With -no-hardlinks, local will make a copy' '
-	cd "$D" &&
 	git clone --bare --no-hardlinks x w &&
-	cd w &&
-	linked=$(find objects -type f ! -links 1 | wc -l) &&
-	test 0 = $linked
+	! repo_is_hardlinked w
 '
 
 test_expect_success 'Even without -l, local will make a hardlink' '
-	cd "$D" &&
 	rm -fr w &&
 	git clone -l --bare x w &&
-	cd w &&
-	copied=$(find objects -type f -links 1 | wc -l) &&
-	test 0 = $copied
+	repo_is_hardlinked w
 '
 
 test_expect_success 'local clone of repo with nonexistent ref in HEAD' '
-	cd "$D" &&
 	echo "ref: refs/heads/nonexistent" > a.git/HEAD &&
 	git clone a d &&
-	cd d &&
+	(cd d &&
 	git fetch &&
-	test ! -e .git/refs/remotes/origin/HEAD'
+	test ! -e .git/refs/remotes/origin/HEAD)
+'
 
 test_expect_success 'bundle clone without .bundle suffix' '
-	cd "$D" &&
 	git clone dir/b3 &&
-	cd b3 &&
-	git fetch
+	(cd b3 && git fetch)
 '
 
 test_expect_success 'bundle clone with .bundle suffix' '
-	cd "$D" &&
 	git clone b1.bundle &&
-	cd b1 &&
-	git fetch
+	(cd b1 && git fetch)
 '
 
 test_expect_success 'bundle clone from b4' '
-	cd "$D" &&
 	git clone b4 bdl &&
-	cd bdl &&
-	git fetch
+	(cd bdl && git fetch)
 '
 
 test_expect_success 'bundle clone from b4.bundle that does not exist' '
-	cd "$D" &&
-	if git clone b4.bundle bb
-	then
-		echo "Oops, should have failed"
-		false
-	else
-		echo happy
-	fi
+	test_must_fail git clone b4.bundle bb
 '
 
 test_expect_success 'bundle clone with nonexistent HEAD' '
-	cd "$D" &&
 	git clone b2.bundle b2 &&
-	cd b2 &&
+	(cd b2 &&
 	git fetch &&
-	test ! -e .git/refs/heads/master
+	test_must_fail git rev-parse --verify refs/heads/master)
 '
 
 test_expect_success 'clone empty repository' '
-	cd "$D" &&
 	mkdir empty &&
 	(cd empty &&
 	 git init &&
@@ -135,7 +105,6 @@ test_expect_success 'clone empty repository' '
 '
 
 test_expect_success 'clone empty repository, and then push should not segfault.' '
-	cd "$D" &&
 	rm -fr empty/ empty-clone/ &&
 	mkdir empty &&
 	(cd empty && git init) &&
@@ -145,13 +114,11 @@ test_expect_success 'clone empty repository, and then push should not segfault.'
 '
 
 test_expect_success 'cloning non-existent directory fails' '
-	cd "$D" &&
 	rm -rf does-not-exist &&
 	test_must_fail git clone does-not-exist
 '
 
 test_expect_success 'cloning non-git directory fails' '
-	cd "$D" &&
 	rm -rf not-a-git-repo not-a-git-repo-clone &&
 	mkdir not-a-git-repo &&
 	test_must_fail git clone not-a-git-repo not-a-git-repo-clone
-- 
1.7.10.1.21.g62fda49.dirty
