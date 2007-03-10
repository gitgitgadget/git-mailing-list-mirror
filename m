From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] fast-import: improve efficiency of tree_content_set
Date: Sat, 10 Mar 2007 14:21:31 -0500
Message-ID: <20070310192131.GB3875@coredump.intra.peff.net>
References: <<20070310191515.GA3416@coredump.intra.peff.net>>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 20:21:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ78P-00063M-6D
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 20:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbXCJTVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 14:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbXCJTVe
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 14:21:34 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3019 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751654AbXCJTVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 14:21:33 -0500
Received: (qmail 19241 invoked from network); 10 Mar 2007 14:21:53 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Mar 2007 14:21:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Mar 2007 14:21:31 -0500
Content-Disposition: inline
In-Reply-To: <<20070310191515.GA3416@coredump.intra.peff.net>>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41880>

This patch keeps the tree entries of a tree_content in
order, sorted by entry name. The lookup in find_tree_entry
now performs a binary search instead of a linear search.

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c |   48 +++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index ac14a5a..4cd01ee 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -594,13 +594,47 @@ static struct tree_content *grow_tree_content(
 	return r;
 }
 
+static int find_tree_entry_bsearch(struct tree_content *t,
+				   struct atom_str *s,
+				   int *found)
+{
+	int high, low, mid=0, cmp=-1;
+	low = 0;
+	high = t->entry_count - 1;
+	while (low <= high) {
+		mid = low + ((high - low) / 2);
+		cmp = strcmp(s->str_dat, t->entries[mid]->name->str_dat);
+		if (cmp < 0)
+			high = mid - 1;
+		else if (cmp > 0)
+			low = mid + 1;
+		else {
+			*found = 1;
+			return mid;
+		}
+	}
+	*found = 0;
+	return cmp < 0 ? mid : mid + 1;
+}
+
 static int find_tree_entry(struct tree_content *t, struct atom_str *s)
 {
-	int i;
-	for (i = 0; i < t->entry_count; i++)
-		if (!strcmp(t->entries[i]->name->str_dat, s->str_dat))
-			return i;
-	return -1;
+	int i, found;
+	i = find_tree_entry_bsearch(t, s, &found);
+	return found ? i : -1;
+}
+
+static void insert_tree_content(struct tree_content *t, struct tree_entry *e)
+{
+	int i, found;
+
+	i = find_tree_entry_bsearch(t, e->name, &found);
+	if (found)
+		die("BUG: duplicate tree content");
+	memmove(t->entries + i + 1, t->entries + i,
+			sizeof(t->entries[0]) * (t->entry_count - i));
+	t->entries[i] = e;
+	t->entry_count++;
 }
 
 static struct tree_entry *new_tree_entry(void)
@@ -1080,7 +1114,7 @@ static void load_tree(struct tree_entry *root)
 		hashcpy(e->versions[1].sha1, (unsigned char*)c);
 		c += 20;
 
-		t->entries[t->entry_count++] = e;
+		insert_tree_content(t, e);
 	}
 	free(buf);
 }
@@ -1241,7 +1275,7 @@ static int tree_content_set(
 	e->name = name;
 	e->versions[0].mode = 0;
 	hashclr(e->versions[0].sha1);
-	t->entries[t->entry_count++] = e;
+	insert_tree_content(t, e);
 	if (slash1) {
 		e->tree = new_tree_content(8);
 		e->versions[1].mode = S_IFDIR;
-- 
1.5.0.3.931.g55c05
