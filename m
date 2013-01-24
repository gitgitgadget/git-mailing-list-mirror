From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/7] sha1_file: separate alt object db from own repos and submodules's
Date: Thu, 24 Jan 2013 15:42:15 +0700
Message-ID: <1359016940-18849-2-git-send-email-pclouds@gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 09:43:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyIOy-0002jC-8B
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 09:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767Ab3AXImy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 03:42:54 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:65173 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab3AXImx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 03:42:53 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so4147128dak.34
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 00:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=jCkYM98lWW3NPjbLTLUIjVQVoI6FUg2dw1eaMpqivo4=;
        b=OTP8aAPIb9Ta5EouqtUw6L7WFswiNL+jCJyiupUoxoox8wlSM2Q5htQyxblXM+f21M
         2Cwm7/O1d+mQt8V1T/iq682I91jee89OCsXg5nr1NeQ61ShlPH+Oea8lohoqgf14EaIS
         /KvI+HVZlA90/HMHLSQvHwRYnaZrtGPVtfahK0PfDfnF02lHf/UESGnjtcQ0Rm8UCnK+
         w0fRg0Xl3C/ULCCuZglxtyouhZEhzIzqvuIB8gB+M+35Yihq3H4/v59SJommOiZVZdCo
         B5R3ZOP2k7ABmHL79Qn6Mmae+Nms4nFI7eQTf/eoDoES3DFODBCfcdzQZk7Qm/Pbx3tl
         Zj/g==
X-Received: by 10.68.228.2 with SMTP id se2mr2861275pbc.93.1359016973193;
        Thu, 24 Jan 2013 00:42:53 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id i5sm15300351pax.13.2013.01.24.00.42.49
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 00:42:52 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 Jan 2013 15:42:28 +0700
X-Mailer: git-send-email 1.8.0.rc3.18.g0d9b108
In-Reply-To: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214413>

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
 sha1_file.c   | 38 +++++++++++++++++++++++++++++---------
 submodule.c   |  2 +-
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 92854ab..b8d5826 100644
--- a/cache.h
+++ b/cache.h
@@ -561,6 +561,7 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
+extern int object_database_contaminated;
=20
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED =3D -1,
@@ -957,11 +958,12 @@ extern void remove_scheduled_dirs(void);
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
index 85edd7f..3c90d95 100644
--- a/environment.c
+++ b/environment.c
@@ -65,6 +65,8 @@ unsigned long pack_size_limit_cfg;
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
index afc7355..af71122 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -58,6 +58,9 @@ static struct cached_object empty_tree =3D {
=20
 static struct packed_git *last_found_pack;
=20
+static void read_info_alternates(const char * relative_base,
+				 int depth, int external);
+
 static struct cached_object *find_cached_object(const unsigned char *s=
ha1)
 {
 	int i;
@@ -247,7 +250,10 @@ static int git_open_noatime(const char *name);
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
@@ -277,6 +283,7 @@ static int link_alt_odb_entry(const char *entry, co=
nst char *relative_base, int
 	memcpy(ent->base, pathbuf.buf, pfxlen);
 	strbuf_release(&pathbuf);
=20
+	ent->external =3D external;
 	ent->name =3D ent->base + pfxlen + 1;
 	ent->base[pfxlen + 3] =3D '/';
 	ent->base[pfxlen] =3D ent->base[entlen-1] =3D 0;
@@ -310,15 +317,19 @@ static int link_alt_odb_entry(const char *entry, =
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
@@ -340,14 +351,16 @@ static void link_alt_odb_entries(const char *alt,=
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
@@ -371,11 +384,18 @@ void read_info_alternates(const char * relative_b=
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
@@ -385,7 +405,7 @@ void add_to_alternates_file(const char *reference)
 	if (commit_lock_file(lock))
 		die("could not close alternates file");
 	if (alt_odb_tail)
-		link_alt_odb_entries(alt, strlen(alt), '\n', NULL, 0);
+		link_alt_odb_entries(alt, strlen(alt), '\n', NULL, 0, 0);
 }
=20
 void foreach_alt_odb(alt_odb_fn fn, void *cb)
@@ -409,9 +429,9 @@ void prepare_alt_odb(void)
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
 static int has_loose_object_local(const unsigned char *sha1)
diff --git a/submodule.c b/submodule.c
index 2f55436..8e4e2ec 100644
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
1.8.0.rc3.18.g0d9b108
