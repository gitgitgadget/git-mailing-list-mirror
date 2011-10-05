From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH WIP 2/3] tree-diff: teach it to understand exclude patterns
Date: Wed,  5 Oct 2011 18:18:07 +1100
Message-ID: <1317799088-26626-3-git-send-email-pclouds@gmail.com>
References: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 09:18:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBLkh-00058h-I3
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 09:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757880Ab1JEHSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 03:18:47 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64627 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757871Ab1JEHSq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 03:18:46 -0400
Received: by ggnv2 with SMTP id v2so609860ggn.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lRMNxFvU+WVugkDNpmTRoa5Ibv/owDrAhEG2ROZudvI=;
        b=YlLnwUMjVG67ciuJGkzhl8hEYv6XSP2HmomiYKAJICi9BprP2Yrd8/8kbtUychED+s
         HS8qXC3sn3+HDiXXGwmxvfMDJX0XiFyGxiKOOmrJP0OnHVG/LIz5YlfPOzSDdOu7iRdU
         xl2DS46Ktuyit/jfhOykvfG0rynozboeXQLIw=
Received: by 10.236.197.104 with SMTP id s68mr11994634yhn.20.1317799125539;
        Wed, 05 Oct 2011 00:18:45 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id w70sm1212049yhk.6.2011.10.05.00.18.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 00:18:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 05 Oct 2011 18:18:30 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182832>

We introduce a new set of API, diff_tree_*_with_exclude, that also
exclude entries based on .gitignore patterns.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.h      |   11 +++++++++++
 tree-diff.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++----
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/diff.h b/diff.h
index 8c66b59..51c8a5f 100644
--- a/diff.h
+++ b/diff.h
@@ -12,6 +12,7 @@ struct diff_queue_struct;
 struct strbuf;
 struct diff_filespec;
 struct userdiff_driver;
+struct exclude_list;
=20
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -170,8 +171,18 @@ extern void diff_tree_setup_paths(const char **pat=
hs, struct diff_options *);
 extern void diff_tree_release_paths(struct diff_options *);
 extern int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 		     const char *base, struct diff_options *opt);
+extern int diff_tree_with_exclude(struct tree_desc *t1, struct tree_de=
sc *t2,
+				  const char *base, struct diff_options *opt,
+				  struct exclude_list *el,
+				  int def_excl1, int def_excl2);
 extern int diff_tree_sha1(const unsigned char *old, const unsigned cha=
r *new,
 			  const char *base, struct diff_options *opt);
+extern int diff_tree_sha1_with_exclude(const unsigned char *old,
+				       const unsigned char *new,
+				       const char *base,
+				       struct diff_options *opt,
+				       struct exclude_list *el,
+				       int def_excl1, int def_excl2);
 extern int diff_root_tree_sha1(const unsigned char *new, const char *b=
ase,
                                struct diff_options *opt);
=20
diff --git a/tree-diff.c b/tree-diff.c
index b3cc2e4..9938ccf 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -5,12 +5,14 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "tree.h"
+#include "dir.h"
=20
 static void show_entry(struct diff_options *opt, const char *prefix,
 		       struct tree_desc *desc, struct strbuf *base);
=20
 static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *=
t2,
-			      struct strbuf *base, struct diff_options *opt)
+			      struct strbuf *base, struct diff_options *opt,
+			      struct exclude_list *el, int def_excl1, int def_excl2)
 {
 	unsigned mode1, mode2;
 	const char *path1, *path2;
@@ -52,7 +54,8 @@ static int compare_tree_entry(struct tree_desc *t1, s=
truct tree_desc *t2,
 				    sha1, sha2, base->buf, 0, 0);
 		}
 		strbuf_addch(base, '/');
-		diff_tree_sha1(sha1, sha2, base->buf, opt);
+		diff_tree_sha1_with_exclude(sha1, sha2, base->buf, opt,
+					    el, def_excl1, def_excl2);
 	} else {
 		opt->change(opt, mode1, mode2, sha1, sha2, base->buf, 0, 0);
 	}
