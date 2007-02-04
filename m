From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Keep untracked files not involved in a merge.
Date: Sun, 4 Feb 2007 00:45:54 -0500
Message-ID: <20070204054554.GB17344@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 06:46:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDaCS-0000cd-An
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 06:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbXBDFp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 00:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbXBDFp6
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 00:45:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53122 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbXBDFp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 00:45:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDaCJ-0003SD-Rr; Sun, 04 Feb 2007 00:45:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 61DED20FBAE; Sun,  4 Feb 2007 00:45:54 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38653>

My earlier fix (8371234e) to delete renamed tracked files from the
working directory also caused merge-recursive to delete untracked
files that were in the working directory.

The problem here is merge-recursive is deleting the working directory
file without regard for which branch it was associated with.  What we
really want to do during a merge is to only delete files that were
renamed by the branch we are merging into the current branch,
and that are still tracked by the current branch.  These files
definately don't belong in the working directory anymore.

Anything else is either a merge conflict (already handled in other
parts of the code) or a file that is untracked by the current branch
and thus is not even participating in the merge.  Its this latter
class that must be left alone.

For this fix to work we are now assuming that the first non-base
argument passed to git-merge-recursive always corresponds to the
working directory.  This is already true for all in-tree callers
of merge-recursive.  This assumption is also supported by the
long time usage message of "<base> ... -- <head> <remote>", where
"<head>" is implied to be HEAD, which is generally assumed to be
the current tree-ish.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 merge-recursive.c               |    2 +-
 t/t6023-merge-rename-nocruft.sh |   42 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index fa320eb..bbb52a7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -891,7 +891,7 @@ static int process_renames(struct path_list *a_renames,
 			struct diff_filespec src_other, dst_other;
 			int try_merge, stage = a_renames == renames1 ? 3: 2;
 
-			remove_file(1, ren1_src, index_only);
+			remove_file(1, ren1_src, index_only || stage == 3);
 
 			hashcpy(src_other.sha1, ren1->src_entry->stages[stage].sha);
 			src_other.mode = ren1->src_entry->stages[stage].mode;
diff --git a/t/t6023-merge-rename-nocruft.sh b/t/t6023-merge-rename-nocruft.sh
index 69c66cf..65be95f 100755
--- a/t/t6023-merge-rename-nocruft.sh
+++ b/t/t6023-merge-rename-nocruft.sh
@@ -45,6 +45,7 @@ git add A M &&
 git commit -m "initial has A and M" &&
 git branch white &&
 git branch red &&
+git branch blue &&
 
 git checkout white &&
 sed -e "/^g /s/.*/g : white changes a line/" <A >B &&
@@ -58,6 +59,13 @@ echo created by red >R &&
 git update-index --add R &&
 git commit -m "red creates R" &&
 
+git checkout blue &&
+sed -e "/^o /s/.*/g : blue changes a line/" <A >B &&
+rm -f A &&
+mv B A &&
+git update-index A &&
+git commit -m "blue modify A" &&
+
 git checkout master'
 
 # This test broke in 65ac6e9c3f47807cb603af07a6a9e1a43bc119ae
@@ -94,4 +102,38 @@ test_expect_success 'merge white into red (A->B,M->N)' \
 	return 0
 '
 
+# This test broke in 8371234ecaaf6e14fe3f2082a855eff1bbd79ae9
+test_expect_success 'merge blue into white (A->B, mod A, A untracked)' \
+'
+	git checkout -b white-blue white &&
+	echo dirty >A &&
+	git merge blue &&
+	git write-tree >/dev/null || {
+		echo "BAD: merge did not complete"
+		return 1
+	}
+
+	test -f A || {
+		echo "BAD: A does not exist in working directory"
+		return 1
+	}
+	test `cat A` = dirty || {
+		echo "BAD: A content is wrong"
+		return 1
+	}
+	test -f B || {
+		echo "BAD: B does not exist in working directory"
+		return 1
+	}
+	test -f N || {
+		echo "BAD: N does not exist in working directory"
+		return 1
+	}
+	test -f M && {
+		echo "BAD: M still exists in working directory"
+		return 1
+	}
+	return 0
+'
+
 test_done
-- 
1.5.0.rc3.22.g5057
