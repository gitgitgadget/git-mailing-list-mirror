From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/9] apply: plug the three-way merge logic in
Date: Thu, 10 May 2012 15:32:50 -0700
Message-ID: <1336689173-15822-7-git-send-email-gitster@pobox.com>
References: <1336689173-15822-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 00:33:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSbvN-0006Jv-D2
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 00:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581Ab2EJWdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 18:33:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932534Ab2EJWdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 18:33:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD17C8436
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=l/AP
	bypkejloChfTxpwdrW0A1Iw=; b=k1dJH98FCwoIviSyvLaTFjOZg+NmbvE8ysS9
	YyOQkpgsKJilXS27Twm4LT45NCHbaXaU35hjU7Wqc0yxV/UDVlFlZs+LYKLuAtr+
	g1WFcYYPhtZLOdJ1FYqY0TG/T3Cs+Jwp/7bBldvMRcTlZajUIvxliMpMNS33mq5H
	QNdjKcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vhiQP8
	PA/Lm5Oe698A2BLRpZEvqh4ebQtEYOHjRoiyoyq6gHrwUQR9L3JFJPSWKfYBXjcZ
	ssyXeOvb+caK/8G1cpKC0GAlurp8cJhFWyzlS9Wy5Tn78ctCY+QrGT7zsCClYxEI
	t+85FH0ApIExIoUInpt/crRv5NKtRRPw2N5HU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4C188435
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 002278434 for
 <git@vger.kernel.org>; Thu, 10 May 2012 18:33:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.574.g840b38f
In-Reply-To: <1336689173-15822-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1D2C90F8-9AF0-11E1-A7BB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197642>

When a patch does not apply to what we have, but we know the preimage the
patch was made against, we apply the patch to the preimage to compute what
the patch author wanted the result to look like, and attempt a three-way
merge between the result and our version, using the intended preimage as
the base version.

When we are applying the patch using the index, we would additionally need
to add the object names of these three blobs involved in the merge, which
is not yet done in this step, but we add a field to "struct patch" so that
later write-out step can use it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 1fe178f..ac53ecf 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -16,6 +16,8 @@
 #include "dir.h"
 #include "diff.h"
 #include "parse-options.h"
+#include "xdiff-interface.h"
+#include "ll-merge.h"
 
 /*
  *  --check turns on checking that the working tree matches the
@@ -194,12 +196,16 @@ struct patch {
 	unsigned int is_copy:1;
 	unsigned int is_rename:1;
 	unsigned int recount:1;
+	unsigned int conflicted_threeway:1;
 	struct fragment *fragments;
 	char *result;
 	size_t resultsize;
 	char old_sha1_prefix[41];
 	char new_sha1_prefix[41];
 	struct patch *next;
+
+	/* three-way fallback result */
+	unsigned char threeway_stage[3][20];
 };
 
 static void free_fragment_list(struct fragment *list)
@@ -3075,11 +3081,33 @@ static int load_preimage(struct image *image,
 
 static int three_way_merge(struct image *image,
 			   char *path,
-			   unsigned char *base,
-			   unsigned char *ours,
-			   unsigned char *theirs)
+			   const unsigned char *base,
+			   const unsigned char *ours,
+			   const unsigned char *theirs)
 {
-	return -1; /* for now */
+	mmfile_t base_file, our_file, their_file;
+	mmbuffer_t result = { 0 };
+	int status;
+
+	read_mmblob(&base_file, base);
+	read_mmblob(&our_file, ours);
+	read_mmblob(&their_file, theirs);
+	status = ll_merge(&result, path,
+			  &base_file, "base",
+			  &our_file, "ours",
+			  &their_file, "theirs", NULL);
+	free(base_file.ptr);
+	free(our_file.ptr);
+	free(their_file.ptr);
+	if (status < 0 || !result.ptr) {
+		free(result.ptr);
+		return -1;
+	}
+	clear_image(image);
+	image->buf = result.ptr;
+	image->len = result.size;
+
+	return status;
 }
 
 static int try_threeway_fallback(struct image *image, struct patch *patch,
@@ -3088,6 +3116,7 @@ static int try_threeway_fallback(struct image *image, struct patch *patch,
 	unsigned char pre_sha1[20], post_sha1[20], our_sha1[20];
 	struct strbuf buf = STRBUF_INIT;
 	size_t len;
+	int status;
 	char *img;
 	struct image tmp_image;
 
@@ -3100,6 +3129,9 @@ static int try_threeway_fallback(struct image *image, struct patch *patch,
 	if (get_sha1(patch->old_sha1_prefix, pre_sha1) ||
 	    read_blob_object(&buf, pre_sha1, patch->old_mode))
 		return error("repository lacks the necessary blob to fall back on 3-way merge.");
+
+	fprintf(stderr, "Falling back to three-way merge...\n");
+
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
 	/* Apply the patch to get the post image */
@@ -3116,8 +3148,23 @@ static int try_threeway_fallback(struct image *image, struct patch *patch,
 	clear_image(&tmp_image);
 
 	/* in-core three-way merge between post and our using pre as base */
-	return three_way_merge(image,
-			       patch->new_name, pre_sha1, our_sha1, post_sha1);
+	status = three_way_merge(image, patch->new_name,
+				 pre_sha1, our_sha1, post_sha1);
+	if (status < 0) {
+		fprintf(stderr, "Failed to fall back on three-way merge...\n");
+		return status;
+	}
+
+	if (status) {
+		patch->conflicted_threeway = 1;
+		hashcpy(patch->threeway_stage[0], pre_sha1);
+		hashcpy(patch->threeway_stage[1], our_sha1);
+		hashcpy(patch->threeway_stage[2], post_sha1);
+		fprintf(stderr, "Applied patch to '%s' with conflicts.\n", patch->new_name);
+	} else {
+		fprintf(stderr, "Applied patch to '%s' cleanly.\n", patch->new_name);
+	}
+	return 0;
 }
 
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
-- 
1.7.10.1.574.g840b38f
