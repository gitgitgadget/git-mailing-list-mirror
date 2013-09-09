From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/16] pack-write.c: add pv4_encode_object_header
Date: Mon,  9 Sep 2013 20:57:57 +0700
Message-ID: <1378735087-4813-7-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:56:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1we-0002xd-68
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab3IINzu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:55:50 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:37618 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab3IINzs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:55:48 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so6129768pbc.30
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CPk+0b9RqmOdAW5weLuYPfiWtRX6XN/87pj2Ju+tUik=;
        b=MdTlc3h1NO7TYQdNt+a0yTx5fVbwyaRoD5klcJ+q54LTbt1WHOuMUveSIc1H42xntq
         FTkY9LqiKwqcnUHM3DJbEBochF+I87py1R/f4J51AgBRU9VAy7o+yrZqxb927OY0qiEY
         7cieSHsK9a2bf6FInW4MUL89U+497oLEXku1vLc2Q+LlCg6GNczLvM9x7nRLX+DwYnMW
         ZlEg7YOVjjCphb3MQUjjMnBHrF6lqwNrbvyKJa9qgjZCA0C3WZUp/QGMMt4zHi124xOx
         c/NorPQgS92vmmIcIuXKIsKFykPzB6+K7d6Kx4try1KLpkx/fN+8hRWngTY41sqOikXz
         UtbQ==
X-Received: by 10.66.221.8 with SMTP id qa8mr1910841pac.188.1378734947099;
        Mon, 09 Sep 2013 06:55:47 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id kd1sm17770384pab.20.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:55:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 20:58:56 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234334>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pack-write.c | 33 +++++++++++++++++++++++++++++++++
 pack.h       |  1 +
 2 files changed, 34 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index 36b88a3..c1e9da4 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pack.h"
 #include "csum-file.h"
+#include "varint.h"
=20
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
@@ -349,6 +350,38 @@ int encode_in_pack_object_header(enum object_type =
type, uintmax_t size, unsigned
 	return n;
 }
=20
+int pv4_encode_object_header(enum object_type type,
+			     uintmax_t size, unsigned char *hdr)
+{
+	uintmax_t val;
+
+	switch (type) {
+	case OBJ_COMMIT:
+	case OBJ_TREE:
+	case OBJ_BLOB:
+	case OBJ_TAG:
+	case OBJ_REF_DELTA:
+	case OBJ_PV4_COMMIT:
+	case OBJ_PV4_TREE:
+		break;
+	default:
+		die("bad type %d", type);
+	}
+
+	/*
+	 * We allocate 4 bits in the LSB for the object type which
+	 * should be good for quite a while, given that we effectively
+	 * encodes only 5 object types: commit, tree, blob, delta,
+	 * tag.
+	 */
+	val =3D size;
+	if (MSB(val, 4))
+		die("fixme: the code doesn't currently cope with big sizes");
+	val <<=3D 4;
+	val |=3D type;
+	return encode_varint(val, hdr);
+}
+
 struct sha1file *create_tmp_packfile(char **pack_tmp_name)
 {
 	char tmpname[PATH_MAX];
diff --git a/pack.h b/pack.h
index 855f6c6..4f10fa4 100644
--- a/pack.h
+++ b/pack.h
@@ -83,6 +83,7 @@ extern off_t write_pack_header(struct sha1file *f, in=
t, uint32_t);
 extern void fixup_pack_header_footer(int, unsigned char *, const char =
*, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 extern int encode_in_pack_object_header(enum object_type, uintmax_t, u=
nsigned char *);
+extern int pv4_encode_object_header(enum object_type, uintmax_t, unsig=
ned char *);
=20
 #define PH_ERROR_EOF		(-1)
 #define PH_ERROR_PACK_SIGNATURE	(-2)
--=20
1.8.2.83.gc99314b
