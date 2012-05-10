From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/8] apply: plug the three-way merge logic in
Date: Wed,  9 May 2012 23:02:24 -0700
Message-ID: <1336629745-22436-8-git-send-email-gitster@pobox.com>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 08:03:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMSv-0002NM-3v
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab2EJGCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 02:02:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755672Ab2EJGCs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 02:02:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C3C85FE6
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gGko
	w/aJ/uGH0SHHyzRqeo14uZ4=; b=HTy0oLJJW90YPu+dhmVCUZN6yz7NknPSLeXS
	UNBY9VNyqWzfHoL2WOPbqqzjVVUxJMBa3e7F0RrpXj1U5iKX6JjvRCvUzqVS6Vg9
	ALsYj5cVkYQ/0jdUpt5rZcE5UKuyfHqAX9DqRwzAjPZCBz0zdJA/19WWPNt80eFW
	7hRjXXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=q+NBZ0
	9v4q9/UQ+qMSWX6YVNu/NGO9GDOBWne7SCIY8tgeB7Y8rw1nF0QdXuE5nlaWU+MH
	3ByrCYDDHccjEwqcP2DpXPMLLG6G9BJ1cLzK07AINNwAOZuyuusrvFOBGte+5FAH
	6v19blH7MO5a5UZy05dld7LgDT/BYTBCY8vRw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4465B5FE5
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 074B95FE4 for
 <git@vger.kernel.org>; Thu, 10 May 2012 02:02:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.562.gfc79b1c
In-Reply-To: <1336629745-22436-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C41C4812-9A65-11E1-B1E0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197539>

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
 builtin/apply.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 798a634..e090e18 100644
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
@@ -194,12 +196,17 @@ struct patch {
 	unsigned int is_copy:1;
 	unsigned int is_rename:1;
 	unsigned int recount:1;
+	unsigned int did_threeway:1;
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
@@ -3075,11 +3082,33 @@ static int load_preimage(struct image *image,
 
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
@@ -3088,6 +3117,7 @@ static int try_threeway_fallback(struct image *image, struct patch *patch,
 	unsigned char pre_sha1[20], post_sha1[20], our_sha1[20];
 	struct strbuf buf = STRBUF_INIT;
 	size_t len;
+	int status;
 	char *img;
 	struct image tmp_image;
 
@@ -3116,8 +3146,19 @@ static int try_threeway_fallback(struct image *image, struct patch *patch,
 	clear_image(&tmp_image);
 
 	/* in-core three-way merge between post and our using pre as base */
-	return three_way_merge(image,
-			       patch->new_name, pre_sha1, our_sha1, post_sha1);
+	status = three_way_merge(image, patch->new_name,
+				 pre_sha1, our_sha1, post_sha1);
+	if (status < 0)
+		return status;
+
+	patch->did_threeway = 1;
+	if (status) {
+		patch->conflicted_threeway = 1;
+		hashcpy(patch->threeway_stage[0], pre_sha1);
+		hashcpy(patch->threeway_stage[1], our_sha1);
+		hashcpy(patch->threeway_stage[2], post_sha1);
+	}
+	return 0;
 }
 
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
-- 
1.7.10.1.562.gfc79b1c
