X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: sizeof(struct ...)
Date: Thu, 23 Nov 2006 13:43:45 +0100
Message-ID: <45659781.5050005@lsrfire.ath.cx>
References: <20061123101609.1711.qmail@8b73034525b1a6.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 23 Nov 2006 12:44:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <20061123101609.1711.qmail@8b73034525b1a6.315fe32.mid.smarden.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32137>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnDvn-00046M-RV for gcvg-git@gmane.org; Thu, 23 Nov
 2006 13:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755783AbWKWMnw convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006 07:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757359AbWKWMnw
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 07:43:52 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:27017 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S1755783AbWKWMnv (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23
 Nov 2006 07:43:51 -0500
Received: from [10.0.1.4] (p508E51A7.dip.t-dialin.net [80.142.81.167]) by
 neapel230.server4you.de (Postfix) with ESMTP id 3FF583C00F; Thu, 23 Nov 2006
 13:43:50 +0100 (CET)
To: Gerrit Pape <pape@smarden.org>
Sender: git-owner@vger.kernel.org

Gerrit Pape schrieb:
> Hi, I don't think we can rely on sizeof(struct ...) to be the exact s=
ize
> of the struct as defined.  As the selftests show, archive-zip doesn't
> work correctly on Debian/arm
>=20
>  http://buildd.debian.org/fetch.cgi?&pkg=3Dgit-core&ver=3D1%3A1.4.4-1=
&arch=3Darm&stamp=3D1164122355&file=3Dlog
>=20
> It's because sizeof(struct zip_local_header) is 32, zip_dir_header 48=
,
> and zip_dir_trailer 24, breaking the zip files.  Compiling with
> -fpack-struct seemed to break other things, so I for now I ended up w=
ith
> this (not so nice) workaround.

Hm, yes, this use sizeof() is not strictly correct.  But I'd very much
like to keep being lazy and let the compiler to do the summing.  How
about this patch instead?  Does it work for you, Gerrit?

Thanks,
Ren=E9


 archive-zip.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index ae5572a..4caaec4 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -35,6 +35,7 @@ struct zip_local_header {
 	unsigned char size[4];
 	unsigned char filename_length[2];
 	unsigned char extra_length[2];
+	unsigned char _end[0];
 };
=20
 struct zip_dir_header {
@@ -55,6 +56,7 @@ struct zip_dir_header {
 	unsigned char attr1[2];
 	unsigned char attr2[4];
 	unsigned char offset[4];
+	unsigned char _end[0];
 };
=20
 struct zip_dir_trailer {
@@ -66,8 +68,18 @@ struct zip_dir_trailer {
 	unsigned char size[4];
 	unsigned char offset[4];
 	unsigned char comment_length[2];
+	unsigned char _end[0];
 };
=20
+/*
+ * On ARM, padding is added at the end of the struct, so a simple
+ * sizeof(struct ...) reports two bytes more than the payload size
+ * we're interested in.
+ */
+#define ZIP_LOCAL_HEADER_SIZE	offsetof(struct zip_local_header, _end)
+#define ZIP_DIR_HEADER_SIZE	offsetof(struct zip_dir_header, _end)
+#define ZIP_DIR_TRAILER_SIZE	offsetof(struct zip_dir_trailer, _end)
+
 static void copy_le16(unsigned char *dest, unsigned int n)
 {
 	dest[0] =3D 0xff & n;
@@ -211,7 +223,7 @@ static int write_zip_entry(const unsigne
 	}
=20
 	/* make sure we have enough free space in the dictionary */
-	direntsize =3D sizeof(struct zip_dir_header) + pathlen;
+	direntsize =3D ZIP_DIR_HEADER_SIZE + pathlen;
 	while (zip_dir_size < zip_dir_offset + direntsize) {
 		zip_dir_size +=3D ZIP_DIRECTORY_MIN_SIZE;
 		zip_dir =3D xrealloc(zip_dir, zip_dir_size);
@@ -234,8 +246,8 @@ static int write_zip_entry(const unsigne
 	copy_le16(dirent.attr1, 0);
 	copy_le32(dirent.attr2, attr2);
 	copy_le32(dirent.offset, zip_offset);
-	memcpy(zip_dir + zip_dir_offset, &dirent, sizeof(struct zip_dir_heade=
r));
-	zip_dir_offset +=3D sizeof(struct zip_dir_header);
+	memcpy(zip_dir + zip_dir_offset, &dirent, ZIP_DIR_HEADER_SIZE);
+	zip_dir_offset +=3D ZIP_DIR_HEADER_SIZE;
 	memcpy(zip_dir + zip_dir_offset, path, pathlen);
 	zip_dir_offset +=3D pathlen;
 	zip_dir_entries++;
@@ -251,8 +263,8 @@ static int write_zip_entry(const unsigne
 	copy_le32(header.size, uncompressed_size);
 	copy_le16(header.filename_length, pathlen);
 	copy_le16(header.extra_length, 0);
-	write_or_die(1, &header, sizeof(struct zip_local_header));
-	zip_offset +=3D sizeof(struct zip_local_header);
+	write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
+	zip_offset +=3D ZIP_LOCAL_HEADER_SIZE;
 	write_or_die(1, path, pathlen);
 	zip_offset +=3D pathlen;
 	if (compressed_size > 0) {
@@ -282,7 +294,7 @@ static void write_zip_trailer(const unsi
 	copy_le16(trailer.comment_length, sha1 ? 40 : 0);
=20
 	write_or_die(1, zip_dir, zip_dir_offset);
-	write_or_die(1, &trailer, sizeof(struct zip_dir_trailer));
+	write_or_die(1, &trailer, ZIP_DIR_TRAILER_SIZE);
 	if (sha1)
 		write_or_die(1, sha1_to_hex(sha1), 40);
