From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 2/2] sha1_file: refactor sha1_file.c to support 'cat-file --literally'
Date: Tue, 17 Mar 2015 10:46:59 +0530
Message-ID: <1426569419-8266-1-git-send-email-karthik.188@gmail.com>
References: <5507B7EE.1070403@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 06:17:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXjsZ-0008Ud-SI
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 06:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbbCQFRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 01:17:19 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34031 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbCQFRS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 01:17:18 -0400
Received: by pdbni2 with SMTP id ni2so79325934pdb.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 22:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wp6616YszqB9ytoKxdapyVYvCDs0lotbfVuQVxMpft4=;
        b=RzYeQORfYEvEWHnEMJkn3kNZDRkBqAihTTAue5l0zvYJ/tzTLEGOYBnV7g+hbLYa1N
         VLMFxEDI6j+N4BcWJiva2BtxGzs2a0Vr91+d1a7rGiQS8JG0mr8386J0usQlnJ8X3YZu
         t+b1ehYGRv0/hkv6HXvM/v2JDLqYC8RUW0TRFYdWXlUyURkqoWyuLC2e02n0mFZXK4vT
         dKMuE3oreI09IEwgrG4LY43B+eHf9+mU5+t21DyauIAFA2H2toThCrSEdxSpaF66wAs9
         tVOBEtuEnRy3OmcHMiNYr/K6UnNqdd319kdHdXLiWv2KwJZ+6U0aT4gT+VuRrqG5765o
         +4Qw==
X-Received: by 10.66.254.34 with SMTP id af2mr68282046pad.1.1426569437956;
        Mon, 16 Mar 2015 22:17:17 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id h9sm6795753pdo.5.2015.03.16.22.17.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2015 22:17:17 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.307.gf3db8a5
In-Reply-To: <5507B7EE.1070403@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265606>

Modify sha1_loose_object_info() to support 'cat-file --literally'
by accepting flags and also make changes to copy the type to
object_info::typename.

Add parse_sha1_header_extended() which acts as a wrapper around
parse_sha1_header() allowing for more information to be obtained
based on the given flags.

Add unpack_sha1_header_literally() to unpack sha1 headers of
unknown/corrupt objects which have a unknown sha1 header size.
This was written by Junio C Hamano but tested by me.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 sha1_file.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 97 insertions(+), 24 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 69a60ec..e31e9e2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1564,6 +1564,36 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
 	return git_inflate(stream, 0);
 }
 
+static int unpack_sha1_header_literally(git_zstream *stream, unsigned char *map,
+					unsigned long mapsize,
+					struct strbuf *header)
+{
+	unsigned char buffer[32], *cp;
+	unsigned long bufsiz = sizeof(buffer);
+	int status;
+
+	/* Get the data stream */
+	memset(stream, 0, sizeof(*stream));
+	stream->next_in = map;
+	stream->avail_in = mapsize;
+	stream->next_out = buffer;
+	stream->avail_out = bufsiz;
+
+	git_inflate_init(stream);
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
@@ -1609,32 +1639,24 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
 	return NULL;
 }
 
-/*
- * We used to just use "sscanf()", but that's actually way
- * too permissive for what we want to check. So do an anal
- * object header parse by hand.
- */
-int parse_sha1_header(const char *hdr, unsigned long *sizep)
+int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
+			       int flags)
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
@@ -1652,12 +1674,45 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 			size = size * 10 + c;
 		}
 	}
-	*sizep = size;
+
+	type = type_from_string_gently(typename.buf, -1, 1);
+	if (oi->sizep)
+		*oi->sizep = size;
+	if (oi->typename)
+		strbuf_addstr(oi->typename, typename.buf);
+	if (oi->typep)
+		*oi->typep = type;
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
 
 	/*
 	 * The length must be followed by a zero byte
 	 */
-	return *hdr ? -1 : type_from_string(type);
+	return *hdr ? -1 : type;
+}
+
+/*
+ * We used to just use "sscanf()", but that's actually way
+ * too permissive for what we want to check. So do an anal
+ * object header parse by hand. Calls the extended function.
+ */
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
@@ -2524,13 +2579,15 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 }
 
 static int sha1_loose_object_info(const unsigned char *sha1,
-				  struct object_info *oi)
+				  struct object_info *oi,
+				  int flags)
 {
-	int status;
+	int status = 0;
 	unsigned long mapsize, size;
 	void *map;
 	git_zstream stream;
 	char hdr[32];
+	struct strbuf hdrbuf = STRBUF_INIT;
 
 	if (oi->delta_base_sha1)
 		hashclr(oi->delta_base_sha1);
@@ -2557,17 +2614,29 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 		return -1;
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
-	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
-		status = error("unable to unpack %s header",
-			       sha1_to_hex(sha1));
-	else if ((status = parse_sha1_header(hdr, &size)) < 0)
-		status = error("unable to parse %s header", sha1_to_hex(sha1));
-	else if (oi->sizep)
+	if ((flags & LOOKUP_LITERALLY)) {
+		if (unpack_sha1_header_literally(&stream, map, mapsize, &hdrbuf) < 0)
+			status = error("unable to unpack %s header with --literally",
+				       sha1_to_hex(sha1));
+		else if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
+			status = error("unable to parse %s header", sha1_to_hex(sha1));
+	} else {
+		if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+			status = error("unable to unpack %s header",
+				       sha1_to_hex(sha1));
+		else if ((status = parse_sha1_header(hdr, &size)) < 0)
+			status = error("unable to parse %s header", sha1_to_hex(sha1));
+	}
+	if (oi->sizep)
 		*oi->sizep = size;
 	git_inflate_end(&stream);
 	munmap(map, mapsize);
 	if (oi->typep)
 		*oi->typep = status;
+	if (oi->typename && !(oi->typename->len))
+		strbuf_addstr(oi->typename, typename(status));
+	if (hdrbuf.buf)
+		strbuf_release(&hdrbuf);
 	return 0;
 }
 
@@ -2588,13 +2657,15 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
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
@@ -2618,6 +2689,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
 					 rtype == OBJ_OFS_DELTA);
 	}
+	if (oi->typename)
+		strbuf_addstr(oi->typename, typename(rtype));
 
 	return 0;
 }
-- 
2.3.1.307.gf3db8a5
