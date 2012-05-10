From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/9] apply: fall back on three-way merge
Date: Thu, 10 May 2012 15:32:49 -0700
Message-ID: <1336689173-15822-6-git-send-email-gitster@pobox.com>
References: <1336689173-15822-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 00:33:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSbvZ-0006Py-3v
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 00:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620Ab2EJWdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 18:33:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36695 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932535Ab2EJWdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 18:33:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F70D8433
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JqFS
	cGbaQdLDD5QZl0K9o1wlxmo=; b=IdGxl92g+kSv1jypWF5HEIl8Ovhhfn/oYBdp
	dBmhVLRUuz5Q58HtaPHtWosdfMvXNRx6N1maYa6/XFiRPfR7OXDjzEqNt7w9cjhs
	Vqwbdp4PZhq5oc0NOMECEBLW6jafqYeENAb0FZ/cDQLTmPqH0h30tSJtR2MYl3SB
	Ghf8pHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=V2AqwN
	EaQtysPfrrF4wFL/JbbyS3BEDIkgZJ1sLV5tMiW7p1D46swUNKNNgxPhrc2Bjzhr
	+c3rbe8njDRBRBVwFslLl8qwL5yrwjzVBt8rLcv6tgpB76XSILzmDRTKH9aBBsxA
	MSWvSMIwUKXt/2yPPN1xCxTXfo378VggECbDQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 979258432
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 265348431 for
 <git@vger.kernel.org>; Thu, 10 May 2012 18:33:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.574.g840b38f
In-Reply-To: <1336689173-15822-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1C12F626-9AF0-11E1-839D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197645>

Grab the preimage blob the patch claims to be based on out of the object
store, apply the patch, and then call three-way-merge function.  This step
still does not plug the actual three-way merge logic yet, but we are
getting there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index fcd5bdf..1fe178f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3073,10 +3073,51 @@ static int load_preimage(struct image *image,
 	return 0;
 }
 
+static int three_way_merge(struct image *image,
+			   char *path,
+			   unsigned char *base,
+			   unsigned char *ours,
+			   unsigned char *theirs)
+{
+	return -1; /* for now */
+}
+
 static int try_threeway_fallback(struct image *image, struct patch *patch,
 				 struct stat *st, struct cache_entry *ce)
 {
-	return -1; /* for now */
+	unsigned char pre_sha1[20], post_sha1[20], our_sha1[20];
+	struct strbuf buf = STRBUF_INIT;
+	size_t len;
+	char *img;
+	struct image tmp_image;
+
+	/* No point falling back to 3-way merge in these cases */
+	if (patch->is_new || patch->is_delete ||
+	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode))
+		return -1;
+
+	/* Preimage the patch was prepared for */
+	if (get_sha1(patch->old_sha1_prefix, pre_sha1) ||
+	    read_blob_object(&buf, pre_sha1, patch->old_mode))
+		return error("repository lacks the necessary blob to fall back on 3-way merge.");
+	img = strbuf_detach(&buf, &len);
+	prepare_image(&tmp_image, img, len, 1);
+	/* Apply the patch to get the post image */
+	if (apply_fragments(&tmp_image, patch) < 0) {
+		clear_image(&tmp_image);
+		return -1;
+	}
+	hash_sha1_file(tmp_image.buf, tmp_image.len, blob_type, post_sha1);
+	clear_image(&tmp_image);
+
+	/* pre_sha1[] is common, post_sha1[] is theirs */
+	load_preimage(&tmp_image, patch, st, ce);
+	hash_sha1_file(tmp_image.buf, tmp_image.len, blob_type, our_sha1);
+	clear_image(&tmp_image);
+
+	/* in-core three-way merge between post and our using pre as base */
+	return three_way_merge(image,
+			       patch->new_name, pre_sha1, our_sha1, post_sha1);
 }
 
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
-- 
1.7.10.1.574.g840b38f
