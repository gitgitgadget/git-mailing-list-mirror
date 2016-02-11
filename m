From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] list-objects: convert name_path to a strbuf
Date: Thu, 11 Feb 2016 17:26:18 -0500
Message-ID: <20160211222618.GC586@sigill.intra.peff.net>
References: <20160211222314.GA31625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 23:26:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTzgv-0005xN-6n
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 23:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbcBKW0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 17:26:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:40758 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750752AbcBKW0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 17:26:20 -0500
Received: (qmail 24542 invoked by uid 102); 11 Feb 2016 22:26:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:26:20 -0500
Received: (qmail 11753 invoked by uid 107); 11 Feb 2016 22:26:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:26:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2016 17:26:18 -0500
Content-Disposition: inline
In-Reply-To: <20160211222314.GA31625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286011>

The "struct name_path" data is examined in only two places:
we generate it in process_tree(), and we convert it to a
single string in path_name(). Everyone else just passes it
through to those functions.

We can further note that process_tree() already keeps a
single strbuf with the leading tree path, for use with
tree_entry_interesting().

Instead of building a separate name_path linked list, let's
just use the one we already build in "base". This reduces
the amount of code (especially tricky code in path_name()
which did not check for integer overflows caused by deep
or large pathnames).

It is also more efficient in some instances.  Any time we
were using tree_entry_interesting, we were building up the
strbuf anyway, so this is an immediate and obvious win
there. In cases where we were not, we trade off storing
"pathname/" in a strbuf on the heap for each level of the
path, instead of two pointers and an int on the stack (with
one pointer into the tree object). On a 64-bit system, the
latter is 20 bytes; so if path components are less than that
on average, this has lower peak memory usage.  In practice
it probably doesn't matter either way; we are already
holding in memory all of the tree objects leading up to each
pathname, and for normal-depth pathnames, we are only
talking about hundreds of bytes.

This patch leaves "struct name_path" as a thin wrapper
around the strbuf, to avoid disrupting callbacks. We should
fix them, but leaving it out makes this diff easier to view.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects.c | 22 +++++++++-------------
 revision.c     | 25 +++++--------------------
 revision.h     |  4 +---
 3 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 11732d9..4f60a3e 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -62,7 +62,6 @@ static void process_gitlink(struct rev_info *revs,
 static void process_tree(struct rev_info *revs,
 			 struct tree *tree,
 			 show_object_fn show,
-			 struct name_path *path,
 			 struct strbuf *base,
 			 const char *name,
 			 void *cb_data)
@@ -86,17 +85,14 @@ static void process_tree(struct rev_info *revs,
 			return;
 		die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
+
 	obj->flags |= SEEN;
-	show(obj, path, name, cb_data);
-	me.up = path;
-	me.elem = name;
-	me.elem_len = strlen(name);
-
-	if (!match) {
-		strbuf_addstr(base, name);
-		if (base->len)
-			strbuf_addch(base, '/');
-	}
+	me.base = base;
+	show(obj, &me, name, cb_data);
+
+	strbuf_addstr(base, name);
+	if (base->len)
+		strbuf_addch(base, '/');
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
@@ -113,7 +109,7 @@ static void process_tree(struct rev_info *revs,
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
-				     show, &me, base, entry.path,
+				     show, base, entry.path,
 				     cb_data);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
@@ -220,7 +216,7 @@ void traverse_commit_list(struct rev_info *revs,
 			path = "";
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     NULL, &base, path, data);
+				     &base, path, data);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
diff --git a/revision.c b/revision.c
index 6387068..8dd0950 100644
--- a/revision.c
+++ b/revision.c
@@ -27,26 +27,11 @@ static const char *term_good;
 
 char *path_name(const struct name_path *path, const char *name)
 {
-	const struct name_path *p;
-	char *n, *m;
-	int nlen = strlen(name);
-	int len = nlen + 1;
-
-	for (p = path; p; p = p->up) {
-		if (p->elem_len)
-			len += p->elem_len + 1;
-	}
-	n = xmalloc(len);
-	m = n + len - (nlen + 1);
-	memcpy(m, name, nlen + 1);
-	for (p = path; p; p = p->up) {
-		if (p->elem_len) {
-			m -= p->elem_len + 1;
-			memcpy(m, p->elem, p->elem_len);
-			m[p->elem_len] = '/';
-		}
-	}
-	return n;
+	struct strbuf ret = STRBUF_INIT;
+	if (path)
+		strbuf_addbuf(&ret, path->base);
+	strbuf_addstr(&ret, name);
+	return strbuf_detach(&ret, NULL);
 }
 
 void show_object_with_name(FILE *out, struct object *obj,
diff --git a/revision.h b/revision.h
index 23857c0..2a26310 100644
--- a/revision.h
+++ b/revision.h
@@ -258,9 +258,7 @@ extern void mark_parents_uninteresting(struct commit *commit);
 extern void mark_tree_uninteresting(struct tree *tree);
 
 struct name_path {
-	struct name_path *up;
-	int elem_len;
-	const char *elem;
+	struct strbuf *base;
 };
 
 char *path_name(const struct name_path *path, const char *name);
-- 
2.7.1.550.gf5fcbd3
