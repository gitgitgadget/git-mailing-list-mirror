From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/6] bulk-checkin: allow the same data to be multiply
 hashed
Date: Thu,  1 Dec 2011 16:40:47 -0800
Message-ID: <1322786449-25753-5-git-send-email-gitster@pobox.com>
References: <1322699263-14475-6-git-send-email-gitster@pobox.com>
 <1322786449-25753-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 01:41:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWHCG-0007B0-LC
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 01:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185Ab1LBAli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 19:41:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50061 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755770Ab1LBAlA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 19:41:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 327AF6B31
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 19:41:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zIpq
	d7MFgzHGK3dK7Dowy2x1VGI=; b=thy1GEh/Lxx7BDAmsBOiFxR6lFGjKH6f4e8+
	5RZ8iflD4c0ONWUkZ34AbmYQAEAd2Gzi4cgpDAtbBxbWvzDbmiKFQII2JjLEkCpQ
	K+Eznh0avEaUCWUbp6rvTmUScIQsdiCwYBtwDCk8jqJ69ELLOeEIxQekAJ+SVaIb
	l5MiiV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=EBbqVu
	YhrMsMu31bPJjUbUCG/stAJXtlLCr6zkqhgy3AXejgG2w7Yy55C43AEuF7grQm/9
	EFcWQHD/hDdhEEmA8Urzk6ZK8gmVw2DMF7VZCJ5mHlqim9YhHkFvRQuw7P4EHw7+
	s+P7vkzXwlK4GqxkgfpVvMgh5KW7q0Nltyv/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28D0B6B30
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 19:41:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FD106B2D for
 <git@vger.kernel.org>; Thu,  1 Dec 2011 19:40:59 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.177.g4d64
In-Reply-To: <1322786449-25753-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4DE2BED4-1C7E-11E1-974E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186206>

This updates stream_to_pack() machinery to feed the data it is writing out
to multiple hash contexts at the same time. Right now we only use a single
git_SHA_CTX, so there is no change in functionality.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bulk-checkin.c |   33 +++++++++++++++++++++++++--------
 1 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6b0b6d4..6f1ce58 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -75,6 +75,20 @@ static int already_written(struct bulk_checkin_state *state, unsigned char sha1[
 	return 0;
 }
 
+struct chunk_ctx {
+	struct chunk_ctx *up;
+	git_SHA_CTX ctx;
+};
+
+static void chunk_SHA1_Update(struct chunk_ctx *ctx,
+			      const unsigned char *buf, size_t size)
+{
+	while (ctx) {
+		git_SHA1_Update(&ctx->ctx, buf, size);
+		ctx = ctx->up;
+	}
+}
+
 /*
  * Read the contents from fd for size bytes, streaming it to the
  * packfile in state while updating the hash in ctx. Signal a failure
@@ -91,7 +105,7 @@ static int already_written(struct bulk_checkin_state *state, unsigned char sha1[
  * with a new pack.
  */
 static int stream_to_pack(struct bulk_checkin_state *state,
-			  git_SHA_CTX *ctx, off_t *already_hashed_to,
+			  struct chunk_ctx *ctx, off_t *already_hashed_to,
 			  int fd, size_t size, enum object_type type,
 			  const char *path, unsigned flags)
 {
@@ -123,7 +137,7 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 				if (rsize < hsize)
 					hsize = rsize;
 				if (hsize)
-					git_SHA1_Update(ctx, ibuf, hsize);
+					chunk_SHA1_Update(ctx, ibuf, hsize);
 				*already_hashed_to = offset;
 			}
 			s.next_in = ibuf;
@@ -185,10 +199,11 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 			   unsigned char result_sha1[],
 			   int fd, size_t size,
 			   enum object_type type, const char *path,
-			   unsigned flags)
+			   unsigned flags,
+			   struct chunk_ctx *up)
 {
 	off_t seekback, already_hashed_to;
-	git_SHA_CTX ctx;
+	struct chunk_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
 	struct sha1file_checkpoint checkpoint;
@@ -200,8 +215,10 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 
 	header_len = sprintf((char *)obuf, "%s %" PRIuMAX,
 			     typename(type), (uintmax_t)size) + 1;
-	git_SHA1_Init(&ctx);
-	git_SHA1_Update(&ctx, obuf, header_len);
+	memset(&ctx, 0, sizeof(ctx));
+	ctx.up = up;
+	git_SHA1_Init(&ctx.ctx);
+	git_SHA1_Update(&ctx.ctx, obuf, header_len);
 
 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & HASH_WRITE_OBJECT) != 0)
@@ -232,7 +249,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
-	git_SHA1_Final(result_sha1, &ctx);
+	git_SHA1_Final(result_sha1, &ctx.ctx);
 	if (!idx)
 		return 0;
 
@@ -256,7 +273,7 @@ int index_bulk_checkin(unsigned char *sha1,
 		       const char *path, unsigned flags)
 {
 	int status = deflate_to_pack(&state, sha1, fd, size, type,
-				     path, flags);
+				     path, flags, NULL);
 	if (!state.plugged)
 		finish_bulk_checkin(&state);
 	return status;
-- 
1.7.8.rc4.177.g4d64