@@ -113,6 +116,31 @@ static void show_entry(struct diff_options *opt, c=
onst char *prefix,
 	strbuf_setlen(base, old_baselen);
 }
=20
+static int skip_excludes(struct tree_desc *t, struct strbuf *base,
+			 struct exclude_list *el, int defval)
+{
+	for (; t->size; update_tree_entry(t)) {
+		/*
+		 * excluded_from_list only cares whether dtype is
+		 * DT_DIR or something else (except DT_UNKNOWN). Any
+		 * other value would do
+		 */
+		int dtype =3D S_ISDIR(t->entry.mode) ? DT_DIR : DT_REG;
+		int ret =3D excluded_from_list(base->buf, base->len, t->entry.path,
+					     &dtype, el);
+
+		/* If undecided, use matching result of parent dir in defval */
+		if (ret < 0)
+			ret =3D defval;
+
+		if (ret =3D=3D 1 && dtype =3D=3D DT_REG)
+			;
+		else
+			return ret;
+	}
+	return defval;
+}
+
 static void skip_uninteresting(struct tree_desc *t, struct strbuf *bas=
e,
 			       struct diff_options *opt, int *match)
 {
@@ -130,9 +158,17 @@ static void skip_uninteresting(struct tree_desc *t=
, struct strbuf *base,
 int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 	      const char *base_str, struct diff_options *opt)
 {
+	return diff_tree_with_exclude(t1, t2, base_str, opt, NULL, 0, 0);
+}
+
+int diff_tree_with_exclude(struct tree_desc *t1, struct tree_desc *t2,
+			   const char *base_str, struct diff_options *opt,
+			   struct exclude_list *el, int def_excl1, int def_excl2)
+{
 	struct strbuf base;
 	int baselen =3D strlen(base_str);
 	int t1_match =3D 0, t2_match =3D 0;
+	int excl1 =3D 0, excl2 =3D 0;
=20
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
@@ -148,6 +184,10 @@ int diff_tree(struct tree_desc *t1, struct tree_de=
sc *t2,
 			skip_uninteresting(t1, &base, opt, &t1_match);
 			skip_uninteresting(t2, &base, opt, &t2_match);
 		}
+		if (el && el->nr) {
+			excl1 =3D skip_excludes(t1, &base, el, def_excl1);
+			excl2 =3D skip_excludes(t2, &base, el, def_excl2);
+		}
 		if (!t1->size) {
 			if (!t2->size)
 				break;
@@ -160,7 +200,7 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2,
 			update_tree_entry(t1);
 			continue;
 		}
-		switch (compare_tree_entry(t1, t2, &base, opt)) {
+		switch (compare_tree_entry(t1, t2, &base, opt, el, excl1, excl2)) {
 		case -1:
 			update_tree_entry(t1);
 			continue;
@@ -267,6 +307,16 @@ static void try_to_follow_renames(struct tree_desc=
 *t1, struct tree_desc *t2, co
=20
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new,=
 const char *base, struct diff_options *opt)
 {
+	return diff_tree_sha1_with_exclude(old, new, base, opt, NULL, 0, 0);
+}
+
+int diff_tree_sha1_with_exclude(const unsigned char *old,
+				const unsigned char *new,
+				const char *base,
+				struct diff_options *opt,
+				struct exclude_list *el,
+				int def_excl1, int def_excl2)
+{
 	void *tree1, *tree2;
 	struct tree_desc t1, t2;
 	unsigned long size1, size2;
@@ -280,7 +330,7 @@ int diff_tree_sha1(const unsigned char *old, const =
unsigned char *new, const cha
 		die("unable to read destination tree (%s)", sha1_to_hex(new));
 	init_tree_desc(&t1, tree1, size1);
 	init_tree_desc(&t2, tree2, size2);
-	retval =3D diff_tree(&t1, &t2, base, opt);
+	retval =3D diff_tree_with_exclude(&t1, &t2, base, opt, el, def_excl1,=
 def_excl2);
 	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rena=
me()) {
 		init_tree_desc(&t1, tree1, size1);
 		init_tree_desc(&t2, tree2, size2);
--=20
1.7.3.1.256.g2539c.dirty
