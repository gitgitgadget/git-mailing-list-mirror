From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] merge-tree: sometimes, d/f conflict is not an issue
Date: Sun, 8 Jul 2007 01:52:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707080148370.4093@racer.site>
References: <20070405071615.2915.6837.reportbug@acer>
 <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
 <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
 <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131354250.4059@racer.site>
 <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131543140.4059@racer.site>
 <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-440284026-1183855926=:4093"
Cc: git@vger.kernel.org,
	=?utf-8?Q?R=C3=A9mi_Vanicat?= <vanicat@debian.org>,
	gitster@pobox.com
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sun Jul 08 02:59:29 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7L7R-0001tR-AP
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 02:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbXGHA7T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 20:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbXGHA7S
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 20:59:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:41842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753774AbXGHA7R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 20:59:17 -0400
Received: (qmail invoked by alias); 08 Jul 2007 00:59:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 08 Jul 2007 02:59:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ePJlHE2eeQI3SoOz7MYMGBZUpT3SzpK/mopvGfv
	8Gsfw0qT/rjvAJ
X-X-Sender: gene099@racer.site
In-Reply-To: <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51850>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-440284026-1183855926=:4093
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


When a merge has a d/f conflict on a path which was not touched
between the merge base(s) and the remote HEAD, and the index and
HEAD contain the same version for that path (even if empty), it
is not really a conflict.

Noticed by Rémi Vanicat, reported to the Git list by Gerrit Pape.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	The only peculiar result is that you can have an entry at
	stage 0 for one path, and stages 1 and 3 for another path
	where the first path is a prefix.

	This can happen now, when you have deleted a directory
	since the branching point, and put a file in the same place, but
	the other side has changed files in that directory.

	This change is reflected in the change to t3030.

	I have no idea if the change is the best there is, but after
	spending some hours trying to get my head around what is written
	in Documentation/technical/trivial-merge.txt, and what is in
	the function threeway_merge(), and still not understanding most of 
	it, there is not much more that I can do.

	Funny note at the side: when I finally got to Gerrit's email again
	today, gmane said _almost_ that it was 3 weeks, 3 days, 3 hours
	and 3 minutes ago...

 t/t3030-merge-recursive.sh |    2 +-
 t/t3502-cherry-pick.sh     |   31 +++++++++++++++++++++++++++++++
 unpack-trees.c             |   14 ++++++++++++++
 3 files changed, 46 insertions(+), 1 deletions(-)
 create mode 100755 t/t3502-cherry-pick.sh

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 607f57f..d413af1 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -450,7 +450,7 @@ test_expect_success 'merge-recursive d/f conflict result' '
 		echo "100644 $o1 0	a"
 		echo "100644 $o0 0	b"
 		echo "100644 $o0 0	c"
-		echo "100644 $o6 2	d"
+		echo "100644 $o6 0	d"
 		echo "100644 $o0 1	d/e"
 		echo "100644 $o1 3	d/e"
 	) >expected &&
diff --git a/t/t3502-cherry-pick.sh b/t/t3502-cherry-pick.sh
new file mode 100755
index 0000000..da3d26e
--- /dev/null
+++ b/t/t3502-cherry-pick.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description='test cherry-pick'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo foo > file &&
+	ln -s dangling link &&
+	git add file link &&
+	test_tick &&
+	git commit -m foo &&
+	git checkout -b branch &&
+	git rm link &&
+	test_tick &&
+	git commit -m "remove link" &&
+	mkdir link &&
+	echo bar > link/file &&
+	git add link/file &&
+	test_tick &&
+	git commit -m "add dir" &&
+	echo bar > file &&
+	git commit -m "change file" file &&
+	git checkout master
+'
+
+test_expect_success 'cherry-pick ignores unrelated dir/symlink conflict' '
+	git cherry-pick branch
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index cac2411..080b016 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -643,6 +643,20 @@ int threeway_merge(struct cache_entry **stages,
 	index = stages[0];
 	head = stages[o->head_idx];
 
+	/*
+	 * Special case: do not care about a dir/file conflict, when
+	 * the entries have not been touched.
+	 * IOW if the ancestors are identical to the remote, and the
+	 * index is the same as head, just take head.
+	 */
+	if (head && same(index, head)) {
+		for (i = 1; i < o->head_idx; i++)
+			if (!same(stages[i], remote))
+				break;
+		if (i == o->head_idx)
+			return merged_entry(head, index, o);
+	}
+
 	if (head == o->df_conflict_entry) {
 		df_conflict_head = 1;
 		head = NULL;
-- 
1.5.3.rc0.2712.g125b7f


--8323584-440284026-1183855926=:4093--
