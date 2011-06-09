From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] unpack_sha1_file(): zlib can only process 4GB at a time
Date: Thu, 09 Jun 2011 13:15:30 -0700
Message-ID: <7vpqmmwyl9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 22:15:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUldl-0003lf-7H
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 22:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab1FIUPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 16:15:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab1FIUPf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 16:15:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3A575510;
	Thu,  9 Jun 2011 16:17:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=8
	fGktv+wJ+ccFFQkPsy5BlmjF8k=; b=p+o5zvwUWPmXlKvFH9uWxaeujzs7JKRNS
	jOfLm+UeSlNRWxupdhm6BNacBjY3BfHKskOkngas9GTBUoztbFwO/bC5f6poPMsx
	iCge3ByqGYkg9ItGD6sfBO3709gGhVhkTV5ehwKPuH2L5GD8ilhNFPon00/FTr1R
	pyguOlXXTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=r5c
	blW3mdeUQrNVR6khcb7xGfVqi8RYlN5huXMC7Yd4cRR0/NeOkRfFTwn0Srj9HY/9
	quhyH832coO57IzXrNhU9f4yhW6vysOdnx+p1t8G8E8lagDIuFm4UOQ4gtOQAgZR
	PXXrO+KMMeHmy58zdJsgVKecItMtukbzg1e8Y7gU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 91CC3550F;
	Thu,  9 Jun 2011 16:17:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B2938550E; Thu,  9 Jun 2011
 16:17:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 886435D4-92D5-11E0-9D86-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175574>

The same theme as "unpack-objects" patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * On a beefy enough machine, you could register a large binary blob
   and run fsck, fetch, or push to play with that object with these
   patches, but there are many more places that aren't safe.

   I seem to have caught a nasty cold, so this will be the end of the
   series from me for today.  At least that is what I plan for now.

 sha1_file.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 12a166f..ab9e962 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1257,7 +1257,7 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
 	stream->next_in = map;
-	stream->avail_in = mapsize;
+	stream->avail_in = zlib_buf_cap(mapsize);
 	stream->next_out = buffer;
 	stream->avail_out = bufsiz;
 
@@ -1291,11 +1291,12 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	return 0;
 }
 
-static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
+static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long mapsize,
+			      unsigned long size, const unsigned char *sha1)
 {
-	int bytes = strlen(buffer) + 1;
+	unsigned long bytes = strlen(buffer) + 1;
 	unsigned char *buf = xmallocz(size);
-	unsigned long n;
+	unsigned long n, bytes_to_produce, bytes_to_consume;
 	int status = Z_OK;
 
 	n = stream->total_out - bytes;
@@ -1303,6 +1304,8 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
 		n = size;
 	memcpy(buf, (char *) buffer + bytes, n);
 	bytes = n;
+
+	bytes_to_consume = mapsize - stream->total_in;
 	if (bytes <= size) {
 		/*
 		 * The above condition must be (bytes <= size), not
@@ -1318,17 +1321,25 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
 		 * went well with status == Z_STREAM_END at the end.
 		 */
 		stream->next_out = buf + bytes;
-		stream->avail_out = size - bytes;
-		while (status == Z_OK)
+		bytes_to_produce = size - bytes;
+
+		while (status == Z_OK || status == Z_BUF_ERROR) {
+			unsigned char *in0 = stream->next_in;
+			unsigned char *out0 = stream->next_out;
+			stream->avail_in = zlib_buf_cap(bytes_to_consume);
+			stream->avail_out = zlib_buf_cap(bytes_to_produce);
 			status = git_inflate(stream, Z_FINISH);
+			bytes_to_produce -= stream->next_out - out0;
+			bytes_to_consume -= stream->next_in - in0;
+		}
 	}
-	if (status == Z_STREAM_END && !stream->avail_in) {
+	if (status == Z_STREAM_END && !bytes_to_consume) {
 		git_inflate_end(stream);
 		return buf;
 	}
 
 	if (status < 0)
-		error("corrupt loose object '%s'", sha1_to_hex(sha1));
+		error("corrupt loose object '%s' %d", sha1_to_hex(sha1), status);
 	else if (stream->avail_in)
 		error("garbage at end of loose object '%s'",
 		      sha1_to_hex(sha1));
@@ -1397,7 +1408,7 @@ static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type
 	if (ret < Z_OK || (*type = parse_sha1_header(hdr, size)) < 0)
 		return NULL;
 
-	return unpack_sha1_rest(&stream, hdr, *size, sha1);
+	return unpack_sha1_rest(&stream, hdr, mapsize, *size, sha1);
 }
 
 unsigned long get_size_from_delta(struct packed_git *p,
-- 
1.7.6.rc1.118.ge175b4a
