From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Wed, 15 Feb 2006 19:25:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602151915010.916@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org> <43F113A5.2080506@f2s.com>
 <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org> <43F249F7.5060008@vilain.net>
 <Pine.LNX.4.64.0602141357300.3691@g5.osdl.org> <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602141741210.3691@g5.osdl.org> <Pine.LNX.4.64.0602141811050.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602141829080.3691@g5.osdl.org> <Pine.LNX.4.64.0602141953081.3691@g5.osdl.org>
 <7vd5hpj6ab.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 16 04:25:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Zm8-0004uV-9n
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 04:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWBPDZm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 22:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWBPDZm
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 22:25:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20886 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932089AbWBPDZm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2006 22:25:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1G3PXDZ027343
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 15 Feb 2006 19:25:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1G3PWoq027504;
	Wed, 15 Feb 2006 19:25:32 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5hpj6ab.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16264>



Btw, here's one last gasp on this thread: it generalizes the notion of 
traversing several trees in sync, which could be used to do the n-way diff 
for the "-c" and "--cc" style merge diffs a lot more efficiently.

I didn't check, but I'm pretty sure that this would bring the cost of 
doing the 12-way diff down to way under a second. Right now:

	[torvalds@g5 linux]$ time git-diff-tree -c 9fdb62a > /dev/null 

	real    0m1.279s
	user    0m1.272s
	sys     0m0.008s

and that's a bit too much. We I'd really have expected us to be able to do 
better.

It should be possible to do this as a 

	traverse_trees(12, &trees, "", combined_diff_callback);

fairly cheaply (and quickly throw away anything where any of the parents 
was the same as the result).

Junio, that "traverse_trees()" logic is totally independent of whether we 
actually do "git-merge-tree" or not, so if you want to, I could split up 
the patches the other way (and merge "traverse_trees()" first as a new 
interface, independently).

		Linus

----
git-merge-tree: generalize the "traverse <n> trees in sync" functionality

It's actually very useful for other things too. Notably, we could do the
combined diff a lot more efficiently with this.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/merge-tree.c b/merge-tree.c
index 6381118..2a9a013 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -125,44 +125,19 @@ static void unresolved(const char *base,
 		printf("3 %06o %s %s%s\n", n[2].mode, sha1_to_hex(n[2].sha1), base, n[2].path);
 }
 
-/*
- * Merge two trees together (t[1] and t[2]), using a common base (t[0])
- * as the origin.
- *
- * This walks the (sorted) trees in lock-step, checking every possible
- * name. Note that directories automatically sort differently from other
- * files (see "base_name_compare"), so you'll never see file/directory
- * conflicts, because they won't ever compare the same.
- *
- * IOW, if a directory changes to a filename, it will automatically be
- * seen as the directory going away, and the filename being created.
- *
- * Think of this as a three-way diff.
- *
- * The output will be either:
- *  - successful merge
- *	 "0 mode sha1 filename"
- *    NOTE NOTE NOTE! FIXME! We really really need to walk the index
- *    in parallel with this too!
- * 
- *  - conflict:
- *	"1 mode sha1 filename"
- *	"2 mode sha1 filename"
- *	"3 mode sha1 filename"
- *    where not all of the 1/2/3 lines may exist, of course.
- *
- * The successful merge rules are the same as for the three-way merge
- * in git-read-tree.
- */
-static void merge_trees(struct tree_desc t[3], const char *base)
+typedef void (*traverse_callback_t)(int n, unsigned long mask, struct name_entry *entry, const char *base);
+
+static void traverse_trees(int n, struct tree_desc *t, const char *base, traverse_callback_t callback)
 {
+	struct name_entry *entry = xmalloc(n*sizeof(*entry));
+
 	for (;;) {
 		struct name_entry entry[3];
-		unsigned int mask = 0;
+		unsigned long mask = 0;
 		int i, last;
 
 		last = -1;
-		for (i = 0; i < 3; i++) {
+		for (i = 0; i < n; i++) {
 			if (!t[i].size)
 				continue;
 			entry_extract(t+i, entry+i);
@@ -182,7 +157,7 @@ static void merge_trees(struct tree_desc
 				if (cmp < 0)
 					mask = 0;
 			}
-			mask |= 1u << i;
+			mask |= 1ul << i;
 			last = i;
 		}
 		if (!mask)
@@ -192,38 +167,77 @@ static void merge_trees(struct tree_desc
 		 * Update the tree entries we've walked, and clear
 		 * all the unused name-entries.
 		 */
-		for (i = 0; i < 3; i++) {
-			if (mask & (1u << i)) {
+		for (i = 0; i < n; i++) {
+			if (mask & (1ul << i)) {
 				update_tree_entry(t+i);
 				continue;
 			}
 			entry_clear(entry + i);
 		}
+		callback(n, mask, entry, base);
+	}
+	free(entry);
+}
 
-		/* Same in both? */
-		if (same_entry(entry+1, entry+2)) {
-			if (entry[0].sha1) {
-				resolve(base, NULL, entry+1);
-				continue;
-			}
+/*
+ * Merge two trees together (t[1] and t[2]), using a common base (t[0])
+ * as the origin.
+ *
+ * This walks the (sorted) trees in lock-step, checking every possible
+ * name. Note that directories automatically sort differently from other
+ * files (see "base_name_compare"), so you'll never see file/directory
+ * conflicts, because they won't ever compare the same.
+ *
+ * IOW, if a directory changes to a filename, it will automatically be
+ * seen as the directory going away, and the filename being created.
+ *
+ * Think of this as a three-way diff.
+ *
+ * The output will be either:
+ *  - successful merge
+ *	 "0 mode sha1 filename"
+ *    NOTE NOTE NOTE! FIXME! We really really need to walk the index
+ *    in parallel with this too!
+ * 
+ *  - conflict:
+ *	"1 mode sha1 filename"
+ *	"2 mode sha1 filename"
+ *	"3 mode sha1 filename"
+ *    where not all of the 1/2/3 lines may exist, of course.
+ *
+ * The successful merge rules are the same as for the three-way merge
+ * in git-read-tree.
+ */
+static void threeway_callback(int n, unsigned long mask, struct name_entry *entry, const char *base)
+{
+	/* Same in both? */
+	if (same_entry(entry+1, entry+2)) {
+		if (entry[0].sha1) {
+			resolve(base, NULL, entry+1);
+			return;
 		}
+	}
 
-		if (same_entry(entry+0, entry+1)) {
-			if (entry[2].sha1 && !S_ISDIR(entry[2].mode)) {
-				resolve(base, entry+1, entry+2);
-				continue;
-			}
+	if (same_entry(entry+0, entry+1)) {
+		if (entry[2].sha1 && !S_ISDIR(entry[2].mode)) {
+			resolve(base, entry+1, entry+2);
+			return;
 		}
+	}
 
-		if (same_entry(entry+0, entry+2)) {
-			if (entry[1].sha1 && !S_ISDIR(entry[1].mode)) {
-				resolve(base, NULL, entry+1);
-				continue;
-			}
+	if (same_entry(entry+0, entry+2)) {
+		if (entry[1].sha1 && !S_ISDIR(entry[1].mode)) {
+			resolve(base, NULL, entry+1);
+			return;
 		}
-
-		unresolved(base, entry);
 	}
+
+	unresolved(base, entry);
+}
+
+static void merge_trees(struct tree_desc t[3], const char *base)
+{
+	traverse_trees(3, t, base, threeway_callback);
 }
 
 static void *get_tree_descriptor(struct tree_desc *desc, const char *rev)
