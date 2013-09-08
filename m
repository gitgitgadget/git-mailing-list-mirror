From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/14] index-pack: split inflate/digest code out of unpack_entry_data
Date: Sun,  8 Sep 2013 14:22:32 +0700
Message-ID: <1378624960-8919-7-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:20:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZI9-0003v1-U3
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab3IHHUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:20:11 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33001 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:20:10 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so4952184pdi.13
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A9JuamfrF5A77P5A6KrIOagm+kSJE+QtSFIPrOLUsrk=;
        b=MBMfhhpupJHrRcYgmJqSxg1ABJEf0lGhyU9Lx/VHQ0Tp5TIrT4rlz7NMHqe1j1hyul
         Tusc71XfT4D0ghWlO0cYU+dAOQK2gzEqws+zhWsKrLpc+/sQzkw6H7UGjfi2l4FA5wVg
         mUeCx6xYqTJrKQXSv1nliwTrEp5W6fX8zyyAAVwMJwR1S6BOP9zd3f6Apny26rc7fll+
         XeMttsETwLMv3BZx/HvuII9fRrRiGBU4GF8CIlQG0CUsEny4VCXzxDOrUGeD4LexckfP
         l5Q+wGlSqxaZ4A8q0BZZvPB4Yunp6q/GOiyn8xUAH/cr8ay0Kam+iaaCHSiDTYWOzyxP
         V41Q==
X-Received: by 10.68.212.106 with SMTP id nj10mr12376562pbc.74.1378624810020;
        Sun, 08 Sep 2013 00:20:10 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id ht5sm8432614pbb.29.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:20:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:23:18 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234203>

---
 builtin/index-pack.c | 62 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 78554d0..3389262 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -431,6 +431,40 @@ static int is_delta_type(enum object_type type)
 	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
 }
 
+static void read_and_inflate(unsigned long offset,
+			     void *buf, unsigned long size,
+			     unsigned long wraparound,
+			     git_SHA_CTX *ctx,
+			     unsigned char *sha1)
+{
+	git_zstream stream;
+	int status;
+
+	memset(&stream, 0, sizeof(stream));
+	git_inflate_init(&stream);
+	stream.next_out = buf;
+	stream.avail_out = wraparound ? wraparound : size;
+
+	do {
+		unsigned char *last_out = stream.next_out;
+		stream.next_in = fill(1);
+		stream.avail_in = input_len;
+		status = git_inflate(&stream, 0);
+		use(input_len - stream.avail_in);
+		if (sha1)
+			git_SHA1_Update(ctx, last_out, stream.next_out - last_out);
+		if (wraparound) {
+			stream.next_out = buf;
+			stream.avail_out = wraparound;
+		}
+	} while (status == Z_OK);
+	if (stream.total_out != size || status != Z_STREAM_END)
+		bad_object(offset, _("inflate returned %d"), status);
+	git_inflate_end(&stream);
+	if (sha1)
+		git_SHA1_Final(sha1, ctx);
+}
+
 /*
  * Unpack an entry data in the streamed pack, calculate the object
  * SHA-1 if it's not a large blob. Otherwise just try to inflate the
@@ -440,8 +474,6 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size,
 			       enum object_type type, unsigned char *sha1)
 {
 	static char fixed_buf[8192];
-	int status;
-	git_zstream stream;
 	void *buf;
 	git_SHA_CTX c;
 	char hdr[32];
@@ -459,29 +491,9 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size,
 	else
 		buf = xmalloc(size);
 
-	memset(&stream, 0, sizeof(stream));
-	git_inflate_init(&stream);
-	stream.next_out = buf;
-	stream.avail_out = buf == fixed_buf ? sizeof(fixed_buf) : size;
-
-	do {
-		unsigned char *last_out = stream.next_out;
-		stream.next_in = fill(1);
-		stream.avail_in = input_len;
-		status = git_inflate(&stream, 0);
-		use(input_len - stream.avail_in);
-		if (sha1)
-			git_SHA1_Update(&c, last_out, stream.next_out - last_out);
-		if (buf == fixed_buf) {
-			stream.next_out = buf;
-			stream.avail_out = sizeof(fixed_buf);
-		}
-	} while (status == Z_OK);
-	if (stream.total_out != size || status != Z_STREAM_END)
-		bad_object(offset, _("inflate returned %d"), status);
-	git_inflate_end(&stream);
-	if (sha1)
-		git_SHA1_Final(sha1, &c);
+	read_and_inflate(offset, buf, size,
+			 buf == fixed_buf ? sizeof(fixed_buf) : 0,
+			 &c, sha1);
 	return buf == fixed_buf ? NULL : buf;
 }
 
-- 
1.8.2.83.gc99314b
