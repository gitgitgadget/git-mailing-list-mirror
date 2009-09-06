From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sun, 6 Sep 2009 15:49:06 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909061545290.8946@localhost.localdomain>
References: <4AA17874.7090905@debian.org> <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com> <7vab191dz1.fsf@alter.siamese.dyndns.org> <7vzl98vrmt.fsf@alter.siamese.dyndns.org> <7vvdjwbhzv.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061053330.8946@localhost.localdomain> <7v3a6z3lsg.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0909061248470.8946@localhost.localdomain> <7vws4bzu7w.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0909061338350.8946@localhost.localdomain>
 <alpine.LFD.2.01.0909061354010.8946@localhost.localdomain> <alpine.LFD.2.01.0909061424160.8946@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 00:52:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkQb4-0004sH-MD
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 00:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758153AbZIFWtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 18:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758125AbZIFWtg
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 18:49:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39130 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752689AbZIFWtf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Sep 2009 18:49:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n86Mn6Ko022945
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Sep 2009 15:49:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n86Mn6w9002350;
	Sun, 6 Sep 2009 15:49:06 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0909061424160.8946@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.459 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127874>



On Sun, 6 Sep 2009, Linus Torvalds wrote:
> 
> So here's a slightly updated version, and it passes all the tests.

.. and here's something with a bit more abstraction, a bit more cleanup, 
and making more sure that there's no semantic changes. So that I can feel 
happy signing off on it.

		Linus
---
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 6 Sep 2009 14:37:21 -0700
Subject: [PATCH] Prepare 'traverse_trees()' for D/F conflict lookahead

traverse_trees() used to always walk the trees in order, and used the
special (and fundamentally broken) 'df_name_compare()' function to
compare directory and file entries as equal.

That works fine for all the common cases, when the D/F conflicts are
immediately adjacent, and there are no other entries that could confuse
the ordering.  But if you have one tree with a file 'a', and another
tree with a file 'a-1' and a directory 'a/', then you would not see the
D/F conflict of 'a' and 'a/' without looking ahead past the 'a-1' file
in the other tree.

So this re-organizes the tree walking code so that we can start doing
look-ahead for those cases.  It doesn't actually _do_ that lookahead
yet, because it requires marking the conflicts we've used, but the code
is now organized to do so.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 tree-walk.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 02e2aed..7251dd2 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -62,7 +62,7 @@ void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
 
 static int entry_compare(struct name_entry *a, struct name_entry *b)
 {
-	return df_name_compare(
+	return base_name_compare(
 			a->path, tree_entry_len(a->path, a->sha1), a->mode,
 			b->path, tree_entry_len(b->path, b->sha1), b->mode);
 }
@@ -138,6 +138,80 @@ char *make_traverse_path(char *path, const struct traverse_info *info, const str
 	return path;
 }
 
+/*
+ * See if 'entry' may conflict with a later tree entry in 't': if so,
+ * fill in 'conflict' with the conflicting tree entry from 't'.
+ *
+ * NOTE! Right now we do _not_ create a create a private copy of the tree
+ * descriptor, so we can't actually walk it any further without losing
+ * our place. We should change it to a loop over a copy of the tree
+ * descriptor, but then we'd also have to remember the skipped entries,
+ * so this is a hacky simple case that only handles the case we used
+ * to handle historically (ie clash in the very first entry)
+ *
+ * Note that only a regular file 'entry' can conflict with a later
+ * directory, since a directory with the same name will sort later.
+ */
+static int find_df_conflict(struct tree_desc *t, struct name_entry *entry, struct name_entry *conflict)
+{
+	int len;
+
+	if (S_ISDIR(entry->mode))
+		return 0;
+	len = tree_entry_len(entry->path, entry->sha1);
+
+	while (t->size) {
+		int nlen;
+
+		entry_extract(t, conflict);
+		nlen = tree_entry_len(conflict->path, conflict->sha1);
+
+		/*
+		 * We can only have a future conflict if the entry matches the
+		 * beginning of the name exactly, and if the next character is
+		 * smaller than '/'.
+		 *
+		 * Break out otherwise.
+		 */
+		if (nlen < len)
+			break;
+		if (memcmp(conflict->path, entry->path, nlen))
+			break;
+		if (nlen == len)
+			return 1;
+
+		if (conflict->path[len] > '/')
+			break;
+		/*
+		 * FIXME! Here we'd really like to do 'update_tree_entry(&copy);'
+		 * but that requires us to remember the conflict position specially
+		 * so now we just punt and stop looking for conflicts
+		 */
+		break;
+	}
+	entry_clear(conflict);
+	return 0;
+}
+
+/*
+ * For now, the used entries are always at the head of the tree_desc
+ * (no look-ahead), so marking an entry used is always just a matter
+ * of doing an 'update_tree_entry()'
+ */
+static void used_entry(struct tree_desc *t, struct name_entry *entry)
+{
+	update_tree_entry(t);
+}
+
+static int get_entry(struct tree_desc *t, struct name_entry *entry)
+{
+	if (t->size) {
+		entry_extract(t, entry);
+		return 1;
+	}
+	return 0;
+}
+
 int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 {
 	int ret = 0;
@@ -150,9 +224,8 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 
 		last = -1;
 		for (i = 0; i < n; i++) {
-			if (!t[i].size)
+			if (!get_entry(t+i, entry+i))
 				continue;
-			entry_extract(t+i, entry+i);
 			if (last >= 0) {
 				int cmp = entry_compare(entry+i, entry+last);
 
@@ -179,13 +252,20 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 		dirmask &= mask;
 
 		/*
-		 * Clear all the unused name-entries.
+		 * Clear all the unused name-entries, and look for
+		 * conflicts.
 		 */
 		for (i = 0; i < n; i++) {
 			if (mask & (1ul << i))
 				continue;
 			entry_clear(entry + i);
+			if (find_df_conflict(t+i, entry+last, entry+i))
+				dirmask |= (1ul << i);
 		}
+
+		/* Add in the DF conflict entries into the mask */
+		mask |= dirmask;
+
 		ret = info->fn(n, mask, dirmask, entry, info);
 		if (ret < 0)
 			break;
@@ -194,7 +274,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 		ret = 0;
 		for (i = 0; i < n; i++) {
 			if (mask & (1ul << i))
-				update_tree_entry(t + i);
+				used_entry(t+i, entry+i);
 		}
 	}
 	free(entry);
