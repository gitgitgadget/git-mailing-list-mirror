From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] git-blame shouldn't crash if run in an unmerged tree
Date: Thu, 18 Oct 2007 02:34:07 -0400
Message-ID: <20071018063407.GA28861@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: B.Steinbrink@gmx.de
To: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 08:34:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiOxe-0004la-Fy
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 08:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760486AbXJRGeP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 02:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760332AbXJRGeP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 02:34:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52981 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759816AbXJRGeN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 02:34:13 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiOxJ-00021c-Bw; Thu, 18 Oct 2007 02:34:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0A66020FBAE; Thu, 18 Oct 2007 02:34:07 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61495>

I'm applying this patch to my maint tree tonight as it does resolve
the issue for now.  What surprised me was the file that we were
crashing out on wasn't even the file we wanted to get the blame
data for.  :-\

--8>--
=46rom: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] git-blame shouldn't crash if run in an unmerged tree

If we are in the middle of resolving a merge conflict there may be
one or more files whose entries in the index represent an unmerged
state (index entries in the higher-order stages).

Attempting to run git-blame on any file in such a working directory
resulted in "fatal: internal error: ce_mode is 0" as we use the magic
marker for an unmerged entry is 0 (set up by things like diff-lib.c's
do_diff_cache() and builtin-read-tree.c's read_tree_unmerged())
and the ce_match_stat_basic() function gets upset about this.

I'm not entirely sure that the whole "ce_mode =3D 0" case is a good
idea to begin with, and maybe the right thing to do is to remove
that horrid freakish special case, but removing the internal error
seems to be the simplest fix for now.

                Linus

[sp: Thanks to Bj=C3=B6rn Steinbrink for the test case]

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 read-cache.c     |    2 +
 t/t8004-blame.sh |   73 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100755 t/t8004-blame.sh

diff --git a/read-cache.c b/read-cache.c
index 536f4d0..928e8fa 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -149,6 +149,8 @@ static int ce_match_stat_basic(struct cache_entry *=
ce, struct stat *st)
 		else if (ce_compare_gitlink(ce))
 			changed |=3D DATA_CHANGED;
 		return changed;
+	case 0: /* Special case: unmerged file in index */
+		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
 	default:
 		die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
 	}
diff --git a/t/t8004-blame.sh b/t/t8004-blame.sh
new file mode 100755
index 0000000..ba19ac1
--- /dev/null
+++ b/t/t8004-blame.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+# Based on a test case submitted by Bj=C3=B6rn Steinbrink.
+
+test_description=3D'git blame on conflicted files'
+. ./test-lib.sh
+
+test_expect_success 'setup first case' '
+	# Create the old file
+	echo "Old line" > file1 &&
+	git add file1 &&
+	git commit --author "Old Line <ol@localhost>" -m file1.a &&
+
+	# Branch
+	git checkout -b foo &&
+
+	# Do an ugly move and change
+	git rm file1 &&
+	echo "New line ..."  > file2 &&
+	echo "... and more" >> file2 &&
+	git add file2 &&
+	git commit --author "U Gly <ug@localhost>" -m ugly &&
+
+	# Back to master and change something
+	git checkout master &&
+	echo "
+
+bla" >> file1 &&
+	git commit --author "Old Line <ol@localhost>" -a -m file1.b &&
+
+	# Back to foo and merge master
+	git checkout foo &&
+	if git merge master; then
+		echo needed conflict here
+		exit 1
+	else
+		echo merge failed - resolving automatically
+	fi &&
+	echo "New line ...
+... and more
+
+bla
+Even more" > file2 &&
+	git rm file1 &&
+	git commit --author "M Result <mr@localhost>" -a -m merged &&
+
+	# Back to master and change file1 again
+	git checkout master &&
+	sed s/bla/foo/ <file1 >X &&
+	rm file1 &&
+	mv X file1 &&
+	git commit --author "No Bla <nb@localhost>" -a -m replace &&
+
+	# Try to merge into foo again
+	git checkout foo &&
+	if git merge master; then
+		echo needed conflict here
+		exit 1
+	else
+		echo merge failed - test is setup
+	fi
+'
+
+test_expect_success \
+	'blame runs on unconflicted file while other file has conflicts' '
+	git blame file2
+'
+
+test_expect_success 'blame runs on conflicted file in stages 1,3' '
+	git blame file1
+'
+
+test_done
--=20
1.5.3.4.1231.gac645
