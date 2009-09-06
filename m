From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sun, 6 Sep 2009 13:58:20 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909061354010.8946@localhost.localdomain>
References: <4AA17874.7090905@debian.org> <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com> <7vab191dz1.fsf@alter.siamese.dyndns.org> <7vzl98vrmt.fsf@alter.siamese.dyndns.org> <7vvdjwbhzv.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061053330.8946@localhost.localdomain> <7v3a6z3lsg.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0909061248470.8946@localhost.localdomain> <7vws4bzu7w.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061338350.8946@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 22:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkOoj-00059u-7U
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 22:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399AbZIFU6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 16:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758214AbZIFU6W
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 16:58:22 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40406 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758119AbZIFU6W (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Sep 2009 16:58:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n86KwL4O016670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Sep 2009 13:58:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n86KwKRT016778;
	Sun, 6 Sep 2009 13:58:20 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0909061338350.8946@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.459 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127869>



On Sun, 6 Sep 2009, Linus Torvalds wrote:
> 
> I agree. It's why I initially wanted to do it _all_ in the 
> unpack_callback() thing, but the more I tried, the more complex it got.
> 
> So now my plan is to do the conflict handling at a tree level in 
> traverse_trees(), and get rid of the use of 'df_name_compare()' just there 
> first. 

Grr. I need to go off and do some other things, and this still fails a few 
tests. This is not my more exhaustive patch that actually tries to 
remember the conflict entries we've used up, this is the most cut-down and 
simplified "just remove df_name_compare() in tree-walk.c".

And it's not working, for some reason I'm not seeing, but I thought I'd 
send it to you just as a way to show where I'm trying to take this. Maybe 
you see what my thinko is.

[ In other words: in this version, we only do a single-entry lookahead, 
  exactly like we used to do before. So this is not meant to _fix_ 
  anything, or change any semantics. It's an incremental "change the model 
  so that we can look ahead more in a future patch" patch.

  But it's broken, and I have to run away for a while. ]

		Linus

---
 tree-walk.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 02e2aed..dd563e9 100644
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
@@ -138,6 +138,68 @@ char *make_traverse_path(char *path, const struct traverse_info *info, const str
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
+
+		/*
+		 * FIXME! This is the case where we'd like to mark the tree
+		 * entry used in the original 't' rather than modify 't'!
+		 */
+		if (nlen == len) {
+			update_tree_entry(t);
+			return 1;
+		}
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
 int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 {
 	int ret = 0;
@@ -179,12 +241,15 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
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
 		ret = info->fn(n, mask, dirmask, entry, info);
 		if (ret < 0)
