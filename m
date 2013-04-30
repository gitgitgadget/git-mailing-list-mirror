From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/8] sha1_file: new object source for submodule's alt object database
Date: Tue, 30 Apr 2013 10:42:48 +0700
Message-ID: <1367293372-1958-5-git-send-email-pclouds@gmail.com>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 05:42:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX1Sl-0005zm-8I
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 05:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758766Ab3D3Dmi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 23:42:38 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:60881 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757179Ab3D3Dmh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 23:42:37 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so59413pde.37
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=6dvL+ejsbAX7JJXTftyhCvbMFxRtKJAgc458xYFMx0M=;
        b=nzFJ/7YFVd9vCzUa07g4B6euhWmYVhvldGCGx1mYk1CT5td5cu5B5+m+CaBu1hAvt5
         ziG8KqtopWjkDY4GSDUrSjZftfekZMcX7JtC1tNnYRrNh3b5EkDpsSzVBP05P5b6FLbU
         hbKC0cZGVPB+HvAsJDbNETv6x5WSbNPA3sDF0gvBjunDBE0+klfecOFNw2ryedCVUP9W
         hDFXczRcCSUIW/ffSvBTRLN15Pr48GKV2CbAMirt8Rdi9IO1I3VjltdF6KmRJT1ZvLIp
         SD6xs3UM9qdM4ICagj8AijdGbhxE8syXeOP43CrjmAVTqaRNYU6RZ6e0fnwt4Sbq1nXj
         IF9A==
X-Received: by 10.66.252.4 with SMTP id zo4mr33611823pac.100.1367293357120;
        Mon, 29 Apr 2013 20:42:37 -0700 (PDT)
Received: from lanh ([115.74.52.135])
        by mx.google.com with ESMTPSA id ea15sm5025712pad.16.2013.04.29.20.42.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 20:42:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Apr 2013 10:43:25 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222898>

This patch separates submodule odb sources from ordinary alternate
sources. The new sources can be accessed with ODB_EXTALT (e.g. via
read_sha1_file_extended).

ODB_EXTALT is only added to odb_default in certain cases. Basically:

 - External commands do not access submodule odb by default
 - unpack-objects, index-pack and rev-list do not
 - All other builtin commands do

unpack-objects, index-pack and rev-list take new objects from outside
and have to make sure the repository is still in good state. They
should not pay attention to submodule's odb, especially rev-list
because it does connectivity check.

External commands also do not have default access to submodule odb,
simply because I see no reasons why the should. They don't usually
play a big role in the user front, where submodule integration happens
and requires looking into submodule odb.

The die() in add_submodule_odb() may be too strong. There might be a
use case where somebody wants to add_submodule_odb() and look some up
with read_sha1_file_extended() even if odb_default does not contain
ODB_EXTALT. Right now such a use case may need to work around die() by
temporarily adding ODB_EXTALT to odb_default. Not nice, but as no such
use case exists yet to worry about.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     |  1 +
 git.c       | 10 +++++++---
 sha1_file.c | 24 +++++++++++++++++-------
 submodule.c |  3 +++
 4 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index b8d8e03..bc3ccd8 100644
--- a/cache.h
+++ b/cache.h
@@ -759,6 +759,7 @@ int offset_1st_component(const char *path);
  * function cals explicitly.
  */
 #define ODB_DEFAULT	8
+#define ODB_EXTALT	16
=20
 extern unsigned int odb_default;
=20
diff --git a/git.c b/git.c
index 1ada169..49a66fa 100644
--- a/git.c
+++ b/git.c
@@ -242,6 +242,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
  * RUN_SETUP for reading from the configuration file.
  */
 #define NEED_WORK_TREE		(1<<3)
+#define NO_ODB_EXTALT		(1<<4)
=20
 struct cmd_struct {
 	const char *cmd;
@@ -258,6 +259,9 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const char **argv)
 	prefix =3D NULL;
 	help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
 	if (!help) {
+		if (!(p->option & NO_ODB_EXTALT))
+			odb_default |=3D ODB_EXTALT;
+
 		if (p->option & RUN_SETUP)
 			prefix =3D setup_git_directory();
 		if (p->option & RUN_SETUP_GENTLY) {
@@ -349,7 +353,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 		{ "hash-object", cmd_hash_object },
 		{ "help", cmd_help },
-		{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
+		{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_ODB_EXTALT },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP },
@@ -392,7 +396,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "repo-config", cmd_repo_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
-		{ "rev-list", cmd_rev_list, RUN_SETUP },
+		{ "rev-list", cmd_rev_list, RUN_SETUP | NO_ODB_EXTALT },
 		{ "rev-parse", cmd_rev_parse },
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP },
@@ -408,7 +412,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "tag", cmd_tag, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree },
 		{ "unpack-file", cmd_unpack_file, RUN_SETUP },
