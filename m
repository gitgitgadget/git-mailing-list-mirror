From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 1/4] sha1_file.c: support reading from a loose object of unknown type
Date: Wed, 15 Apr 2015 22:29:03 +0530
Message-ID: <1429117143-4882-1-git-send-email-karthik.188@gmail.com>
References: <552E9816.6040502@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 18:59:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQer-00076X-KU
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 18:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbbDOQ7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 12:59:21 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36719 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbbDOQ7U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 12:59:20 -0400
Received: by pdea3 with SMTP id a3so58774293pde.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vLBw18c+2VFnOCsHGR2VQkXALoKqGkhRSiWH5Fnz9DM=;
        b=vh8uvYwFrcE+85DmJV14AySgcUYBamgIr4w0pb0FcqGaH2HUxzSDLFbAr7yw2pd3F7
         5+5x0C99cBk7MWK6humsa/G1yKf1ABeZBDGWT87e3FnyP0SskWk1Q1HrOWST814yKama
         SAYnuq58N5kJI3AVW+/Nl+yx7Y5tvBrQA4Xcqmjn0BnDjlykQpWwI+SKnoUCXDoi2t3U
         KGhT5UUH8AlU2aOflVoLFruP3QoHXiRUGzkS/8o8O/MTGwEP4DPl0T9Y9tygD+9VHFfU
         JI4I5TAxIdBgcJA2RaxfA1t/taaVtxcOH0PzS4pg2cgr18w4piM82uF/SY23q0xuIHV1
         eDaw==
X-Received: by 10.70.44.3 with SMTP id a3mr48634373pdm.93.1429117159576;
        Wed, 15 Apr 2015 09:59:19 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id gy1sm4631479pbc.55.2015.04.15.09.59.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Apr 2015 09:59:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.249.g1310741
In-Reply-To: <552E9816.6040502@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267214>

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
 cache.h     |   2 +
 sha1_file.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 105 insertions(+), 23 deletions(-)

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
index 980ce6b..267399d 100644
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
@@ -1614,27 +1642,40 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
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
+
+	type = type_from_string_gently(typename.buf, typename.len, 1);
+	if (oi->typename)
+		strbuf_addbuf(oi->typename, &typename);
+	strbuf_release(&typename);
+	/*
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
 
 	/*
 	 * The length must follow immediately, and be in canonical
@@ -1652,12 +1693,24 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 			size = size * 10 + c;
 		}
 	}
-	*sizep = size;
+
+	if (oi->sizep)
+		*oi->sizep = size;
 
 	/*
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
@@ -2522,13 +2575,15 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
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
@@ -2541,7 +2596,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	 * return value implicitly indicates whether the
 	 * object even exists.
 	 */
-	if (!oi->typep && !oi->sizep) {
+	if (!oi->typep && !oi->typename && !oi->sizep) {
 		struct stat st;
 		if (stat_sha1_file(sha1, &st) < 0)
 			return -1;
@@ -2555,17 +2610,26 @@ static int sha1_loose_object_info(const unsigned char *sha1,
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
 
@@ -2574,6 +2638,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
+	enum object_type real_type;
 	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
 
 	co = find_cached_object(real);
@@ -2586,13 +2651,15 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
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
@@ -2603,9 +2670,18 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			return -1;
 	}
 
+	/*
+	 * packed_object_info() does not follow the delta chain to
+	 * find out the real type, unless it is given oi->typep.
+	 */
+	if (oi->typename && !oi->typep)
+		oi->typep = &real_type;
+
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
+		if (oi->typep == &real_type)
+			oi->typep = NULL;
 		return sha1_object_info_extended(real, oi, 0);
 	} else if (in_delta_base_cache(e.p, e.offset)) {
 		oi->whence = OI_DBCACHED;
@@ -2616,6 +2692,10 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
 					 rtype == OBJ_OFS_DELTA);
 	}
+	if (oi->typename)
+		strbuf_addstr(oi->typename, typename(*oi->typep));
+	if (oi->typep == &real_type)
+		oi->typep = NULL;
 
 	return 0;
 }
-- 
2.4.0.rc1.249.gb598846
