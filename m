From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] sha1_file.c: "legacy" is really the current format
Date: Wed, 08 Jun 2011 11:29:01 -0700
Message-ID: <7vaads2n4i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 20:29:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNVB-0006Yv-RG
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab1FHS3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:29:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab1FHS3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:29:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F4F85642;
	Wed,  8 Jun 2011 14:31:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=K
	gas0ZFer8lWUc2Ez4G/1Y5O3/g=; b=JTXihkUEjrF0mUapbiNRtr4VkZpK4E4qM
	E+5XSpG7eXX5EhARLTwhwZ0WHxjwdkmJ6VpY6JpQEXqSF2j9mVqVwUiobfTQhOM9
	HKIJCAppajQIJ4WW73zol5fk1jLtlP9WyuAtlvPLUflvjMfj+4wcrp9tIDKjjvJI
	C5/8YHNOYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=fge
	IMQx6aWzMWnI8ALhLEC/bqN3FxmMq3HIWHL1qAuaFLFApUbk2EsnkgJTGMfYaWe3
	E4q7s0Ulkw8aUnN8TRlBlGX124kJLSrAZS7GS1H6qj0rDIZaGN6y/nOseexViHzh
	b/owbC8yaoc+0XFAvgkU7Nd0Q3TolLaDSp6wSwhk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A355563F;
	Wed,  8 Jun 2011 14:31:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 35560563E; Wed,  8 Jun 2011
 14:31:12 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E23CAEA-91FD-11E0-9208-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175418>

Every time I look at the read-loose-object codepath, legacy_loose_object()
function makes my brain go through mental contortion. When we were playing
with the experimental loose object format, it may have made sense to call
the traditional format "legacy", in the hope that the experimental one
will some day replace it to become official, but it never happened.

This renames the function (and negates its return value) to detect if we
are looking at the experimental format, and move the code around in its
caller which used to do "if we are looing at legacy, do this special case,
otherwise the normal case is this". The codepath to read from the loose
objects in experimental format is the "unlikely" case.

Someday after Git 2.0, we should drop the support of this format.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |   62 +++++++++++++++++++++++++++++++---------------------------
 1 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 064a330..697f4a4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1205,20 +1205,29 @@ static void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 	return map;
 }
 
-static int legacy_loose_object(unsigned char *map)
+/*
+ * There used to be a second loose object header format which
+ * was meant to mimic the in-pack format, allowing for direct
+ * copy of the object data.  This format turned up not to be
+ * really worth it and we no longer write loose objects in that
+ * format.
+ */
+static int experimental_loose_object(unsigned char *map)
 {
 	unsigned int word;
 
 	/*
 	 * Is it a zlib-compressed buffer? If so, the first byte
 	 * must be 0x78 (15-bit window size, deflated), and the
-	 * first 16-bit word is evenly divisible by 31
+	 * first 16-bit word is evenly divisible by 31. If so,
+	 * we are looking at the official format, not the experimental
+	 * one.
 	 */
 	word = (map[0] << 8) + map[1];
 	if (map[0] == 0x78 && !(word % 31))
-		return 1;
-	else
 		return 0;
+	else
+		return 1;
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
@@ -1262,34 +1271,29 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	stream->next_out = buffer;
 	stream->avail_out = bufsiz;
 
-	if (legacy_loose_object(map)) {
-		git_inflate_init(stream);
-		return git_inflate(stream, 0);
-	}
-
+	if (experimental_loose_object(map)) {
+		/*
+		 * The old experimental format we no longer produce;
+		 * we can still read it.
+		 */
+		used = unpack_object_header_buffer(map, mapsize, &type, &size);
+		if (!used || !valid_loose_object_type[type])
+			return -1;
+		map += used;
+		mapsize -= used;
 
-	/*
-	 * There used to be a second loose object header format which
-	 * was meant to mimic the in-pack format, allowing for direct
-	 * copy of the object data.  This format turned up not to be
-	 * really worth it and we don't write it any longer.  But we
-	 * can still read it.
-	 */
-	used = unpack_object_header_buffer(map, mapsize, &type, &size);
-	if (!used || !valid_loose_object_type[type])
-		return -1;
-	map += used;
-	mapsize -= used;
+		/* Set up the stream for the rest.. */
+		stream->next_in = map;
+		stream->avail_in = mapsize;
+		git_inflate_init(stream);
 
-	/* Set up the stream for the rest.. */
-	stream->next_in = map;
-	stream->avail_in = mapsize;
+		/* And generate the fake traditional header */
+		stream->total_out = 1 + snprintf(buffer, bufsiz, "%s %lu",
+						 typename(type), size);
+		return 0;
+	}
 	git_inflate_init(stream);
-
-	/* And generate the fake traditional header */
-	stream->total_out = 1 + snprintf(buffer, bufsiz, "%s %lu",
-					 typename(type), size);
-	return 0;
+	return git_inflate(stream, 0);
 }
 
 static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
