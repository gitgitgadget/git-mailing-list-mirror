From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t3030: fix accidental success in symlink rename
Date: Fri, 25 Mar 2011 12:03:26 -0400
Message-ID: <20110325160326.GA26635@sigill.intra.peff.net>
References: <20110325160013.GA25851@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Ken Schalk <ken.schalk@intel.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:03:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q39UB-0002PT-3u
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 17:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab1CYQD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 12:03:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56704
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253Ab1CYQD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 12:03:28 -0400
Received: (qmail 14828 invoked by uid 107); 25 Mar 2011 16:04:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 12:04:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 12:03:26 -0400
Content-Disposition: inline
In-Reply-To: <20110325160013.GA25851@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169993>

In this test, we have merge two branches. On one branch, we
renamed "a" to "e". On the other, we renamed "a" to "e" and
then added a symlink pointing at "a" pointing to "e".

The results for the test indicate that the merge should
succeed, but also that "a" should no longer exist. Since
both sides renamed "a" to the same destination, we will end
up comparing those destinations for content.

But what about what's left? One side (the rename only),
replaced "a" with nothing. The other side replaced it with a
symlink. The common base must also be nothing, because any
"a" before this was meaningless (it was totally unrelated
content that ended up getting renamed).

The only sensible resolution is to keep the symlink. The
rename-only side didn't touch the content versus the common
base, and the other side added content. The 3-way merge
dictates that we take the side with a change.

And this gives the overall merge an intuitive result.  One
side made one change (a rename), and the other side made two
changes: an identical rename, and an addition (that just
happened to be at the same spot). The end result should
contain both changes.

Signed-off-by: Jeff King <peff@peff.net>
---
Ken, I'm cc'ing you as the test in question is yours. The
context is that I want to turn on break detection in
merge-recursive, but doing so makes your test fail.

 t/t3030-merge-recursive.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 34794f8..e686f04 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -267,7 +267,8 @@ test_expect_success 'setup 8' '
 		ln -s e a &&
 		git add a e &&
 		test_tick &&
-		git commit -m "rename a->e, symlink a->e"
+		git commit -m "rename a->e, symlink a->e" &&
+		oln=`printf e | git hash-object --stdin`
 	fi
 '
 
@@ -630,16 +631,18 @@ test_expect_success 'merge-recursive copy vs. rename' '
 
 if test_have_prereq SYMLINKS
 then
-	test_expect_success 'merge-recursive rename vs. rename/symlink' '
+	test_expect_failure 'merge-recursive rename vs. rename/symlink' '
 
 		git checkout -f rename &&
 		git merge rename-ln &&
 		( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 		(
+			echo "120000 blob $oln	a"
 			echo "100644 blob $o0	b"
 			echo "100644 blob $o0	c"
 			echo "100644 blob $o0	d/e"
 			echo "100644 blob $o0	e"
+			echo "120000 $oln 0	a"
 			echo "100644 $o0 0	b"
 			echo "100644 $o0 0	c"
 			echo "100644 $o0 0	d/e"
-- 
1.7.4.41.g423da.dirty
