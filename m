From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Tue, 14 Feb 2006 18:05:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602141741210.3691@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org> <43F113A5.2080506@f2s.com>
 <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org> <43F249F7.5060008@vilain.net>
 <Pine.LNX.4.64.0602141357300.3691@g5.osdl.org> <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 03:05:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9C35-0005CJ-Q5
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 03:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbWBOCFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 21:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWBOCFh
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 21:05:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18613 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932447AbWBOCFf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 21:05:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1F25VDZ017947
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Feb 2006 18:05:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1F25UY9007276;
	Tue, 14 Feb 2006 18:05:30 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16203>



On Tue, 14 Feb 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > If somebody is interested in making the "lots of filename changes" case go 
> > fast, I'd be more than happy to walk them through what they'd need to 
> > change. I'm just not horribly motivated to do it myself. Hint, hint.
> 
> In case anybody is wondering, I share the same feeling.  I
> cannot say I'd be "more than happy to" clean up potential
> breakages during the development of such changes, but if the
> change eventually would help certain use cases, I can be
> persuaded to help debugging such a mess ;-).

Actually, I got interested in seeing how hard this is, and wrote a simple 
first cut at doing a tree-optimized merger.

Let me shout a bit first:

  THIS IS WORKING CODE, BUT BE CAREFUL: IT'S A TECHNOLOGY DEMONSTRATION 
  RATHER THAN THE FINAL PRODUCT!

With that out of the way, let me descibe what this does (and then describe 
the missing parts).

This is basically a three-way merge that works entirely on the "tree" 
level, rather than on the index. A lot of the _concepts_ are the same, 
though, and if you're familiar with the results of an index merge, some of 
the output will make more sense.

You give it three trees: the base tree (tree 0), and the two branches to 
be merged (tree 1 and tree 2 respectively). It will then walk these three 
trees, and resolve them as it goes along.

The interesting part is:
 - it can resolve whole sub-directories in one go, without actually even 
   looking recursively at them. A whole subdirectory will resolve the same 
   way as any individual files will (although that may need some 
   modification, see later).
 - if it has a "content conflict", for subdirectories that means "try to 
   do a recursive tree merge", while for non-subdirectories it's just a 
   content conflict and we'll output the stage 1/2/3 information.
 - a successful merge will output a single stage 0 ("merged") entry, 
   potentially for a whole subdirectory.
 - it outputs all the resolve information on stdout, so something like the 
   recursive resolver can pretty easily parse it all.

Now, the caveats:
 - we probably need to be more careful about subdirectory resolves. The 
   trivial case (both branches have the exact same subdirectory) is a 
   trivial resolve, but the other cases ("branch1 matches base, branch2 is 
   different" probably can't be silently just resolved to the "branch2" 
   subdirectory state, since it might involve renames into - or out of - 
   that subdirectory)
 - we do not track the current index file at all, so this does not do the 
   "check that index matches branch1" logic that the three-way merge in 
   git-read-tree does. The theory is that we'd do a full three-way merge 
   (ignoring the index and working directory), and then to update the 
   working tree, we'd do a two-way "git-read-tree branch1->result"
 - I didn't actually make it do all the trivial resolve cases that 
   git-read-tree does. It's a technology demonstration.

Finally (a more serious caveat):
 - doing things through stdout may end up being so expensive that we'd 
   need to do something else. In particular, it's likely that I should 
   not actually output the "merge results", but instead output a "merge 
   results as they _differ_ from branch1"

However, I think this patch is already interesting enough that people who 
are interested in merging trees might want to look at it. Please keep in 
mind that tech _demo_ part, and in particular, keep in mind the final 
"serious caveat" part.

In many ways, the really _interesting_ part of a merge is not the result, 
but how it _changes_ the branch we're merging into. That's particularly 
important as it should hopefully also mean that the output size for any 
reasonable case is minimal (and tracks what we actually need to do to the 
current state to create the final result).

The code very much is organized so that doing the result as a "diff 
against branch1" should be quite easy/possible. I was actually going to do 
it, but I decided that it probably makes the output harder to read. I 
dunno.

