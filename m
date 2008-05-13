From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] fix bsd shell negation
Date: Tue, 13 May 2008 04:44:52 -0400
Message-ID: <20080513084452.GA23799@sigill.intra.peff.net>
References: <20080513084338.GA23729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 10:45:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvq8n-0007bC-Pu
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 10:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484AbYEMIo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 04:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757164AbYEMIoz
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 04:44:55 -0400
Received: from peff.net ([208.65.91.99]:1102 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756369AbYEMIoy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 04:44:54 -0400
Received: (qmail 19813 invoked by uid 111); 13 May 2008 08:44:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 May 2008 04:44:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 May 2008 04:44:52 -0400
Content-Disposition: inline
In-Reply-To: <20080513084338.GA23729@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82001>

On some shells (notably /bin/sh on FreeBSD 6.1), the
construct

  ! foo | bar

does not negate the exit value of the pipeline, but rather
of 'foo', producing the opposite of the expected value. We
can work around this by specifying it as

  ! (foo | bar)

Signed-off-by: Jeff King <peff@peff.net>
---
 git-rebase.sh     |    2 +-
 t/t3400-rebase.sh |    4 ++--
 t/t3700-add.sh    |    6 +++---
 t/t7501-commit.sh |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 9b13b83..fbb0f28 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -353,7 +353,7 @@ orig_head=$branch
 mb=$(git merge-base "$onto" "$branch")
 if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
 	# linear history?
-	! git rev-list --parents "$onto".."$branch" | grep " .* " > /dev/null
+	! (git rev-list --parents "$onto".."$branch" | grep " .* ") > /dev/null
 then
 	# Lazily switch to the target branch if needed...
 	test -z "$switch_to" || git checkout "$switch_to"
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 496f4ec..fdad7da 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -44,13 +44,13 @@ test_expect_success 'rebase against master' '
 
 test_expect_success \
     'the rebase operation should not have destroyed author information' \
-    '! git log | grep "Author:" | grep "<>"'
+    '! (git log | grep "Author:" | grep "<>")'
 
 test_expect_success 'rebase after merge master' '
      git reset --hard topic &&
      git merge master &&
      git rebase master &&
-     ! git show | grep "^Merge:"
+     ! (git show | grep "^Merge:")
 '
 
 test_expect_success 'rebase of history with merges is linearized' '
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 287e058..68c5dde 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -81,17 +81,17 @@ test_expect_success '.gitignore test setup' '
 
 test_expect_success '.gitignore is honored' '
 	git add . &&
-	! git ls-files | grep "\\.ig"
+	! (git ls-files | grep "\\.ig")
 '
 
 test_expect_success 'error out when attempting to add ignored ones without -f' '
 	! git add a.?? &&
-	! git ls-files | grep "\\.ig"
+	! (git ls-files | grep "\\.ig")
 '
 
 test_expect_success 'error out when attempting to add ignored ones without -f' '
 	! git add d.?? &&
-	! git ls-files | grep "\\.ig"
+	! (git ls-files | grep "\\.ig")
 '
 
 test_expect_success 'add ignored ones with -f' '
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index c0288f3..89710af 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -41,7 +41,7 @@ test_expect_success \
 test_expect_success \
 	"using paths with --interactive" \
 	"echo bong-o-bong >file &&
-	! echo 7 | git-commit -m foo --interactive file"
+	! (echo 7 | git-commit -m foo --interactive file)"
 
 test_expect_success \
 	"using invalid commit with -C" \
-- 
1.5.5.1.296.gf618c
