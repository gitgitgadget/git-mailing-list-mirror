From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/21] diff-tree: convert base+baselen to writable strbuf
Date: Wed, 15 Dec 2010 22:02:42 +0700
Message-ID: <1292425376-14550-8-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:05:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsvI-00013J-4h
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab0LOPEu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:04:50 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53691 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab0LOPEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:04:48 -0500
Received: by mail-yw0-f46.google.com with SMTP id 5so1082697ywl.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=pI4z76oGh7P6m0fzSbG4Ltb/K+c0NIA44xH4E1lTEtY=;
        b=kDV5kPpkU+Tk0RNnkhsqh6zY9oW1gNWna1ghZZPINEs++bzN8P82tGKR07lFtJiwoB
         79hl3G0l+Ul6jhyw4YjGL6skVb1BbY0fTfoO7YcMo943Wfn//hNHuTdebsnsf+QNUgZF
         bUuoQvcV5T6RmySMnVEeEFZQsZCOuY418PYs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PgNp9B8CGZSeuAblPPzSWLPzzWw7JFROwmsaT3DX6wCvAZXfjKWYZrSGgkF7sjqnPe
         I5YEnUQwEISmzJzue6kEbV3F/88mtfNvGmt+3Cr0uT6a+FdhjhwZyas+Xs5Mh23pM62D
         +HPVApp6JLmxFBTrwm6OsHqJ4JEBkxXLFWHTA=
Received: by 10.42.177.137 with SMTP id bi9mr5944061icb.194.1292425487817;
        Wed, 15 Dec 2010 07:04:47 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id y3sm853556icw.0.2010.12.15.07.04.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:04:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:03:55 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163763>

In traversing trees, a full path is splitted into two parts: base
directory and entry. They are however quite often concatenated
whenever a full path is needed. Current code allocates a new buffer,
do two memcpy(), use it, then release.

Instead this patch turns "base" to a writable, extendable buffer. When
a concatenation is needed, the callee only needs to append "entry" to
base, use it, then truncate the entry out again. "base" must remain
unchanged before and after entering a function.

This avoids quite a bit of malloc() and memcpy().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-diff.c |  119 ++++++++++++++++++++++++++-------------------------=
-------
 tree-walk.c |    5 +-
 tree-walk.h |    2 +-
 3 files changed, 57 insertions(+), 69 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 28a69dc..67fa6c4 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -6,34 +6,18 @@
 #include "diffcore.h"
 #include "tree.h"
=20
-static char *malloc_base(const char *base, int baselen, const char *pa=
th, int pathlen)
-{
-	char *newbase =3D xmalloc(baselen + pathlen + 2);
-	memcpy(newbase, base, baselen);
-	memcpy(newbase + baselen, path, pathlen);
-	memcpy(newbase + baselen + pathlen, "/", 2);
-	return newbase;
-}
-
-static char *malloc_fullname(const char *base, int baselen, const char=
 *path, int pathlen)
-{
-	char *fullname =3D xmalloc(baselen + pathlen + 1);
-	memcpy(fullname, base, baselen);
-	memcpy(fullname + baselen, path, pathlen);
-	fullname[baselen + pathlen] =3D 0;
-	return fullname;
-}
-
-static void show_entry(struct diff_options *opt, const char *prefix, s=
truct tree_desc *desc,
-		       const char *base, int baselen);
+static void show_entry(struct diff_options *opt, const char *prefix,
+		       struct tree_desc *desc, struct strbuf *base);
=20
-static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *=
t2, const char *base, int baselen, struct diff_options *opt)
+static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *=
t2,
+			      struct strbuf *base, struct diff_options *opt)
 {
 	unsigned mode1, mode2;
 	const char *path1, *path2;
 	const unsigned char *sha1, *sha2;
 	int cmp, pathlen1, pathlen2;
-	char *fullname;
+	int old_baselen =3D base->len;
+	int retval =3D 0;
=20
 	sha1 =3D tree_entry_extract(t1, &path1, &mode1);
 	sha2 =3D tree_entry_extract(t2, &path2, &mode2);
@@ -42,11 +26,11 @@ static int compare_tree_entry(struct tree_desc *t1,=
 struct tree_desc *t2, const
 	pathlen2 =3D tree_entry_len(path2, sha2);
 	cmp =3D base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mo=
de2);
 	if (cmp < 0) {
-		show_entry(opt, "-", t1, base, baselen);
+		show_entry(opt, "-", t1, base);
 		return -1;
 	}
 	if (cmp > 0) {
-		show_entry(opt, "+", t2, base, baselen);
+		show_entry(opt, "+", t2, base);
 		return 1;
 	}
 	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(sha1, sha2) &&=
 mode1 =3D=3D mode2)
