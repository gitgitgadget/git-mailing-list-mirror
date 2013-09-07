From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/12] index-pack: split out varint decoding code
Date: Sat,  7 Sep 2013 17:43:09 +0700
Message-ID: <1378550599-25365-3-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:40:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFwi-0002aH-Eb
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221Ab3IGKks convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:40:48 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:44298 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab3IGKkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:40:47 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so4200655pbc.23
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=D5CPhICQ2XdQloAro7gW4gmM2P5xUq/Ls4f9oCsTU64=;
        b=YpNwB1BxU92qa8BXwlBGuA67l+nndXnwSTFmPPsebZOqTighl5qsbbzOoS0W4czw4S
         117j/32i/iTu23/uZM0nca3BNO/4LkMJ+DJUePglqWzkfzI9B8ik5ym5Sm0etaB4T5me
         T3qjD0q8el8QfA8HxEEwTYq0mnX1W5ar4gevtXgpUfBrURMMnJJ6Tv4RbYrgkIWcdj5R
         V+UYWDT53UsAh0IK5r4MYX+d3l5Uhi6qKS/0IN0sCONDcUK39Zz5arOAN6udUxT3beaO
         My1uE5MSLMA0uJ2ZFfrCeYi8+XugZloWWh0rYjnJY4NIrCfUBY2hSMXDFu1VHfNZHvJS
         1F+A==
X-Received: by 10.68.21.66 with SMTP id t2mr7843742pbe.151.1378550447259;
        Sat, 07 Sep 2013 03:40:47 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id ha10sm3391079pbc.23.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:40:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:43:55 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234120>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 82 ++++++++++++++++++++++++++++----------------=
--------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9c1cfac..5b1395d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -275,6 +275,31 @@ static void use(int bytes)
 	consumed_bytes +=3D bytes;
 }
=20
+static inline void *fill_and_use(int bytes)
+{
+	void *p =3D fill(bytes);
+	use(bytes);
+	return p;
+}
+
+static NORETURN void bad_object(unsigned long offset, const char *form=
at,
+		       ...) __attribute__((format (printf, 2, 3)));
+
+static uintmax_t read_varint(void)
+{
+	unsigned char c =3D *(char*)fill_and_use(1);
+	uintmax_t val =3D c & 127;
+	while (c & 128) {
+		val +=3D 1;
+		if (!val || MSB(val, 7))
+			bad_object(consumed_bytes,
+				   _("offset overflow in read_varint"));
+		c =3D *(char*)fill_and_use(1);
+		val =3D (val << 7) + (c & 127);
+	}
+	return val;
+}
+
 static const char *open_pack_file(const char *pack_name)
 {
 	if (from_stdin) {
@@ -315,9 +340,6 @@ static void parse_pack_header(void)
 	use(sizeof(struct pack_header));
 }
=20
-static NORETURN void bad_object(unsigned long offset, const char *form=
at,
-		       ...) __attribute__((format (printf, 2, 3)));
-
 static NORETURN void bad_object(unsigned long offset, const char *form=
at, ...)
 {
 	va_list params;
@@ -455,55 +477,41 @@ static void *unpack_entry_data(unsigned long offs=
et, unsigned long size,
 	return buf =3D=3D fixed_buf ? NULL : buf;
 }
=20
+static void read_typesize_v2(struct object_entry *obj)
+{
+	unsigned char c =3D *(char*)fill_and_use(1);
+	unsigned shift;
+
+	obj->type =3D (c >> 4) & 7;
+	obj->size =3D (c & 15);
+	shift =3D 4;
+	while (c & 128) {
+		c =3D *(char*)fill_and_use(1);
+		obj->size +=3D (c & 0x7f) << shift;
+		shift +=3D 7;
+	}
+}
+
 static void *unpack_raw_entry(struct object_entry *obj,
 			      union delta_base *delta_base,
 			      unsigned char *sha1)
 {
-	unsigned char *p;
-	unsigned long size, c;
-	off_t base_offset;
-	unsigned shift;
 	void *data;
+	uintmax_t val;
=20
 	obj->idx.offset =3D consumed_bytes;
 	input_crc32 =3D crc32(0, NULL, 0);
=20
-	p =3D fill(1);
-	c =3D *p;
-	use(1);
-	obj->type =3D (c >> 4) & 7;
-	size =3D (c & 15);
-	shift =3D 4;
-	while (c & 0x80) {
-		p =3D fill(1);
-		c =3D *p;
-		use(1);
-		size +=3D (c & 0x7f) << shift;
-		shift +=3D 7;
-	}
-	obj->size =3D size;
+	read_typesize_v2(obj);
=20
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
-		hashcpy(delta_base->sha1, fill(20));
-		use(20);
+		hashcpy(delta_base->sha1, fill_and_use(20));
 		break;
 	case OBJ_OFS_DELTA:
 		memset(delta_base, 0, sizeof(*delta_base));
-		p =3D fill(1);
-		c =3D *p;
-		use(1);
-		base_offset =3D c & 127;
-		while (c & 128) {
-			base_offset +=3D 1;
-			if (!base_offset || MSB(base_offset, 7))
-				bad_object(obj->idx.offset, _("offset value overflow for delta bas=
e object"));
-			p =3D fill(1);
-			c =3D *p;
-			use(1);
-			base_offset =3D (base_offset << 7) + (c & 127);
-		}
-		delta_base->offset =3D obj->idx.offset - base_offset;
+		val =3D read_varint();
+		delta_base->offset =3D obj->idx.offset - val;
 		if (delta_base->offset <=3D 0 || delta_base->offset >=3D obj->idx.of=
fset)
 			bad_object(obj->idx.offset, _("delta base offset is out of bound"))=
;
 		break;
--=20
1.8.2.83.gc99314b
