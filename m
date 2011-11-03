From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] fsck: print progress
Date: Thu,  3 Nov 2011 15:50:34 +0700
Message-ID: <1320310234-11243-1-git-send-email-pclouds@gmail.com>
References: <20111103033325.GA10230@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 09:51:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLt0p-0007dy-Qt
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 09:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683Ab1KCIu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 04:50:56 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56260 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624Ab1KCIuy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 04:50:54 -0400
Received: by ggnb2 with SMTP id b2so1092855ggn.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SxMWE7p4yJeqSzRVTQcA9EYul3Ftjb7v+dWxBemJOyo=;
        b=wQr5xPXrjsq76edWfzrvWmbgvbKBYXgxKghNjUD/JIpIqbD3kTwF6McyeI6Q+a3OBd
         3aw3coy0Ew7qQqzpeym/DnQBC9HJCn4pCMDdhvSZdepqKlr+Wg9hNP6dIgL7CubaUiug
         UeTAg/t+JkMb54z51eLCtSEiG/wqXk0GWfE9U=
Received: by 10.68.208.229 with SMTP id mh5mr10696955pbc.124.1320310253121;
        Thu, 03 Nov 2011 01:50:53 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id t5sm11996692pbb.13.2011.11.03.01.50.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Nov 2011 01:50:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 Nov 2011 15:50:35 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <20111103033325.GA10230@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184709>

fsck is usually a long process and it would be nice if it prints
progress from time to time.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2011/11/3 Jeff King <peff@peff.net>:
 > We're actually leaking some memory here, since stop_progress will al=
so
 > free() the progress object and any associated resources. It's not a =
lot,
 > but it's kind of ugly.

 Fixed by always calling stop_progress_msg() but make sure no newline
 is printed (actually "done\n" is not)

 Also fixed "progress" initialization in fsck_object_dir()

 > Or perhaps we could even come up with a total object count
 > before starting.  I guess it would involve mapping each pack index
 > simultaneously, though by my reading of the code, I think we do that
 > anyway (the opened index is cached in the pack object).

 I think this way is better because we can count two numbers at a
 time, nr. packs and nr. objects of current pack. Total object
 (I assume you mean of all packs) may be less informative.

 Documentation/git-fsck.txt |   12 +++++++++-
 builtin/fsck.c             |   52 ++++++++++++++++++++++++++++++++++++=
+++++--
 pack-check.c               |   11 ++++++--
 pack.h                     |    4 ++-
 progress.c                 |    2 +-
 5 files changed, 72 insertions(+), 9 deletions(-)

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
index df1a88b..e19b78c 100644
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
@@ -622,20 +637,51 @@ int cmd_fsck(int argc, const char **argv, const c=
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
=20
-		for (p =3D packed_git; p; p =3D p->next) {
+			if (p->next)
+				stop_progress_msg(&progress, NULL);
+		}
+		stop_progress(&progress);
+
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
+
+			if (p->next)
+				stop_progress_msg(&progress, NULL);
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
diff --git a/progress.c b/progress.c
index 3971f49..fc96a5f 100644
--- a/progress.c
+++ b/progress.c
@@ -245,7 +245,7 @@ void stop_progress_msg(struct progress **p_progress=
, const char *msg)
 	if (!progress)
 		return;
 	*p_progress =3D NULL;
-	if (progress->last_value !=3D -1) {
+	if (progress->last_value !=3D -1 && msg) {
 		/* Force the last update */
 		char buf[128], *bufp;
 		size_t len =3D strlen(msg) + 5;
--=20
1.7.3.1.256.g2539c.dirty
