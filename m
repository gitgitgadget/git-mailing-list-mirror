From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/8] sha1_file: mark alt object database from add_submodule_odb()
Date: Tue, 30 Apr 2013 10:42:47 +0700
Message-ID: <1367293372-1958-4-git-send-email-pclouds@gmail.com>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 05:42:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX1Sd-0005se-EX
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 05:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758757Ab3D3Dma convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 23:42:30 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:63538 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758638Ab3D3Dma (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 23:42:30 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so50443pbc.30
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=97v4+yx1I1YwkgSGbVnAbtIzQrD37ZYKlPRfVy4v4TU=;
        b=kBOfNcZ/JDQ5y/glgg99zq8GG06iW3zfHhZbwA4lsIKsocWCPnYENcSnPOUFxHXisO
         3V0s2EEV/XZ7XG8l6nx0TUNqst4RYWgidGp8ByTdrol9/PfUXwJstBz0eYRepGi5l/jN
         26BPSmrZXwcdWs8qeuhtmu8tjTIopF4knixPTy6GcmFIWodNtNgUmEXpY93Wtsc5U4MT
         rQCCWJFvTYxP7q2/5FsWWoiBaci8iRjyIGx7vhJseErdecIO3PbLs8OLpdv8p9N/kuuW
         dQVigwCrY9/TuPfXb0VQ8oub7t3tNpjptCcW++GzvC9/9g+uabR/ALnl4Arh44ipUTvG
         DREA==
X-Received: by 10.68.99.163 with SMTP id er3mr74669134pbb.36.1367293349447;
        Mon, 29 Apr 2013 20:42:29 -0700 (PDT)
Received: from lanh ([115.74.52.135])
        by mx.google.com with ESMTPSA id 10sm19688577pbr.45.2013.04.29.20.42.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 20:42:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Apr 2013 10:43:17 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222897>

A submodule's object database may be imported to in-core object pool
for a quick peek without paying the price of running a separate git
command. These databases are marked in for stricter checks later to
avoid accidentially refering to a submodule's SHA-1 from main repo
(except in gitlinks).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h       |  4 +++-
 environment.c |  2 ++
 sha1_file.c   | 37 ++++++++++++++++++++++++++++---------
 submodule.c   |  2 +-
 4 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index dfb78ca..b8d8e03 100644
--- a/cache.h
+++ b/cache.h
@@ -571,6 +571,7 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
+extern int object_database_contaminated;
=20
 /*
  * The character that begins a commented line in user-editable file
@@ -993,11 +994,12 @@ extern void remove_scheduled_dirs(void);
=20
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
+	int external;
 	char *name;
 	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
-extern void read_info_alternates(const char * relative_base, int depth=
);
+extern void read_external_info_alternates(const char * relative_base, =
int depth);
 extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern void foreach_alt_odb(alt_odb_fn, void*);
diff --git a/environment.c b/environment.c
index e2e75c1..5bed7fc 100644
--- a/environment.c
+++ b/environment.c
@@ -72,6 +72,8 @@ char comment_line_char =3D '#';
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
=20
+int object_database_contaminated;
+
 /* This is set by setup_git_dir_gently() and/or git_default_config() *=
/
 char *git_work_tree_cfg;
 static char *work_tree;
diff --git a/sha1_file.c b/sha1_file.c
index 1a744ae..eb682b3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -65,6 +65,8 @@ static struct cached_object empty_tree =3D {
=20
 static struct packed_git *last_found_pack;
=20
+static void read_info_alternates(const char * relative_base,
+				 int depth, int external);
 static struct cached_object *find_cached_object(const unsigned char *s=
ha1,
 						unsigned int origin)
 {
@@ -263,7 +265,10 @@ static int git_open_noatime(const char *name);
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static int link_alt_odb_entry(const char *entry, const char *relative_=
base, int depth)
+static int link_alt_odb_entry(const char *entry,
+			      const char *relative_base,
+			      int depth,
+			      int external)
 {
 	const char *objdir =3D get_object_directory();
 	struct alternate_object_database *ent;
@@ -293,6 +298,7 @@ static int link_alt_odb_entry(const char *entry, co=
nst char *relative_base, int
 	memcpy(ent->base, pathbuf.buf, pfxlen);
 	strbuf_release(&pathbuf);
=20
+	ent->external =3D external;
 	ent->name =3D ent->base + pfxlen + 1;
 	ent->base[pfxlen + 3] =3D '/';
 	ent->base[pfxlen] =3D ent->base[entlen-1] =3D 0;
@@ -326,15 +332,19 @@ static int link_alt_odb_entry(const char *entry, =
const char *relative_base, int
 	ent->next =3D NULL;
=20
 	/* recursively add alternates */
-	read_info_alternates(ent->base, depth + 1);
+	read_info_alternates(ent->base, depth + 1, 0);
=20
 	ent->base[pfxlen] =3D '/';
=20
+	if (external)
+		object_database_contaminated =3D 1;
+
 	return 0;
 }
