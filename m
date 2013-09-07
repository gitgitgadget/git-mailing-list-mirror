From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/12] index-pack: split inflate/digest code out of unpack_entry_data
Date: Sat,  7 Sep 2013 17:43:11 +0700
Message-ID: <1378550599-25365-5-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:41:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFwt-0002ir-1M
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284Ab3IGKk7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:40:59 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:65320 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3IGKk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:40:58 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so4275775pdj.26
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ab8aXOCvfc1HsH/8UvdoOLtmVKTBkL4rQWX/evQx1D0=;
        b=Wh8RqVahBER/4s0wgQEvNmbIrXqoRNpjq0F/CXNyqsbj7z+lqCxL+UxmVZvfQ/eK2J
         mBrfYK5ILXBef3vAefNwVJYFrp9mSLAQy53ytPM7r1sjethKB+cMGEwBkxtBGr+0AzMH
         6OsRyqUVn+mcD1rOI9RILslJEpTbgMAiqf4e8r/SkHXB3ziCWyTONG+0rc9soy70icpH
         CY6yQ/AYTp+hKyYGkTAlUpME3TNyqe2ZKbwQ9gQ0RMDYHbt4d9FIu0gxZrFhD01w+DRz
         ukNyigq23UsBT6/8KBsdjdzAa9JjLcgMhl5jIFrZZK+IStxEexHBhgw06bXcnsTILUmY
         Iuag==
X-Received: by 10.68.129.201 with SMTP id ny9mr6735718pbb.70.1378550458148;
        Sat, 07 Sep 2013 03:40:58 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id oc10sm3418199pbb.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:40:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:44:06 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234122>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 62 +++++++++++++++++++++++++++++++-------------=
--------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a47cc34..0dd7193 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -429,33 +429,19 @@ static int is_delta_type(enum object_type type)
 	return (type =3D=3D OBJ_REF_DELTA || type =3D=3D OBJ_OFS_DELTA);
 }
=20
-static void *unpack_entry_data(unsigned long offset, unsigned long siz=
e,
-			       enum object_type type, unsigned char *sha1)
+static void read_and_inflate(unsigned long offset,
+			     void *buf, unsigned long size,
+			     unsigned long wraparound,
+			     git_SHA_CTX *ctx,
+			     unsigned char *sha1)
 {
-	static char fixed_buf[8192];
-	int status;
 	git_zstream stream;
-	void *buf;
-	git_SHA_CTX c;
-	char hdr[32];
-	int hdrlen;
-
-	if (!is_delta_type(type)) {
-		hdrlen =3D sprintf(hdr, "%s %lu", typename(type), size) + 1;
-		git_SHA1_Init(&c);
-		git_SHA1_Update(&c, hdr, hdrlen);
-	} else
-		sha1 =3D NULL;
-	if (is_delta_type(type) ||
-	     (type =3D=3D OBJ_BLOB && size > big_file_threshold))
-		buf =3D fixed_buf;
-	else
-		buf =3D xmalloc(size);
+	int status;
=20
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init(&stream);
 	stream.next_out =3D buf;
-	stream.avail_out =3D buf =3D=3D fixed_buf ? sizeof(fixed_buf) : size;
+	stream.avail_out =3D wraparound ? wraparound : size;
=20
 	do {
 		unsigned char *last_out =3D stream.next_out;
@@ -464,17 +450,43 @@ static void *unpack_entry_data(unsigned long offs=
et, unsigned long size,
 		status =3D git_inflate(&stream, 0);
 		use(input_len - stream.avail_in);
 		if (sha1)
-			git_SHA1_Update(&c, last_out, stream.next_out - last_out);
-		if (buf =3D=3D fixed_buf) {
+			git_SHA1_Update(ctx, last_out, stream.next_out - last_out);
+		if (wraparound) {
 			stream.next_out =3D buf;
-			stream.avail_out =3D sizeof(fixed_buf);
+			stream.avail_out =3D wraparound;
 		}
 	} while (status =3D=3D Z_OK);
 	if (stream.total_out !=3D size || status !=3D Z_STREAM_END)
 		bad_object(offset, _("inflate returned %d"), status);
 	git_inflate_end(&stream);
 	if (sha1)
-		git_SHA1_Final(sha1, &c);
+		git_SHA1_Final(sha1, ctx);
+}
+
+static void *unpack_entry_data(unsigned long offset, unsigned long siz=
e,
+			       enum object_type type, unsigned char *sha1)
+{
+	static char fixed_buf[8192];
+	void *buf;
+	git_SHA_CTX c;
+	char hdr[32];
+	int hdrlen;
+
+	if (!is_delta_type(type)) {
+		hdrlen =3D sprintf(hdr, "%s %lu", typename(type), size) + 1;
+		git_SHA1_Init(&c);
+		git_SHA1_Update(&c, hdr, hdrlen);
+	} else
+		sha1 =3D NULL;
+	if (is_delta_type(type) ||
+	     (type =3D=3D OBJ_BLOB && size > big_file_threshold))
+		buf =3D fixed_buf;
+	else
+		buf =3D xmalloc(size);
+
+	read_and_inflate(offset, buf, size,
+			 buf =3D=3D fixed_buf ? sizeof(fixed_buf) : 0,
+			 &c, sha1);
 	return buf =3D=3D fixed_buf ? NULL : buf;
 }
=20
--=20
1.8.2.83.gc99314b
