From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: grep portability fixes
Date: Tue, 30 Sep 2008 04:03:55 -0400
Message-ID: <20080930080355.GA19605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 10:11:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkaEK-00017w-C3
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 10:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbYI3ID7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 04:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbYI3ID7
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 04:03:59 -0400
Received: from peff.net ([208.65.91.99]:1401 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbYI3ID5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 04:03:57 -0400
Received: (qmail 31259 invoked by uid 111); 30 Sep 2008 08:03:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 30 Sep 2008 04:03:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Sep 2008 04:03:55 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97076>

We try to avoid using the "-q" or "-e" options, as they are
largely useless, as explained in aadbe44f.

There is one exception for "-e" here, which is in t7701 used
to produce an "or" of patterns. This can be rewritten as an
egrep pattern.

This patch also removes use of "grep -F" in favor of the
more widely available "fgrep".

Signed-off-by: Jeff King <peff@peff.net>
---
These are fallouts from getting (most of) the tests to pass
on Solaris.

 t/t0002-gitfile.sh                     |    4 ++--
 t/t1501-worktree.sh                    |    2 +-
 t/t3700-add.sh                         |    2 +-
 t/t4150-am.sh                          |    2 +-
 t/t6040-tracking-info.sh               |    4 ++--
 t/t7002-grep.sh                        |    2 +-
 t/t7701-repack-unpack-unreachable.sh   |    4 ++--
 t/t9500-gitweb-standalone-no-errors.sh |    2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 4db4ac4..cb14425 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -32,7 +32,7 @@ test_expect_success 'bad setup: invalid .git file format' '
 		echo "git rev-parse accepted an invalid .git file"
 		false
 	fi &&
-	if ! grep -qe "Invalid gitfile format" .err
+	if ! grep "Invalid gitfile format" .err
 	then
 		echo "git rev-parse returned wrong error"
 		false
@@ -46,7 +46,7 @@ test_expect_success 'bad setup: invalid .git file path' '
 		echo "git rev-parse accepted an invalid .git file path"
 		false
 	fi &&
-	if ! grep -qe "Not a git repository" .err
+	if ! grep "Not a git repository" .err
 	then
 		echo "git rev-parse returned wrong error"
 		false
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index c039ee3..f6a6f83 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -171,7 +171,7 @@ test_expect_success 'git diff' '
 
 test_expect_success 'git grep' '
 	(cd repo.git/work/sub &&
-	GIT_DIR=../.. GIT_WORK_TREE=.. git grep -l changed | grep -q dir/tracked)
+	GIT_DIR=../.. GIT_WORK_TREE=.. git grep -l changed | grep dir/tracked)
 '
 
 test_done
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 2ac93a3..9f6454d 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -226,7 +226,7 @@ test_expect_success 'git add '\''fo\[ou\]bar'\'' ignores foobar' '
 	git reset --hard &&
 	touch fo\[ou\]bar foobar &&
 	git add '\''fo\[ou\]bar'\'' &&
-	git ls-files fo\[ou\]bar | grep -F fo\[ou\]bar &&
+	git ls-files fo\[ou\]bar | fgrep fo\[ou\]bar &&
 	! ( git ls-files foobar | grep foobar )
 '
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 1be5fb3..796f795 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -165,7 +165,7 @@ test_expect_success 'am --keep really keeps the subject' '
 	git am --keep patch4 &&
 	! test -d .git/rebase-apply &&
 	git cat-file commit HEAD |
-		grep -q -F "Re: Re: Re: [PATCH 1/5 v2] third"
+		fgrep "Re: Re: Re: [PATCH 1/5 v2] third"
 '
 
 test_expect_success 'am -3 falls back to 3-way merge' '
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index aac212e..ba90601 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -53,7 +53,7 @@ test_expect_success 'checkout' '
 	(
 		cd test && git checkout b1
 	) >actual &&
-	grep -e "have 1 and 1 different" actual
+	grep "have 1 and 1 different" actual
 '
 
 test_expect_success 'status' '
@@ -63,7 +63,7 @@ test_expect_success 'status' '
 		# reports nothing to commit
 		test_must_fail git status
 	) >actual &&
-	grep -e "have 1 and 1 different" actual
+	grep "have 1 and 1 different" actual
 '
 
 
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 5e359cb..18fe6f2 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -109,7 +109,7 @@ do
 	'
 
 	test_expect_success "grep -c $L (no /dev/null)" '
-		! git grep -c test $H | grep -q /dev/null
+		! git grep -c test $H | grep /dev/null
         '
 
 done
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 531dac0..b48046e 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -29,7 +29,7 @@ test_expect_success '-A option leaves unreachable objects unpacked' '
 	git repack -A -d -l &&
 	# verify objects are packed in repository
 	test 3 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		   grep -e "^$fsha1 " -e "^$csha1 " -e "^$tsha1 " |
+		   egrep "^($fsha1|$csha1|$tsha1) " |
 		   sort | uniq | wc -l) &&
 	git show $fsha1 &&
 	git show $csha1 &&
@@ -41,7 +41,7 @@ test_expect_success '-A option leaves unreachable objects unpacked' '
 	git repack -A -d -l &&
 	# verify objects are retained unpacked
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		   grep -e "^$fsha1 " -e "^$csha1 " -e "^$tsha1 " |
+		   egrep "^($fsha1|$csha1|$tsha1) " |
 		   sort | uniq | wc -l) &&
 	git show $fsha1 &&
 	git show $csha1 &&
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 46ba19b..07117a8 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -56,7 +56,7 @@ gitweb_run () {
 	rm -f gitweb.log &&
 	perl -- "$TEST_DIRECTORY/../gitweb/gitweb.perl" \
 		>/dev/null 2>gitweb.log &&
-	if grep -q -s "^[[]" gitweb.log >/dev/null; then false; else true; fi
+	if grep "^[[]" gitweb.log >/dev/null 2>&1; then false; else true; fi
 
 	# gitweb.log is left for debugging
 }
-- 
1.6.0.2.517.g4d51
