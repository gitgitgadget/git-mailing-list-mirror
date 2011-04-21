From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] fix "add -u" that sometimes failes to resolve unmerged
 paths
Date: Wed, 20 Apr 2011 18:11:19 -0700
Message-ID: <7vaafkz9vs.fsf@alter.siamese.dyndns.org>
References: <7vei4wza1q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 03:11:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCiQe-0004QJ-4Y
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 03:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab1DUBL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 21:11:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1DUBL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 21:11:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 347F25E08;
	Wed, 20 Apr 2011 21:13:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gUk4UraBcOe3njCnRHkUyMbQwS4=; b=qqytXI
	9xTYMOuUqkosN/32cbohu2gdH/08byNjdVkVLdzsPjTF/ivwVB9YqneVjh4a+nd0
	zGr8Y7jwJnfJKCLngHHyFUaaRBofIXZrzWRpzo66suwEDROay+CsEukorLkRoGRz
	mJNVVlRgF5Dc2DxCCtBF1iQySlh1xZ3o6jYNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XxkHbzgj0L/dQ2iFkpQMPNH98flsZIgw
	Vba0VndtlwN4zxbJAes7Afk8HWKOWp2vi9xFBNuRJqDnOgR2FslFWEeaDtrFGZpn
	j0NU+ndgfbV7NUE2pt/MTHPhTIsPLeZKz36ME/GlSvR0EUyTExV7eQ30pLPQ4LiD
	TNdfLJfUpUk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 121425E07;
	Wed, 20 Apr 2011 21:13:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F128B5E02; Wed, 20 Apr 2011
 21:13:20 -0400 (EDT)
In-Reply-To: <7vei4wza1q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 20 Apr 2011 18:07:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D488606-6BB4-11E0-B53E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171885>

"git add -u" updates the index with the updated contents from the working
tree by internally running "diff-files" to grab the set of paths that are
different from the index, and updates the paths that are modified, and
deletes the paths that are deleted.

It ignored the diff-files output that indicated a path is unmerged, and
relied on the fact that an unmerged path is followed by the result of
comparison between stage #2 (ours) and the working tree and used that to
update or delete such a path when it is used to record the resolution of a
conflict.  As the result, when a path did not have stage #2 (e.g. "we
deleted while the other side added"), these unmerged stages were left
behind, instead of recording what the user resolved in the working tree.

This teaches the diff-files machinery to record if an unmerged path has a
corresponding file in the working tree, teaches "add -u" codepath to tell
the diff-files not to show the extra comparison with stage #2 (i.e. we get
only the "unmerged" report), and upon seeing an unmerged path, either
update (when the file exists in the working tree) or delete (otherwise).

The changes to the test vector in t2200 illustrates the nature of the bug
and the fix.  The test expected stage #1 and #3 entries be left behind,
but it was codifying the buggy behaviour.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Storing the working tree information in an unmerged index entry feels
   somewhat dirty, as it breaks the expectation that "U" entries would
   show zero mode and 0{40} SHA-1 people might have gained from the
   traditional behaviour.

   Considering that a similar change was made to diff-index in e9c8409
   (diff-index --cached --raw: show tree entry on the LHS for unmerged
   entries., 2007-01-05) and later in d1f2d7e (Make run_diff_index() use
   unpack_trees(), not read_tree(), 2008-01-19) and as the result of these
   changes, "diff-index --cached $tree" shows the information from the
   index on the preimage side ever since, and nobody complained when or
   after the change was made, I am hoping that nobody relies on the
   current behaviour of "diff --raw" family for the unmerged paths.

   If anything, the updated behaviour of "diff-files" is more consistent
   with the other parts of the system.  When showing the working tree
   status in the diff --raw output, we do not show its object name, but we
   do show its mode.  We didn't show its mode when the corresponding index
   entry is unmerged before this fix.

   When showing an unmerged index entry in the diff --raw output as a
   single entry, we do not show its mode nor object name, as it stands for
   "fate not determined yet".  That is not something this patch changes.

 builtin/add.c         |   39 +++++++++++++++++----------------------
 diff-lib.c            |    9 +++++++--
 t/t2200-add-update.sh |   24 +++++++-----------------
 3 files changed, 31 insertions(+), 41 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 56a4e0a..c85a3ac 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -27,6 +27,21 @@ struct update_callback_data
 	int add_errors;
 };
 
+static int fix_unmerged_status(struct diff_filepair *p,
+			       struct update_callback_data *data)
+{
+	if (p->status != DIFF_STATUS_UNMERGED)
+		return p->status;
+	if (!(data->flags & ADD_CACHE_IGNORE_REMOVAL) && !p->two->mode)
+		/*
+		 * This is not an explicit add request,
+		 * and the path is missing from the working tree.
+		 */
+		return DIFF_STATUS_DELETED;
+	else
+		return DIFF_STATUS_MODIFIED;
+}
+
 static void update_callback(struct diff_queue_struct *q,
 			    struct diff_options *opt, void *cbdata)
 {
@@ -36,30 +51,9 @@ static void update_callback(struct diff_queue_struct *q,
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
@@ -92,6 +86,7 @@ int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 	data.flags = flags;
 	data.add_errors = 0;
 	rev.diffopt.format_callback_data = &data;
+	rev.max_count = 0; /* do not show extra M/D after U */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	return !!data.add_errors;
 }
diff --git a/diff-lib.c b/diff-lib.c
index 392ce2b..f0ce473 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -111,7 +111,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 		if (ce_stage(ce)) {
 			struct combine_diff_path *dpath;
+			struct diff_filepair *dp;
 			int num_compare_stages = 0;
+			unsigned int wt_mode = 0;
 			size_t path_len;
 
 			path_len = ce_namelen(ce);
@@ -129,7 +131,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 			changed = check_removed(ce, &st);
 			if (!changed)
-				dpath->mode = ce_mode_from_stat(ce, st.st_mode);
+				wt_mode = ce_mode_from_stat(ce, st.st_mode);
 			else {
 				if (changed < 0) {
 					perror(ce->name);
@@ -137,7 +139,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				}
 				if (silent_on_removed)
 					continue;
+				wt_mode = 0;
 			}
+			dpath->mode = wt_mode;
 
 			while (i < entries) {
 				struct cache_entry *nce = active_cache[i];
@@ -183,7 +187,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			 * Show the diff for the 'ce' if we found the one
 			 * from the desired stage.
 			 */
-			diff_unmerge(&revs->diffopt, ce->name, 0, null_sha1);
+			dp = diff_unmerge(&revs->diffopt, ce->name, 0, null_sha1);
+			dp->two->mode = wt_mode;
 			if (ce_stage(ce) != diff_unmerged_stage)
 				continue;
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
