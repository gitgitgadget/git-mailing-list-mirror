From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/8] sha1_file: keep track of alternate source of objects
Date: Tue, 30 Apr 2013 10:42:46 +0700
Message-ID: <1367293372-1958-3-git-send-email-pclouds@gmail.com>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 05:42:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX1SX-0005ms-4d
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 05:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758652Ab3D3DmX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 23:42:23 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:50947 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758638Ab3D3DmW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 23:42:22 -0400
Received: by mail-pb0-f42.google.com with SMTP id up15so51223pbc.15
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=wHbqyT8ZuKw8UM0CxTrBdulPg5p6zWgiulO6IW7OU+4=;
        b=frGfYcQ8/gCIdq+o0VyH/rbh2dMV2g+GtDa9FbmK2gbRCqNavCCoWZZH1mhfZ+Qckr
         ed8DBgCfz3VEHFtUzbfSXpq/CppJ/pW2himu/7JxMAT4T0JWeHhSg9REyRf+QMvAVfnx
         q5IeRlsXSIupBXza38fiGp6nq6O2bBtxFMK7kYpIgzAkWfgBWZEdeuZ7yo+hXE/pp4na
         K75wf6t0XQKy9J7HEeGxP9o8ADK0RQMdge3SAVw/vs1WV87VJpCk7/7fZ4iToKWW56/w
         Ztsi2t4vRYGxMgJH8veA5xu/z2t83kVgPQfbTZvO0o+k/Z02F8VxvcYMJNUZ0SVudq/d
         Eu4A==
X-Received: by 10.68.160.162 with SMTP id xl2mr3874896pbb.84.1367293341703;
        Mon, 29 Apr 2013 20:42:21 -0700 (PDT)
Received: from lanh ([115.74.52.135])
        by mx.google.com with ESMTPSA id be7sm28580645pad.20.2013.04.29.20.42.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 20:42:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Apr 2013 10:43:10 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222896>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |  2 +-
 cache.h              |  3 ++-
 fast-import.c        |  2 +-
 sha1_file.c          | 15 +++++++++------
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 79dfe47..aab9de5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1414,7 +1414,7 @@ static void read_v2_anomalous_offsets(struct pack=
ed_git *p,
=20
 static void read_idx_option(struct pack_idx_option *opts, const char *=
pack_name)
 {
-	struct packed_git *p =3D add_packed_git(pack_name, strlen(pack_name),=
 1);
+	struct packed_git *p =3D add_packed_git(pack_name, strlen(pack_name),=
 NULL);
=20
 	if (!p)
 		die(_("Cannot open existing pack file '%s'"), pack_name);
diff --git a/cache.h b/cache.h
index bed403a..dfb78ca 100644
--- a/cache.h
+++ b/cache.h
@@ -1014,6 +1014,7 @@ struct pack_window {
 extern struct packed_git {
 	struct packed_git *next;
 	struct pack_window *windows;
+	struct alternate_object_database *alt;
 	off_t pack_size;
 	const void *index_data;
 	size_t index_size;
@@ -1107,7 +1108,7 @@ extern void close_pack_windows(struct packed_git =
*);
 extern void unuse_pack(struct pack_window **);
 extern void free_pack_by_name(const char *);
 extern void clear_delta_base_cache(void);
-extern struct packed_git *add_packed_git(const char *, int, int);
+extern struct packed_git *add_packed_git(const char *, int, struct alt=
ernate_object_database *);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *=
, uint32_t);
 extern off_t nth_packed_object_offset(const struct packed_git *, uint3=
2_t);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_=
git *);
diff --git a/fast-import.c b/fast-import.c
index 8542786..749e9db 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -964,7 +964,7 @@ static void end_packfile(void)
 		idx_name =3D keep_pack(create_index());
=20
 		/* Register the packfile with core git's machinery. */
-		new_p =3D add_packed_git(idx_name, strlen(idx_name), 1);
+		new_p =3D add_packed_git(idx_name, strlen(idx_name), NULL);
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] =3D new_p;
diff --git a/sha1_file.c b/sha1_file.c
index d1f44c9..1a744ae 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -958,7 +958,8 @@ static void try_to_free_pack_memory(size_t size)
 	release_pack_memory(size, -1);
 }
=20
-struct packed_git *add_packed_git(const char *path, int path_len, int =
local)
+struct packed_git *add_packed_git(const char *path, int path_len,
+				  struct alternate_object_database *alt)
 {
 	static int have_set_try_to_free_routine;
 	struct stat st;
@@ -994,7 +995,8 @@ struct packed_git *add_packed_git(const char *path,=
 int path_len, int local)
 	 * actually mapping the pack file.
 	 */
 	p->pack_size =3D st.st_size;
-	p->pack_local =3D local;
+	p->pack_local =3D !alt;
+	p->alt =3D alt;
 	p->mtime =3D st.st_mtime;
 	if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
 		hashclr(p->sha1);
@@ -1082,7 +1084,8 @@ static void report_pack_garbage(struct string_lis=
t *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
=20
-static void prepare_packed_git_one(char *objdir, int local)
+static void prepare_packed_git_one(char *objdir,
+				   struct alternate_object_database *alt)
 {
 	/* Ensure that this buffer is large enough so that we can
 	   append "/pack/" without clobbering the stack even if
@@ -1133,7 +1136,7 @@ static void prepare_packed_git_one(char *objdir, =
int local)
 			     * See if it really is a valid .idx file with
 			     * corresponding .pack file that we can map.
 			     */
-			    (p =3D add_packed_git(path, len + namelen, local)) !=3D NULL)
+			    (p =3D add_packed_git(path, len + namelen, alt)) !=3D NULL)
 				install_packed_git(p);
 		}
=20
@@ -1213,11 +1216,11 @@ void prepare_packed_git(void)
=20
 	if (prepare_packed_git_run_once)
 		return;
-	prepare_packed_git_one(get_object_directory(), 1);
+	prepare_packed_git_one(get_object_directory(), NULL);
 	prepare_alt_odb();
 	for (alt =3D alt_odb_list; alt; alt =3D alt->next) {
 		alt->name[-1] =3D 0;
-		prepare_packed_git_one(alt->base, 0);
+		prepare_packed_git_one(alt->base, alt);
 		alt->name[-1] =3D '/';
 	}
 	rearrange_packed_git();
--=20
1.8.2.83.gc99314b
