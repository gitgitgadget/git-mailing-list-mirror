From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 1/4] sha1_file.c: support reading from a loose object of unknown type
Date: Sun,  5 Apr 2015 23:58:25 +0530
Message-ID: <1428258505-25223-1-git-send-email-karthik.188@gmail.com>
References: <1428126162-18987-1-git-send-email-karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 20:28:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YepHq-0008WT-0P
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 20:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbbDES2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 14:28:41 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36398 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbbDES2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 14:28:41 -0400
Received: by pdea3 with SMTP id a3so22099978pde.3
        for <git@vger.kernel.org>; Sun, 05 Apr 2015 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2t2A0b8kU6tUQhJoeLdR/gR/tjRFJ7sA9NNSXJxrCXE=;
        b=Gywz2HshLlQRTmzP2to837jcY/qPs1xZ8nJqaSmDkImzk07mpuM2hffAQKJOy9Rjw7
         SytHJobdkTyjlOmzJOftj3bjBKvA7aRQOjKE20DHKYBWnBsMHlcT2COSXeZknPX89ofQ
         9hqe4xMIQupF5OFRqUPchOa3ZiAsy0xrCZdxEQB5Qigj5/zYnesLz9gULEYlK8DdgRBz
         tX/ypNsYffOlK5Qe+Re6H025KuMB+ZLfcbg4ZWD7PK+5jBiVzsSnMCJBaH9pRWe9vsPh
         3uz5PtnSJhuSQO82Mup8N1OhljfgoWphfv7bWP1VpP6X3zukDwTXMjHBPZfl3Vhag6//
         DdXQ==
X-Received: by 10.70.48.68 with SMTP id j4mr21239843pdn.5.1428258520379;
        Sun, 05 Apr 2015 11:28:40 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id zi5sm2172470pbc.39.2015.04.05.11.28.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Apr 2015 11:28:38 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.249.g9f2ee54
In-Reply-To: <1428126162-18987-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266812>

Update sha1_loose_object_info() to optionally allow it to read
from a loose object file of unknown/bogus type; as the function
usually returns the type of the object it read in the form of enum
for known types, add an optional "typename" field to receive the
name of the type in textual form and a flag to indicate the reading
of a loose object file of unknown/bogus type.

Add parse_sha1_header_extended() which acts as a wrapper around
parse_sha1_header() allowing more information to be obtained.

