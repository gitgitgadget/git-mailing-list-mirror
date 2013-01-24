From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/7] sha1_file: keep track of where an SHA-1 object comes from
Date: Thu, 24 Jan 2013 15:42:14 +0700
Message-ID: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 09:43:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyIOq-0002fK-Io
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 09:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab3AXIms convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 03:42:48 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40461 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3AXImq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 03:42:46 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so5283972pbc.33
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 00:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=sVkTBBffGz5+Gc3g8DBOK923tNltvbgw73UI5pRMAmo=;
        b=wdIv3hL10lZToVIdbXT0dRNhqhlS/O/vVDVKkLdm3LhPuK+gxBH9V7c7H7QD8ljQdx
         pJ7ZPiH+wxaMTZrwGG5zIAAPyfj2KLcGSQC3GlEQFZ76VxV+9x9oHAI4V3N3pHGSMKvf
         +CFniUpXmV2NumU93dpNaW7RfTSUNmgoHOlbU2jrJXyd5MMm1Tcbqgb5I+UXZdeX8AlT
         OcsJ91kY1OW3MpJiEjyYqff4O79C33+x10eidZMzxEtppe0N66nx5FqGQMujc6iPXUSz
         TD7Ya5Mdj/BiMIJq50rQCx5HwZSylJf9/2JXNu5yp0JH+CcOZ9oiGFPMpDS3QUoQoNhs
         C1WQ==
X-Received: by 10.68.222.196 with SMTP id qo4mr2720098pbc.140.1359016966120;
        Thu, 24 Jan 2013 00:42:46 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id rv8sm14489742pbc.27.2013.01.24.00.42.41
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 00:42:44 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 Jan 2013 15:42:20 +0700
X-Mailer: git-send-email 1.8.0.rc3.18.g0d9b108
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214412>

We currently know if an object is loose or packed. We do not know if
it's from the repo's object database, or via alternates
mechanism. With this patch, sha1_object_info_extended() can tell if an
object comes from alternates source (and which one).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 How about this way instead: we keep track of where objects come from
 so we can verify object source when we create or update something
 that contains SHA-1.

 1/7 and 2/7 prepare for tracking object source. The rest verifies
 that new commits, trees, tags, indexes, refs or reflogs do not refer
 to an external source.

 This adds some cost when add_submodule_odb() is used. I did not
 measure, but I guess the added cost is much smaller compared to
 forking, especially on Windows. No breakages detected by the test
 suite, which is really good (or my code is really broken).

 builtin/index-pack.c |  2 +-
 cache.h              |  4 +++-
 fast-import.c        |  2 +-
 sha1_file.c          | 66 ++++++++++++++++++++++++++++++++++++--------=
--------
 4 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 43d364b..a7de3f8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1393,7 +1393,7 @@ static void read_v2_anomalous_offsets(struct pack=
ed_git *p,
=20
 static void read_idx_option(struct pack_idx_option *opts, const char *=
pack_name)
 {
-	struct packed_git *p =3D add_packed_git(pack_name, strlen(pack_name),=
 1);
+	struct packed_git *p =3D add_packed_git(pack_name, strlen(pack_name),=
 1, NULL);
=20
 	if (!p)
 		die(_("Cannot open existing pack file '%s'"), pack_name);
diff --git a/cache.h b/cache.h
index c257953..92854ab 100644
--- a/cache.h
+++ b/cache.h
@@ -978,6 +978,7 @@ struct pack_window {
 extern struct packed_git {
 	struct packed_git *next;
 	struct pack_window *windows;
+	struct alternate_object_database *alt;
 	off_t pack_size;
 	const void *index_data;
 	size_t index_size;
@@ -1066,7 +1067,7 @@ extern void close_pack_windows(struct packed_git =
*);
 extern void unuse_pack(struct pack_window **);
 extern void free_pack_by_name(const char *);
 extern void clear_delta_base_cache(void);
-extern struct packed_git *add_packed_git(const char *, int, int);
+extern struct packed_git *add_packed_git(const char *, int, int, struc=
t alternate_object_database *);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *=
, uint32_t);
 extern off_t nth_packed_object_offset(const struct packed_git *, uint3=
2_t);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_=
git *);
@@ -1102,6 +1103,7 @@ struct object_info {
 			unsigned int is_delta;
 		} packed;
 	} u;
+	struct alternate_object_database *alt;
 };
 extern int sha1_object_info_extended(const unsigned char *, struct obj=
ect_info *);
=20
diff --git a/fast-import.c b/fast-import.c
index c2a814e..4bf732e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -964,7 +964,7 @@ static void end_packfile(void)
 		idx_name =3D keep_pack(create_index());