@@ -57,33 +41,29 @@ static int compare_tree_entry(struct tree_desc *t1,=
 struct tree_desc *t2, const
 	 * file, we need to consider it a remove and an add.
 	 */
 	if (S_ISDIR(mode1) !=3D S_ISDIR(mode2)) {
-		show_entry(opt, "-", t1, base, baselen);
-		show_entry(opt, "+", t2, base, baselen);
+		show_entry(opt, "-", t1, base);
+		show_entry(opt, "+", t2, base);
 		return 0;
 	}
=20
+	strbuf_add(base, path1, pathlen1);
 	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode1)) {
-		int retval;
-		char *newbase =3D malloc_base(base, baselen, path1, pathlen1);
 		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE)) {
-			newbase[baselen + pathlen1] =3D 0;
 			opt->change(opt, mode1, mode2,
-				    sha1, sha2, newbase, 0, 0);
-			newbase[baselen + pathlen1] =3D '/';
+				    sha1, sha2, base->buf, 0, 0);
 		}
-		retval =3D diff_tree_sha1(sha1, sha2, newbase, opt);
-		free(newbase);
-		return retval;
+		strbuf_addch(base, '/');
+		retval =3D diff_tree_sha1(sha1, sha2, base->buf, opt);
 	}
-
-	fullname =3D malloc_fullname(base, baselen, path1, pathlen1);
-	opt->change(opt, mode1, mode2, sha1, sha2, fullname, 0, 0);
-	free(fullname);
+	else
+		opt->change(opt, mode1, mode2, sha1, sha2, base->buf, 0, 0);
+	strbuf_setlen(base, old_baselen);
 	return 0;
 }
=20
 /* A whole sub-tree went away or appeared */
-static void show_tree(struct diff_options *opt, const char *prefix, st=
ruct tree_desc *desc, const char *base, int baselen)
+static void show_tree(struct diff_options *opt, const char *prefix,
+		      struct tree_desc *desc, struct strbuf *base)
 {
 	int all_interesting =3D 0;
 	while (desc->size) {
@@ -92,30 +72,32 @@ static void show_tree(struct diff_options *opt, con=
st char *prefix, struct tree_
 		if (all_interesting)
 			show =3D 1;
 		else {
-			show =3D tree_entry_interesting(&desc->entry, base, baselen, &opt->=
pathspec);
+			show =3D tree_entry_interesting(&desc->entry, base,
+						      &opt->pathspec);
 			if (show =3D=3D 2)
 				all_interesting =3D 1;
 		}
 		if (show < 0)
 			break;
 		if (show)
-			show_entry(opt, prefix, desc, base, baselen);
+			show_entry(opt, prefix, desc, base);
 		update_tree_entry(desc);
 	}
 }
=20
 /* A file entry went away or appeared */
-static void show_entry(struct diff_options *opt, const char *prefix, s=
truct tree_desc *desc,
-		       const char *base, int baselen)
+static void show_entry(struct diff_options *opt, const char *prefix,
+		       struct tree_desc *desc, struct strbuf *base)
 {
 	unsigned mode;
 	const char *path;
 	const unsigned char *sha1 =3D tree_entry_extract(desc, &path, &mode);
 	int pathlen =3D tree_entry_len(path, sha1);
+	int old_baselen =3D base->len;
=20
+	strbuf_add(base, path, pathlen);
 	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode)) {
 		enum object_type type;
-		char *newbase =3D malloc_base(base, baselen, path, pathlen);
 		struct tree_desc inner;
 		void *tree;
 		unsigned long size;
@@ -124,25 +106,22 @@ static void show_entry(struct diff_options *opt, =
const char *prefix, struct tree
 		if (!tree || type !=3D OBJ_TREE)
 			die("corrupt tree sha %s", sha1_to_hex(sha1));
=20
-		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE)) {
-			newbase[baselen + pathlen] =3D 0;
-			opt->add_remove(opt, *prefix, mode, sha1, newbase, 0);
-			newbase[baselen + pathlen] =3D '/';
-		}
+		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE))
+			opt->add_remove(opt, *prefix, mode, sha1, base->buf, 0);
=20
-		init_tree_desc(&inner, tree, size);
-		show_tree(opt, prefix, &inner, newbase, baselen + 1 + pathlen);
+		strbuf_addch(base, '/');
=20
+		init_tree_desc(&inner, tree, size);
+		show_tree(opt, prefix, &inner, base);
 		free(tree);