-		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
+		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP | NO_ODB_EXTALT },
 		{ "update-index", cmd_update_index, RUN_SETUP },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
 		{ "update-server-info", cmd_update_server_info, RUN_SETUP },
diff --git a/sha1_file.c b/sha1_file.c
index eb682b3..53f93ab 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -37,6 +37,10 @@ static inline uintmax_t sz_fmt(size_t s) { return s;=
 }
 const unsigned char null_sha1[20];
=20
 /*
+ * Some commands may not want to touch ODB_EXTALT at all. So
+ * ODB_EXTALT is only enabled later, not now, when we know which
+ * command is running.
+ *
  * clear_delta_base_cache() may be needed if odb_default is changed to
  * a narrower origin set.
  */
@@ -433,10 +437,12 @@ void foreach_alt_odb(alt_odb_fn fn, void *cb)
 			return;
 }
=20
-static inline int match_origin(unsigned int origin, int pack_local)
+static inline int match_origin(unsigned int origin,
+			       struct alternate_object_database *alt)
 {
-	return (pack_local && (origin & ODB_LOCAL)) ||
-		(!pack_local && (origin & ODB_ALT));
+	return (!alt && (origin & ODB_LOCAL)) ||
+		(alt && (origin & ODB_ALT)    && !alt->external) ||
+		(alt && (origin & ODB_EXTALT) &&  alt->external);
 }
=20
 void prepare_alt_odb(void)
@@ -464,10 +470,12 @@ static int has_loose_object_extended(const unsign=
ed char *sha1,
 			return 1;
 	}
=20
-	if (origin & ODB_ALT) {
+	if (origin & (ODB_ALT | ODB_EXTALT)) {
 		struct alternate_object_database *alt;
 		prepare_alt_odb();
 		for (alt =3D alt_odb_list; alt; alt =3D alt->next) {
+			if (!match_origin(origin, alt))
+				continue;
 			fill_sha1_path(alt->name, sha1);
 			if (!access(alt->base, F_OK))
 				return 1;
@@ -478,7 +486,7 @@ static int has_loose_object_extended(const unsigned=
 char *sha1,
=20
 int has_loose_object_nonlocal(const unsigned char *sha1)
 {
-	unsigned int origin =3D ODB_ALT;
+	unsigned int origin =3D ODB_ALT | ODB_EXTALT;
 	return has_loose_object_extended(sha1, origin);
 }
=20
@@ -1354,7 +1362,7 @@ static int open_sha1_file(const unsigned char *sh=
a1, unsigned int origin)
 	    (fd =3D git_open_noatime(name)) >=3D 0)
 		return fd;
=20
-	if (!(origin & ODB_ALT)) {
+	if (!(origin & (ODB_ALT | ODB_EXTALT))) {
 		errno =3D ENOENT;
 		return -1;
 	}
@@ -1362,6 +1370,8 @@ static int open_sha1_file(const unsigned char *sh=
a1, unsigned int origin)
 	prepare_alt_odb();
 	errno =3D ENOENT;
 	for (alt =3D alt_odb_list; alt; alt =3D alt->next) {
+		if (!match_origin(origin, alt))
+			continue;
 		name =3D alt->name;
 		fill_sha1_path(name, sha1);
 		fd =3D git_open_noatime(alt->base);
@@ -2336,7 +2346,7 @@ static int fill_pack_entry(const unsigned char *s=
ha1,
 {
 	off_t offset;
=20
-	if (!match_origin(origin, p->pack_local))
+	if (!match_origin(origin, p->alt))
 		return 0;
=20
 	if (p->num_bad_objects) {
diff --git a/submodule.c b/submodule.c
index 3cb63f7..1271366 100644
--- a/submodule.c
+++ b/submodule.c
@@ -37,6 +37,9 @@ static int add_submodule_odb(const char *path)
 	int ret =3D 0;
 	const char *git_dir;
=20
+	if (!(odb_default & ODB_EXTALT))
+		die("BUG: this command does not support submodule odb");
+
 	strbuf_addf(&objects_directory, "%s/.git", path);
 	git_dir =3D read_gitfile(objects_directory.buf);
 	if (git_dir) {
--=20
1.8.2.83.gc99314b
