From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/9] archive-tar: turn write_tar_entry into blob-writing only
Date: Thu,  3 May 2012 08:51:01 +0700
Message-ID: <1336009868-7411-3-git-send-email-pclouds@gmail.com>
References: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 03:53:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPlEB-0007Ha-6E
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 03:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557Ab2ECBwy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 21:52:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55696 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab2ECBwc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 21:52:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1813971pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 18:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=E7qiQQ5woeSFpW7U6Ywkb0aU72Vsv5sSjMmI/4c63nE=;
        b=gKDVKrYsL2VpSCbDFTuVv/xLv+AQlTgUuMxFEopvqZGUZ4f9qWfiruOPgcVVc1YDbt
         vDV3Gtj93ezie5UfnUqNJvwkByo1qE9NFuq8IeR2/aPtxbPXpIvpz3JJntrE/p0gKsQs
         lWrELDMXZbk26CUsfvEuVn68+juyFUuT/pDtdxMVQlzDsuuWVViRWK75TuDCJ4MiYW04
         f38PYsAMqX4/dudTyM+sxYZVSCKTRwzOHvR9tqfdJ7yWOIR6mF75HX9cSrh+FiUXt0tr
         4un6xyrdUnUj9wkY1Pz/MRHYrCROfU6OmfBppFWGj2IfO2s2cTAAKB2v8TImfJa0GMax
         F77w==
Received: by 10.68.241.98 with SMTP id wh2mr236744pbc.117.1336009952350;
        Wed, 02 May 2012 18:52:32 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id hp1sm3616032pbc.67.2012.05.02.18.52.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 18:52:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 May 2012 08:51:35 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196877>

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
1.7.3.1.256.g2539c.dirty
