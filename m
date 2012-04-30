From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] archive-tar: turn write_tar_entry into blob-writing only
Date: Mon, 30 Apr 2012 11:57:13 +0700
Message-ID: <1335761837-12482-2-git-send-email-pclouds@gmail.com>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 07:01:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOijM-0008S0-AM
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 07:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab2D3FAz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 01:00:55 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:33712 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab2D3FAy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 01:00:54 -0400
Received: by mail-pz0-f51.google.com with SMTP id z8so3584710dad.10
        for <git@vger.kernel.org>; Sun, 29 Apr 2012 22:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XyM7PGkb31LObXW9JI1Jzw1oYtDkEtCZsluvgf6y354=;
        b=ubeDVDyf+nPizkG1r8uLEelTrgDM+P1COLAtKF5782TdyJdLv1qFC4LxVbHrhDMhTK
         sptMIJTlL/D2h51oKWTfsg8LKy4A2GveWSbRdS3JuqP7mB70Z81yJOJHaB4CsZlXrQvD
         o/kC9Kidjp7AGV3JnmlCOQeT2eHCybsTYKL5KheDM3usPBDJh6F88BKM/D4CKdpLJLgy
         A8+mI1VmGbSoKqVxgmfkAc1lQzuBCcIiouezkUrkQKt/kinZUgarzhfbBRGUmYDF92MJ
         fbRXUuzAWXkdYCgSdU/DT1GauD3exWfqPq8Pv9YNU1qvdFDuasHRq1arpP5nq/djNWJx
         Saeg==
Received: by 10.68.194.227 with SMTP id hz3mr19566638pbc.23.1335762054409;
        Sun, 29 Apr 2012 22:00:54 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id lb10sm246021pbc.37.2012.04.29.22.00.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Apr 2012 22:00:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 30 Apr 2012 11:57:29 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196536>

Before this patch write_tar_entry() can:

 - write global header
   by write_global_extended_header() calling write_tar_entry with
   with both sha1 and path =3D=3D NULL

 - write extended header for symlinks, by write_tar_entry() calling
   itself with sha1 !=3D NULL and path =3D=3D NULL

 - write a normal blob. In this case both sha1 and path are valid.

After this patch, the first two call sites are modified to write the
header without calling write_tar_entry(). The function is now for
writing blobs only. This simplifies handling when write_tar_entry()
learns about large blobs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-tar.c |   78 ++++++++++++++++++++++++++++++++++++++-----------=
--------
 1 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 20af005..1727ab9 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -123,6 +123,43 @@ static size_t get_path_prefix(const char *path, si=
ze_t pathlen, size_t maxlen)
 	return i;
 }
=20
+static void prepare_header(struct archiver_args *args,
+			   struct ustar_header *header,
+			   unsigned int mode, unsigned long size)
+{
+	sprintf(header->mode, "%07o", mode & 07777);
+	sprintf(header->size, "%011lo", S_ISREG(mode) ? size : 0);
+	sprintf(header->mtime, "%011lo", (unsigned long) args->time);
+
+	sprintf(header->uid, "%07o", 0);
+	sprintf(header->gid, "%07o", 0);
+	strlcpy(header->uname, "root", sizeof(header->uname));
+	strlcpy(header->gname, "root", sizeof(header->gname));
+	sprintf(header->devmajor, "%07o", 0);
+	sprintf(header->devminor, "%07o", 0);
+
+	memcpy(header->magic, "ustar", 6);
+	memcpy(header->version, "00", 2);
+
+	sprintf(header->chksum, "%07o", ustar_header_chksum(header));
+}
+
+static int write_extended_header(struct archiver_args *args,
+				 const unsigned char *sha1,
+				 const void *buffer, unsigned long size)
+{
+	struct ustar_header header;
+	unsigned int mode;
+	memset(&header, 0, sizeof(header));
+	*header.typeflag =3D TYPEFLAG_EXT_HEADER;
+	mode =3D 0100666;
+	sprintf(header.name, "%s.paxheader", sha1_to_hex(sha1));
+	prepare_header(args, &header, mode, size);
+	write_blocked(&header, sizeof(header));
+	write_blocked(buffer, size);
+	return 0;
+}
+
 static int write_tar_entry(struct archiver_args *args,
 		const unsigned char *sha1, const char *path, size_t pathlen,
 		unsigned int mode, void *buffer, unsigned long size)
@@ -134,13 +171,9 @@ static int write_tar_entry(struct archiver_args *a=
rgs,
 	memset(&header, 0, sizeof(header));
=20
 	if (!sha1) {
-		*header.typeflag =3D TYPEFLAG_GLOBAL_HEADER;
-		mode =3D 0100666;
-		strcpy(header.name, "pax_global_header");
+		die("BUG: sha1 =3D=3D NULL is not supported");
 	} else if (!path) {
-		*header.typeflag =3D TYPEFLAG_EXT_HEADER;
-		mode =3D 0100666;
-		sprintf(header.name, "%s.paxheader", sha1_to_hex(sha1));
+		die("BUG: path =3D=3D NULL is not supported");
 	} else {
 		if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 			*header.typeflag =3D TYPEFLAG_DIR;
@@ -182,25 +215,11 @@ static int write_tar_entry(struct archiver_args *=
args,
 			memcpy(header.linkname, buffer, size);
 	}
=20
-	sprintf(header.mode, "%07o", mode & 07777);
-	sprintf(header.size, "%011lo", S_ISREG(mode) ? size : 0);
-	sprintf(header.mtime, "%011lo", (unsigned long) args->time);
-
-	sprintf(header.uid, "%07o", 0);
-	sprintf(header.gid, "%07o", 0);
-	strlcpy(header.uname, "root", sizeof(header.uname));
-	strlcpy(header.gname, "root", sizeof(header.gname));
-	sprintf(header.devmajor, "%07o", 0);
-	sprintf(header.devminor, "%07o", 0);
-
-	memcpy(header.magic, "ustar", 6);
-	memcpy(header.version, "00", 2);
-
-	sprintf(header.chksum, "%07o", ustar_header_chksum(&header));
+	prepare_header(args, &header, mode, size);
=20
 	if (ext_header.len > 0) {
-		err =3D write_tar_entry(args, sha1, NULL, 0, 0, ext_header.buf,
-				ext_header.len);
+		err =3D write_extended_header(args, sha1, ext_header.buf,
+					    ext_header.len);
 		if (err)
 			return err;
 	}
@@ -215,11 +234,18 @@ static int write_global_extended_header(struct ar=
chiver_args *args)
 {
 	const unsigned char *sha1 =3D args->commit_sha1;
 	struct strbuf ext_header =3D STRBUF_INIT;
-	int err;
+	struct ustar_header header;
+	unsigned int mode;
+	int err =3D 0;
=20
 	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 4=
0);
-	err =3D write_tar_entry(args, NULL, NULL, 0, 0, ext_header.buf,
-			ext_header.len);
+	memset(&header, 0, sizeof(header));
+	*header.typeflag =3D TYPEFLAG_GLOBAL_HEADER;
+	mode =3D 0100666;
+	strcpy(header.name, "pax_global_header");
+	prepare_header(args, &header, mode, ext_header.len);
+	write_blocked(&header, sizeof(header));
+	write_blocked(ext_header.buf, ext_header.len);
 	strbuf_release(&ext_header);
 	return err;
 }
--=20
1.7.8.36.g69ee2
