From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/11] streaming: read non-delta incrementally from a pack
Date: Thu, 19 May 2011 14:33:44 -0700
Message-ID: <1305840826-7783-10-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAsG-00074u-Jr
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934863Ab1ESVfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:35:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934853Ab1ESVeK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:34:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E63E52BD
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2d7B
	ulckC9lhWG90dU1WH7TwUJs=; b=EF8omM8hlqbk+jg82yCNz5+5kTevyZ3wobTX
	qnsrvDmVwG5W6rkGKtpYBN8cnOlIHvpb+g7SKQXyCK1en/sqnlhbwBmLY099wrIS
	B+3s+PeYY+4RA5sVk3RXjiL3v/bR/xHRVlCsBQVoSa6j5E9z5dumXdbJzdx6Yg2Y
	8AwrZjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DL45tH
	Px6lIpRLEJlQKFhU8jE7R7pangJ013w1yItgR/S2SwvmNvQmREaiw27c5MFVoDKP
	yAhu+SkyGoeXyukYAJfgdrUxx8g4Hi0422992KC3GN/F0BygSe1cUo9OrizUKBqP
	QZRzAUOm4hhLZWqNv3LfJ/niOUwiGr3s8REgI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1BE4E52BC
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 662F552BB for
 <git@vger.kernel.org>; Thu, 19 May 2011 17:36:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.416.gac10c8
In-Reply-To: <1305840826-7783-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 07CB19CC-8260-11E0-B6F9-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174021>

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 streaming.c |  105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/streaming.c b/streaming.c
index 84330b4..fbe8eb6 100644
--- a/streaming.c
+++ b/streaming.c
@@ -52,6 +52,8 @@ struct git_istream {
 	enum input_source source;
 	const struct stream_vtbl *vtbl;
 	unsigned long size; /* inflated size of full object */
+	z_stream z;
+	enum { z_unused, z_used, z_done, z_error } z_state;
 
 	union {
 		struct {
@@ -65,8 +67,8 @@ struct git_istream {
 		} loose;
 
 		struct {
-			int fd; /* open for reading */
-			/* NEEDSWORK: what else? */
+			struct packed_git *pack;
+			off_t pos;
 		} in_pack;
 	} u;
 };
@@ -130,6 +132,20 @@ struct git_istream *open_istream(const unsigned char *sha1,
 	return st;
 }
 
+
+/*****************************************************************
+ *
+ * Common helpers
+ *
+ *****************************************************************/
+
+static void close_deflated_stream(struct git_istream *st)
+{
+	if (st->z_state == z_used)
+		git_inflate_end(&st->z);
+}
+
+
 /*****************************************************************
  *
  * Loose object stream
@@ -148,9 +164,92 @@ static open_method_decl(loose)
  *
  *****************************************************************/
 
+static read_method_decl(pack_non_delta)
+{
+	size_t total_read = 0;
+
+	switch (st->z_state) {
+	case z_unused:
+		memset(&st->z, 0, sizeof(st->z));
+		git_inflate_init(&st->z);
+		st->z_state = z_used;
+		break;
+	case z_done:
+		return 0;
+	case z_error:
+		return -1;
+	case z_used:
+		break;
+	}
+
+	while (total_read < sz) {
+		int status;
+		struct pack_window *window = NULL;
+		unsigned char *mapped;
+
+		mapped = use_pack(st->u.in_pack.pack, &window,
+				  st->u.in_pack.pos, &st->z.avail_in);
+
+		st->z.next_out = (unsigned char *)buf + total_read;
+		st->z.avail_out = sz - total_read;
+		st->z.next_in = mapped;
+		status = git_inflate(&st->z, Z_FINISH);
+
+		st->u.in_pack.pos += st->z.next_in - mapped;
+		total_read = st->z.next_out - (unsigned char *)buf;
+		unuse_pack(&window);
+
+		if (status == Z_STREAM_END) {
+			git_inflate_end(&st->z);
+			st->z_state = z_done;
+			break;
+		}
+		if (status != Z_OK && status != Z_BUF_ERROR) {
+			git_inflate_end(&st->z);
+			st->z_state = z_error;
+			return -1;
+		}
+	}
+	return total_read;
+}
+
+static close_method_decl(pack_non_delta)
+{
+	close_deflated_stream(st);
+	return 0;
+}
+
+static struct stream_vtbl pack_non_delta_vtbl = {
+	close_istream_pack_non_delta,
+	read_istream_pack_non_delta,
+};
+
 static open_method_decl(pack_non_delta)
 {
-	return -1; /* for now */
+	struct pack_window *window;
+	enum object_type in_pack_type;
+
+	st->u.in_pack.pack = oi->u.packed.pack;
+	st->u.in_pack.pos = oi->u.packed.offset;
+	window = NULL;
+
+	in_pack_type = unpack_object_header(st->u.in_pack.pack,
+					    &window,
+					    &st->u.in_pack.pos,
+					    &st->size);
+	unuse_pack(&window);
+	switch (in_pack_type) {
+	default:
+		return -1; /* we do not do deltas for now */
+	case OBJ_COMMIT:
+	case OBJ_TREE:
+	case OBJ_BLOB:
+	case OBJ_TAG:
+		break;
+	}
+	st->z_state = z_unused;
+	st->vtbl = &pack_non_delta_vtbl;
+	return 0;
 }
 
 
-- 
1.7.5.1.416.gac10c8