=20
 		/* Register the packfile with core git's machinery. */
-		new_p =3D add_packed_git(idx_name, strlen(idx_name), 1);
+		new_p =3D add_packed_git(idx_name, strlen(idx_name), 1, NULL);
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] =3D new_p;
diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..afc7355 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -933,7 +933,8 @@ static void try_to_free_pack_memory(size_t size)
 	release_pack_memory(size, -1);
 }
=20
-struct packed_git *add_packed_git(const char *path, int path_len, int =
local)
+struct packed_git *add_packed_git(const char *path, int path_len, int =
local,
+				  struct alternate_object_database *alt)
 {
 	static int have_set_try_to_free_routine;
 	struct stat st;
@@ -973,6 +974,7 @@ struct packed_git *add_packed_git(const char *path,=
 int path_len, int local)
 	p->mtime =3D st.st_mtime;
 	if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
 		hashclr(p->sha1);
+	p->alt =3D alt;
 	return p;
 }
=20
@@ -1000,7 +1002,8 @@ void install_packed_git(struct packed_git *pack)
 	packed_git =3D pack;
 }
=20
-static void prepare_packed_git_one(char *objdir, int local)
+static void prepare_packed_git_one(char *objdir, int local,
+				   struct alternate_object_database *alt)
 {
 	/* Ensure that this buffer is large enough so that we can
 	   append "/pack/" without clobbering the stack even if
@@ -1041,7 +1044,7 @@ static void prepare_packed_git_one(char *objdir, =
int local)
 		/* See if it really is a valid .idx file with corresponding
 		 * .pack file that we can map.
 		 */
-		p =3D add_packed_git(path, len + namelen, local);
+		p =3D add_packed_git(path, len + namelen, local, alt);
 		if (!p)
 			continue;
 		install_packed_git(p);
@@ -1110,11 +1113,11 @@ void prepare_packed_git(void)
=20
 	if (prepare_packed_git_run_once)
 		return;
-	prepare_packed_git_one(get_object_directory(), 1);
+	prepare_packed_git_one(get_object_directory(), 1, NULL);
 	prepare_alt_odb();
 	for (alt =3D alt_odb_list; alt; alt =3D alt->next) {
 		alt->name[-1] =3D 0;
-		prepare_packed_git_one(alt->base, 0);
+		prepare_packed_git_one(alt->base, 0, alt);
 		alt->name[-1] =3D '/';
 	}
 	rearrange_packed_git();
@@ -1215,15 +1218,19 @@ static int git_open_noatime(const char *name)
 	}
 }
=20
-static int open_sha1_file(const unsigned char *sha1)
+static int open_sha1_file(const unsigned char *sha1,
+			  struct alternate_object_database **p_alt)
 {
 	int fd;
 	char *name =3D sha1_file_name(sha1);
 	struct alternate_object_database *alt;
=20
 	fd =3D git_open_noatime(name);
-	if (fd >=3D 0)
+	if (fd >=3D 0) {
+		if (p_alt)
+			*p_alt =3D NULL;
 		return fd;
+	}
=20
 	prepare_alt_odb();
 	errno =3D ENOENT;
@@ -1231,18 +1238,23 @@ static int open_sha1_file(const unsigned char *=
sha1)
 		name =3D alt->name;
 		fill_sha1_path(name, sha1);
 		fd =3D git_open_noatime(alt->base);
-		if (fd >=3D 0)
+		if (fd >=3D 0) {
+			if (p_alt)
+				*p_alt =3D alt;
 			return fd;
+		}
 	}
 	return -1;
 }
