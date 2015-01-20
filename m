From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/24] ewah: add convenient wrapper ewah_serialize_strbuf()
Date: Tue, 20 Jan 2015 20:03:18 +0700
Message-ID: <1421759013-8494-10-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:04:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYU7-0003bN-RH
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbbATNEf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:04:35 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:39892 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbbATNEd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:04:33 -0500
Received: by mail-pd0-f175.google.com with SMTP id fl12so9951106pdb.6
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vZ1Pp5stnJBo9AYCkyW+S/kQ4Gg40aDR1VqBQ7HZuTQ=;
        b=KpmDdO8ghwR9HYTTc9De8DYt+afkkOcewQCFlgFY0wKrJBjdIRd01I+G2wrshgJYe/
         RzT+v4oDwHZJr8Be/UhuMTxmTqv9XEOVn4dlbn21CN6v71U/DtOUjAb5clLCeBvPwu/R
         qtAtjSg2Zt8/l/QG1n7fHPzg1zJODvUbFwBP+xhGP523gTs71PJagKXz1j/tbfyY47qg
         Lf72Vc+YnGp+w1HpbsmxSbWU8TNadKhfPAkG98T79GV9RUCCek6yhCNhNYcMCWtaIK3K
         xBnmtKfsNkB0PL/TFT1ewmd39oi8gEEe0zBzOMICv6hh3NQlVaVxsAXMb8xSufQGunUr
         RdrQ==
X-Received: by 10.70.52.161 with SMTP id u1mr43729924pdo.106.1421759073590;
        Tue, 20 Jan 2015 05:04:33 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id wm1sm3267832pac.11.2015.01.20.05.04.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:04:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:04:43 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262661>

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
2.2.0.84.ge9c7a8a
