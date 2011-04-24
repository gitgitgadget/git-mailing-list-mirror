From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix "add -u" that sometimes fails to resolve unmerged paths
Date: Sun, 24 Apr 2011 13:53:53 -0700
Message-ID: <7vy62zl6am.fsf@alter.siamese.dyndns.org>
References: <1303678289-27627-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 22:54:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE6Ji-0008D4-53
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 22:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757786Ab1DXUyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 16:54:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757701Ab1DXUx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 16:53:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B9C284777;
	Sun, 24 Apr 2011 16:56:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7VZxk07lLbtMWJ84vCz0mOnNtVc=; b=noJUU4
	PyZkawEd6iY5H00MLYY1PzBZPr2nDKWskCcITVA2/0wWEUs/Jrca9avKAWhLymE8
	OXMHKOVySwmG+jx9dY8Q6cIqJJqlWECLsy4EJZKl2GVEiA1am8X2riKIunHftscz
	APOzhyvcmQAR2juXn08tvkT4X+CkedS3SrJP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TWWvDUkVglsfe7Y3w5XyzULoaoinff0m
	QdK6pj2SY94ThLWDjQQK8TIXhvjFClU+tIvTP8+mDeYU9XR2e1jDGtfcO96t1/OF
	j8jNstZWEvgNvnlba+XtAwp4o19AVbA4Waa7ZwUOZjbmjimAOS7e6BWx7K7wdAH5
	ksas5BVMoHQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A061F4776;
	Sun, 24 Apr 2011 16:55:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 98B204775; Sun, 24 Apr 2011
 16:55:57 -0400 (EDT)
In-Reply-To: <1303678289-27627-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Sun, 24 Apr 2011 13:51:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41F26EE8-6EB5-11E0-B6E3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172004>

"git add -u" updates the index with the updated contents from the working
tree by internally running "diff-files" to grab the set of paths that are
different from the index. Then it updates the index entries for the paths
that are modified in the working tree, and deletes the index entries for
the paths that are deleted in the working tree.

It ignored the output from the diff-files that indicated that a path is
unmerged.  For these paths, it instead relied on the fact that an unmerged
path is followed by the result of comparison between stage #2 (ours) and
the working tree, and used that to update or delete such a path when it is
used to record the resolution of a conflict.

As the result, when a path did not have stage #2 (e.g. "we deleted while
the other side added"), these unmerged stages were left behind, instead of
recording what the user resolved in the working tree.

Since we recently fixed "diff-files" to indicate if the corresponding path
exists on the working tree for an unmerged path, we do not have to rely on
the comparison with stage #2 anymore. We can instead tell the diff-files
not to compare with higher stages, and use the unmerged output to update
the index to reflect the state of the working tree.

The changes to the test vector in t2200 illustrates the nature of the bug
and the fix.  The test expected stage #1 and #3 entries be left behind,
but it was codifying the buggy behaviour.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This comes on top of the 4-patch series to fix "diff-files" output for
   unmerged paths.

 builtin/add.c         |   45 +++++++++++++++++++++++----------------------
 t/t2200-add-update.sh |   24 +++++++-----------------
 2 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 56a4e0a..027ca3b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -27,6 +27,27 @@ struct update_callback_data
 	int add_errors;
 };
 
+static int fix_unmerged_status(struct diff_filepair *p,
+			       struct update_callback_data *data)
+{
+	if (p->status != DIFF_STATUS_UNMERGED)
+		return p->status;
+	if (!(data->flags & ADD_CACHE_IGNORE_REMOVAL) && !p->two->mode)
+		/*
+		 * This is not an explicit add request, and the
+		 * path is missing from the working tree (deleted)
+		 */
+		return DIFF_STATUS_DELETED;
+	else
+		/*
+		 * Either an explicit add request, or path exists
+		 * in the working tree.  An attempt to explicitly
+		 * add a path that does not exist in the working tree
+		 * will be caught as an error by the caller immediately.
+		 */
+		return DIFF_STATUS_MODIFIED;
+}
+
 static void update_callback(struct diff_queue_struct *q,
 			    struct diff_options *opt, void *cbdata)
 {
@@ -36,30 +57,9 @@ static void update_callback(struct diff_queue_struct *q,
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
-		switch (p->status) {
+		switch (fix_unmerged_status(p, data)) {
 		default:
 			die("unexpected diff status %c", p->status);
-		case DIFF_STATUS_UNMERGED:
-			/*
-			 * ADD_CACHE_IGNORE_REMOVAL is unset if "git
-			 * add -u" is calling us, In such a case, a
-			 * missing work tree file needs to be removed
-			 * if there is an unmerged entry at stage #2,
-			 * but such a diff record is followed by
-			 * another with DIFF_STATUS_DELETED (and if
-			 * there is no stage #2, we won't see DELETED
-			 * nor MODIFIED).  We can simply continue
-			 * either way.
-			 */
-			if (!(data->flags & ADD_CACHE_IGNORE_REMOVAL))
-				continue;
-			/*
-			 * Otherwise, it is "git add path" is asking
-			 * to explicitly add it; we fall through.  A
-			 * missing work tree file is an error and is
-			 * caught by add_file_to_index() in such a
-			 * case.
-			 */
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
 			if (add_file_to_index(&the_index, path, data->flags)) {
@@ -92,6 +92,7 @@ int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 	data.flags = flags;
 	data.add_errors = 0;
 	rev.diffopt.format_callback_data = &data;
+	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	return !!data.add_errors;
 }
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 2ad2819..d3bb9fa 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -149,31 +149,21 @@ test_expect_success 'add -u resolves unmerged paths' '
 	echo 3 >path1 &&
 	echo 2 >path3 &&
 	echo 2 >path5 &&
-	git add -u &&
-	git ls-files -s path1 path2 path3 path4 path5 path6 >actual &&
-	{
-		echo "100644 $three 0	path1"
-		echo "100644 $one 1	path3"
-		echo "100644 $one 1	path4"
-		echo "100644 $one 3	path5"
-		echo "100644 $one 3	path6"
-	} >expect &&
-	test_cmp expect actual &&
 
-	# Bonus tests.  Explicit resolving
-	git add path3 path5 &&
+	# Explicit resolving by adding removed paths should fail
 	test_must_fail git add path4 &&
 	test_must_fail git add path6 &&
-	git rm path4 &&
-	git rm path6 &&
 
-	git ls-files -s "path?" >actual &&
+	# "add -u" should notice removals no matter what stages
+	# the index entries are in.
+	git add -u &&
+	git ls-files -s path1 path2 path3 path4 path5 path6 >actual &&
 	{
 		echo "100644 $three 0	path1"
 		echo "100644 $two 0	path3"
 		echo "100644 $two 0	path5"
-	} >expect
-
+	} >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success '"add -u non-existent" should fail' '
-- 
1.7.5
