From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 05/19] tree-diff: show_tree() is not needed
Date: Mon, 24 Feb 2014 20:21:37 +0400
Message-ID: <4555386618c18b40ee9e06ebaae23e2eb5eb0d1e.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:21:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyHA-0003IB-1F
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbaBXQU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:20:57 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34160 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256AbaBXQU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:20:56 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyH0-0003zu-Uz; Mon, 24 Feb 2014 20:20:55 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyIg-00079f-37; Mon, 24 Feb 2014 20:22:38 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242594>

We don't need special code for showing added/removed subtree, because we
can do the same via diff_tree_sha1, just passing NULL for absent tree.

And compared to show_tree(), which was calling show_entry() for every
tree entry, that would lead to the same show_entry() callings:

    show_tree(t):
        for e in t.entries:
            show_entry(e)

    diff_tree_sha1(NULL, new):  /* the same applies to (old, NULL) */
        diff_tree(t1=NULL, t2)
            ...
            if (!t1->size)
                show_entry(t2)
            ...

and possible overhead is negligible, since after the patch, timing for

    `git log --raw --no-abbrev --no-renames`

for navy.git and `linux.git v3.10..v3.11` is practically the same.

So let's say goodbye to show_tree() - it removes some code, but also,
and what is important, consolidates more code for showing/recursing into
trees into one place.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---

( re-posting without change )

 tree-diff.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index a8c2aec..2ad7788 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -55,25 +55,7 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
 	return 0;
 }
 
-/* A whole sub-tree went away or appeared */
-static void show_tree(struct diff_options *opt, const char *prefix,
-		      struct tree_desc *desc, struct strbuf *base)
-{
-	enum interesting match = entry_not_interesting;
-	for (; desc->size; update_tree_entry(desc)) {
-		if (match != all_entries_interesting) {
-			match = tree_entry_interesting(&desc->entry, base, 0,
-						       &opt->pathspec);
-			if (match == all_entries_not_interesting)
-				break;
-			if (match == entry_not_interesting)
-				continue;
-		}
-		show_entry(opt, prefix, desc, base);
-	}
-}
-
-/* A file entry went away or appeared */
+/* An entry went away or appeared */
 static void show_entry(struct diff_options *opt, const char *prefix,
 		       struct tree_desc *desc, struct strbuf *base)
 {
@@ -85,23 +67,12 @@ static void show_entry(struct diff_options *opt, const char *prefix,
 
 	strbuf_add(base, path, pathlen);
 	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode)) {
-		enum object_type type;
-		struct tree_desc inner;
-		void *tree;
-		unsigned long size;
-
-		tree = read_sha1_file(sha1, &type, &size);
-		if (!tree || type != OBJ_TREE)
-			die("corrupt tree sha %s", sha1_to_hex(sha1));
-
 		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE))
 			opt->add_remove(opt, *prefix, mode, sha1, 1, base->buf, 0);
 
 		strbuf_addch(base, '/');
-
-		init_tree_desc(&inner, tree, size);
-		show_tree(opt, prefix, &inner, base);
-		free(tree);
+		diff_tree_sha1(*prefix == '-' ? sha1 : NULL,
+			       *prefix == '+' ? sha1 : NULL, base->buf, opt);
 	} else
 		opt->add_remove(opt, prefix[0], mode, sha1, 1, base->buf, 0);
 
-- 
1.9.rc1.181.g641f458
