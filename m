From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] fsck: print progress
Date: Thu,  3 Nov 2011 10:21:53 +0700
Message-ID: <1320290513-8878-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8DN74QWYA_NzBCGgp_VdQpV5PqGMgAFUKYbOecVqw6HYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 04:22:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLnsb-00083u-99
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 04:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204Ab1KCDWI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 23:22:08 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:55763 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab1KCDWG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 23:22:06 -0400
Received: by pzk2 with SMTP id 2so2253172pzk.1
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 20:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3bd05eqmkPG/FJySZustIdahGHvMfVC3b9UaPqvjR8s=;
        b=k99r/+crbE/aD1b8zr0iGhA2t7KZt75mgd3tyenxLctoq3nXFmKRcfR62m9PwHuikZ
         IPzKvwfd56Tv+uVP5+Vo7Xic09tuz00SENuL+vNvnRAUauzuGioH4ulrNMZHsG17afrJ
         i6ETZ3bQjdcvN9DKfDAKgWOWWYHO8+UpXE46I=
Received: by 10.68.72.73 with SMTP id b9mr8825916pbv.100.1320290524231;
        Wed, 02 Nov 2011 20:22:04 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id mh1sm9925801pbc.11.2011.11.02.20.21.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Nov 2011 20:22:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 Nov 2011 10:21:55 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <CACsJy8DN74QWYA_NzBCGgp_VdQpV5PqGMgAFUKYbOecVqw6HYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184700>

fsck is usually a long process and it would be nice if it prints
progress from time to time.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-fsck.txt |   12 ++++++++-
 builtin/fsck.c             |   57 ++++++++++++++++++++++++++++++++++++=
+++++--
 pack-check.c               |   11 ++++++--
 pack.h                     |    4 ++-
 4 files changed, 76 insertions(+), 8 deletions(-)

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
index df1a88b..dc6a6fc 100644
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
@@ -27,6 +28,8 @@ static const char *head_points_at;
 static int errors_found;
 static int write_lost_and_found;
 static int verbose;
+static int show_progress =3D -1;
+
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
=20
@@ -512,15 +515,20 @@ static void get_default_heads(void)
 static void fsck_object_dir(const char *path)
 {
 	int i;
+	struct progress *progress;
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
@@ -591,6 +599,7 @@ static struct option fsck_opts[] =3D {
 	OPT_BOOLEAN(0, "strict", &check_strict, "enable more strict checking"=
),
 	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
 				"write dangling objects in .git/lost-found"),
+	OPT_BOOL   (0, "progress", &show_progress, "show progress"),
 	OPT_END(),
 };
=20
@@ -603,6 +612,12 @@ int cmd_fsck(int argc, const char **argv, const ch=
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
@@ -622,20 +637,56 @@ int cmd_fsck(int argc, const char **argv, const c=
har *prefix)
=20
 	if (check_full) {
 		struct packed_git *p;
+		int i, nr_packs =3D 0;
+		struct progress *progress =3D NULL;
=20
 		prepare_packed_git();
+
 		for (p =3D packed_git; p; p =3D p->next)
+			nr_packs++;
+
+		for (i =3D 1, p =3D packed_git; p; p =3D p->next, i++) {
+			if (show_progress) {
+				char buf[32];
+				snprintf(buf, sizeof(buf), "Verifying pack %d/%d",
+					 i, nr_packs);
+				if (open_pack_index(p))
+					continue;
+				progress =3D start_progress(buf, p->num_objects);
+			}
 			/* verify gives error messages itself */
-			verify_pack(p);
+			verify_pack(p, progress);
+
+			/*
+			 * we do not stop progress here, let the next
+			 * progress line overwrite the current one for
+			 * the next pack.
+			 */
+		}
+		stop_progress(&progress);
=20
-		for (p =3D packed_git; p; p =3D p->next) {
+		for (i =3D 1, p =3D packed_git; p; p =3D p->next, i++) {
+			char buf[64];
 			uint32_t j, num;
 			if (open_pack_index(p))
 				continue;
 			num =3D p->num_objects;
-			for (j =3D 0; j < num; j++)
+
+			snprintf(buf, sizeof(buf), "Checking objects on pack %d/%d",
+				 i, nr_packs);
+			if (show_progress)
+				progress =3D start_progress(buf, num);
+			for (j =3D 0; j < num; j++) {
 				fsck_sha1(nth_packed_object_sha1(p, j));
+				display_progress(progress, j+1);
+			}
+			/*
+			 * we do not stop progress here, let the next
+			 * progress line overwrite the current one for
+			 * the next pack.
+			 */
 		}
+		stop_progress(&progress);
 	}
=20
 	heads =3D 0;
diff --git a/pack-check.c b/pack-check.c
index 0c19b6e..e30c18c 100644
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
@@ -42,7 +43,8 @@ int check_pack_crc(struct packed_git *p, struct pack_=
window **w_curs,
 }
=20
 static int verify_packfile(struct packed_git *p,
-		struct pack_window **w_curs)
+			   struct pack_window **w_curs,
+			   struct progress *progress)
 {
 	off_t index_size =3D p->index_size;
 	const unsigned char *index_base =3D p->index_data;
@@ -126,7 +128,10 @@ static int verify_packfile(struct packed_git *p,
 			break;
 		}
 		free(data);
+		if ((i & 1023) =3D=3D 0)
+			display_progress(progress, i);
 	}
+	display_progress(progress, i);
 	free(entries);
=20
 	return err;
@@ -155,7 +160,7 @@ int verify_pack_index(struct packed_git *p)
 	return err;
 }
=20
-int verify_pack(struct packed_git *p)
+int verify_pack(struct packed_git *p, struct progress *progress)
 {
 	int err =3D 0;
 	struct pack_window *w_curs =3D NULL;
@@ -164,7 +169,7 @@ int verify_pack(struct packed_git *p)
 	if (!p->index_data)
 		return -1;
=20
-	err |=3D verify_packfile(p, &w_curs);
+	err |=3D verify_packfile(p, &w_curs, progress);
 	unuse_pack(&w_curs);
=20
 	return err;
diff --git a/pack.h b/pack.h
index 722a54e..572794f 100644
--- a/pack.h
+++ b/pack.h
@@ -70,10 +70,12 @@ struct pack_idx_entry {
 	off_t offset;
 };
=20
+struct progress;
+
 extern const char *write_idx_file(const char *index_name, struct pack_=
idx_entry **objects, int nr_objects, const struct pack_idx_option *, un=
signed char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w=
_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
-extern int verify_pack(struct packed_git *);
+extern int verify_pack(struct packed_git *, struct progress *);
 extern void fixup_pack_header_footer(int, unsigned char *, const char =
*, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 extern int encode_in_pack_object_header(enum object_type, uintmax_t, u=
nsigned char *);
--=20
1.7.3.1.256.g2539c.dirty
