From: Jeff King <peff@peff.net>
Subject: [PATCH] t3200: clean up checks for file existence
Date: Tue, 13 Sep 2011 12:13:58 -0400
Message-ID: <20110913161358.GB28634@sigill.intra.peff.net>
References: <20110909193033.GA31184@sigill.intra.peff.net>
 <49578782dd114220aa2562b5bd29755fc2bdd0fa.1315597137.git.git@drmicha.warpmail.net>
 <20110909194357.GA31446@sigill.intra.peff.net>
 <4E6B6647.7090802@drmicha.warpmail.net>
 <20110913035724.GA4828@sigill.intra.peff.net>
 <4E6F48C4.3030407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 18:14:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Vce-00055M-R5
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 18:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241Ab1IMQOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 12:14:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56900
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755159Ab1IMQOA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 12:14:00 -0400
Received: (qmail 30143 invoked by uid 107); 13 Sep 2011 16:14:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 12:14:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 12:13:58 -0400
Content-Disposition: inline
In-Reply-To: <4E6F48C4.3030407@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181288>

This patch uses test_path_is_file and test_path_is_missing
instead of "test -f / ! test -f" checks. The former are more
verbose in case of failure and more precise (e.g., is_missing
will check that the entry is actually missing, not just not
a regular file).

As a bonus, this also fixes a few buggy tests that used
"test foo" instead of "test -f foo", and consequently always
reported success.

Signed-off-by: Jeff King <peff@peff.net>
---
On Tue, Sep 13, 2011 at 02:12:52PM +0200, Michael J Gruber wrote:

> I'd prefer your style anyway, but also prefer changing t3200 in one go.

Here it is, on top of mg/branch-list. The "test without -f" bits could
actually be squashed in to your commits if we really want clean history,
but I don't think it's a big deal.

 t/t3200-branch.sh |   50 +++++++++++++++++++++++++-------------------------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c466b20..3988ec9 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -23,7 +23,7 @@ test_expect_success \
 test_expect_success \
     'git branch --help should not have created a bogus branch' '
      git branch --help </dev/null >/dev/null 2>/dev/null;
-     ! test -f .git/refs/heads/--help
+     test_path_is_missing .git/refs/heads/--help
 '
 
 test_expect_success 'branch -h in broken repository' '
@@ -39,11 +39,11 @@ test_expect_success 'branch -h in broken repository' '
 
 test_expect_success \
     'git branch abc should create a branch' \
-    'git branch abc && test -f .git/refs/heads/abc'
+    'git branch abc && test_path_is_file .git/refs/heads/abc'
 
 test_expect_success \
     'git branch a/b/c should create a branch' \
-    'git branch a/b/c && test -f .git/refs/heads/a/b/c'
+    'git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c'
 
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
@@ -52,15 +52,15 @@ test_expect_success \
     'git branch -l d/e/f should create a branch and a log' \
 	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
      git branch -l d/e/f &&
-	 test -f .git/refs/heads/d/e/f &&
-	 test -f .git/logs/refs/heads/d/e/f &&
+	 test_path_is_file .git/refs/heads/d/e/f &&
+	 test_path_is_file .git/logs/refs/heads/d/e/f &&
 	 test_cmp expect .git/logs/refs/heads/d/e/f'
 
 test_expect_success \
     'git branch -d d/e/f should delete a branch and a log' \
 	'git branch -d d/e/f &&
-	 test ! -f .git/refs/heads/d/e/f &&
-	 test ! -f .git/logs/refs/heads/d/e/f'
+	 test_path_is_missing .git/refs/heads/d/e/f &&
+	 test_path_is_missing .git/logs/refs/heads/d/e/f'
 
 test_expect_success \
     'git branch j/k should work after branch j has been deleted' \
@@ -78,13 +78,13 @@ test_expect_success \
     'git branch -m m m/m should work' \
        'git branch -l m &&
         git branch -m m m/m &&
