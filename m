From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/11] streaming: read loose objects incrementally
Date: Sun, 15 May 2011 17:30:31 -0700
Message-ID: <1305505831-31587-12-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:31:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLliW-0004Hp-B6
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839Ab1EPAbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 20:31:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716Ab1EPAa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 20:30:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A4195F9A
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:33:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=eQbG
	BV91U+DrUVj8TuaAUHcd3GU=; b=WMAgkD6en7TvazxQMLx+zbttrwk/B5nvXyZR
	6kZhf0xvKe1skvm0bousFSu6NbAMfp4lgxa8HXtA3PVB2Py6o0+RFYveDM07FFlj
	7cn6zY8k9HtvBdwOWYLJmfXNRGHxW+g1u/TfZ6vmkGtpJw88nt5nxxIpwExbGPyK
	O0mR0EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=j/smpi
	lTTL7EpjDo8IzoRnyFIiqxfuOc2cbA2XY+UGV7m0LUvt8sECup9AWKt+owajTQze
	Jso9NDSuYFUYOscH0VF03kOdKfkmrbPZV2Op2P2YXMa6zOCYbyZRHkZMNKQxV6+e
	woFYS4FoV97PuP2kWSzwgynVNo7rYgwdRPiR4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 165765F99
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:33:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A1A25F98 for
 <git@vger.kernel.org>; Sun, 15 May 2011 20:33:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.365.g32b65
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 10FC6E38-7F54-11E0-B451-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173692>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 streaming.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/streaming.c b/streaming.c
index 0f85bd8..e732337 100644
--- a/streaming.c
+++ b/streaming.c
@@ -55,8 +55,11 @@ struct git_istream {
 		} incore;
 
 		struct {
-			int fd; /* open for reading */
-			/* NEEDSWORK: what else? */
+			void *mapped;
+			unsigned long mapsize;
+			char hdr[32];
+			int hdr_avail;
+			int hdr_used;
 		} loose;
 
 		struct {
@@ -149,9 +152,85 @@ static void close_deflated_stream(struct git_istream *st)
  *
  *****************************************************************/
 
+static read_method_decl(loose)
+{
+	size_t total_read = 0;
+
+	switch (st->z_state) {
+	case z_done:
+		return 0;
+	case z_error:
+		return -1;
+	default:
+		break;
+	}
+
+	if (st->u.loose.hdr_used < st->u.loose.hdr_avail) {
+		size_t to_copy = st->u.loose.hdr_avail - st->u.loose.hdr_used;
+		if (sz < to_copy)
+			to_copy = sz;
+		memcpy(buf, st->u.loose.hdr + st->u.loose.hdr_used, to_copy);
+		st->u.loose.hdr_used += to_copy;
+		total_read += to_copy;
+	}
+
+	while (total_read < sz) {
+		int status;
+
+		st->z.next_out = (unsigned char *)buf + total_read;
+		st->z.avail_out = sz - total_read;
+		status = git_inflate(&st->z, Z_FINISH);
+
+		total_read = st->z.next_out - (unsigned char *)buf;
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
+static close_method_decl(loose)
+{
+	close_deflated_stream(st);
+	munmap(st->u.loose.mapped, st->u.loose.mapsize);
+	return 0;
+}
+
+static struct stream_vtbl loose_vtbl = {
+	close_istream_loose,
+	read_istream_loose,
+};
+
 static open_method_decl(loose)
 {
-	return -1; /* for now */
+	st->u.loose.mapped = map_sha1_file(sha1, &st->u.loose.mapsize);
+	if (!st->u.loose.mapped)
+		return -1;
+	if (unpack_sha1_header(&st->z,
+			       st->u.loose.mapped,
+			       st->u.loose.mapsize,
+			       st->u.loose.hdr,
+			       sizeof(st->u.loose.hdr)) < 0) {
+		git_inflate_end(&st->z);
+		munmap(st->u.loose.mapped, st->u.loose.mapsize);
+		return -1;
+	}
+
+	/* bypass parse_sha1_header() as we know it is already valid */
+	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
+	st->u.loose.hdr_avail = st->z.total_out;
+	st->z_state = z_used;
+
+	st->vtbl = &loose_vtbl;
+	return 0;
 }
 
 
-- 
1.7.5.1.365.g32b65
