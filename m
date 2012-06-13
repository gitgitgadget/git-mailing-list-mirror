From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/19] apply: fall back on three-way merge
Date: Wed, 13 Jun 2012 12:32:53 -0700
Message-ID: <1339615980-19727-13-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetJv-0008OY-AN
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795Ab2FMTdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab2FMTdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 909A58728
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Ruzd
	G8IV3NjW+M3FVyiKiblSIIc=; b=tubPZFRCMeRmiQk2bQfBMpN1s2V05BR7EMiV
	aeMSqHhLSUtZl+YSaO6YUvzjkAtxqPmm2rzRO5ymDaeebmy7qX0B2S+kXYq/MACt
	EMHKssjFCHaXQqUBEUJOVBf7yt8ESa1KENOiCkOzi9VxEeUyaTB1OeQ6qkTWuJ/c
	Y6zjJAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BXsvRN
	z0HJwhfxq1EuCTV81NnjaKwcLViUDo/Q2VJDN68RoDz03v2DiX1p6kmBKfnL0DQl
	2w0V+cSYIiGUlQo9sbeCk2GlWtGOrB2l9MFS8dhqIQv2QNMAVfN/Z92W//BmKa7Q
	Pohrd0PeDoyy9R9lbkH+Coi7po4D55DznzNGY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88B268727
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 009D88724 for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:24 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A4A5A778-B58E-11E1-B2DE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199923>

Grab the preimage blob the patch claims to be based on out of the object
store, apply the patch, and then call three-way-merge function.  This step
still does not plug the actual three-way merge logic yet, but we are
getting there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 509a297..6936588 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3140,10 +3140,54 @@ static int load_preimage(struct image *image,
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
 static int try_threeway(struct image *image, struct patch *patch,
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
+	/* post_sha1[] is theirs */
+	write_sha1_file(tmp_image.buf, tmp_image.len, blob_type, post_sha1);
+	clear_image(&tmp_image);
+
+	/* our_sha1[] is ours */
+	if (load_preimage(&tmp_image, patch, st, ce))
+		return error("cannot read the current contents of '%s'",
+			     patch->old_name);
+	write_sha1_file(tmp_image.buf, tmp_image.len, blob_type, our_sha1);
+	clear_image(&tmp_image);
+
+	/* in-core three-way merge between post and our using pre as base */
+	return three_way_merge(image,
+			       patch->new_name, pre_sha1, our_sha1, post_sha1);
 }
 
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
-- 
1.7.11.rc3.30.g3bdace2