-        test -f .git/logs/refs/heads/m/m'
+        test_path_is_file .git/logs/refs/heads/m/m'
 
 test_expect_success \
     'git branch -m n/n n should work' \
        'git branch -l n/n &&
         git branch -m n/n n
-        test -f .git/logs/refs/heads/n'
+        test_path_is_file .git/logs/refs/heads/n'
 
 test_expect_success 'git branch -m o/o o should fail when o/p exists' '
 	git branch o/o &&
@@ -100,34 +100,34 @@ test_expect_success 'git branch -m q r/q should fail when r exists' '
 
 test_expect_success 'git branch -v -d t should work' '
 	git branch t &&
-	test .git/refs/heads/t &&
+	test_path_is_file .git/refs/heads/t &&
 	git branch -v -d t &&
-	test ! -f .git/refs/heads/t
+	test_path_is_missing .git/refs/heads/t
 '
 
 test_expect_success 'git branch -v -m t s should work' '
 	git branch t &&
-	test .git/refs/heads/t &&
+	test_path_is_file .git/refs/heads/t &&
 	git branch -v -m t s &&
-	test ! -f .git/refs/heads/t &&
-	test -f .git/refs/heads/s &&
+	test_path_is_missing .git/refs/heads/t &&
+	test_path_is_file .git/refs/heads/s &&
 	git branch -d s
 '
 
 test_expect_success 'git branch -m -d t s should fail' '
 	git branch t &&
-	test .git/refs/heads/t &&
+	test_path_is_file .git/refs/heads/t &&
 	test_must_fail git branch -m -d t s &&
 	git branch -d t &&
-	test ! -f .git/refs/heads/t
+	test_path_is_missing .git/refs/heads/t
 '
 
 test_expect_success 'git branch --list -d t should fail' '
 	git branch t &&
-	test .git/refs/heads/t &&
+	test_path_is_file .git/refs/heads/t &&
 	test_must_fail git branch --list -d t &&
 	git branch -d t &&
-	test ! -f .git/refs/heads/t
+	test_path_is_missing .git/refs/heads/t
 '
 
 mv .git/config .git/config-saved
@@ -144,12 +144,12 @@ git config branch.s/s.dummy Hello
 test_expect_success \
     'git branch -m s/s s should work when s/t is deleted' \
        'git branch -l s/s &&
-        test -f .git/logs/refs/heads/s/s &&
+        test_path_is_file .git/logs/refs/heads/s/s &&
         git branch -l s/t &&
-        test -f .git/logs/refs/heads/s/t &&
+        test_path_is_file .git/logs/refs/heads/s/t &&
         git branch -d s/t &&
         git branch -m s/s s &&
-        test -f .git/logs/refs/heads/s'
+        test_path_is_file .git/logs/refs/heads/s'
 
 test_expect_success 'config information was renamed, too' \
 	"test $(git config branch.s.dummy) = Hello &&
@@ -160,8 +160,8 @@ test_expect_success 'renaming a symref is not allowed' \
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
 	git symbolic-ref refs/heads/master2 &&
-	test -f .git/refs/heads/master &&
-	! test -f .git/refs/heads/master3
+	test_path_is_file .git/refs/heads/master &&
+	test_path_is_missing .git/refs/heads/master3
 '
 
 test_expect_success SYMLINKS \
@@ -270,8 +270,8 @@ test_expect_success \
     'git checkout -b g/h/i -l should create a branch and a log' \
 	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
      git checkout -b g/h/i -l master &&
-	 test -f .git/refs/heads/g/h/i &&
-	 test -f .git/logs/refs/heads/g/h/i &&
+	 test_path_is_file .git/refs/heads/g/h/i &&
+	 test_path_is_file .git/logs/refs/heads/g/h/i &&
 	 test_cmp expect .git/logs/refs/heads/g/h/i'
 
 test_expect_success 'checkout -b makes reflog by default' '
-- 
1.7.7.rc1.2.gb2409
