From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/8] apply: fall back on three-way merge
Date: Wed,  9 May 2012 23:02:23 -0700
Message-ID: <1336629745-22436-7-git-send-email-gitster@pobox.com>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 08:03:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMSv-0002NM-L2
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672Ab2EJGCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 02:02:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755504Ab2EJGCq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 02:02:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9ECD5FE1
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=NhLT
	4HKx5tTvABrQgHtYMGj7dHc=; b=pR/fkJhuANJWhhK4owLwq+mKOdWZBj1CKE/d
	M8QABT2e+l9pmDwNooo3vk7IIbxJmEwMOaRC8A8xzh4UegRlCR21idCb4fa4bXJX
	0PERvZYwqDOUaf1eOZ0b9FE13PRg3zah9G+JjcKzIRaveKkux3Esf5p//m9y+lF3
	7p8yK6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=t+yGRq
	huCxJUcjZgts6c/RKSWz9UXyMBTqFRcwey7+DkgqeUydVCKo+rLrmVoVXayiWMNw
	OtQDOYFc2WX9jcukxleRYbKResG9+iD3nSgYmcFih2x73T2TA1cVWMQ/+pQkC7XI
	g74BawcnpRLUwM1ZT1vIWNYe0IL9en+ssRI4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1FBE5FE0
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34F675FDD for
 <git@vger.kernel.org>; Thu, 10 May 2012 02:02:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.562.gfc79b1c
In-Reply-To: <1336629745-22436-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C26F20AC-9A65-11E1-8104-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197541>

Grab the preimage blob the patch claims to be based on out of the object
store, apply the patch, and then call three-way-merge function.

This step does not plug the actual three-way merge logic yet, but we are
getting there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b1dd23c..798a634 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3073,11 +3073,53 @@ static int load_preimage(struct image *image,
 	return 0;
 }
 
-static int try_threeway_fallback(struct image *image, struct patch *patch)
+static int three_way_merge(struct image *image,
+			   char *path,
+			   unsigned char *base,
+			   unsigned char *ours,
+			   unsigned char *theirs)
 {
 	return -1; /* for now */
 }
 
+static int try_threeway_fallback(struct image *image, struct patch *patch,
+				 struct stat *st, struct cache_entry *ce)
+{
+	unsigned char pre_sha1[20], post_sha1[20], our_sha1[20];
+	struct strbuf buf = STRBUF_INIT;
+	size_t len;
+	char *img;
+	struct image tmp_image;
+
+	/* No point falling back to 3-way merge in these cases */
+	if (patch->is_binary || patch->is_new || patch->is_delete ||
+	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode))
+		return -1;
+
+	/* Preimage the patch was prepared for */
+	if (get_sha1(patch->old_sha1_prefix, pre_sha1) ||
+	    read_blob_object(&buf, pre_sha1, patch->old_mode))
+		return error("repository lacks necessary blobs to fall back on 3-way merge.");
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
+}
+
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	struct image image;
@@ -3087,7 +3129,7 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 
 	if (apply_fragments(&image, patch) < 0) {
 		/* Note: with --reject, the above call succeeds. */
-		if (!threeway || try_threeway_fallback(&image, patch) < 0)
+		if (!threeway || try_threeway_fallback(&image, patch, st, ce) < 0)
 			return -1;
 	}
 	patch->result = image.buf;
-- 
1.7.10.1.562.gfc79b1c
