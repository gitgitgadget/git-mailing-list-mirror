From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] tree.c: update read_tree_recursive callback to pass strbuf as base
Date: Sat,  8 Nov 2014 18:00:30 +0700
Message-ID: <1415444432-18596-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 12:00:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn3ku-00064E-ED
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 12:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbaKHLAX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 06:00:23 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:65387 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbaKHLAT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 06:00:19 -0500
Received: by mail-pa0-f52.google.com with SMTP id fa1so5110235pad.25
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 03:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=0q8FJ7pqC0BiQ25tSzsfOc5p28BOn6Hm5MJRoDLdxXc=;
        b=Bn8YmjXJPKellcQAOJCHLHh9mwMflfDzzdmUBonD3MJ0u3RwKwQ8ITTi2E/0S2roGP
         SW9wTt6L/NDEA88T9Y+Ivr4FmQKAzxESJLWxml3uJI1i326zXLYa+cE886QAoyEO9ZbM
         ShtKyg1rJX41bvSMd51+mMjCZP7jWMoUMDO3P6kqGFcV06AcwaCqL96NtpCSANq3MWZy
         F5Z7/tKRc0Ud2KAksZGsywkFe/G85VgXxTKT8Trdes3PdR3KZhbpN2twxa+AFF+GQv0P
         jr46sz+3hWZXf83mzKFCOdi+6ilKgxjvgLTje2BbOW1+F2e532XZpXJL2cOzRv3g/EFn
         ZbZA==
X-Received: by 10.68.175.196 with SMTP id cc4mr1289956pbc.147.1415444419399;
        Sat, 08 Nov 2014 03:00:19 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id ol3sm11233156pbb.17.2014.11.08.03.00.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 03:00:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 18:00:33 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows the callback to use 'base' as a temporary buffer to
quickly assemble full path "without" extra allocation. The caller has
to restore it afterwards of course.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c          | 10 +++++-----
 builtin/checkout.c |  8 ++++----
 builtin/log.c      |  2 +-
 builtin/ls-tree.c  |  9 +++++----
 merge-recursive.c  | 15 ++++++---------
 tree.c             | 16 +++++++++++-----
 tree.h             |  3 ++-
 7 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/archive.c b/archive.c
index 3fc0fb2..fcd0b53 100644
--- a/archive.c
+++ b/archive.c
@@ -103,8 +103,8 @@ struct archiver_context {
 	write_archive_entry_fn_t write_entry;
 };
