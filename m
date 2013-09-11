From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/21] unpack-objects: decode v4 object header
Date: Wed, 11 Sep 2013 13:06:15 +0700
Message-ID: <1378879582-15372-15-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:08:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdbW-0006mp-EM
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab3IKGIi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:08:38 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:41352 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab3IKGIh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:08:37 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so8720418pad.23
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IMZe2p+L+aaqD8ENu4ixnQ1+/12z3ALaF3f6tdjufA0=;
        b=yJl4wPUNjJNcTwPSwf1uBHG1XR474m2s1tvPvv9JiwYtTSTAdXLyhks+Gdzkm5eKP8
         T+qu8Tpfidv9ptXmSjMd8mwY+TpZedBhmkZ2LfcQUQ3X6hXd/7/qaoiPmQsYFOFH6C7z
         Lk+ODVn+RFm8d3zwXOFcgLepLtBsIRolNulXzO2KOOGHmB+ZYn+8Y1tvJEyibd3JXAI7
         1Yau/6upv1cxbwZdXf8X9PtF6MK5OQ1lUgO4KN1GuASMrhdCLkycTpOhCHpUtRe8p2hE
         J+gi6Dc2yy91oLfCEFFICr4QhSpPcDqZf3Rct6TkZ+jXg2KXOeA3iUqwwwTdmIW2q3tS
         0ImQ==
X-Received: by 10.68.197.73 with SMTP id is9mr29157616pbc.75.1378879717384;
        Tue, 10 Sep 2013 23:08:37 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id oj6sm1106679pab.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:08:36 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:08:29 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234538>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/unpack-objects.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 1a3c30e..a906a98 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -448,32 +448,38 @@ static void unpack_delta_entry(enum object_type t=
ype, unsigned long delta_size,
 	free(base);
 }
=20
-static int unpack_one(unsigned nr)
+static void read_typesize_v2(enum object_type *type, unsigned long *si=
ze)
 {
+	unsigned char c =3D *(char*)fill_and_use(1);
 	unsigned shift;
-	unsigned char *pack;
-	unsigned long size, c;
+
+	*type =3D (c >> 4) & 7;
+	*size =3D (c & 15);
+	shift =3D 4;
+	while (c & 128) {
+		c =3D *(char*)fill_and_use(1);
+		*size +=3D (c & 0x7f) << shift;
+		shift +=3D 7;
+	}
+}
+
+static int unpack_one(unsigned nr)
+{
+	unsigned long size;
 	enum object_type type;
=20
 	obj_list[nr].offset =3D consumed_bytes;
=20
-	pack =3D fill(1);
 	if (packv4 && *(char*)fill(1) =3D=3D 0) {
 		use(1);
 		return -1;
 	}
-	c =3D *pack;
-	use(1);
-	type =3D (c >> 4) & 7;
-	size =3D (c & 15);
-	shift =3D 4;
-	while (c & 0x80) {
-		pack =3D fill(1);
-		c =3D *pack;
-		use(1);
-		size +=3D (c & 0x7f) << shift;
-		shift +=3D 7;
-	}
+	if (packv4) {
+		uintmax_t val =3D read_varint();
+		type =3D val & 15;
+		size =3D val >> 4;
+	} else
+		read_typesize_v2(&type, &size);
=20
 	switch (type) {
 	case OBJ_COMMIT:
--=20
1.8.2.82.gc24b958
