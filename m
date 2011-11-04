From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] fsck: print progress
Date: Fri,  4 Nov 2011 22:47:50 +0700
Message-ID: <1320421670-518-5-git-send-email-pclouds@gmail.com>
References: <1320421670-518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 16:49:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMM1l-0003P3-0a
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 16:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517Ab1KDPtw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 11:49:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36170 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554Ab1KDPtv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 11:49:51 -0400
Received: by mail-iy0-f174.google.com with SMTP id e36so2682080iag.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9ONHNLL85qHga292ND/cAgjDOakNqEIqO1u9l+Wp5Is=;
        b=emUiA+89kc25avLHODVRT5z/E8nqatwkFOMb1Z+0NGYr6fu0JvnhCondz4F0cO+Z38
         Xa+kIVWAU0t4yqDui1kNwi0b/X1uPe61iy6N5ClmNpKO9Kmu86B/6wMU4NPInNi2Fiyj
         nkSe4lJloMZhzcCqolqJ9qdUmwcZIUEvH88tg=
Received: by 10.43.50.201 with SMTP id vf9mr16502956icb.10.1320421790758;
        Fri, 04 Nov 2011 08:49:50 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.210.255])
        by mx.google.com with ESMTPS id dd36sm22104614ibb.7.2011.11.04.08.49.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Nov 2011 08:49:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 04 Nov 2011 22:48:27 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1320421670-518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184781>

fsck is usually a long process and it would be nice if it prints
progress from time to time.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-fsck.txt |   12 +++++++++++-
 builtin/fsck.c             |   40 ++++++++++++++++++++++++++++++++++++=
++--
 pack-check.c               |   14 +++++++++++---
 pack.h                     |    3 ++-
 4 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index a2a508d..5245101 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
-	 [--[no-]full] [--strict] [--verbose] [--lost-found] [<object>*]
+	 [--[no-]full] [--strict] [--verbose] [--lost-found]
+	 [--[no-]progress] [<object>*]
=20
 DESCRIPTION
 -----------
@@ -72,6 +73,15 @@ index file, all SHA1 references in .git/refs/*, and =
all reflogs (unless
 	a blob, the contents are written into the file, rather than
 	its object name.
=20
+--progress::
+--no-progress::
+	When fsck is run in a terminal, it will show the progress.
+	These options can force progress to be shown or not
+	regardless terminal check.
++
+Progress is not shown when --verbose is used. --progress is ignored
+in this case.
+
 It tests SHA1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0603f64..c4b1ca6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -11,6 +11,7 @@
 #include "fsck.h"
 #include "parse-options.h"
 #include "dir.h"
+#include "progress.h"
=20
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -27,6 +28,7 @@ static const char *head_points_at;
 static int errors_found;
 static int write_lost_and_found;
 static int verbose;
+static int show_progress =3D -1;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
@@ -138,7 +140,11 @@ static int traverse_one_object(struct object *obj)
=20
 static int traverse_reachable(void)
 {
+	struct progress *progress =3D NULL;
+	unsigned int nr =3D 0;
 	int result =3D 0;
+	if (show_progress)
+		progress =3D start_progress_delay("Checking connectivity", 0, 0, 2);
 	while (pending.nr) {
 		struct object_array_entry *entry;
 		struct object *obj;
@@ -146,7 +152,9 @@ static int traverse_reachable(void)
 		entry =3D pending.objects + --pending.nr;
 		obj =3D entry->item;
 		result |=3D traverse_one_object(obj);
+		display_progress(progress, ++nr);
 	}
+	stop_progress(&progress);
 	return !!result;
 }
=20
@@ -530,15 +538,20 @@ static void get_default_heads(void)
 static void fsck_object_dir(const char *path)
 {
 	int i;
+	struct progress *progress =3D NULL;
=20
 	if (verbose)
 		fprintf(stderr, "Checking object directory\n");
=20
+	if (show_progress)
+		progress =3D start_progress("Checking object directories", 256);
 	for (i =3D 0; i < 256; i++) {
 		static char dir[4096];
 		sprintf(dir, "%s/%02x", path, i);
 		fsck_dir(i, dir);
+		display_progress(progress, i+1);
 	}
+	stop_progress(&progress);
 	fsck_sha1_list();
 }
=20
@@ -609,6 +622,7 @@ static struct option fsck_opts[] =3D {
 	OPT_BOOLEAN(0, "strict", &check_strict, "enable more strict checking"=
),
 	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
 				"write dangling objects in .git/lost-found"),
+	OPT_BOOL   (0, "progress", &show_progress, "show progress"),
 	OPT_END(),
 };
=20
@@ -621,6 +635,12 @@ int cmd_fsck(int argc, const char **argv, const ch=
ar *prefix)
 	read_replace_refs =3D 0;
=20
 	argc =3D parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
+
+	if (show_progress =3D=3D -1)
+		show_progress =3D isatty(2);
+	if (verbose)
+		show_progress =3D 0;
+
 	if (write_lost_and_found) {
 		check_full =3D 1;
 		include_reflogs =3D 0;
@@ -640,12 +660,28 @@ int cmd_fsck(int argc, const char **argv, const c=
har *prefix)
=20
 	if (check_full) {
 		struct packed_git *p;
+		uint32_t total =3D 0, count =3D 0;
+		struct progress *progress =3D NULL;
=20
 		prepare_packed_git();
-		for (p =3D packed_git; p; p =3D p->next)
+
+		if (show_progress) {
+			for (p =3D packed_git; p; p =3D p->next) {
+				if (open_pack_index(p))
+					continue;
+				total +=3D p->num_objects;
+			}
+
+			progress =3D start_progress("Checking objects", total);
+		}
+		for (p =3D packed_git; p; p =3D p->next) {
 			/* verify gives error messages itself */
