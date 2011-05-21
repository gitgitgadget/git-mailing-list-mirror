From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/12] streaming: read loose objects incrementally
Date: Fri, 20 May 2011 23:56:35 -0700
Message-ID: <1305960995-25738-13-git-send-email-gitster@pobox.com>
References: <1305960995-25738-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:58:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg8Y-0006Q2-3F
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab1EUG6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:58:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab1EUG6F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:58:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1BCA55DD8
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:00:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0O8d
	5PWMSMOVSSiBqRMEzjklTaA=; b=gzF+ayHgsNLm62zbkzrKtvyKHG2x3dmuuVA9
	tN4w7K6hLbT9/nfUoEZLU3rga6gjCW0BMApxSFVIw6IrHJqoK0iBRbqGk3PwnVH3
	wrimJQ9XKfnSEO35azfs4DRl1HPyAO7MKlSgUE3K+lCVX8AzOjU04e5Ybeihrgyn
	YatXVn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=MygIqP
	HcB9mPX3nXKrGS31Hk7ut9eVEdOXolj6UXCzFEFmGli2gYA9pKgc/+bYbzb2nDvd
	D28EcREwY4OUQANxZ8UnJ/oahjUne4/7Q4JW8Wzqco7KNeWM0A0v6RBNkVUO5d2Z
	dKqLxv3bUyQuCtUFk1gjeE+7+7stJ6a8gYqLQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 164E55DD7
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:00:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1BF955DD6 for
 <git@vger.kernel.org>; Sat, 21 May 2011 03:00:09 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305960995-25738-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F83A6742-8377-11E0-9DC1-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174106>

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 streaming.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/streaming.c b/streaming.c
index 4fdd567..0602926 100644
--- a/streaming.c
+++ b/streaming.c
@@ -61,8 +61,11 @@ struct git_istream {
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
@@ -150,9 +153,85 @@ static void close_deflated_stream(struct git_istream *st)
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
+	parse_sha1_header(st->u.loose.hdr, &st->size);
+	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
+	st->u.loose.hdr_avail = st->z.total_out;
+	st->z_state = z_used;
+
+	st->vtbl = &loose_vtbl;
+	return 0;
 }
 
 
-- 
1.7.5.2.369.g8fc017
