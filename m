From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 2/3] sha1_file: implement changes for "cat-file --literally -t"
Date: Tue,  3 Mar 2015 15:42:36 +0530
Message-ID: <1425377556-25332-1-git-send-email-karthik.188@gmail.com>
References: <54F5888B.7040400@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 11:12:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSjos-00052z-56
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 11:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbbCCKMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 05:12:49 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44004 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbbCCKMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 05:12:47 -0500
Received: by pablj1 with SMTP id lj1so13599745pab.10
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 02:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FRcxzVqnf/LddrrlObw/RD4LZyK4pmZu+SIgeEQ612w=;
        b=BuQfPDKY7U4u3e1nQFGudIjASVmbcOcw1vpOy/pzYFOfDmo1gdKP2wdQK5D3lxd/Rv
         Df6Ge3hPvWqGK94KUcxCdwjKf6q4jHBsPH7HVYRjkitYp912+/i56+Mk8n/30SEiJotZ
         2+lcujQgKq+lIrT6fQv0oC/VvSm8v6GC6gQmoieB2H2P0Ov6akd4dEONo96i5WIs8iv+
         q/0olgJZ1BSdw8Tx57NETD1rH+HNJlLx7Un+o4C30yLpvUG9OQg8zVSNyTTCPKUCi9AK
         zP/o1ZzcSmdY/Yi2y9MS+4GG0ThoJF5xNUQ36+QeyV3ct7kWz77/TkYGHOQLOPkMzMMQ
         NW7w==
X-Received: by 10.70.135.165 with SMTP id pt5mr53947288pdb.101.1425377567474;
        Tue, 03 Mar 2015 02:12:47 -0800 (PST)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id z1sm474630pdp.52.2015.03.03.02.12.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2015 02:12:46 -0800 (PST)
X-Mailer: git-send-email 2.3.1.169.ga243085.dirty
In-Reply-To: <54F5888B.7040400@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264644>

add "sha1_object_info_literally()" which is to be used when
the "literally" option is given to get the type of object
and print it, using "sha1_object_info_extended()".

add "unpack_sha1_header_literally()" to unpack sha headers
which may be greater than 32 bytes, which is the threshold
for a regular object header.

modify "sha1_loose_object_info()" to include a flag argument
and also include changes to call "unpack_sha1_header_literally()"
when the literally flag is passed. Also copies the obtained
type to the typename field of object_info.

modify "sha1_object_info_extended()" to call the function
"sha1_loose_object_info()" with flags.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 sha1_file.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 69a60ec..1068ca0 100644
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
@@ -2524,13 +2554,16 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
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
+	char *hdrp;
 
 	if (oi->delta_base_sha1)
 		hashclr(oi->delta_base_sha1);
@@ -2557,10 +2590,25 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 		return -1;
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
-	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
-		status = error("unable to unpack %s header",
-			       sha1_to_hex(sha1));
-	else if ((status = parse_sha1_header(hdr, &size)) < 0)
+	if ((flags & LOOKUP_LITERALLY)) {
+		if (unpack_sha1_header_literally(&stream, map, mapsize, &hdrbuf) < 0)
+			status = error("unable to unpack %s header with --literally",
+				       sha1_to_hex(sha1));
+		hdrp = hdrbuf.buf;
+	} else {
+		if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
+			status = error("unable to unpack %s header",
+				       sha1_to_hex(sha1));
+		}
+		hdrp = hdr;
+	}
+	if (status)
+		; /* We're already checking for errors */
+	else if ((flags & LOOKUP_LITERALLY)) {
+		size_t typelen = strcspn(hdrbuf.buf, " ");
+		strbuf_add(oi->typename, hdrbuf.buf, typelen);
+	}
+	else if ((status = parse_sha1_header(hdrp, &size)) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
 	else if (oi->sizep)
 		*oi->sizep = size;
@@ -2568,6 +2616,10 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	munmap(map, mapsize);
 	if (oi->typep)
 		*oi->typep = status;
+	if (oi->typename && 0 <= status && typename(status))
+		strbuf_addstr(oi->typename, typename(status));
+	if (hdrp == hdrbuf.buf)
+		strbuf_release(&hdrbuf);
 	return 0;
 }
 
@@ -2594,7 +2646,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi)) {
+		if (!sha1_loose_object_info(real, oi, flags)) {
 			oi->whence = OI_LOOSE;
 			return 0;
 		}
@@ -2635,6 +2687,24 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 	return type;
 }
 
+int sha1_object_info_literally(const unsigned char *sha1)
+{
+	enum object_type type;
+	struct strbuf sb = STRBUF_INIT;
+	struct object_info oi = {NULL};
+
+	oi.typename = &sb;
+	oi.typep = &type;
+	if (sha1_object_info_extended(sha1, &oi, LOOKUP_LITERALLY) < 0)
+		return -1;
+	if (*oi.typep > 0)
+		printf("%s\n", typename(*oi.typep));
+	else
+		printf("%s\n", oi.typename->buf);
+	strbuf_release(oi.typename);
+	return 0;
+}
+
 static void *read_packed_sha1(const unsigned char *sha1,
 			      enum object_type *type, unsigned long *size)
 {
-- 
2.3.1.169.ga243085.dirty
