From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] tree_entry_interesting(): remove dependency on struct diff_options
Date: Wed,  8 Sep 2010 01:48:02 +1000
Message-ID: <1283874483-32017-5-git-send-email-pclouds@gmail.com>
References: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 03:38:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot9cd-00056Y-Hk
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 03:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709Ab0IHBik convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 21:38:40 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33851 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab0IHBij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 21:38:39 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1635270pwi.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 18:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mBLil/5wQ5LpVD2BF+HTJJoXftUl1AE2wVrHifbjYw4=;
        b=lLwQJAYO9ESaAEA6wAc6D5e72f/J/Y4JSmuU431Bep0NksiRbGWcjUzExFkHKa64zz
         eeDXasUhldjq/und1em7VyABfhlghJfxBIlEu1Pik9vTReCjBCKC8IUAg6GYpB+ekiMV
         nIScQHpBe0EM4HDBnOhpm6j6ANhQIIi9j1bvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ibUBFS1vNYH+5DDqHqEISDO7DrTCcSte9GouRANeVKe4NrH6rZkFAtWsLypof3sof5
         hQumnu3MrRU1urA8GiHcWDwrzVtyu/NIUNcY2SxysS/BG6saH0HkSP1Qi6N5VDEC5nct
         hLYhGSNKaFdstnzMGc0UiLUbuNZi68+bRsWic=
Received: by 10.114.111.14 with SMTP id j14mr540535wac.123.1283909918645;
        Tue, 07 Sep 2010 18:38:38 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id d39sm14567599wam.16.2010.09.07.18.38.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 18:38:37 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Sep 2010 11:38:33 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155756>

This function can be potentially used in more places than just
tree-diff.c. "struct diff_options" does not make much sense outside
diff_tree_sha1().

Moreover people seem to be agree that diff machinery should learn
proper pathspecs too (i.e. glob support [1] and stuff), not just
treating pathspecs as tree prefix.

So instead of using pathspecs in
diff_options.{nr_paths,paths,pathlens}, tree_entry_interesting() now
uses struct exclude_list.

Struct exclude_list is also added to diff_options with the intention
to replace {nr_paths,paths,pathlens} later on. But for now, it's just
a temporary field.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.h      |    3 +++
 tree-diff.c |   31 ++++++++++++++++++++++++++++---
 tree-walk.c |   26 +++++++++++---------------
 tree-walk.h |    5 +++--
 4 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/diff.h b/diff.h
index bf2f44d..bd8fe9e 100644
--- a/diff.h
+++ b/diff.h
@@ -5,6 +5,7 @@
 #define DIFF_H
=20
 #include "tree-walk.h"
+#include "dir.h"
=20
 struct rev_info;
 struct diff_options;
@@ -136,6 +137,7 @@ struct diff_options {
 	int nr_paths;
 	const char **paths;
 	int *pathlens;
+	struct exclude_list el;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
 	diff_format_fn_t format_callback;
@@ -163,6 +165,7 @@ const char *diff_get_color(int diff_use_color, enum=
 color_diff ix);
 extern const char mime_boundary_leader[];
=20
 extern void diff_tree_setup_paths(const char **paths, struct diff_opti=
ons *);
+extern void diff_tree_setup_exclude_list(struct diff_options *);
 extern void diff_tree_release_paths(struct diff_options *);
 extern int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 		     const char *base, struct diff_options *opt);
diff --git a/tree-diff.c b/tree-diff.c
index c74d0b5..c2951af 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -92,8 +92,7 @@ static void show_tree(struct diff_options *opt, const=
 char *prefix, struct tree_
 		if (all_interesting)
 			show =3D 1;
 		else {
-			show =3D tree_entry_interesting(desc, base, baselen,
-						      opt);
+			show =3D tree_entry_interesting(&desc->entry, base, baselen, &opt->=
el);
 			if (show =3D=3D 2)
 				all_interesting =3D 1;
 		}
@@ -152,7 +151,7 @@ static void skip_uninteresting(struct tree_desc *t,=
 const char *base, int basele
 		if (all_interesting)
 			show =3D 1;
 		else {
-			show =3D tree_entry_interesting(t, base, baselen, opt);
+			show =3D tree_entry_interesting(&t->entry, base, baselen, &opt->el)=
;
 			if (show =3D=3D 2)
 				all_interesting =3D 1;
 		}
@@ -167,10 +166,34 @@ static void skip_uninteresting(struct tree_desc *=
t, const char *base, int basele
 	}
 }
=20
+void diff_tree_setup_exclude_list(struct diff_options *opt)
+{
+	int i, size1, size2;
+
+	memset(&opt->el, 0, sizeof(opt->el));
+	opt->el.nr =3D opt->nr_paths;
+	if (!opt->el.nr)
+		return;
+
+	size1 =3D opt->el.nr * sizeof(struct exclude *);
+	size2 =3D opt->el.nr * sizeof(struct exclude);
+	opt->el.excludes =3D xmalloc(size1+size2);
+	memset(opt->el.excludes, 0, size1+size2);
+	for (i=3D0; i < opt->el.nr; i++) {
+		struct exclude *exc =3D ((struct exclude *)((char*)opt->el.excludes+=
size1))+i;
+		exc->base =3D opt->paths[i];
+		exc->baselen =3D opt->pathlens[i];
+		opt->el.excludes[i] =3D exc;
+	}
+}
+
 int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *=
base, struct diff_options *opt)
 {
 	int baselen =3D strlen(base);
+	struct exclude_list el;
=20
+	el =3D opt->el; /* diff_tree() can be nested, save and restore opt->e=
l later */
+	diff_tree_setup_exclude_list(opt);
 	for (;;) {
 		if (DIFF_OPT_TST(opt, QUICK) &&
 		    DIFF_OPT_TST(opt, HAS_CHANGES))
@@ -204,6 +227,8 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2, const char *base, stru
 		}
 		die("git diff-tree: internal error");
 	}