=20
 static void link_alt_odb_entries(const char *alt, int len, int sep,
-				 const char *relative_base, int depth)
+				 const char *relative_base,
+				 int depth, int external)
 {
 	struct string_list entries =3D STRING_LIST_INIT_NODUP;
 	char *alt_copy;
@@ -356,14 +366,16 @@ static void link_alt_odb_entries(const char *alt,=
 int len, int sep,
 			error("%s: ignoring relative alternate object store %s",
 					relative_base, entry);
 		} else {
-			link_alt_odb_entry(entry, relative_base, depth);
+			link_alt_odb_entry(entry, relative_base,
+					   depth, external);
 		}
 	}
 	string_list_clear(&entries, 0);
 	free(alt_copy);
 }
=20
-void read_info_alternates(const char * relative_base, int depth)
+static void read_info_alternates(const char * relative_base,
+				 int depth, int external)
 {
 	char *map;
 	size_t mapsz;
@@ -387,11 +399,18 @@ void read_info_alternates(const char * relative_b=
ase, int depth)
 	map =3D xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
=20
-	link_alt_odb_entries(map, mapsz, '\n', relative_base, depth);
+	link_alt_odb_entries(map, mapsz, '\n', relative_base,
+			     depth, external);
=20
 	munmap(map, mapsz);
 }
=20
+void read_external_info_alternates(const char *relative_base,
+				   int depth)
+{
+	read_info_alternates(relative_base, depth, 1);
+}
+
 void add_to_alternates_file(const char *reference)
 {
 	struct lock_file *lock =3D xcalloc(1, sizeof(struct lock_file));
@@ -401,7 +420,7 @@ void add_to_alternates_file(const char *reference)
 	if (commit_lock_file(lock))
 		die("could not close alternates file");
 	if (alt_odb_tail)
-		link_alt_odb_entries(alt, strlen(alt), '\n', NULL, 0);
+		link_alt_odb_entries(alt, strlen(alt), '\n', NULL, 0, 0);
 }
=20
 void foreach_alt_odb(alt_odb_fn fn, void *cb)
@@ -431,9 +450,9 @@ void prepare_alt_odb(void)
 	if (!alt) alt =3D "";
=20
 	alt_odb_tail =3D &alt_odb_list;
-	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
+	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0, 0);
=20
-	read_info_alternates(get_object_directory(), 0);
+	read_info_alternates(get_object_directory(), 0, 0);
 }
=20
 static int has_loose_object_extended(const unsigned char *sha1,
diff --git a/submodule.c b/submodule.c
index e728025..3cb63f7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -65,7 +65,7 @@ static int add_submodule_odb(const char *path)
 	alt_odb_list =3D alt_odb;
=20
 	/* add possible alternates from the submodule */
-	read_info_alternates(objects_directory.buf, 0);
+	read_external_info_alternates(objects_directory.buf, 0);
 	prepare_alt_odb();
 done:
 	strbuf_release(&objects_directory);
--=20
1.8.2.83.gc99314b