Anyway, let's think about this kind of approach.. Note how the code itself 
is actually quite small and short, although it's prbably pretty "dense".

As an interesting test-case, I'd suggest this merge in the kernel:

	git-merge-tree $(git-merge-base 4cbf876 7d2babc) 4cbf876 7d2babc

which resolves beautifully (there are no actual file-level conflicts), and 
you can look at the output of that command to start thinking about what 
it does.

The interesting part (perhaps) is that timing that command for me shows 
that it takes all of 0.004 seconds.. (the git-merge-base thing takes 
considerably more ;)

The point is, we _can_ do the actual merge part really really quickly. 

		Linus

PS. Final note: when I say that it is "WORKING CODE", that is obviously by 
my standards. IOW, I tested it once and it gave reasonable results - so it 
must be perfect.

Whether it works for anybody else, or indeed for any other test-case, is 
not my problem ;)

---
diff-tree f0e6b454ff873429237322c846603d2e1fffc867 (from 6a9b87972f27edfe53da4ce016adf4c0cd42f5e6)
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Tue Feb 14 17:39:15 2006 -0800

    Add "git-merge-tree" functionality
    
    This is basically a tree-optimized merge.  Or rather, it is the first
    stages _towards_ such a merge.
    
    Given a base tree and two branches to merge, it will do a trivial merge,
    optimizing away the case of identical subdirectories, and resolving
    trivial merges.  It outputs the list of file/directory resolves.
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/Makefile b/Makefile
index d40aa6a..4d04f49 100644
--- a/Makefile
+++ b/Makefile
@@ -151,7 +151,7 @@ PROGRAMS = \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
-	git-describe$X
+	git-describe$X git-merge-tree$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
diff --git a/merge-tree.c b/merge-tree.c
new file mode 100644
index 0000000..0d6d434
--- /dev/null
+++ b/merge-tree.c
@@ -0,0 +1,238 @@
+#include "cache.h"
+#include "diff.h"
+
+static const char merge_tree_usage[] = "git-merge-tree <base-tree> <branch1> <branch2>";
+static int resolve_directories = 1;
+
+static void merge_trees(struct tree_desc t[3], const char *base);
+
+static void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
+{
+	unsigned long size = 0;
+	void *buf = NULL;
+
+	if (sha1) {
+		buf = read_object_with_reference(sha1, "tree", &size, NULL);
+		if (!buf)
+			die("unable to read tree %s", sha1_to_hex(sha1));
+	}
+	desc->size = size;
+	desc->buf = buf;
+	return buf;
+}
+
+struct name_entry {
+	const unsigned char *sha1;
+	const char *path;
+	unsigned int mode;
+	int pathlen;
+};
+
+static void entry_clear(struct name_entry *a)
+{
+	memset(a, 0, sizeof(*a));
+}
+
+static int entry_compare(struct name_entry *a, struct name_entry *b)
+{
+	return base_name_compare(
+			a->path, a->pathlen, a->mode,
+			b->path, b->pathlen, b->mode);
+}
+
+static void entry_extract(struct tree_desc *t, struct name_entry *a)
+{
+	a->sha1 = tree_entry_extract(t, &a->path, &a->mode);
+	a->pathlen = strlen(a->path);
+}
+
+/* An empty entry never compares same, not even to another empty entry */
+static int same_entry(struct name_entry *a, struct name_entry *b)
+{
+	return	a->sha1 &&
+		b->sha1 &&
+		!memcmp(a->sha1, b->sha1, 20) &&
+		a->mode == b->mode;
+}
+
+static void resolve(const char *base, struct name_entry *result)
+{
+	printf("0 %06o %s %s%s\n", result->mode, sha1_to_hex(result->sha1), base, result->path);
+}
+
+static int unresolved_directory(const char *base, struct name_entry n[3])
+{
+	int baselen;
+	char *newbase;
+	struct name_entry *p;
+	struct tree_desc t[3];
+	void *buf0, *buf1, *buf2;
+
+	if (!resolve_directories)
+		return 0;
+	p = n;
+	if (!p->mode) {
+		p++;
+		if (!p->mode)
+			p++;
+	}
+	if (!S_ISDIR(p->mode))
+		return 0;
+	baselen = strlen(base);
+	newbase = xmalloc(baselen + p->pathlen + 2);
+	memcpy(newbase, base, baselen);
+	memcpy(newbase + baselen, p->path, p->pathlen);
+	memcpy(newbase + baselen + p->pathlen, "/", 2);
+
+	buf0 = fill_tree_descriptor(t+0, n[0].sha1);
+	buf1 = fill_tree_descriptor(t+1, n[1].sha1);
+	buf2 = fill_tree_descriptor(t+2, n[2].sha1);
+	merge_trees(t, newbase);
+
+	free(buf0);
+	free(buf1);
+	free(buf2);
+	free(newbase);
+	return 1;
+}
+
+static void unresolved(const char *base, struct name_entry n[3])
+{
+	if (unresolved_directory(base, n))
+		return;
+	printf("1 %06o %s %s%s\n", n[0].mode, sha1_to_hex(n[0].sha1), base, n[0].path);
+	printf("2 %06o %s %s%s\n", n[1].mode, sha1_to_hex(n[1].sha1), base, n[1].path);
+	printf("3 %06o %s %s%s\n", n[2].mode, sha1_to_hex(n[2].sha1), base, n[2].path);
+}
+
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
+static void merge_trees(struct tree_desc t[3], const char *base)
+{
+	for (;;) {
+		struct name_entry entry[3];
+		unsigned int mask = 0;
+		int i, last;
+
+		last = -1;
+		for (i = 0; i < 3; i++) {
+			if (!t[i].size)
+				continue;
+			entry_extract(t+i, entry+i);
+			if (last >= 0) {
+				int cmp = entry_compare(entry+i, entry+last);
+
+				/*
+				 * Is the new name bigger than the old one?
+				 * Ignore it
+				 */
+				if (cmp > 0)
+					continue;
+				/*
+				 * Is the new name smaller than the old one?
+				 * Ignore all old ones
+				 */
+				if (cmp < 0)
+					mask = 0;
+			}
+			mask |= 1u << i;
+			last = i;
+		}
+		if (!mask)
+			break;
+
+		/*
+		 * Update the tree entries we've walked, and clear
+		 * all the unused name-entries.
+		 */
+		for (i = 0; i < 3; i++) {
+			if (mask & (1u << i)) {
+				update_tree_entry(t+i);
+				continue;
+			}
+			entry_clear(entry + i);
+		}
+
+		/* Same in both? */
+		if (same_entry(entry+1, entry+2)) {
+			if (entry[0].sha1) {
+				resolve(base, entry+1);
+				continue;
+			}
+		}
+
+		if (same_entry(entry+0, entry+1)) {
+			if (entry[2].sha1) {
+				resolve(base, entry+2);
+				continue;
+			}
+		}
+
+		if (same_entry(entry+0, entry+2)) {
+			if (entry[1].sha1) {
+				resolve(base, entry+1);
+				continue;
+			}
+		}
+
+		unresolved(base, entry);
+	}
+}
+
+static void *get_tree_descriptor(struct tree_desc *desc, const char *rev)
+{
+	unsigned char sha1[20];
+	void *buf;
+
+	if (get_sha1(rev, sha1) < 0)
+		die("unknown rev %s", rev);
+	buf = fill_tree_descriptor(desc, sha1);
+	if (!buf)
+		die("%s is not a tree", rev);
+	return buf;
+}
+
+int main(int argc, char **argv)
+{
+	struct tree_desc t[3];
+	void *buf1, *buf2, *buf3;
+
+	if (argc < 4)
+		usage(merge_tree_usage);
+
+	buf1 = get_tree_descriptor(t+0, argv[1]);
+	buf2 = get_tree_descriptor(t+1, argv[2]);
+	buf3 = get_tree_descriptor(t+2, argv[3]);
+	merge_trees(t, "");
+	free(buf1);
+	free(buf2);
+	free(buf3);
+	return 0;
+}
