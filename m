From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/11] streaming: read non-delta incrementally from a pack
Date: Sun, 15 May 2011 17:30:29 -0700
Message-ID: <1305505831-31587-10-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:31:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLliV-0004Hp-7a
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab1EPAa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 20:30:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab1EPAay (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 20:30:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F2BC5F94
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:33:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=CoMD
	LfRvOZJFM1g3usB0WPQ86kk=; b=drPaXKrwD/ZPoYhaGowcr1suakZ3+zxwDlya
	1csFZBsBgXT6FaMvZBZubAppxmZnOaolGw2OVDfQrHA55rN1bjw3Zxicw0iUIIHd
	q3RUl6YYkDKjkzQOejA+LqcQM2VUIq+KzshxNsfstLzFHKPTn/KpqCmin6nBZk4Y
	2wBSSYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=npbpH/
	aHxb1u/9vt1Ys9c3lq9QPi2xWXGPs+Umi336fcPMkrDaeF5z9/5EO5vz00YXP/zb
	gSTtm91tU3Z4HjfpUCBGyD8qijNeF9BQbXvTNnRAadzCBcTxN/L+6uyTeh8vcsZL
	J6lGH+lK/EWFuRH36HmdFAZ9n2+fqoYuUqtxI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8CF485F92
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:33:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D14C75F91 for
 <git@vger.kernel.org>; Sun, 15 May 2011 20:33:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.365.g32b65
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0E499148-7F54-11E0-B1EE-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173694>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 streaming.c |  107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/streaming.c b/streaming.c
index e03a374..0f85bd8 100644
--- a/streaming.c
+++ b/streaming.c
@@ -60,10 +60,13 @@ struct git_istream {
 		} loose;
 
 		struct {
-			int fd; /* open for reading */
-			/* NEEDSWORK: what else? */
+			struct packed_git *pack;
+			off_t pos;
+			unsigned long sz;
 		} in_pack;
 	} u;
+	z_stream z;
+	enum { z_unused, z_used, z_done, z_error } z_state;
 };
 
 int close_istream(struct git_istream *st)
@@ -126,6 +129,20 @@ struct git_istream *open_istream(const unsigned char *sha1,
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
@@ -144,9 +161,93 @@ static open_method_decl(loose)
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
+					    &st->u.in_pack.sz);
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
+
+	st->z_state = z_unused;
+	st->vtbl = &pack_non_delta_vtbl;
+	return 0;
 }
 
 
-- 
1.7.5.1.365.g32b65