-			if (verify_pack(p, fsck_obj_buffer))
+			if (verify_pack(p, fsck_obj_buffer,
+					progress, count))
 				errors_found |=3D ERROR_PACK;
+			count +=3D p->num_objects;
+		}
+		stop_progress(&progress);
 	}
=20
 	heads =3D 0;
diff --git a/pack-check.c b/pack-check.c
index 372d6b2..a3262af 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pack.h"
 #include "pack-revindex.h"
+#include "progress.h"
=20
 struct idx_entry {
 	off_t                offset;
@@ -43,7 +44,9 @@ int check_pack_crc(struct packed_git *p, struct pack_=
window **w_curs,
=20
 static int verify_packfile(struct packed_git *p,
 			   struct pack_window **w_curs,
-			   verify_fn fn)
+			   verify_fn fn,
+			   struct progress *progress, uint32_t base_count)
+
 {
 	off_t index_size =3D p->index_size;
 	const unsigned char *index_base =3D p->index_data;
@@ -136,8 +139,12 @@ static int verify_packfile(struct packed_git *p,
 			if (eaten)
 				data =3D NULL;
 		}
+		if (((base_count + i) & 1023) =3D=3D 0)
+			display_progress(progress, base_count + i);
 		free(data);
+
 	}
+	display_progress(progress, base_count + i);
 	free(entries);
=20
 	return err;
@@ -166,7 +173,8 @@ int verify_pack_index(struct packed_git *p)
 	return err;
 }
=20
-int verify_pack(struct packed_git *p, verify_fn fn)
+int verify_pack(struct packed_git *p, verify_fn fn,
+		struct progress *progress, uint32_t base_count)
 {
 	int err =3D 0;
 	struct pack_window *w_curs =3D NULL;
@@ -175,7 +183,7 @@ int verify_pack(struct packed_git *p, verify_fn fn)
 	if (!p->index_data)
 		return -1;
=20
-	err |=3D verify_packfile(p, &w_curs, fn);
+	err |=3D verify_packfile(p, &w_curs, fn, progress, base_count);
 	unuse_pack(&w_curs);
=20
 	return err;
diff --git a/pack.h b/pack.h
index 70f3c29..324a1d7 100644
--- a/pack.h
+++ b/pack.h
@@ -71,12 +71,13 @@ struct pack_idx_entry {
 };
=20
=20
+struct progress;
 typedef int (*verify_fn)(const unsigned char*, enum object_type, unsig=
ned long, void*, int*);
=20
 extern const char *write_idx_file(const char *index_name, struct pack_=
idx_entry **objects, int nr_objects, const struct pack_idx_option *, un=
signed char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w=
_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
-extern int verify_pack(struct packed_git *, verify_fn fn);
+extern int verify_pack(struct packed_git *, verify_fn fn, struct progr=
ess *, uint32_t);
 extern void fixup_pack_header_footer(int, unsigned char *, const char =
*, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 extern int encode_in_pack_object_header(enum object_type, uintmax_t, u=
nsigned char *);
--=20
1.7.4.74.g639db