Add unpack_sha1_header_to_strbuf() to unpack sha1 headers of
unknown/corrupt objects which have a unknown sha1 header size to
a strbuf structure. This was written by Junio C Hamano but tested
by me.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 cache.h     |   2 ++
 sha1_file.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 94 insertions(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index c47323e..ea6faf0 100644
--- a/cache.h
+++ b/cache.h
@@ -881,6 +881,7 @@ extern int is_ntfs_dotgit(const char *name);
 
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
+#define LOOKUP_LITERALLY 2
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
 static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
@@ -1349,6 +1350,7 @@ struct object_info {
 	unsigned long *sizep;
 	unsigned long *disk_sizep;
 	unsigned char *delta_base_sha1;
+	struct strbuf *typename;
 
 	/* Response */
 	enum {
diff --git a/sha1_file.c b/sha1_file.c
index 980ce6b..ac8fffc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1564,6 +1564,34 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
 	return git_inflate(stream, 0);
 }
 
+static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
+					unsigned long mapsize,
+					struct strbuf *header)
+{
+	unsigned char buffer[32], *cp;
+	unsigned long bufsiz = sizeof(buffer);
+	int status;
+
+	status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
+
+	if (status) {
+		strbuf_add(header, buffer, stream->next_out - buffer);
+		return status;
+	}
+
+	do {
+		status = git_inflate(stream, 0);
+		strbuf_add(header, buffer, stream->next_out - buffer);
+		for (cp = buffer; cp < stream->next_out; cp++)
+			if (!*cp)
+				/* Found the NUL at the end of the header */
+				return 0;
+		stream->next_out = buffer;
+		stream->avail_out = bufsiz;
+	} while (status != Z_STREAM_END);
+	return -1;
+}
+
 static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
 {
 	int bytes = strlen(buffer) + 1;
@@ -1614,27 +1642,24 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-int parse_sha1_header(const char *hdr, unsigned long *sizep)
+int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
+			       unsigned int flags)
 {
-	char type[10];
-	int i;
+	struct strbuf typename = STRBUF_INIT;
 	unsigned long size;
+	int type;
 
 	/*
 	 * The type can be at most ten bytes (including the
 	 * terminating '\0' that we add), and is followed by
 	 * a space.
 	 */
-	i = 0;
 	for (;;) {
 		char c = *hdr++;
 		if (c == ' ')
 			break;
-		type[i++] = c;
-		if (i >= sizeof(type))
-			return -1;
+		strbuf_addch(&typename, c);
 	}
-	type[i] = 0;
 
 	/*
 	 * The length must follow immediately, and be in canonical
@@ -1652,12 +1677,39 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 			size = size * 10 + c;
 		}
 	}
-	*sizep = size;
+
+	type = type_from_string_gently(typename.buf, typename.len, 1);
+	if (oi->sizep)
+		*oi->sizep = size;
+	if (oi->typename)
+		strbuf_addbuf(oi->typename, &typename);
+	strbuf_release(&typename);
 
 	/*
+	 * Set type to 0 if its an unknown object and
+	 * we're obtaining the type using '--literally'
+	 * option.
+	 */
+	if ((flags & LOOKUP_LITERALLY) && (type == -1))
+		type = 0;
+	else if (type == -1)
+		die("invalid object type");
+	if (oi->typep)
+		*oi->typep = type;
+	/*
 	 * The length must be followed by a zero byte
 	 */
-	return *hdr ? -1 : type_from_string(type);
+	return *hdr ? -1 : type;
+}
+
+int parse_sha1_header(const char *hdr, unsigned long *sizep)
+{
+	struct object_info oi;
+
+	oi.sizep = sizep;
+	oi.typename = NULL;
+	oi.typep = NULL;
+	return parse_sha1_header_extended(hdr, &oi, LOOKUP_REPLACE_OBJECT);
 }
 
 static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
@@ -2522,13 +2574,15 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 }
 
 static int sha1_loose_object_info(const unsigned char *sha1,
-				  struct object_info *oi)
+				  struct object_info *oi,
+				  int flags)
 {
-	int status;
-	unsigned long mapsize, size;
+	int status = 0;
+	unsigned long mapsize;
 	void *map;
 	git_zstream stream;
 	char hdr[32];
+	struct strbuf hdrbuf = STRBUF_INIT;
 
 	if (oi->delta_base_sha1)
 		hashclr(oi->delta_base_sha1);
@@ -2555,17 +2609,26 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 		return -1;
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
-	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
-		status = error("unable to unpack %s header",
-			       sha1_to_hex(sha1));
-	else if ((status = parse_sha1_header(hdr, &size)) < 0)
-		status = error("unable to parse %s header", sha1_to_hex(sha1));
-	else if (oi->sizep)
-		*oi->sizep = size;
+	if ((flags & LOOKUP_LITERALLY)) {
+		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, &hdrbuf) < 0)
+			status = error("unable to unpack %s header with --literally",
+				       sha1_to_hex(sha1));
+		else if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
+			status = error("unable to parse %s header with --literally",
+				       sha1_to_hex(sha1));
+	} else {
+		if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+			status = error("unable to unpack %s header",
+				       sha1_to_hex(sha1));
+		else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
+			status = error("unable to parse %s header", sha1_to_hex(sha1));
+	}
 	git_inflate_end(&stream);
 	munmap(map, mapsize);
-	if (oi->typep)
+	if (status && oi->typep)
 		*oi->typep = status;
+	if (hdrbuf.buf)
+		strbuf_release(&hdrbuf);
 	return 0;
 }
 
@@ -2576,6 +2639,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	int rtype;
 	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
 
+	if (oi->typename && !oi->typep)
+		die("object_info: cannot use typename without typep");
+
 	co = find_cached_object(real);
 	if (co) {
 		if (oi->typep)
@@ -2586,13 +2652,15 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			*(oi->disk_sizep) = 0;
 		if (oi->delta_base_sha1)
 			hashclr(oi->delta_base_sha1);
+		if (oi->typename)
+			strbuf_addstr(oi->typename, typename(co->type));
 		oi->whence = OI_CACHED;
 		return 0;
 	}
 
 	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi)) {
+		if (!sha1_loose_object_info(real, oi, flags)) {
 			oi->whence = OI_LOOSE;
 			return 0;
 		}
@@ -2616,6 +2684,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
 					 rtype == OBJ_OFS_DELTA);
 	}
+	if (oi->typename)
+		strbuf_addstr(oi->typename, typename(*oi->typep));
 
 	return 0;
 }
-- 
2.4.0.rc1.249.g9f2ee54