=20
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+static void *map_sha1_file_extended(const unsigned char *sha1,
+				    unsigned long *size,
+				    struct alternate_object_database **p_alt)
 {
 	void *map;
 	int fd;
=20
-	fd =3D open_sha1_file(sha1);
+	fd =3D open_sha1_file(sha1, p_alt);
 	map =3D NULL;
 	if (fd >=3D 0) {
 		struct stat st;
@@ -1261,6 +1273,11 @@ void *map_sha1_file(const unsigned char *sha1, u=
nsigned long *size)
 	return map;
 }
=20
+void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+{
+	return map_sha1_file_extended(sha1, size, NULL);
+}
+
 /*
  * There used to be a second loose object header format which
  * was meant to mimic the in-pack format, allowing for direct
@@ -2096,7 +2113,9 @@ static int fill_pack_entry(const unsigned char *s=
ha1,
 	return 1;
 }
=20
-static int find_pack_entry(const unsigned char *sha1, struct pack_entr=
y *e)
+static int find_pack_entry(const unsigned char *sha1,
+			   struct pack_entry *e,
+			   struct alternate_object_database **p_alt)
 {
 	struct packed_git *p;
=20
@@ -2104,14 +2123,19 @@ static int find_pack_entry(const unsigned char =
*sha1, struct pack_entry *e)
 	if (!packed_git)
 		return 0;
=20
-	if (last_found_pack && fill_pack_entry(sha1, e, last_found_pack))
+	if (last_found_pack && fill_pack_entry(sha1, e, last_found_pack)) {
+		if (p_alt)
+			*p_alt =3D last_found_pack->alt;
 		return 1;
+	}
=20
 	for (p =3D packed_git; p; p =3D p->next) {
 		if (p =3D=3D last_found_pack || !fill_pack_entry(sha1, e, p))
 			continue;
=20
 		last_found_pack =3D p;
+		if (p_alt)
+			*p_alt =3D p->alt;
 		return 1;
 	}
 	return 0;
@@ -2130,7 +2154,9 @@ struct packed_git *find_sha1_pack(const unsigned =
char *sha1,
=20
 }
=20
-static int sha1_loose_object_info(const unsigned char *sha1, unsigned =
long *sizep)
+static int sha1_loose_object_info(const unsigned char *sha1,
+				  unsigned long *sizep,
+				  struct alternate_object_database **p_alt)
 {
 	int status;
 	unsigned long mapsize, size;
@@ -2138,7 +2164,7 @@ static int sha1_loose_object_info(const unsigned =
char *sha1, unsigned long *size
 	git_zstream stream;
 	char hdr[32];
=20
-	map =3D map_sha1_file(sha1, &mapsize);
+	map =3D map_sha1_file_extended(sha1, &mapsize, p_alt);
 	if (!map)
 		return error("unable to find %s", sha1_to_hex(sha1));
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
@@ -2168,9 +2194,9 @@ int sha1_object_info_extended(const unsigned char=
 *sha1, struct object_info *oi)
 		return co->type;
 	}
=20
-	if (!find_pack_entry(sha1, &e)) {
+	if (!find_pack_entry(sha1, &e, &oi->alt)) {
 		/* Most likely it's a loose object. */
-		status =3D sha1_loose_object_info(sha1, oi->sizep);
+		status =3D sha1_loose_object_info(sha1, oi->sizep, &oi->alt);
 		if (status >=3D 0) {
 			oi->whence =3D OI_LOOSE;
 			return status;
@@ -2178,7 +2204,7 @@ int sha1_object_info_extended(const unsigned char=
 *sha1, struct object_info *oi)
=20
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git();
-		if (!find_pack_entry(sha1, &e))
+		if (!find_pack_entry(sha1, &e, &oi->alt))
 			return status;
 	}
=20
@@ -2213,7 +2239,7 @@ static void *read_packed_sha1(const unsigned char=
 *sha1,
 	struct pack_entry e;
 	void *data;
=20
-	if (!find_pack_entry(sha1, &e))
+	if (!find_pack_entry(sha1, &e, NULL))
 		return NULL;
 	data =3D cache_or_unpack_entry(e.p, e.offset, size, type, 1);
 	if (!data) {
@@ -2618,14 +2644,14 @@ int has_pack_index(const unsigned char *sha1)
 int has_sha1_pack(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	return find_pack_entry(sha1, &e);
+	return find_pack_entry(sha1, &e, NULL);
 }
=20
 int has_sha1_file(const unsigned char *sha1)
 {
 	struct pack_entry e;
=20
-	if (find_pack_entry(sha1, &e))
+	if (find_pack_entry(sha1, &e, NULL))
 		return 1;
 	return has_loose_object(sha1);
 }
--=20
1.8.0.rc3.18.g0d9b108
