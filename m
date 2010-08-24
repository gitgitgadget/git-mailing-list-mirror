From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/32] move do_compress() from pack-objects.c to pack-write.c
Date: Wed, 25 Aug 2010 08:19:54 +1000
Message-ID: <1282688422-7738-5-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1st-0001Xh-Q6
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308Ab0HXWV0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:21:26 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:45873 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305Ab0HXWVY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:21:24 -0400
Received: by pxi10 with SMTP id 10so2812915pxi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=P70m3slPz8wbe2KL8Ox8+alz4t75dGnPLHU69BMS4fE=;
        b=jL6Pcd5s3jHWU1tTLbPzkazBWGvfQUvdP9r4F3BDePm6qgqY7VdMCCILiGhRnLNChL
         P4ix1/PskmGY14YDjaeRRgnuRlogCrszAzaSzQBRPriq1ipraUai4oTeIjuHAFJ4SNto
         ofXSQkiHcInxLR10Ca6f5gTG29iQqi6F33hJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Y+ON7QGkGxVYUoyNBfIwvUgyRthYx44yeyO/JKEINcgOstWZVBeMnMWGn80ix+J8mK
         LkSZ1qGkMBXx+T0jSx+46Q/t9svZkIJO6+rB0sER/T2YlYih7b/mEe8sBJ1Heh/1qaaY
         zhEzZV4fJAeRok7uCSJst12kALhGn07HsfE+M=
Received: by 10.142.153.2 with SMTP id a2mr6228409wfe.153.1282688483893;
        Tue, 24 Aug 2010 15:21:23 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id 33sm633358wfg.21.2010.08.24.15.21.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:21:21 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:21:17 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154345>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c |   24 +++---------------------
 pack-write.c           |   25 +++++++++++++++++++++++++
 pack.h                 |    1 +
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0e81673..a664223 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -130,28 +130,10 @@ static void *get_delta(struct object_entry *entry=
)
=20
 static unsigned long do_compress(void **pptr, unsigned long size)
 {
-	z_stream stream;
-	void *in, *out;
-	unsigned long maxsize;
-
-	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, pack_compression_level);
-	maxsize =3D deflateBound(&stream, size);
-
-	in =3D *pptr;
-	out =3D xmalloc(maxsize);
-	*pptr =3D out;
-
-	stream.next_in =3D in;
-	stream.avail_in =3D size;
-	stream.next_out =3D out;
-	stream.avail_out =3D maxsize;
-	while (deflate(&stream, Z_FINISH) =3D=3D Z_OK)
-		; /* nothing */
-	deflateEnd(&stream);
-
+	void **in =3D *pptr;
+	unsigned total_out =3D compress_object(pptr, size);
 	free(in);
-	return stream.total_out;
+	return total_out;
 }
=20
 /*
diff --git a/pack-write.c b/pack-write.c
index a905ca4..cc7761e 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -280,3 +280,28 @@ int encode_in_pack_object_header(enum object_type =
type, uintmax_t size, unsigned
 	*hdr =3D c;
 	return n;
 }
+
+unsigned long compress_object(void **pptr, unsigned long size)
+{
+	z_stream stream;
+	void *in, *out;
+	unsigned long maxsize;
+
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, Z_DEFAULT_COMPRESSION);
+	maxsize =3D deflateBound(&stream, size);
+
+	in =3D *pptr;
+	out =3D xmalloc(maxsize);
+	*pptr =3D out;
+
+	stream.next_in =3D in;
+	stream.avail_in =3D size;
+	stream.next_out =3D out;
+	stream.avail_out =3D maxsize;
+	while (deflate(&stream, Z_FINISH) =3D=3D Z_OK)
+		; /* nothing */
+	deflateEnd(&stream);
+
+	return stream.total_out;
+}
diff --git a/pack.h b/pack.h
index bb27576..28a966b 100644
--- a/pack.h
+++ b/pack.h
@@ -62,6 +62,7 @@ extern int verify_pack(struct packed_git *);
 extern void fixup_pack_header_footer(int, unsigned char *, const char =
*, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 extern int encode_in_pack_object_header(enum object_type, uintmax_t, u=
nsigned char *);
+extern unsigned long compress_object(void **, unsigned long size);
=20
 #define PH_ERROR_EOF		(-1)
 #define PH_ERROR_PACK_SIGNATURE	(-2)
--=20
1.7.1.rc1.69.g24c2f7
