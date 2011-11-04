From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] fsck: print progress
Date: Fri,  4 Nov 2011 10:10:42 +0700
Message-ID: <1320376242-27851-1-git-send-email-pclouds@gmail.com>
References: <20111103211819.GA17341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 04 04:11:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMABJ-0008NJ-TW
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 04:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab1KDDK4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 23:10:56 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58415 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab1KDDK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 23:10:56 -0400
Received: by iage36 with SMTP id e36so2062071iag.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 20:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FxPS9UKxA20fsO5k9FL6Yt814QuAYZgo1hn/fSJLVrI=;
        b=Bs+6wfp0P8ZAyg6PFsYAitZ/Ky03p4lynISHrsOMcwanjyDOMyym4WlDnw3Uqasg9e
         XxIYchmlg2XCoc2Rq8Jgrdb094WVI0syBOjvM7nle5GshJL3wAfVR6aCqeKbEw8iGMmt
         DuhQaBzlBMly7X9sfwuaS3nzn1q5o+4L6UToc=
Received: by 10.42.244.137 with SMTP id lq9mr12485366icb.28.1320376255608;
        Thu, 03 Nov 2011 20:10:55 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ge16sm15337738ibb.2.2011.11.03.20.10.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Nov 2011 20:10:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 04 Nov 2011 10:10:45 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <20111103211819.GA17341@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184756>

fsck is usually a long process and it would be nice if it prints
progress from time to time.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 OK let's go with total object count for more accurate progress. One
 thing I did not realize that the title is not copied to struct
 progress and we can update title (e.g. current pack) while displaying
 progress.

 Updating once every 1024 objects may feel sluggish on large blobs,
 but we have more important things to worry about when it comes to
 large blobs than this progress bar.

 multithread fsck sounds interesting, I'll look into it.

 Documentation/git-fsck.txt |   12 +++++++++-
 builtin/fsck.c             |   49 ++++++++++++++++++++++++++++++++++++=
++++---
 pack-check.c               |   11 +++++++--
 pack.h                     |    4 ++-
 4 files changed, 67 insertions(+), 9 deletions(-)

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
index df1a88b..e0cc4de 100644
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
@@ -622,20 +637,46 @@ int cmd_fsck(int argc, const char **argv, const c=
har *prefix)
=20
 	if (check_full) {
 		struct packed_git *p;
+		int i, nr_objects =3D 0, object_count;
+		struct progress *progress =3D NULL;
=20
 		prepare_packed_git();
-		for (p =3D packed_git; p; p =3D p->next)
+
+		if (show_progress) {
+			for (p =3D packed_git; p; p =3D p->next) {
+				if (open_pack_index(p))
+					continue;
+				nr_objects +=3D p->num_objects;
+			}
+
+			object_count =3D 0;
+			progress =3D start_progress("Verifying packs", nr_objects);
+		}
+
+		for (i =3D 1, p =3D packed_git; p; p =3D p->next, i++) {
 			/* verify gives error messages itself */
-			verify_pack(p);
+			verify_pack(p, progress, object_count);
+			object_count +=3D p->num_objects;
+		}
+		stop_progress(&progress);
=20
-		for (p =3D packed_git; p; p =3D p->next) {
+		if (show_progress) {
+			object_count =3D 0;
+			progress =3D start_progress("Checking objects", nr_objects);
+		}
+
+		for (i =3D 1, p =3D packed_git; p; p =3D p->next, i++) {
 			uint32_t j, num;
 			if (open_pack_index(p))
 				continue;
 			num =3D p->num_objects;
-			for (j =3D 0; j < num; j++)
+			for (j =3D 0; j < num; j++) {
 				fsck_sha1(nth_packed_object_sha1(p, j));
+				display_progress(progress, object_count + j+1);
+			}
+			object_count +=3D p->num_objects;
 		}
+		stop_progress(&progress);
 	}
=20
 	heads =3D 0;
diff --git a/pack-check.c b/pack-check.c
index 0c19b6e..80de302 100644
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
+			   struct progress *progress, uint32_t base_count)
 {
 	off_t index_size =3D p->index_size;
 	const unsigned char *index_base =3D p->index_data;
@@ -126,7 +128,10 @@ static int verify_packfile(struct packed_git *p,
 			break;
 		}
 		free(data);
+		if (((base_count + i) & 1023) =3D=3D 0)
+			display_progress(progress, base_count + i);
 	}
+	display_progress(progress, base_count + i);
 	free(entries);
=20
 	return err;
@@ -155,7 +160,7 @@ int verify_pack_index(struct packed_git *p)
 	return err;
 }
=20
-int verify_pack(struct packed_git *p)
+int verify_pack(struct packed_git *p, struct progress *progress, uint3=
2_t base_count)
 {
 	int err =3D 0;
 	struct pack_window *w_curs =3D NULL;
@@ -164,7 +169,7 @@ int verify_pack(struct packed_git *p)
 	if (!p->index_data)
 		return -1;
=20
-	err |=3D verify_packfile(p, &w_curs);
+	err |=3D verify_packfile(p, &w_curs, progress, base_count);
 	unuse_pack(&w_curs);
=20
 	return err;
diff --git a/pack.h b/pack.h
index 722a54e..3a63bf6 100644
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
+extern int verify_pack(struct packed_git *, struct progress *, uint32_=
t);
 extern void fixup_pack_header_footer(int, unsigned char *, const char =
*, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 extern int encode_in_pack_object_header(enum object_type, uintmax_t, u=
nsigned char *);
--=20
1.7.3.1.256.g2539c.dirty
