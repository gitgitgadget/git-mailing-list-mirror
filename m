From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 09/23] ewah: add convenient wrapper ewah_serialize_strbuf()
Date: Mon,  8 Dec 2014 21:04:53 +0700
Message-ID: <1418047507-22892-11-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:55:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxymq-0004Y5-MX
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbaLHNzg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:55:36 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35167 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbaLHNzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:55:33 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so5223889pdj.28
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dz3TBW7k8kJwt0+v7MJD1pa09R5Piah0DEIFO8oUyAU=;
        b=o3fWTISef5jGqQoVdWVio9fqlIbjT2Uzuhel3m48shwEvmW6xbrDJyUC3f6R82oN6c
         SOoo0CzvcTNkrYsBGJb/cLRr2tAh+onC2/2msjCShUBp6jTQmqsATFV1OBgGSZkYVmuA
         67bY1x3XJtSLDMTDSa3JTGpVqD5w1t5TnovzczuQz5vhWpu9ez35RuVb3RhndL8gmp5y
         gGRHS6ViFCSH9uqMsxtvUuEQwmovrzTT0uA7kG9oEPYizXWbEkTHUWuPrxI5Fw0z+w6/
         0nSaZHN9895BqB+2lDvu+0c5Ezg2UmHP7RyeDVNAZ+yySshrAKsxeCrk0sIQNDr1Kv/q
         Bp4A==
X-Received: by 10.70.118.35 with SMTP id kj3mr21355025pdb.36.1418046933010;
        Mon, 08 Dec 2014 05:55:33 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id gx5sm21160408pbb.96.2014.12.08.05.55.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:55:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:06:08 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261026>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ewah/ewah_io.c | 13 +++++++++++++
 ewah/ewok.h    |  2 ++
 split-index.c  | 11 ++---------
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index 1c2d7af..43481b9 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -19,6 +19,7 @@
  */
 #include "git-compat-util.h"
 #include "ewok.h"
+#include "strbuf.h"
=20
 int ewah_serialize_native(struct ewah_bitmap *self, int fd)
 {
@@ -110,6 +111,18 @@ int ewah_serialize(struct ewah_bitmap *self, int f=
d)
 	return ewah_serialize_to(self, write_helper, (void *)(intptr_t)fd);
 }
=20
+static int write_strbuf(void *user_data, const void *data, size_t len)
+{
+	struct strbuf *sb =3D user_data;
+	strbuf_add(sb, data, len);
+	return len;
+}
+
+int ewah_serialize_strbuf(struct ewah_bitmap *self, struct strbuf *sb)
+{
+	return ewah_serialize_to(self, write_strbuf, sb);
+}
+
 int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t l=
en)
 {
 	const uint8_t *ptr =3D map;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index f6ad190..4d7f5e9 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -30,6 +30,7 @@
 #	define ewah_calloc xcalloc
 #endif
=20
+struct strbuf;
 typedef uint64_t eword_t;
 #define BITS_IN_WORD (sizeof(eword_t) * 8)
=20
@@ -97,6 +98,7 @@ int ewah_serialize_to(struct ewah_bitmap *self,
 		      void *out);
 int ewah_serialize(struct ewah_bitmap *self, int fd);
 int ewah_serialize_native(struct ewah_bitmap *self, int fd);
+int ewah_serialize_strbuf(struct ewah_bitmap *self, struct strbuf *);
=20
 int ewah_deserialize(struct ewah_bitmap *self, int fd);
 int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t l=
en);
diff --git a/split-index.c b/split-index.c
index 21485e2..968b780 100644
--- a/split-index.c
+++ b/split-index.c
@@ -41,13 +41,6 @@ int read_link_extension(struct index_state *istate,
 	return 0;
 }
=20
-static int write_strbuf(void *user_data, const void *data, size_t len)
-{
-	struct strbuf *sb =3D user_data;
-	strbuf_add(sb, data, len);
-	return len;
-}
-
 int write_link_extension(struct strbuf *sb,
 			 struct index_state *istate)
 {
@@ -55,8 +48,8 @@ int write_link_extension(struct strbuf *sb,
 	strbuf_add(sb, si->base_sha1, 20);
 	if (!si->delete_bitmap && !si->replace_bitmap)
 		return 0;
-	ewah_serialize_to(si->delete_bitmap, write_strbuf, sb);
-	ewah_serialize_to(si->replace_bitmap, write_strbuf, sb);
+	ewah_serialize_strbuf(si->delete_bitmap, sb);
+	ewah_serialize_strbuf(si->replace_bitmap, sb);
 	return 0;
 }
=20
--=20
2.2.0.60.gb7b3c64
