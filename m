From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 13/19] apply: plug the three-way merge logic in
Date: Tue, 10 Jul 2012 00:04:06 -0700
Message-ID: <1341903852-4815-14-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:05:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUVZ-0000bE-7z
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab2GJHEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53266 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152Ab2GJHEv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E1F57DF2
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Z5og
	Ty8qnBTjDhEKnKu3XqWJUZQ=; b=NrFA2sL3qKxZmGdDT9zMRWpDRWQb1HEIlGo+
	XCPfnp/SgeykIxLPpNWbOLmli1mppfmBz96GSLCDWxXGbYhkYYHB4K9pNf9YJBJS
	jz/nxlrvzF1xRP9AEUS5RUlrQ0+YPsii8Z5t1CXlRRySdbOPaQpdDyumwIp7Mo86
	+x6P26A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=px/1cw
	QxCdD2WTs7MEbDN4JQSiZG9B0utMa2iNjDJLzCmxS5dJL286ZdueTFQ8rG6tL0se
	/fUUKBxqQPbQIDkKIOvWQnUZmSdmGF+AiB5w26mWdk8ZujQOmcTGxR01ZgUPHaDD
	yp/wy/Gv6eqOHLxIW1MXlo5je6ZNfzrjBF8BI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85D607DF1
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93AE47DF0 for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8A22EA26-CA5D-11E1-9D2D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201248>

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
 builtin/apply.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5a7201f..d84958b 100644
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
@@ -3146,7 +3152,29 @@ static int three_way_merge(struct image *image,
 			   const unsigned char *ours,
 			   const unsigned char *theirs)
 {
-	return -1; /* for now */
+	mmfile_t base_file, our_file, their_file;
+	mmbuffer_t result = { NULL };
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
 
 static int try_threeway(struct image *image, struct patch *patch,
@@ -3155,6 +3183,7 @@ static int try_threeway(struct image *image, struct patch *patch,
 	unsigned char pre_sha1[20], post_sha1[20], our_sha1[20];
 	struct strbuf buf = STRBUF_INIT;
 	size_t len;
+	int status;
 	char *img;
 	struct image tmp_image;
 
@@ -3167,6 +3196,9 @@ static int try_threeway(struct image *image, struct patch *patch,
 	if (get_sha1(patch->old_sha1_prefix, pre_sha1) ||
 	    read_blob_object(&buf, pre_sha1, patch->old_mode))
 		return error("repository lacks the necessary blob to fall back on 3-way merge.");
+
+	fprintf(stderr, "Falling back to three-way merge...\n");
+
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
 	/* Apply the patch to get the post image */
@@ -3186,8 +3218,23 @@ static int try_threeway(struct image *image, struct patch *patch,
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
1.7.11.1.294.g68a9409
