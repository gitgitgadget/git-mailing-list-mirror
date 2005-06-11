From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/3] read-tree: loosen too strict index requirements
Date: Sat, 11 Jun 2005 02:53:57 -0700
Message-ID: <7vfyvpxlqi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 11:49:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh2cf-0001QL-IA
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 11:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVFKJyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 05:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVFKJyF
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 05:54:05 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:42461 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261666AbVFKJx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 05:53:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611095358.PFJS26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Jun 2005 05:53:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch teaches read-tree 3-way merge that, when only "the
other tree" changed a path, and if the index file already has
the same change, we are not in a situation that would clobber
the index and the work tree, and lets the merge succeed; this is
case #14ALT in t1000 test.  It does not change the result of the
merge, but prevents it from failing when it does not have to.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** This is another leftover bits from the earlier 3-piece series.
*** This is not necessary for the --emu23 two-way improvements,
*** but rather help a case that would not be so uncommon in the
*** 3-way merge case.

 read-tree.c                 |    6 ++++++
 t/t1000-read-tree-m-3way.sh |    9 +++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -280,6 +280,12 @@ static int threeway_merge(struct cache_e
 		}
 		/* otherwise we will apply the original rule */
 	}
+	/* #14ALT */
+	if (a && b && c && same(a, b) && !same(a, c)) {
+		if (old && same(old, c))
+			return merged_entry_allow_dirty(c, old, dst);
+		/* otherwise the regular rule applies */
+	}
 	/*
 	 * If we have an entry in the index cache ("old"), then we want
 	 * to make sure that it matches any entries in stage 2 ("first
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -464,6 +464,15 @@ test_expect_success \
      git-read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
+test_expect_success \
+    '14 - may match B in O && A && B && O==A && O!=B case' \
+    "rm -f .git/index NM &&
+     cp .orig-B/NM NM &&
+     git-update-cache --add NM &&
+     echo extra >>NM &&
+     git-read-tree -m $tree_O $tree_A $tree_B &&
+     check_result"
+
 test_expect_failure \
     '14 (fail) - must match and be up-to-date in O && A && B && O==A && O!=B case' \
     "rm -f .git/index NM &&
------------

