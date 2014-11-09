From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] tree.c: update read_tree_recursive callback to pass strbuf as base
Date: Sun,  9 Nov 2014 15:58:37 +0700
Message-ID: <1415523519-28789-1-git-send-email-pclouds@gmail.com>
References: <1415444432-18596-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 09:58:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnOKO-00043L-3S
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 09:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbaKII61 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 03:58:27 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:64138 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbaKII61 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 03:58:27 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so5930344pdb.39
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 00:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9UgjaOyiGf1h2hPNcojr2Q3Lb5kC/JBVe31mXnPgEfw=;
        b=PwdJGydophYyFq6LHLcQ7fnBfJ0VKE7Q/wk0UViNQfXnXDHYT2zWgK31gohlJbf9GD
         Gh5sWGISN//SXgRmmvpQCFPctJ3WUB2v/xsbsYVdTyq+5eits9ikX5Qs4KEnL/AWxcBa
         m1LIzUbLJoWRy/ZjCDGeHKTgK2L9/JMN65BDMv98unRpD7JNM4S0S/CuHQCmFHKrle3z
         nT0Vap63TUg6ABjxblwY/dDKhlPn6SrzDV98OujPPaHy1T7VsOJk3u4WE6mZFHKefzFl
         Pb/4KniXVq4IpR8+oxgYTnvipyR60u9K7rlognGAFF33iGjQK9EGhtwguhi+vnrAjL6L
         caOw==
X-Received: by 10.68.249.133 with SMTP id yu5mr24191796pbc.31.1415523506532;
        Sun, 09 Nov 2014 00:58:26 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id yw3sm13248423pbc.88.2014.11.09.00.58.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Nov 2014 00:58:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Nov 2014 15:58:40 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415444432-18596-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows the callback to use 'base' as a temporary buffer to
quickly assemble full path "without" extra allocation. The callback has
to restore it afterwards of course.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Rebased on latest master, required because of my new changes on master=
=2E.
 s/base_len/baselen/

 archive.c          | 34 +++++++++++++++++++++-------------
 builtin/checkout.c |  8 ++++----
 builtin/log.c      |  2 +-
 builtin/ls-tree.c  |  9 +++++----
 merge-recursive.c  | 15 ++++++---------
 tree.c             | 16 +++++++++++-----
 tree.h             |  3 ++-
 7 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/archive.c b/archive.c
index 94a9981..9e30246 100644
--- a/archive.c
+++ b/archive.c
@@ -157,18 +157,26 @@ static int write_archive_entry(const unsigned cha=
r *sha1, const char *base,
 	return write_entry(args, sha1, path.buf, path.len, mode);
 }
=20
+static int write_archive_entry_buf(const unsigned char *sha1, struct s=
trbuf *base,
+		const char *filename, unsigned mode, int stage,
+		void *context)
+{
+	return write_archive_entry(sha1, base->buf, base->len,
+				     filename, mode, stage, context);
+}
+
 static void queue_directory(const unsigned char *sha1,
-		const char *base, int baselen, const char *filename,
+		struct strbuf *base, const char *filename,
 		unsigned mode, int stage, struct archiver_context *c)
 {
 	struct directory *d;
-	d =3D xmallocz(sizeof(*d) + baselen + 1 + strlen(filename));
+	d =3D xmallocz(sizeof(*d) + base->len + 1 + strlen(filename));
 	d->up	   =3D c->bottom;
-	d->baselen =3D baselen;
+	d->baselen =3D base->len;
 	d->mode	   =3D mode;
 	d->stage   =3D stage;
 	c->bottom  =3D d;
-	d->len =3D sprintf(d->path, "%.*s%s/", baselen, base, filename);
+	d->len =3D sprintf(d->path, "%.*s%s/", (int)base->len, base->buf, fil=
ename);
 	hashcpy(d->sha1, sha1);
 }
=20
@@ -191,28 +199,28 @@ static int write_directory(struct archiver_contex=
t *c)
 }
=20
 static int queue_or_write_archive_entry(const unsigned char *sha1,
-		const char *base, int baselen, const char *filename,
+		struct strbuf *base, const char *filename,
 		unsigned mode, int stage, void *context)
 {
 	struct archiver_context *c =3D context;
=20
 	while (c->bottom &&
-	       !(baselen >=3D c->bottom->len &&
-		 !strncmp(base, c->bottom->path, c->bottom->len))) {
+	       !(base->len >=3D c->bottom->len &&
+		 !strncmp(base->buf, c->bottom->path, c->bottom->len))) {
 		struct directory *next =3D c->bottom->up;
 		free(c->bottom);
 		c->bottom =3D next;
 	}
=20
 	if (S_ISDIR(mode)) {
-		queue_directory(sha1, base, baselen, filename,
+		queue_directory(sha1, base, filename,
 				mode, stage, c);
 		return READ_TREE_RECURSIVE;
 	}
=20
 	if (write_directory(c))
 		return -1;
-	return write_archive_entry(sha1, base, baselen, filename, mode,
+	return write_archive_entry(sha1, base->buf, base->len, filename, mode=
,
 				   stage, context);
 }
=20
@@ -260,7 +268,7 @@ int write_archive_entries(struct archiver_args *arg=
s,
 	err =3D read_tree_recursive(args->tree, "", 0, 0, &args->pathspec,
 				  args->pathspec.has_wildcard ?
 				  queue_or_write_archive_entry :
-				  write_archive_entry,
+				  write_archive_entry_buf,
 				  &context);
 	if (err =3D=3D READ_TREE_RECURSIVE)
 		err =3D 0;
@@ -286,14 +294,14 @@ static const struct archiver *lookup_archiver(con=
st char *name)
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
 	int ret =3D -1;
 	if (S_ISDIR(mode)) {
 		struct strbuf sb =3D STRBUF_INIT;
-		strbuf_addstr(&sb, base);
+		strbuf_addbuf(&sb, base);
 		strbuf_addstr(&sb, filename);
 		if (!match_pathspec(context, sb.buf, sb.len, 0, NULL, 1))
 			ret =3D READ_TREE_RECURSIVE;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5410dac..8adf48d 100644
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
index 734aab3..f2a9f01 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -489,7 +489,7 @@ static int show_tag_object(const unsigned char *sha=
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
index fdb7d0f..25c067e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -275,23 +275,20 @@ struct tree *write_tree_from_memory(struct merge_=
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
+	int baselen =3D base->len;
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
+	strbuf_setlen(base, baselen);
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
