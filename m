From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] prune-packed: avoid implying "1" is DRY_RUN in prune_packed_objects()
Date: Mon, 27 May 2013 18:18:47 +0700
Message-ID: <1369653527-2233-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 27 13:17:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgvQl-0004f6-5E
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 13:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757731Ab3E0LRb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 May 2013 07:17:31 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33774 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757669Ab3E0LRa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 07:17:30 -0400
Received: by mail-pd0-f181.google.com with SMTP id bv13so4620539pdb.40
        for <git@vger.kernel.org>; Mon, 27 May 2013 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=KWIc0XCWNVQgiQS2Tpu6cyFDTLDpSTB1A46NteGr57c=;
        b=LPxULFuRnvuVfLVJVTxDBtbqEDzj0lRo+DqTHOoS9UZnbZV23PQOgqMU3VHiKfjJZN
         IoiJGFOjT+gW37CH+sYCqo68PvfMvIg3jUl07uqFm7mvqGOKjyIi7/NbyaBc9aSpUSl3
         SEWgSaDcQsjeoWPqAL2VuQoBGUK+HX4J7r9BfJV7v+bJlzC9ji5OujIdmWci1PWPwCIy
         aSjbtyc3CuBnF625NYuiQQVHKDaJE0VT+WsRbhgvE32jE4urkC/d4r2+WLjKm+7ZV8qH
         XsbSi3DsGHNOHgm2x7z8Xr4z85v7m+Vvt3oncB5X17K2Qn+CmkzRdm83MyWMRcviYmTV
         sUZA==
X-Received: by 10.66.122.39 with SMTP id lp7mr28900728pab.208.1369653450116;
        Mon, 27 May 2013 04:17:30 -0700 (PDT)
Received: from lanh ([115.73.210.112])
        by mx.google.com with ESMTPSA id xl10sm30246033pac.15.2013.05.27.04.17.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 04:17:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 May 2013 18:18:48 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225586>

Commit b60daf0 (Make git-prune-packed a bit more chatty. - 2007-01-12)
changes the meaning of prune_packed_objects()'s argument, from "dry
run or not dry run" to a bitmap.

It however forgot to update prune_packed_objects() caller in
builtin/prune.c to use new DRY_RUN macro. It's fine (for a long time!)
but there is a risk that someday someone may change the value of
DRY_RUN to something else and builtin/prune.c suddenly breaks. Avoid
that possibility.

While at there, change "opts =3D=3D VERBOSE" to "opts & VERBOSE" as the=
re
is no obvious reason why we only be chatty when DRY_RUN is not set.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin.h              |  3 +++
 builtin/prune-packed.c | 15 +++++++--------
 builtin/prune.c        |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin.h b/builtin.h
index faef559..64bab6b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -12,6 +12,9 @@
 extern const char git_usage_string[];
 extern const char git_more_info_string[];
=20
+#define PRUNE_PACKED_DRY_RUN 01
+#define PRUNE_PACKED_VERBOSE 02
+
 extern void prune_packed_objects(int);
=20
 struct fmt_merge_msg_opts {
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 83382c1..fa6ce42 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -8,9 +8,6 @@ static const char * const prune_packed_usage[] =3D {
 	NULL
 };
=20
-#define DRY_RUN 01
-#define VERBOSE 02
-
 static struct progress *progress;
=20
 static void prune_dir(int i, DIR *dir, char *pathname, int len, int op=
ts)
@@ -29,7 +26,7 @@ static void prune_dir(int i, DIR *dir, char *pathname=
, int len, int opts)
 		if (!has_sha1_pack(sha1))
 			continue;
 		memcpy(pathname + len, de->d_name, 38);
-		if (opts & DRY_RUN)
+		if (opts & PRUNE_PACKED_DRY_RUN)
 			printf("rm -f %s\n", pathname);
 		else
 			unlink_or_warn(pathname);
@@ -44,7 +41,7 @@ void prune_packed_objects(int opts)
 	const char *dir =3D get_object_directory();
 	int len =3D strlen(dir);
=20
-	if (opts =3D=3D VERBOSE)
+	if (opts & PRUNE_PACKED_VERBOSE)
 		progress =3D start_progress_delay("Removing duplicate objects",
 			256, 95, 2);
=20
@@ -71,10 +68,12 @@ void prune_packed_objects(int opts)
=20
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
-	int opts =3D isatty(2) ? VERBOSE : 0;
+	int opts =3D isatty(2) ? PRUNE_PACKED_VERBOSE : 0;
 	const struct option prune_packed_options[] =3D {
-		OPT_BIT('n', "dry-run", &opts, N_("dry run"), DRY_RUN),
-		OPT_NEGBIT('q', "quiet", &opts, N_("be quiet"), VERBOSE),
+		OPT_BIT('n', "dry-run", &opts, N_("dry run"),
+			PRUNE_PACKED_DRY_RUN),
+		OPT_NEGBIT('q', "quiet", &opts, N_("be quiet"),
+			   PRUNE_PACKED_VERBOSE),
 		OPT_END()
 	};
=20
diff --git a/builtin/prune.c b/builtin/prune.c
index 85843d4..59d1fdc 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -165,7 +165,7 @@ int cmd_prune(int argc, const char **argv, const ch=
ar *prefix)
 	stop_progress(&progress);
 	prune_object_dir(get_object_directory());
=20
-	prune_packed_objects(show_only);
+	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
 	remove_temporary_files(get_object_directory());
 	s =3D mkpathdup("%s/pack", get_object_directory());
 	remove_temporary_files(s);
--=20
1.8.2.83.gc99314b
