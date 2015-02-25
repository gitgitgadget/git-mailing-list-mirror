From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_file: Add sha1_object_type_literally and export it.
Date: Wed, 25 Feb 2015 14:44:21 -0800
Message-ID: <xmqqtwy9mx16.fsf@gitster.dls.corp.google.com>
References: <54EDACC9.5080204@gmail.com>
	<1424862460-13514-1-git-send-email-karthik.188@gmail.com>
	<xmqq61apoewr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 23:44:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQkgv-0003KP-CR
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 23:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbbBYWoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 17:44:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752953AbbBYWoX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 17:44:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF07E3B8CF;
	Wed, 25 Feb 2015 17:44:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RD+JIgpoyW0FoU150nFmD7ae8mM=; b=Msm/sZ
	2FnsaoQQLsW07i59G48xUXdFkbTFtIw/lZgrUARrASDA2KdxEv14db66zyOy15Ch
	uoid2BErmQphV2SuITJpM5oQ1sw3DLs46LL2HRGKTHJYItvlVvogDbAUrAy8xo7H
	ifDvIz6XCNV4dm/apOHKJrr2QR34JTeXpr/pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qAG5dIKcxz9S6bT6ZW+4b2I8Tyfdyu4o
	k75owuF/CAjr8fooAk0Cwej+hvd35PRgHlZMIUma1E8AzrxkvONTxbjhiw+s2hid
	caXSAd5Q9ef8irHAeB0FAHtZSuuVR9up5XfZxlBVhQueg75zGZsJjNJ01b4SM/qY
	PpN4tFF4DU4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6D963B8CE;
	Wed, 25 Feb 2015 17:44:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FE863B8CC;
	Wed, 25 Feb 2015 17:44:22 -0500 (EST)
In-Reply-To: <xmqq61apoewr.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 25 Feb 2015 13:32:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D76BAB88-BD3F-11E4-92DA-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264420>

Junio C Hamano <gitster@pobox.com> writes:

> Looking at how we collect information on normal objects, it may make
> more sense to model this after sha1_loose_object_info(), with a
> tweak to struct object_info datatype, and integrate it into
> sha1_object_info_extended() may make more sense, perhaps along the
> lines of the attached patch.
>
> The new helper would mimick what sha1_loose_object_info() is doing,
> in that it may be used to learn on-disk size, object size, typename
> string (returned in oi->typename strbuf that is optional).  There is
> no sensible value to stuff in oi->typep if the incoming object name
> refers to the experimental invalid object, so perhaps you will store
> OBJ_NONE or something there and the "cat-file --literally" would use
> the oi->typename to learn the name of the "type".

You may be able to even reuse most of the sha1_loose_object_info()
by doing something like this illustration (read: incomplete) patch:

 * add an optional typename pointer to object_info request structure
   for the caller to ask sha1_object_info() to fill.

 * unpack_sha1_header() takes advantage of the fact that the object
   header of a usual object of known type would fit within 32 bytes,
   and that otherwise the object is invalid anyway.  A literal
   reader cannot afford to rely on these assumptions, so introduce a
   reader that can read into a strbuf, and use it instead from
   sha1_loose_object_info() when the caller wants to deal with
   invalid object with a possibly overlong header.

 * teach sha1_object_info_extended() pass the "flags" parameter from
   the caller down the callchain to sha1_loose_object_info().


 cache.h     |  3 ++-
 sha1_file.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 4d02efc..34ede34 100644
--- a/cache.h
+++ b/cache.h
@@ -828,8 +828,8 @@ char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
 extern int is_ntfs_dotgit(const char *name);
 
-/* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
+#define LOOKUP_LITERALLY      2
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
 static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
@@ -1296,6 +1296,7 @@ struct object_info {
 	unsigned long *sizep;
 	unsigned long *disk_sizep;
 	unsigned char *delta_base_sha1;
+	struct strbuf *typename;
 
 	/* Response */
 	enum {
diff --git a/sha1_file.c b/sha1_file.c
index 69a60ec..0f6783e 100644
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
+				  unsigned flags)
 {
 	int status;
 	unsigned long mapsize, size;
 	void *map;
 	git_zstream stream;
 	char hdr[32];
+	struct strbuf hdrbuf = STRBUF_INIT;
+	char *hdrp;
 
 	if (oi->delta_base_sha1)
 		hashclr(oi->delta_base_sha1);
@@ -2557,10 +2590,21 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 		return -1;
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
-	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
-		status = error("unable to unpack %s header",
-			       sha1_to_hex(sha1));
-	else if ((status = parse_sha1_header(hdr, &size)) < 0)
+	if ((flags & LOOKUP_LITERALLY)) {
+		if (unpack_sha1_header_literally(&stream, map, mapsize, &hdrbuf) < 0)
+			status = error("unable to unpack %s header",
+				       sha1_to_hex(sha1));
+		hdrp = hdrbuf.buf;
+	} else {
+		if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+			status = error("unable to unpack %s header",
+				       sha1_to_hex(sha1));
+		hdrp = hdr;
+	}
+
+	if (status)
+		; /* we already have error condition */
+	else if ((status = parse_sha1_header(hdrp, &size)) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
 	else if (oi->sizep)
 		*oi->sizep = size;
@@ -2568,6 +2612,16 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	munmap(map, mapsize);
 	if (oi->typep)
 		*oi->typep = status;
+	if (oi->typename) {
+		if (0 <= status && typename(status))
+			strbuf_addstr(oi->typename, typename(status));
+		else if ((flags & LOOKUP_LITERALLY)) {
+			size_t typelen = strcspn(hdrbuf.buf, " ");
+			strbuf_add(oi->typename, hdrbuf.buf, typelen);
+		}
+	}
+	if (hdrp == hdrbuf.buf)
+		strbuf_release(&hdrbuf);
 	return 0;
 }
 
@@ -2594,7 +2648,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi)) {
+		if (!sha1_loose_object_info(real, oi, flags)) {
 			oi->whence = OI_LOOSE;
 			return 0;
 		}
