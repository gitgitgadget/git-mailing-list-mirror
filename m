From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/14] index-pack: split out varint decoding code
Date: Sun,  8 Sep 2013 14:22:30 +0700
Message-ID: <1378624960-8919-5-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:20:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZHx-0003mg-IH
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab3IHHUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:20:00 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54355 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:19:59 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so5013566pab.11
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wfR/XEF47aXWNsd+cli518xQecjfAv7wZEU4OKNhfow=;
        b=aQ+XV8PzZVk9nuGyOO9NgRCq4DranB+WjAlRjHGUzVqcuuYO/gsJ6dwc/92cQqGXCR
         V4JoInTorC3kDvda7UNfRfvhBqLGsQUc1usrxFk4Vk4VEZJwE96AI6HBcLTdAA9axKwx
         ATRrPiwu5r3kTcV/mdLWtgUsfQWqjvfsWELpQvkbOX//KrC5mIPNns5cEDfOJcPh/8CA
         OhjtjEy0gSupBUQePN/TnyUgtmBkpnZqy6v0KPlMjCCNyxC8dIkIRCQKrqBPBv+M/IXB
         2mU6/PPu7H3ZqtvTL4+Q94yqbsscw0v1bQoeiHW9yOnxtGbgkn1+VK8r7EYvr4oWHfoS
         uV9w==
X-Received: by 10.67.23.199 with SMTP id ic7mr13413051pad.73.1378624799158;
        Sun, 08 Sep 2013 00:19:59 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id sy2sm8446858pbc.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:19:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:23:07 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234201>

---
 builtin/index-pack.c | 82 ++++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1dbabe0..5fbd517 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -277,6 +277,31 @@ static void use(int bytes)
 	consumed_bytes += bytes;
 }
 
+static inline void *fill_and_use(int bytes)
+{
+	void *p = fill(bytes);
+	use(bytes);
+	return p;
+}
+
+static NORETURN void bad_object(unsigned long offset, const char *format,
+		       ...) __attribute__((format (printf, 2, 3)));
+
+static uintmax_t read_varint(void)
+{
+	unsigned char c = *(char*)fill_and_use(1);
+	uintmax_t val = c & 127;
+	while (c & 128) {
+		val += 1;
+		if (!val || MSB(val, 7))
+			bad_object(consumed_bytes,
+				   _("offset overflow in read_varint"));
+		c = *(char*)fill_and_use(1);
+		val = (val << 7) + (c & 127);
+	}
+	return val;
+}
+
 static const char *open_pack_file(const char *pack_name)
 {
 	if (from_stdin) {
@@ -317,9 +342,6 @@ static void parse_pack_header(void)
 	use(sizeof(struct pack_header));
 }
 
-static NORETURN void bad_object(unsigned long offset, const char *format,
-		       ...) __attribute__((format (printf, 2, 3)));
-
 static NORETURN void bad_object(unsigned long offset, const char *format, ...)
 {
 	va_list params;
@@ -462,55 +484,41 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size,
 	return buf == fixed_buf ? NULL : buf;
 }
 
+static void read_typesize_v2(struct object_entry *obj)
+{
+	unsigned char c = *(char*)fill_and_use(1);
+	unsigned shift;
+
+	obj->type = (c >> 4) & 7;
+	obj->size = (c & 15);
+	shift = 4;
+	while (c & 128) {
+		c = *(char*)fill_and_use(1);
+		obj->size += (c & 0x7f) << shift;
+		shift += 7;
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
 
 	obj->idx.offset = consumed_bytes;
 	input_crc32 = crc32(0, NULL, 0);
 
-	p = fill(1);
-	c = *p;
-	use(1);
-	obj->type = (c >> 4) & 7;
-	size = (c & 15);
-	shift = 4;
-	while (c & 0x80) {
-		p = fill(1);
-		c = *p;
-		use(1);
-		size += (c & 0x7f) << shift;
-		shift += 7;
-	}
-	obj->size = size;
+	read_typesize_v2(obj);
 
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
-		hashcpy(delta_base->sha1, fill(20));
-		use(20);
+		hashcpy(delta_base->sha1, fill_and_use(20));
 		break;
 	case OBJ_OFS_DELTA:
 		memset(delta_base, 0, sizeof(*delta_base));
-		p = fill(1);
-		c = *p;
-		use(1);
-		base_offset = c & 127;
-		while (c & 128) {
-			base_offset += 1;
-			if (!base_offset || MSB(base_offset, 7))
-				bad_object(obj->idx.offset, _("offset value overflow for delta base object"));
-			p = fill(1);
-			c = *p;
-			use(1);
-			base_offset = (base_offset << 7) + (c & 127);
-		}
-		delta_base->offset = obj->idx.offset - base_offset;
+		val = read_varint();
+		delta_base->offset = obj->idx.offset - val;
 		if (delta_base->offset <= 0 || delta_base->offset >= obj->idx.offset)
 			bad_object(obj->idx.offset, _("delta base offset is out of bound"));
 		break;
-- 
1.8.2.83.gc99314b
