From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sun, 6 Sep 2009 14:37:07 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909061424160.8946@localhost.localdomain>
References: <4AA17874.7090905@debian.org> <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com> <7vab191dz1.fsf@alter.siamese.dyndns.org> <7vzl98vrmt.fsf@alter.siamese.dyndns.org> <7vvdjwbhzv.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061053330.8946@localhost.localdomain> <7v3a6z3lsg.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0909061248470.8946@localhost.localdomain> <7vws4bzu7w.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0909061338350.8946@localhost.localdomain>
 <alpine.LFD.2.01.0909061354010.8946@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 23:37:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkPQF-0006iP-UY
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 23:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758438AbZIFVhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 17:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758287AbZIFVhI
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 17:37:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59558 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752401AbZIFVhH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Sep 2009 17:37:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n86Lb7cE019671
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Sep 2009 14:37:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n86Lb7iL026696;
	Sun, 6 Sep 2009 14:37:07 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0909061354010.8946@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.459 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127872>



On Sun, 6 Sep 2009, Linus Torvalds wrote:
> 
> And it's not working, for some reason I'm not seeing, but I thought I'd 
> send it to you just as a way to show where I'm trying to take this. Maybe 
> you see what my thinko is.

Duh. My thinko was that I wasn't testing the right thing. The patch works 
fine, my test failures came from the fact that I was working on a branch 
with some other broken experimental features.

Now, the patch I sent out did have a buglet: when a conflict happens, 
'mask' will not have the conflicting bits we just added to 'dirmask'. But 
that buglet doesn't actually seem to affect any of the traverse_tree() 
callers, and they are fine with 'dirmask' being separate from 'mask'.

So here's a slightly updated version, and it passes all the tests.

Again, an important note: this is _not_ meant to change semantics, it's 
really only meant to re-organize the code so that we _can_ do look-ahead 
in the trees for conflicts. But in its current form, the look-ahead is 
limited to the next entry, the same as the old code.

So there should be no semantic changes from this patch. Just avoid using 
'df_name_compare()' and create that 'find_df_conflict()' function that can 
be expanded to actually look ahead more.

		Linus

---
 tree-walk.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 02e2aed..fb5ca1e 100644
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
@@ -179,14 +241,18 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
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
-		ret = info->fn(n, mask, dirmask, entry, info);
+
+		ret = info->fn(n, mask | dirmask, dirmask, entry, info);
 		if (ret < 0)
 			break;
 		if (ret)