+	free(opt->el.excludes);
+	opt->el =3D el;
 	return 0;
 }
=20
diff --git a/tree-walk.c b/tree-walk.c
index bc83fa3..c915218 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -2,7 +2,7 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "tree.h"
-#include "diff.h"
+#include "dir.h"
=20
 static const char *get_mode(const char *str, unsigned int *modep)
 {
@@ -466,25 +466,21 @@ int get_tree_entry(const unsigned char *tree_sha1=
, const char *name, unsigned ch
  *  - zero for no
  *  - negative for "no, and no subsequent entries will be either"
  */
-static int tree_entry_interesting(struct tree_desc *desc, const char *=
base, int baselen, struct diff_options *opt)
+int tree_entry_interesting(const struct name_entry *entry, const char =
*base, int baselen,
+			   const struct exclude_list *el)
 {
-	const char *path;
-	const unsigned char *sha1;
-	unsigned mode;
 	int i;
 	int pathlen;
 	int never_interesting =3D -1;
=20
-	if (!opt->nr_paths)
+	if (!el->nr)
 		return 1;
=20
-	sha1 =3D tree_entry_extract(desc, &path, &mode);
-
-	pathlen =3D tree_entry_len(path, sha1);
+	pathlen =3D tree_entry_len(entry->path, entry->sha1);
=20
-	for (i =3D 0; i < opt->nr_paths; i++) {
-		const char *match =3D opt->paths[i];
-		int matchlen =3D opt->pathlens[i];
+	for (i =3D 0; i < el->nr; i++) {
+		const char *match =3D el->excludes[i]->base;
+		int matchlen =3D el->excludes[i]->baselen;
 		int m =3D -1; /* signals that we haven't called strncmp() */
=20
 		if (baselen >=3D matchlen) {
@@ -522,7 +518,7 @@ static int tree_entry_interesting(struct tree_desc =
*desc, const char *base, int
 			 * Does match sort strictly earlier than path
 			 * with their common parts?
 			 */
-			m =3D strncmp(match, path,
+			m =3D strncmp(match, entry->path,
 				    (matchlen < pathlen) ? matchlen : pathlen);
 			if (m < 0)
 				continue;
@@ -549,7 +545,7 @@ static int tree_entry_interesting(struct tree_desc =
*desc, const char *base, int
 		if (matchlen > pathlen) {
 			if (match[pathlen] !=3D '/')
 				continue;
-			if (!S_ISDIR(mode))
+			if (!S_ISDIR(entry->mode))
 				continue;
 		}
=20
@@ -558,7 +554,7 @@ static int tree_entry_interesting(struct tree_desc =
*desc, const char *base, int
 			 * we cheated and did not do strncmp(), so we do
 			 * that here.
 			 */
-			m =3D strncmp(match, path, pathlen);
+			m =3D strncmp(match, entry->path, pathlen);
=20
 		/*
 		 * If common part matched earlier then it is a hit,
diff --git a/tree-walk.h b/tree-walk.h
index 0572721..4b37671 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -57,7 +57,8 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 	return info->pathlen + tree_entry_len(n->path, n->sha1);
 }
=20
-struct diff_options;
-extern int tree_entry_interesting(struct tree_desc *desc, const char *=
base, int baselen, struct diff_options *opt);
+struct exclude_list;
+extern int tree_entry_interesting(const struct name_entry *entry, cons=
t char *base, int baselen,
+				  const struct exclude_list *el);
=20
 #endif
--=20
1.7.1.rc1.69.g24c2f7
