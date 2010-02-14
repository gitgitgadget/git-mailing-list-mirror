From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH 3/4] Refactoring: move duplicated code from builtin-pack-objects.c and fast-import.c to object.c
Date: Sun, 14 Feb 2010 21:27:42 +0000
Message-ID: <1266182863-5048-3-git-send-email-michael.lukashov@gmail.com>
References: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 22:30:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngm2s-0001K3-OM
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 22:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab0BNV2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 16:28:31 -0500
Received: from mail-bw0-f216.google.com ([209.85.218.216]:61417 "EHLO
	mail-bw0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab0BNV2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 16:28:19 -0500
Received: by mail-bw0-f216.google.com with SMTP id 8so2302841bwz.38
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 13:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ad6SRnfG6vd4nGChhfpii3XOlYTPjjKECpMnQPaHILY=;
        b=HHE7AUAZwYwEa5+AXx0gjPeQGXyfc+8eCLSQ7Qw5I7irRqxPQ3XsCJkNmdWpFN0BVi
         NwtslqRY8gUQQ8L+tihaQGWQIzTdpWRlSeW/6kpQ8MtN8krVp/h9RmSmhANga/Bt3DIs
         Pey9aKIqCJJnNPXqzWIRR3hKexJ31sasxan/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Dr7IsYpIP5YqfwAp2sDRBGA21axfnDehd9uR8+8vivP0JyZ2IkWDexoXycYlitxQaE
         szV9rE9nZX2Km1tF3yDP/Covq4E83nXHbB1IltKqpBX08KdUKK2BMVCm95JKEaptw3Bs
         CbU1suiyT9p6BQWg6NEUaEovnOi1mM/2heXTI=
Received: by 10.204.32.7 with SMTP id a7mr2622828bkd.139.1266182899183;
        Sun, 14 Feb 2010 13:28:19 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 16sm2381914bwz.11.2010.02.14.13.28.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 13:28:18 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
In-Reply-To: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139940>

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
