From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/24] ewah: add convenient wrapper ewah_serialize_strbuf()
Date: Sun,  8 Mar 2015 17:12:32 +0700
Message-ID: <1425809567-25518-10-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:14:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYDk-0003CM-Oz
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbbCHKN7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:13:59 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:41973 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbbCHKN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:13:58 -0400
Received: by pdjy10 with SMTP id y10so17667363pdj.8
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vERd3pi8Uxa1Ze4WYP51VdjVyd5jNyCdf9C4NbtHfe0=;
        b=KV0gJ3ZhYcVLFLA5lLLL9NMu81eV9BrvobymRUfjL/JwznW3i+OUaNrAuFchQT+jqE
         /BCiojG5HNZ7CmFB9B8RVk80Vzm9ePsNbYLb1i2+fFDrTSgV/g3HSYLqg1UubdZb7SFJ
         8iRijDfNzXZSON50vC3lRM7ABlkoOzdKExwipiJEns5rYKlykgvT9bczsYS0OlTEpUs5
         35Yie2PXqz3mrBB9SvCi+7yQ2kKpOFkAvzOWYaiqfehaqbor0Kr4Bxp/zXAhNtkOMAjI
         Vgzsfzl6sCtXlJCiSW7+wI3MYkokzNBzKE7FaBfYSZ3uzYyWYwJzXBOti6ivMhOP3PZA
         b+uA==
X-Received: by 10.68.68.238 with SMTP id z14mr40877497pbt.81.1425809638587;
        Sun, 08 Mar 2015 03:13:58 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id c17sm14351185pdl.79.2015.03.08.03.13.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:13:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:13:54 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265064>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.3.0.rc1.137.g477eb31
