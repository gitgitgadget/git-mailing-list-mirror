From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH v2 3/4] Refactoring: move duplicated code from builtin-pack-objects.c and fast-import.c to object.c
Date: Mon, 15 Feb 2010 23:26:49 +0000
Message-ID: <1266276411-5796-4-git-send-email-michael.lukashov@gmail.com>
References: <1266276411-5796-1-git-send-email-michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 00:33:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhARQ-0000ka-5R
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 00:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124Ab0BOXdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 18:33:17 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:48695 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090Ab0BOXdR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 18:33:17 -0500
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2010 18:32:54 EST
Received: by mail-bw0-f213.google.com with SMTP id 5so1503115bwz.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 15:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ad6SRnfG6vd4nGChhfpii3XOlYTPjjKECpMnQPaHILY=;
        b=kp+ZFwfZwBJCPTYGZIp8eyWJFggjOWezHywvTAyLd01dCA62tyDhH+dWWVf2RKVzL5
         FsZYM0VBOwb8skZmVb7fcVVrS/9jkmld6GVeFFSkX39xlergIcky+ctXZHwD6qL4wz9b
         BdnQW9z8+MrhG47Qlk+3aoP5mI0zEDihOiIws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BigwSRe72gwPGhKaZwgAK6peFFmMElThSffdpkTBaXhij8L1xyM7s6VlZlaybPOjW8
         RgUkETTDCgmU+ItYRrnHgKyV6kRbbrzbZ7/G64wFmx+LoZEEfRPE0B+ZYKlOYQ9rEjqc
         ZX9hfcv6c+K3n9jbvdGgBDqtJvu0ntxcMjzdg=
Received: by 10.204.132.207 with SMTP id c15mr57942bkt.102.1266276432224;
        Mon, 15 Feb 2010 15:27:12 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 14sm2876740bwz.5.2010.02.15.15.27.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 15:27:11 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
In-Reply-To: <1266276411-5796-1-git-send-email-michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140046>

The following functions are duplicated:

  encode_header

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 builtin-pack-objects.c |   27 ---------------------------
 fast-import.c          |   23 -----------------------
 object.c               |   20 ++++++++++++++++++++
 object.h               |    9 +++++++++
 4 files changed, 29 insertions(+), 50 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e1d3adf..80bbcd2 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -155,33 +155,6 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 }
 
 /*
- * The per-object header is a pretty dense thing, which is
- *  - first byte: low four bits are "size", then three bits of "type",
- *    and the high bit is "size continues".
- *  - each byte afterwards: low seven bits are size continuation,
- *    with the high bit being "size continues"
- */
-static int encode_header(enum object_type type, unsigned long size, unsigned char *hdr)
-{
-	int n = 1;
-	unsigned char c;
-
-	if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
-		die("bad type %d", type);
-
-	c = (type << 4) | (size & 15);
-	size >>= 4;
-	while (size) {
-		*hdr++ = c | 0x80;
-		c = size & 0x7f;
-		size >>= 7;
-		n++;
-	}
-	*hdr = c;
-	return n;
-}
-
-/*
  * we are going to reuse the existing object data as is.  make
  * sure it is not corrupt.
  */
diff --git a/fast-import.c b/fast-import.c
index b477dc6..f983338 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1013,29 +1013,6 @@ static void cycle_packfile(void)
 	start_packfile();
 }
 
-static size_t encode_header(
-	enum object_type type,
-	uintmax_t size,
-	unsigned char *hdr)
-{
-	int n = 1;
-	unsigned char c;
-
-	if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
-		die("bad type %d", type);
-
-	c = (type << 4) | (size & 15);
-	size >>= 4;
-	while (size) {
-		*hdr++ = c | 0x80;
-		c = size & 0x7f;
-		size >>= 7;
-		n++;
-	}
-	*hdr = c;
-	return n;
-}
-
 static int store_object(
 	enum object_type type,
 	struct strbuf *dat,
diff --git a/object.c b/object.c
index 3ca92c4..a06ad01 100644
--- a/object.c
+++ b/object.c
@@ -268,3 +268,23 @@ void object_array_remove_duplicates(struct object_array *array)
 		array->nr = dst;
 	}
 }
+
+int encode_header(enum object_type type, uintmax_t size, unsigned char *hdr)
+{
+	int n = 1;
+	unsigned char c;
+
+	if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
+		die("bad type %d", type);
+
+	c = (type << 4) | (size & 15);
+	size >>= 4;
+	while (size) {
+		*hdr++ = c | 0x80;
+		c = size & 0x7f;
+		size >>= 7;
+		n++;
+	}
+	*hdr = c;
+	return n;
+}
diff --git a/object.h b/object.h
index 82877c8..f5a5c77 100644
--- a/object.h
+++ b/object.h
@@ -79,4 +79,13 @@ void add_object_array(struct object *obj, const char *name, struct object_array
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
 void object_array_remove_duplicates(struct object_array *);
 
+/*
+ * The per-object header is a pretty dense thing, which is
+ *  - first byte: low four bits are "size", then three bits of "type",
+ *    and the high bit is "size continues".
+ *  - each byte afterwards: low seven bits are size continuation,
+ *    with the high bit being "size continues"
+ */
+int encode_header(enum object_type type, uintmax_t size, unsigned char *hdr);
+
 #endif /* OBJECT_H */
-- 
1.7.0.1571.g856c2
