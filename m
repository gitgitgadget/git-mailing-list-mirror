From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/11] rerere: split code to call ll_merge() further
Date: Wed,  6 Apr 2016 16:05:34 -0700
Message-ID: <1459983935-25267-11-git-send-email-gitster@pobox.com>
References: <1459204942-26601-1-git-send-email-gitster@pobox.com>
 <1459983935-25267-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 01:06:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anwWR-0008RF-VB
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 01:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbcDFXF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 19:05:57 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754390AbcDFXFz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 19:05:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB7A153746;
	Wed,  6 Apr 2016 19:05:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Qcpo
	EVGLe6OVzercYwDAE7AUrFk=; b=DjitVbIJOF2/4ztu8IktLJmpFdO+fLzn+odK
	Ok4CJQOjyRud4CZizGgJ5mMivpkOJq691vrCAbyXMIPxaXS18eBrLIipoUQ4WN7p
	dWMWwWvIrp55hYNay6y3It/FnYtF3TtWrzHPAopTP2j5aEFr07MrtLz9vJAN1s8Q
	gwlfI9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qPsDq7
	Xa4JpI75+lybiZ1EMXJhpCOAfCebtuqVKy8RW4J1QgU4+w2DmKPp8l5KckOEeG8u
	GCsjxhIszSYuxI4hPtE2F62TFl+mWJKO3lVyXozqgVWHfcd3FcLk29eqM1DVGVeH
	oNt6RoG9EmwoZxvi6HLTnWR739bAjzlFZgXPs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A3BCB53745;
	Wed,  6 Apr 2016 19:05:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 280BB53744;
	Wed,  6 Apr 2016 19:05:54 -0400 (EDT)
X-Mailer: git-send-email 2.3.8-32-g0ce02b3
In-Reply-To: <1459983935-25267-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1D2B3214-FC4C-11E5-BB43-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290894>

The merge() helper function is given an existing rerere ID (i.e. the
name of the .git/rr-cache/* subdirectory, and the variant number)
that identifies one <preimage, postimage> pair, try to see if the
conflicted state in the given path can be resolved by using the pair,
and if this succeeds, then update the conflicted path with the
result in the working tree.

To implement rerere_forget() in the multiple variant world, we'd
need a helper to do the "see if a <preimage, postimage> pair cleanly
resolves a conflicted state we have in-core" part, without actually
touching any file in the working tree, in order to identify which
variant(s) to remove.  Split the logic to do so into a separate
helper function try_merge() out of merge().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/rerere.c b/rerere.c
index 2b870e0..e636d4b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -622,6 +622,33 @@ int rerere_remaining(struct string_list *merge_rr)
 }
 
 /*
+ * Try using the given conflict resolution "ID" to see
+ * if that recorded conflict resolves cleanly what we
+ * got in the "cur".
+ */
+static int try_merge(const struct rerere_id *id, const char *path,
+		     mmfile_t *cur, mmbuffer_t *result)
+{
+	int ret;
+	mmfile_t base = {NULL, 0}, other = {NULL, 0};
+
+	if (read_mmfile(&base, rerere_path(id, "preimage")) ||
+	    read_mmfile(&other, rerere_path(id, "postimage")))
+		ret = 1;
+	else
+		/*
+		 * A three-way merge. Note that this honors user-customizable
+		 * low-level merge driver settings.
+		 */
+		ret = ll_merge(result, path, &base, NULL, cur, "", &other, "", NULL);
+
+	free(base.ptr);
+	free(other.ptr);
+
+	return ret;
+}
+
+/*
  * Find the conflict identified by "id"; the change between its
  * "preimage" (i.e. a previous contents with conflict markers) and its
  * "postimage" (i.e. the corresponding contents with conflicts
@@ -635,30 +662,20 @@ static int merge(const struct rerere_id *id, const char *path)
 {
 	FILE *f;
 	int ret;
-	mmfile_t cur = {NULL, 0}, base = {NULL, 0}, other = {NULL, 0};
+	mmfile_t cur = {NULL, 0};
 	mmbuffer_t result = {NULL, 0};
 
 	/*
 	 * Normalize the conflicts in path and write it out to
 	 * "thisimage" temporary file.
 	 */
-	if (handle_file(path, NULL, rerere_path(id, "thisimage")) < 0) {
-		ret = 1;
-		goto out;
-	}
-
-	if (read_mmfile(&cur, rerere_path(id, "thisimage")) ||
-	    read_mmfile(&base, rerere_path(id, "preimage")) ||
-	    read_mmfile(&other, rerere_path(id, "postimage"))) {
+	if ((handle_file(path, NULL, rerere_path(id, "thisimage")) < 0) ||
+	    read_mmfile(&cur, rerere_path(id, "thisimage"))) {
 		ret = 1;
 		goto out;
 	}
 
-	/*
-	 * A three-way merge. Note that this honors user-customizable
-	 * low-level merge driver settings.
-	 */
-	ret = ll_merge(&result, path, &base, NULL, &cur, "", &other, "", NULL);
+	ret = try_merge(id, path, &cur, &result);
 	if (ret)
 		goto out;
 
@@ -684,8 +701,6 @@ static int merge(const struct rerere_id *id, const char *path)
 
 out:
 	free(cur.ptr);
-	free(base.ptr);
-	free(other.ptr);
 	free(result.ptr);
 
 	return ret;
-- 
2.8.1-273-ga2cd0f9
