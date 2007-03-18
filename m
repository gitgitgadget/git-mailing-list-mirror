From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Sat, 17 Mar 2007 20:06:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
 <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
 <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
 <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 04:07:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSljh-0005ZM-Dd
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 04:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbXCRDGv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 23:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752986AbXCRDGv
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 23:06:51 -0400
Received: from smtp.osdl.org ([65.172.181.24]:53757 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbXCRDGu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 23:06:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2I36QcD019807
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 20:06:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2I36OC5014674;
	Sat, 17 Mar 2007 19:06:25 -0800
In-Reply-To: <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.977 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42472>


This is a micro-optimization that grew out of the mailing list discussion 
about "strlen()" showing up in profiles. 

We used to pass regular C strings around to the low-level tree walking 
routines, and while this worked fine, it meant that we needed to call 
strlen() on strings that the caller always actually knew the size of 
anyway.

So pass the length of the string down wih the string, and avoid 
unnecessary calls to strlen(). Also, when extracting a pathname from a 
tree entry, use "tree_entry_len()" instead of strlen(), since the length 
of the pathname is directly calculable from the decoded tree entry itself 
without having to actually do another strlen().

This shaves off another ~5-10% from some loads that are very tree 
intensive (notably doing commit filtering by a pathspec).

Signed-off-by: Linus Torvalds  <torvalds@linux-foundation.org>"
---

On Sat, 17 Mar 2007, Linus Torvalds wrote:
>
>  - we pass strings around as just C strings, even when we know their 
>    lengths. Prime example: look at tree-diff.c. And when you look at it, 
>    realize that *for*every*single*strlen* in that file except for the very 
>    last one (which is only used once per process for setup) we actually 
>    know the string length from before, but we (well, *I*) decided that it 
>    wasn't worth passing down as a parameter all the time.

So here's the patch.

It definitely cuts down on CPU usage, and I actually left one extra 
"strlen()" around, simply because I didn't want to mess with the exported 
interface of "diff_tree()".

But that other strlen() is also one that is done *once* for the whole 
tree, so from a performance standpoint it doesn't matter (we *could* have 
passed in that length too, but that would have involved more changes that 
simply aren't really useful).

Does it help? Yes it does. It takes another 5-10% off my test-case. 
"strlen()" still exists, but it's basically half of what it used to be 
because we now basically only call it when literally parsing the tree data 
itself (ie now it's ~8% of the total, and no longer the hottest entry.

Is it worth it? If it was just a random micro-optimization I might not 
care, but I guess it's not that ugly to pass an extra "baselen" around all 
the time. And that "tree_entry_len()" helper function is actually quite 
nice. So yeah, I'd suggest applying this one just because it's actually a 
perfectly fine patch and it does speed things up.

So it *is* very much a micro-optimization, but one that doesn't really 
make the code any uglier, so why not..

I still think that if we do these kinds of optimizations and they matter, 
that shows just how *well* we're actually doing here!

Anyway, Junio, it passes all the tests, as well as passing my "looks 
obviously correct" filter, so..

		Linus

---
diff --git a/tree-diff.c b/tree-diff.c
index c827582..f89b9d3 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -5,9 +5,8 @@
 #include "diff.h"
 #include "tree.h"
 
-static char *malloc_base(const char *base, const char *path, int pathlen)
+static char *malloc_base(const char *base, int baselen, const char *path, int pathlen)
 {
-	int baselen = strlen(base);
 	char *newbase = xmalloc(baselen + pathlen + 2);
 	memcpy(newbase, base, baselen);
 	memcpy(newbase + baselen, path, pathlen);
@@ -16,9 +15,9 @@ static char *malloc_base(const char *base, const char *path, int pathlen)
 }
 
 static void show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc,
-		       const char *base);
+		       const char *base, int baselen);
 