-		free(newbase);
-	} else {
-		char *fullname =3D malloc_fullname(base, baselen, path, pathlen);
-		opt->add_remove(opt, prefix[0], mode, sha1, fullname, 0);
-		free(fullname);
-	}
+	} else
+		opt->add_remove(opt, prefix[0], mode, sha1, base->buf, 0);
+
+	strbuf_setlen(base, old_baselen);
 }
=20
-static void skip_uninteresting(struct tree_desc *t, const char *base, =
int baselen, struct diff_options *opt)
+static void skip_uninteresting(struct tree_desc *t, struct strbuf *bas=
e,
+			       struct diff_options *opt)
 {
 	int all_interesting =3D 0;
 	while (t->size) {
@@ -151,7 +130,8 @@ static void skip_uninteresting(struct tree_desc *t,=
 const char *base, int basele
 		if (all_interesting)
 			show =3D 1;
 		else {
-			show =3D tree_entry_interesting(&t->entry, base, baselen, &opt->pat=
hspec);
+			show =3D tree_entry_interesting(&t->entry, base,
+						      &opt->pathspec);
 			if (show =3D=3D 2)
 				all_interesting =3D 1;
 		}
@@ -166,31 +146,36 @@ static void skip_uninteresting(struct tree_desc *=
t, const char *base, int basele
 	}
 }
=20
-int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *=
base, struct diff_options *opt)
+int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
+	      const char *base_str, struct diff_options *opt)
 {
-	int baselen =3D strlen(base);
+	struct strbuf base;
+	int baselen =3D strlen(base_str);
+
+	strbuf_init(&base, PATH_MAX);
+	strbuf_add(&base, base_str, baselen);
=20
 	for (;;) {
 		if (DIFF_OPT_TST(opt, QUICK) &&
 		    DIFF_OPT_TST(opt, HAS_CHANGES))
 			break;
 		if (opt->pathspec.nr) {
-			skip_uninteresting(t1, base, baselen, opt);
-			skip_uninteresting(t2, base, baselen, opt);
+			skip_uninteresting(t1, &base, opt);
+			skip_uninteresting(t2, &base, opt);
 		}
 		if (!t1->size) {
 			if (!t2->size)
 				break;
-			show_entry(opt, "+", t2, base, baselen);
+			show_entry(opt, "+", t2, &base);
 			update_tree_entry(t2);
 			continue;
 		}
 		if (!t2->size) {
-			show_entry(opt, "-", t1, base, baselen);
+			show_entry(opt, "-", t1, &base);
 			update_tree_entry(t1);
 			continue;
 		}
-		switch (compare_tree_entry(t1, t2, base, baselen, opt)) {
+		switch (compare_tree_entry(t1, t2, &base, opt)) {
 		case -1:
 			update_tree_entry(t1);
 			continue;
@@ -203,6 +188,8 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2, const char *base, stru
 		}
 		die("git diff-tree: internal error");
 	}
+
+	strbuf_release(&base);
 	return 0;
 }
=20
diff --git a/tree-walk.c b/tree-walk.c
index a2e2a99..0830676 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -466,12 +466,13 @@ int get_tree_entry(const unsigned char *tree_sha1=
, const char *name, unsigned ch
  *  - negative for "no, and no subsequent entries will be either"
  */
 int tree_entry_interesting(const struct name_entry *entry,
-			   const char *base, int baselen,
+			   const struct strbuf *base_buf,
 			   const struct pathspec *ps)
 {
 	int i;
-	int pathlen;
+	int pathlen, baselen =3D base_buf->len;
 	int never_interesting =3D -1;
+	const char *base =3D base_buf->buf;
=20
 	if (!ps || !ps->nr)
 		return 1;
diff --git a/tree-walk.h b/tree-walk.h
index c12f0a2..f81c232 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -60,6 +60,6 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 	return info->pathlen + tree_entry_len(n->path, n->sha1);
 }
=20
-extern int tree_entry_interesting(const struct name_entry *, const cha=
r *, int, const struct pathspec *ps);
+extern int tree_entry_interesting(const struct name_entry *, const str=
uct strbuf *, const struct pathspec *ps);
=20
 #endif
--=20
1.7.3.3.476.g10a82
