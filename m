From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 1/4] sha1_file: support reading from a loose object of unknown type
Date: Sun,  3 May 2015 19:59:59 +0530
Message-ID: <1430663402-26717-1-git-send-email-karthik.188@gmail.com>
References: <55463094.9040204@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 16:30:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YouuX-0005rW-MO
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 16:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbbECOaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 10:30:22 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33080 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbbECOaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 10:30:20 -0400
Received: by pacwv17 with SMTP id wv17so138498911pac.0
        for <git@vger.kernel.org>; Sun, 03 May 2015 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QG6QsDDRUsGgG0rFZGkYDEtjDGwuiCfYDumdURWIYEo=;
        b=mi5u0w7p5iBIsBENpnyn95N63c2cR6zlwf7PFnEFmB+XDJ8mgFHFu0GBiP9dKl06Kk
         nd1vZmcxcFBNRADJaHbG4GN3ZP+00JCdsTBgNJsJGr73ySSQ+radVWTG27+G48Dx/ExM
         BXJVH9mCfDjaKRLmXY0XOA7waU6oi/csXlbjtGPJsl6ZiFhI/+kBt+uuDAgFQr5PMAve
         96JmDgFIDl0T2pM2Lxpt/209P/oIP5FxslvNPFKGj8NTyqvcwCpzQKFhTkPxyNosClAB
         rvh72VDO5SmCEPcPIeo47S1JtesS2N/YevdlEnVYSyKVyzn7UKxh6xUji4V8ErVSiDox
         56DQ==
X-Received: by 10.70.47.9 with SMTP id z9mr34783241pdm.69.1430663420024;
        Sun, 03 May 2015 07:30:20 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id xt9sm10097262pbc.14.2015.05.03.07.30.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 May 2015 07:30:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.250.gfbd73bd
In-Reply-To: <55463094.9040204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268263>

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
Helped-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Hepled-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 cache.h     |   2 +
 sha1_file.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 101 insertions(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index 3d3244b..38419c3 100644
--- a/cache.h
+++ b/cache.h
@@ -838,6 +838,7 @@ extern int is_ntfs_dotgit(const char *name);
 
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
+#define LOOKUP_UNKNOWN_OBJECT 2
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
 static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
@@ -1304,6 +1305,7 @@ struct object_info {
 	unsigned long *sizep;
 	unsigned long *disk_sizep;
 	unsigned char *delta_base_sha1;
+	struct strbuf *typename;
 
 	/* Response */
 	enum {
diff --git a/sha1_file.c b/sha1_file.c
index 88f06ba..f65bf90 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1564,6 +1564,33 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
 	return git_inflate(stream, 0);
 }
 
+static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
+					unsigned long mapsize, void *buffer,
+					unsigned long bufsiz, struct strbuf *header)
+{
+	unsigned char *cp;
+	int status;
+
+	status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
+
+	/*
+	 * Check if entire header is unpacked in the first iteration.
+	 */
+	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
+		return 0;
+
+	strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
+	do {
+		status = git_inflate(stream, 0);
+		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
+		if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
+			return 0;
+		stream->next_out = buffer;
+		stream->avail_out = bufsiz;
+	} while (status != Z_STREAM_END);
+	return -1;
+}
+
 static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
 {
 	int bytes = strlen(buffer) + 1;
@@ -1614,27 +1641,38 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-int parse_sha1_header(const char *hdr, unsigned long *sizep)
+static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
+			       unsigned int flags)
 {
-	char type[10];
-	int i;
+	const char *type_buf = hdr;
 	unsigned long size;
+	int type, type_len = 0;
 
 	/*
-	 * The type can be at most ten bytes (including the
-	 * terminating '\0' that we add), and is followed by
+	 * The type can be of any size but is followed by
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
+		type_len++;
 	}
-	type[i] = 0;
+
+	type = type_from_string_gently(type_buf, type_len, 1);
+	if (oi->typename)
+		strbuf_add(oi->typename, type_buf, type_len);
+	/*
+	 * Set type to 0 if its an unknown object and
+	 * we're obtaining the type using '--allow-unkown-type'
+	 * option.
+	 */
+	if ((flags & LOOKUP_UNKNOWN_OBJECT) && (type < 0))
+		type = 0;
+	else if (type < 0)
+		die("invalid object type");
+	if (oi->typep)
+		*oi->typep = type;
 
 	/*
 	 * The length must follow immediately, and be in canonical
@@ -1652,12 +1690,24 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
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
@@ -2524,13 +2574,15 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
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
@@ -2543,7 +2595,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	 * return value implicitly indicates whether the
 	 * object even exists.
 	 */
-	if (!oi->typep && !oi->sizep) {
+	if (!oi->typep && !oi->typename && !oi->sizep) {
 		struct stat st;
 		if (stat_sha1_file(sha1, &st) < 0)
 			return -1;
@@ -2557,17 +2609,26 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 		return -1;
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
-	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+	if ((flags & LOOKUP_UNKNOWN_OBJECT)) {
+		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
+			status = error("unable to unpack %s header with --allow-unknown-type",
+				       sha1_to_hex(sha1));
+	} else if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error("unable to unpack %s header",
 			       sha1_to_hex(sha1));
-	else if ((status = parse_sha1_header(hdr, &size)) < 0)
+	if (status < 0)
+		; /* Do nothing */
+	else if (hdrbuf.len) {
+		if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
+			status = error("unable to parse %s header with --allow-unknown-type",
+				       sha1_to_hex(sha1));
+	} else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
-	else if (oi->sizep)
-		*oi->sizep = size;
 	git_inflate_end(&stream);
 	munmap(map, mapsize);
-	if (oi->typep)
+	if (status && oi->typep)
 		*oi->typep = status;
+	strbuf_release(&hdrbuf);
 	return 0;
 }
 
@@ -2576,6 +2637,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
+	enum object_type real_type;
 	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
 
 	co = find_cached_object(real);
@@ -2588,13 +2650,15 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
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
@@ -2605,9 +2669,18 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
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
@@ -2618,6 +2691,10 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
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
2.4.0.rc1.250.gfbd73bd