-static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
+static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const char *base, int baselen, struct diff_options *opt)
 {
 	unsigned mode1, mode2;
 	const char *path1, *path2;
@@ -28,15 +27,15 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 	sha1 = tree_entry_extract(t1, &path1, &mode1);
 	sha2 = tree_entry_extract(t2, &path2, &mode2);
 
-	pathlen1 = strlen(path1);
-	pathlen2 = strlen(path2);
+	pathlen1 = tree_entry_len(path1, sha1);
+	pathlen2 = tree_entry_len(path2, sha2);
 	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
 	if (cmp < 0) {
-		show_entry(opt, "-", t1, base);
+		show_entry(opt, "-", t1, base, baselen);
 		return -1;
 	}
 	if (cmp > 0) {
-		show_entry(opt, "+", t2, base);
+		show_entry(opt, "+", t2, base, baselen);
 		return 1;
 	}
 	if (!opt->find_copies_harder && !hashcmp(sha1, sha2) && mode1 == mode2)
@@ -47,14 +46,14 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 	 * file, we need to consider it a remove and an add.
 	 */
 	if (S_ISDIR(mode1) != S_ISDIR(mode2)) {
-		show_entry(opt, "-", t1, base);
-		show_entry(opt, "+", t2, base);
+		show_entry(opt, "-", t1, base, baselen);
+		show_entry(opt, "+", t2, base, baselen);
 		return 0;
 	}
 
 	if (opt->recursive && S_ISDIR(mode1)) {
 		int retval;
-		char *newbase = malloc_base(base, path1, pathlen1);
+		char *newbase = malloc_base(base, baselen, path1, pathlen1);
 		if (opt->tree_in_recursive)
 			opt->change(opt, mode1, mode2,
 				    sha1, sha2, base, path1);
@@ -67,20 +66,20 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 	return 0;
 }
 
-static int interesting(struct tree_desc *desc, const char *base, struct diff_options *opt)
+static int interesting(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt)
 {
 	const char *path;
+	const unsigned char *sha1;
 	unsigned mode;
 	int i;
-	int baselen, pathlen;
+	int pathlen;
 
 	if (!opt->nr_paths)
 		return 1;
 
-	(void)tree_entry_extract(desc, &path, &mode);
+	sha1 = tree_entry_extract(desc, &path, &mode);
 
-	pathlen = strlen(path);
-	baselen = strlen(base);
+	pathlen = tree_entry_len(path, sha1);
 
 	for (i=0; i < opt->nr_paths; i++) {
 		const char *match = opt->paths[i];
@@ -121,18 +120,18 @@ static int interesting(struct tree_desc *desc, const char *base, struct diff_opt
 }
 
 /* A whole sub-tree went away or appeared */
-static void show_tree(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base)
+static void show_tree(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base, int baselen)
 {
 	while (desc->size) {
-		if (interesting(desc, base, opt))
-			show_entry(opt, prefix, desc, base);
+		if (interesting(desc, base, baselen, opt))
+			show_entry(opt, prefix, desc, base, baselen);
 		update_tree_entry(desc);
 	}
 }
 
 /* A file entry went away or appeared */
 static void show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc,
-		       const char *base)
+		       const char *base, int baselen)
 {
 	unsigned mode;
 	const char *path;
@@ -140,7 +139,8 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 
 	if (opt->recursive && S_ISDIR(mode)) {
 		enum object_type type;
-		char *newbase = malloc_base(base, path, strlen(path));
+		int pathlen = tree_entry_len(path, sha1);
+		char *newbase = malloc_base(base, baselen, path, pathlen);
 		struct tree_desc inner;
 		void *tree;
 
@@ -149,7 +149,7 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 			die("corrupt tree sha %s", sha1_to_hex(sha1));
 
 		inner.buf = tree;
-		show_tree(opt, prefix, &inner, newbase);
+		show_tree(opt, prefix, &inner, newbase, baselen + 1 + pathlen);
 
 		free(tree);
 		free(newbase);
@@ -160,26 +160,28 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 
 int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
 {
+	int baselen = strlen(base);
+
 	while (t1->size | t2->size) {
-		if (opt->nr_paths && t1->size && !interesting(t1, base, opt)) {
+		if (opt->nr_paths && t1->size && !interesting(t1, base, baselen, opt)) {
 			update_tree_entry(t1);
 			continue;
 		}
-		if (opt->nr_paths && t2->size && !interesting(t2, base, opt)) {
+		if (opt->nr_paths && t2->size && !interesting(t2, base, baselen, opt)) {
 			update_tree_entry(t2);
 			continue;
 		}
 		if (!t1->size) {
-			show_entry(opt, "+", t2, base);
+			show_entry(opt, "+", t2, base, baselen);
 			update_tree_entry(t2);
 			continue;
 		}
 		if (!t2->size) {
-			show_entry(opt, "-", t1, base);
+			show_entry(opt, "-", t1, base, baselen);
 			update_tree_entry(t1);
 			continue;
 		}
-		switch (compare_tree_entry(t1, t2, base, opt)) {
+		switch (compare_tree_entry(t1, t2, base, baselen, opt)) {
 		case -1:
 			update_tree_entry(t1);
 			continue;
diff --git a/tree-walk.c b/tree-walk.c
index 70f8999..a4a4e2a 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -32,7 +32,7 @@ static void entry_clear(struct name_entry *a)
 static void entry_extract(struct tree_desc *t, struct name_entry *a)
 {
 	a->sha1 = tree_entry_extract(t, &a->path, &a->mode);
-	a->pathlen = strlen(a->path);
+	a->pathlen = tree_entry_len(a->path, a->sha1);
 }
 
 void update_tree_entry(struct tree_desc *desc)
@@ -169,7 +169,7 @@ static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char
 
 		sha1 = tree_entry_extract(t, &entry, mode);
 		update_tree_entry(t);
-		entrylen = strlen(entry);
+		entrylen = tree_entry_len(entry, sha1);
 		if (entrylen > namelen)
 			continue;
 		cmp = memcmp(name, entry, entrylen);
diff --git a/tree-walk.h b/tree-walk.h
index e57befa..a0d7afd 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -13,6 +13,11 @@ struct name_entry {
 	int pathlen;
 };
 
+static inline int tree_entry_len(const char *name, const unsigned char *sha1)
+{
+	return (char *)sha1 - (char *)name - 1;
+}
+
 void update_tree_entry(struct tree_desc *);
 const unsigned char *tree_entry_extract(struct tree_desc *, const char **, unsigned int *);
 
