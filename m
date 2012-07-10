From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 12/19] apply: fall back on three-way merge
Date: Tue, 10 Jul 2012 00:04:05 -0700
Message-ID: <1341903852-4815-13-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:05:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUVY-0000bE-NA
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155Ab2GJHEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141Ab2GJHEs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ADD27DEF
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2GHu
	hmapynR0xJdKwVF49tacajc=; b=vXU3g2aXGaEB0wDA2G2h4jVLcPq8tpIkvkFm
	jccOQTilOzya0EAIb/hlckspis3l5bUsgdGJzQQ8nRaTyuGt9mRLGy9ehL05ojuK
	tFMth7BuFVh7iXNiy5PzMq6x4gYtuhrgjwRJpJhsV3aSlOmByxl4JshrB7H8gxiQ
	abozfdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=RS2KCW
	+EMVt+Feox3ldlUb5b8UEOq3BHpMXm4+kdpmJkXYZlwzi4VX4m3poMQRHNQK4BEM
	P+C7aLSv/SyqhV2u+6dc54cBBKV1th7vrvjg3WIj+mCDdUAoZ/QgHkRFSsZhRa41
	KEE6kkHiVHz+flW7Aq1fQ+g4S2tJ6xI6Z5JSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 410787DEE
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0909B7DED for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 889B248E-CA5D-11E1-AD61-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201251>

Grab the preimage blob the patch claims to be based on out of the object
store, apply the patch, and then call three-way-merge function.  This step
still does not plug the actual three-way merge logic yet, but we are
getting there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 51b695b..5a7201f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3140,10 +3140,54 @@ static int load_preimage(struct image *image,
 	return 0;
 }
 
+static int three_way_merge(struct image *image,
+			   char *path,
+			   const unsigned char *base,
+			   const unsigned char *ours,
+			   const unsigned char *theirs)
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
1.7.11.1.294.g68a9409
