From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 4/4] count-objects: report how much disk space taken by garbage files
Date: Tue, 12 Feb 2013 16:27:57 +0700
Message-ID: <1360661277-17273-5-git-send-email-pclouds@gmail.com>
References: <1360661277-17273-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 10:28:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5C9m-0002DN-9A
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 10:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032Ab3BLJ1k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2013 04:27:40 -0500
Received: from mail-da0-f53.google.com ([209.85.210.53]:43124 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933012Ab3BLJ1i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 04:27:38 -0500
Received: by mail-da0-f53.google.com with SMTP id w3so855329dad.12
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 01:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=0KOmdewsaV5zDLAD5uVT99SMqFYPgzKnSmRhf1fTAl0=;
        b=HRcdvhSoUi/xrBv6Ws34e6p23qRIjtatB23Xc4evENFiIVJpVkxl9O3OvT3tW4wSF+
         ygNKEl+b01PIeELnGx1u5fJKKlk/Nx3c4gRuo+UBqclgGKNwCokVSHXl7pm3uOofZiCd
         Z1EuTz3/lMD1QEXjK0iB2uSRVvILL6Um371Rpo00s/LG0bgP+XCfd424+n9LD827OJCm
         DSoJ0Wo14ii0C3RQvSGUA7tuSUlQvT3v6QUjFOy7ZitVSAsB4dR5Mh6GoU1QoIF2It6t
         S4O/CYtHHMNMB7s9JKmJwqd7VlXKWYO87NwRJX5O26WycXXho+H1q3aO0i1DY4DMbxWG
         TUuA==
X-Received: by 10.66.226.71 with SMTP id rq7mr33013776pac.80.1360661257723;
        Tue, 12 Feb 2013 01:27:37 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id e6sm73515577paw.16.2013.02.12.01.27.34
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 01:27:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Feb 2013 16:28:25 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1360661277-17273-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216126>

Also issue warnings on loose garbages instead of errors as a result of
using report_garbage() function in count_objects()

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-count-objects.txt |  2 ++
 builtin/count-objects.c             | 21 +++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-co=
unt-objects.txt
index 1611d7c..da6e72e 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -35,6 +35,8 @@ the packs. These objects could be pruned using `git p=
rune-packed`.
 +
 garbage: the number of files in object database that are not valid
 loose objects nor valid packs
++
+size-garbage: disk space consumed by garbage files, in KiB
=20
 GIT
 ---
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 639c9a5..75feee5 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -10,12 +10,15 @@
 #include "parse-options.h"
=20
 static unsigned long garbage;
+static off_t size_garbage;
=20
 static void real_report_garbage(const char *desc,
 				const char *path, int len,
 				const char *name)
 {
 	struct strbuf sb =3D STRBUF_INIT;
+	struct stat st;
+
 	if (len && name)
 		strbuf_addf(&sb, "%.*s/%s", len, path, name);
 	else if (!len && name)
@@ -23,6 +26,10 @@ static void real_report_garbage(const char *desc,
 	else
 		strbuf_addf(&sb, "%s", path);
 	warning("%s: %s", desc, sb.buf);
+
+	if (!stat(sb.buf, &st))
+		size_garbage +=3D st.st_size;
+
 	garbage++;
 	strbuf_release(&sb);
 }
@@ -30,8 +37,7 @@ static void real_report_garbage(const char *desc,
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
 			  off_t *loose_size,
-			  unsigned long *packed_loose,
-			  unsigned long *garbage)
+			  unsigned long *packed_loose)
 {
 	struct dirent *ent;
 	while ((ent =3D readdir(d)) !=3D NULL) {
@@ -63,11 +69,9 @@ static void count_objects(DIR *d, char *path, int le=
n, int verbose,
 				(*loose_size) +=3D xsize_t(on_disk_bytes(st));
 		}
 		if (bad) {
-			if (verbose) {
-				error("garbage found: %.*s/%s",
-				      len + 2, path, ent->d_name);
-				(*garbage)++;
-			}
+			if (verbose)
+				report_garbage("garbage found",
+					       path, len + 2, ent->d_name);
 			continue;
 		}
 		(*loose)++;
@@ -117,7 +121,7 @@ int cmd_count_objects(int argc, const char **argv, =
const char *prefix)
 		if (!d)
 			continue;
 		count_objects(d, path, len, verbose,
-			      &loose, &loose_size, &packed_loose, &garbage);
+			      &loose, &loose_size, &packed_loose);
 		closedir(d);
 	}
 	if (verbose) {
@@ -142,6 +146,7 @@ int cmd_count_objects(int argc, const char **argv, =
const char *prefix)
 		printf("size-pack: %lu\n", (unsigned long) (size_pack / 1024));
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
+		printf("size-garbage: %lu\n", (unsigned long) (size_garbage / 1024))=
;
 	}
 	else
 		printf("%lu objects, %lu kilobytes\n",
--=20
1.8.1.2.536.gf441e6d
