From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 1/2] sha1_file.c: support reading from a loose object of unknown type
Date: Wed, 25 Mar 2015 12:51:45 +0530
Message-ID: <1427268105-16901-1-git-send-email-karthik.188@gmail.com>
References: <5512618B.2060402@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 08:22:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yafda-0007vD-3S
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 08:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbbCYHV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 03:21:58 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36279 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbbCYHV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 03:21:57 -0400
Received: by padcy3 with SMTP id cy3so19767377pad.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 00:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5QDpXEMRSI5FVpnW/6rRTI6hKPeXBAxiLf540ljfZTo=;
        b=f3/4151VthpMi2NymuC8JioINTBRkbHQ1vaq6MIJhiVPRQkhXovw59oSIjxDitrKKx
         UcUDQsqvFkjc4yY9jPVuVjdcj1UfpMrvmIz5y6j7C4poweJAQvuoWC29sW1LR1hgc/zb
         0gxSyg4NDY49/a9hAfcm3ivFGNroA2WThc87eWFqAgIRy/1loBTkXpNvlC+V3th1oQ+2
         ezvsrF4MvPrsPjjbHoVy8LG7o/H/pWS9VcpC4+oqTscyMVYsQxPjbEHev6xSq3JurNv8
         7SdkvuTKJRJpFxw7Q/TtvaedwmUjSJmnKKEjujVe3+LwviN0629pEovduOuYPACIbdeN
         H0Pw==
X-Received: by 10.68.139.225 with SMTP id rb1mr14451138pbb.93.1427268116410;
        Wed, 25 Mar 2015 00:21:56 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id lr1sm1411393pab.39.2015.03.25.00.21.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2015 00:21:55 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.170.g5319d60.dirty
In-Reply-To: <5512618B.2060402@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266269>

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
 sha1_file.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 89 insertions(+), 23 deletions(-)

diff --git a/cache.h b/cache.h
index 4d02efc..949ef4c 100644
--- a/cache.h
+++ b/cache.h
@@ -830,6 +830,7 @@ extern int is_ntfs_dotgit(const char *name);
 
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
+#define LOOKUP_LITERALLY 2
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
 static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
@@ -1296,6 +1297,7 @@ struct object_info {
 	unsigned long *sizep;
 	unsigned long *disk_sizep;
 	unsigned char *delta_base_sha1;
+	struct strbuf *typename;
 
 	/* Response */
 	enum {
diff --git a/sha1_file.c b/sha1_file.c
index 69a60ec..39041a6 100644
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
+	} while (status == Z_OK);
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
 
+	type = type_from_string_gently(typename.buf, typename.len, 1);
+	if (oi->sizep)
+		*oi->sizep = size;
+	if (oi->typename)
+		strbuf_addbuf(oi->typename, &typename);
+	strbuf_release(&typename);
+
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
@@ -2524,13 +2576,15 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
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
@@ -2557,17 +2611,23 @@ static int sha1_loose_object_info(const unsigned char *sha1,
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
+			status = error("unable to parse %s header", sha1_to_hex(sha1));
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
-		*oi->typep = status;
+	if (hdrbuf.buf)
+		strbuf_release(&hdrbuf);
 	return 0;
 }
 
@@ -2588,13 +2648,15 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
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
@@ -2618,6 +2680,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
 					 rtype == OBJ_OFS_DELTA);
 	}
+	if (oi->typename)
+		strbuf_addstr(oi->typename, typename(rtype));
 
 	return 0;
 }
-- 
2.3.1.170.g5319d60.dirty
