From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 2/2] documentation: merge-base: explain
 "git merge-base" with more than 2 args
Date: Wed, 30 Jul 2008 07:04:43 +0200
Message-ID: <20080730070443.f137efd1.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 07:02:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO3oz-0005Vk-Fh
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 07:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbYG3FA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 01:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbYG3FA5
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 01:00:57 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:57045 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbYG3FA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 01:00:56 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8355F1AB2C4;
	Wed, 30 Jul 2008 07:00:55 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 07FE81AB2D2;
	Wed, 30 Jul 2008 07:00:54 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90739>

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-merge-base.txt |   77 ++++++++++++++++++++++++++++++++-----
 1 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 1a7ecbf..fd4b5c9 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -8,26 +8,81 @@ git-merge-base - Find as good common ancestors as possible for a merge
 
 SYNOPSIS
 --------
-'git merge-base' [--all] <commit> <commit>
+'git merge-base' [--all] <commit> <commit>...
 
 DESCRIPTION
 -----------
 
-'git-merge-base' finds as good a common ancestor as possible between
-the two commits. That is, given two commits A and B, `git merge-base A
-B` will output a commit which is reachable from both A and B through
-the parent relationship.
+'git-merge-base' finds best common ancestor(s) between two commits to use
+in a three-way merge.  One common ancestor is 'better' than another common
+ancestor if the latter is an ancestor of the former.  A common ancestor
+that does not have any better common ancestor than it is a 'best common
+ancestor', i.e. a 'merge base'.  Note that there can be more than one
+merge bases between two commits.
 
-Given a selection of equally good common ancestors it should not be
-relied on to decide in any particular way.
-
-The 'git-merge-base' algorithm is still in flux - use the source...
+Among the two commits to compute their merge bases, one is specified by
+the first commit argument on the command line; the other commit is a
+(possibly hypothetical) commit that is a merge across all the remaining
+commits on the command line.  As the most common special case, giving only
+two commits from the command line means computing the merge base between
+the given two commits.
 
 OPTIONS
 -------
 --all::
-	Output all common ancestors for the two commits instead of
-	just one.
+	Output all merge bases for the commits, instead of just one.
+
+DISCUSSION
+----------
+
+Given two commits 'A' and 'B', `git merge-base A B` will output a commit
+which is reachable from both 'A' and 'B' through the parent relationship.
+
+For example, with this topology:
+
+                 o---o---o---B
+                /
+        ---o---1---o---o---o---A
+
+the merge base between 'A' and 'B' is '1'.
+
+Given three commits 'A', 'B' and 'C', `git merge-base A B C` will compute the
+merge base between 'A' and an hypothetical commit 'M', which is a merge
+between 'B' and 'C'.  For example, with this topology:
+
+               o---o---o---o---C
+              /
+             /   o---o---o---B
+            /   /
+        ---2---1---o---o---o---A
+
+the result of `git merge-base A B C` is '1'.  This is because the
+equivalent topology with a merge commit 'M' between 'B' and 'C' is:
+
+
+               o---o---o---o---o
+              /                 \
+             /   o---o---o---o---M
+            /   /
+        ---2---1---o---o---o---A
+
+and the result of `git merge-base A M` is '1'.  Commit '2' is also a
+common ancestor between 'A' and 'M', but '1' is a better common ancestor,
+because '2' is an ancestor of '1'.  Hence, '2' is not a merge base.
+
+When the history involves criss-cross merges, there can be more than one
+'best' common ancestors between two commits.  For example, with this
+topology:
+
+       ---1---o---A
+	   \ /
+	    X
+	   / \
+       ---2---o---o---B
+
+both '1' and '2' are merge-base of A and B.  Neither one is better than
+the other (both are 'best' merge base).  When `--all` option is not given,
+it is unspecified which best one is output.
 
 Author
 ------
-- 
1.6.0.rc0.42.g186458.dirty