=20
-static int write_archive_entry(const unsigned char *sha1, const char *=
base,
-		int baselen, const char *filename, unsigned mode, int stage,
+static int write_archive_entry(const unsigned char *sha1, struct strbu=
f *base,
+		const char *filename, unsigned mode, int stage,
 		void *context)
 {
 	static struct strbuf path =3D STRBUF_INIT;
@@ -119,7 +119,7 @@ static int write_archive_entry(const unsigned char =
*sha1, const char *base,
 	strbuf_reset(&path);
 	strbuf_grow(&path, PATH_MAX);
 	strbuf_add(&path, args->base, args->baselen);
-	strbuf_add(&path, base, baselen);
+	strbuf_addbuf(&path, base);
 	strbuf_addstr(&path, filename);
 	if (S_ISDIR(mode) || S_ISGITLINK(mode))
 		strbuf_addch(&path, '/');
@@ -207,8 +207,8 @@ static const struct archiver *lookup_archiver(const=
 char *name)
 	return NULL;
 }
=20
-static int reject_entry(const unsigned char *sha1, const char *base,
-			int baselen, const char *filename, unsigned mode,
+static int reject_entry(const unsigned char *sha1, struct strbuf *base=
,
+			const char *filename, unsigned mode,
 			int stage, void *context)
 {
 	return -1;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f71e745..575b76a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -62,7 +62,7 @@ static int post_checkout_hook(struct commit *old, str=
uct commit *new,
=20
 }
=20
-static int update_some(const unsigned char *sha1, const char *base, in=
t baselen,
+static int update_some(const unsigned char *sha1, struct strbuf *base,
 		const char *pathname, unsigned mode, int stage, void *context)
 {
 	int len;
@@ -71,11 +71,11 @@ static int update_some(const unsigned char *sha1, c=
onst char *base, int baselen,
 	if (S_ISDIR(mode))
 		return READ_TREE_RECURSIVE;
=20
-	len =3D baselen + strlen(pathname);
+	len =3D base->len + strlen(pathname);
 	ce =3D xcalloc(1, cache_entry_size(len));
 	hashcpy(ce->sha1, sha1);
-	memcpy(ce->name, base, baselen);
-	memcpy(ce->name + baselen, pathname, len - baselen);
+	memcpy(ce->name, base->buf, base->len);
+	memcpy(ce->name + base->len, pathname, len - base->len);
 	ce->ce_flags =3D create_ce_flags(0) | CE_UPDATE;
 	ce->ce_namelen =3D len;
 	ce->ce_mode =3D create_ce_mode(mode);
diff --git a/builtin/log.c b/builtin/log.c
index 4389722..d097d16 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -487,7 +487,7 @@ static int show_tag_object(const unsigned char *sha=
1, struct rev_info *rev)
 }
=20
 static int show_tree_object(const unsigned char *sha1,
-		const char *base, int baselen,
+		struct strbuf *base,
 		const char *pathname, unsigned mode, int stage, void *context)
 {
 	printf("%s%s\n", pathname, S_ISDIR(mode) ? "/" : "");
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 51184df..1ab0381 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -61,7 +61,7 @@ static int show_recursive(const char *base, int basel=
en, const char *pathname)
 	}
 }
=20
-static int show_tree(const unsigned char *sha1, const char *base, int =
baselen,
+static int show_tree(const unsigned char *sha1, struct strbuf *base,
 		const char *pathname, unsigned mode, int stage, void *context)
 {
 	int retval =3D 0;
@@ -79,7 +79,7 @@ static int show_tree(const unsigned char *sha1, const=
 char *base, int baselen,
 		 */
 		type =3D commit_type;
 	} else if (S_ISDIR(mode)) {
-		if (show_recursive(base, baselen, pathname)) {
+		if (show_recursive(base->buf, base->len, pathname)) {
 			retval =3D READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
 				return retval;
@@ -90,7 +90,8 @@ static int show_tree(const unsigned char *sha1, const=
 char *base, int baselen,
 		return 0;
=20
 	if (chomp_prefix &&
-	    (baselen < chomp_prefix || memcmp(ls_tree_prefix, base, chomp_pre=
fix)))
+	    (base->len < chomp_prefix ||
+	     memcmp(ls_tree_prefix, base->buf, chomp_prefix)))
 		return 0;
=20
 	if (!(ls_options & LS_NAME_ONLY)) {
@@ -112,7 +113,7 @@ static int show_tree(const unsigned char *sha1, con=
st char *base, int baselen,
 			printf("%06o %s %s\t", mode, type,
 			       find_unique_abbrev(sha1, abbrev));
 	}
-	write_name_quotedpfx(base + chomp_prefix, baselen - chomp_prefix,
+	write_name_quotedpfx(base->buf + chomp_prefix, base->len - chomp_pref=
ix,
 			  pathname, stdout, line_termination);
 	return retval;
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index 1d332b8..1bd8c0d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -276,23 +276,20 @@ struct tree *write_tree_from_memory(struct merge_=
options *o)
 }
=20
 static int save_files_dirs(const unsigned char *sha1,
-		const char *base, int baselen, const char *path,
+		struct strbuf *base, const char *path,
 		unsigned int mode, int stage, void *context)
 {
-	int len =3D strlen(path);
-	char *newpath =3D xmalloc(baselen + len + 1);
+	int base_len =3D base->len;
 	struct merge_options *o =3D context;
=20
-	memcpy(newpath, base, baselen);
-	memcpy(newpath + baselen, path, len);
-	newpath[baselen + len] =3D '\0';
+	strbuf_addstr(base, path);
=20
 	if (S_ISDIR(mode))
-		string_list_insert(&o->current_directory_set, newpath);
+		string_list_insert(&o->current_directory_set, base->buf);
 	else
-		string_list_insert(&o->current_file_set, newpath);
-	free(newpath);
+		string_list_insert(&o->current_file_set, base->buf);
=20
+	strbuf_setlen(base, base_len);
 	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
 }
=20
diff --git a/tree.c b/tree.c
index bb02c1c..58ebfce 100644
--- a/tree.c
+++ b/tree.c
@@ -30,9 +30,12 @@ static int read_one_entry_opt(const unsigned char *s=
ha1, const char *base, int b
 	return add_cache_entry(ce, opt);
 }
=20
-static int read_one_entry(const unsigned char *sha1, const char *base,=
 int baselen, const char *pathname, unsigned mode, int stage, void *con=
text)
+static int read_one_entry(const unsigned char *sha1, struct strbuf *ba=
se,
+			  const char *pathname, unsigned mode, int stage,
+			  void *context)
 {
-	return read_one_entry_opt(sha1, base, baselen, pathname, mode, stage,
+	return read_one_entry_opt(sha1, base->buf, base->len, pathname,
+				  mode, stage,
 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
=20
@@ -40,9 +43,12 @@ static int read_one_entry(const unsigned char *sha1,=
 const char *base, int basel
  * This is used when the caller knows there is no existing entries at
  * the stage that will conflict with the entry being added.
  */
-static int read_one_entry_quick(const unsigned char *sha1, const char =
*base, int baselen, const char *pathname, unsigned mode, int stage, voi=
d *context)
+static int read_one_entry_quick(const unsigned char *sha1, struct strb=
uf *base,
+				const char *pathname, unsigned mode, int stage,
+				void *context)
 {
-	return read_one_entry_opt(sha1, base, baselen, pathname, mode, stage,
+	return read_one_entry_opt(sha1, base->buf, base->len, pathname,
+				  mode, stage,
 				  ADD_CACHE_JUST_APPEND);
 }
=20
@@ -70,7 +76,7 @@ static int read_tree_1(struct tree *tree, struct strb=
uf *base,
 				continue;
 		}
=20
-		switch (fn(entry.sha1, base->buf, base->len,
+		switch (fn(entry.sha1, base,
 			   entry.path, entry.mode, stage, context)) {
 		case 0:
 			continue;
diff --git a/tree.h b/tree.h
index d84ac63..d24125f 100644
--- a/tree.h
+++ b/tree.h
@@ -4,6 +4,7 @@
 #include "object.h"
=20
 extern const char *tree_type;
+struct strbuf;
=20
 struct tree {
 	struct object object;
@@ -22,7 +23,7 @@ void free_tree_buffer(struct tree *tree);
 struct tree *parse_tree_indirect(const unsigned char *sha1);
=20
 #define READ_TREE_RECURSIVE 1
-typedef int (*read_tree_fn_t)(const unsigned char *, const char *, int=
, const char *, unsigned int, int, void *);
+typedef int (*read_tree_fn_t)(const unsigned char *, struct strbuf *, =
const char *, unsigned int, int, void *);
=20
 extern int read_tree_recursive(struct tree *tree,
 			       const char *base, int baselen,
--=20
2.1.0.rc0.78.gc0d8480
