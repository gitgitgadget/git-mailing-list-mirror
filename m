From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 12/18] Add --index-only support for recursive merges
Date: Thu,  7 Apr 2016 23:58:40 -0700
Message-ID: <1460098726-5958-13-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 09:00:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQOi-0002y6-SI
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 09:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469AbcDHG7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33385 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998AbcDHG7L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:11 -0400
Received: by mail-pf0-f196.google.com with SMTP id e190so8853654pfe.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=18ZZEP5bSGx8ICTbjTeg9TI0vsYwHtHiYc8Rf7hadgM=;
        b=fL1uPaoRE6OPVbOIobGomCDaEz73H9rOrpfyboWG3arceMM0iaVfb/4B3EuHNyH8wp
         WH/LcBV36RAXKehEjcmwJ0Xh5WHj7leAqkWdbqlZkKFwU/JFJTs2Kh3QsKD/oydHSFDV
         w6uPfMi+097OKqpDf5mTQeu5yuLgGEc92TNsteCa3HLDSz+tW8F0CaEXdcoS8zoXlJXL
         Kg49ILXmdqtd0dsD8pIOyu0n9Bpw+yy6HKlsflRd1DqRIkNJQFGjy4cnHQwGCyXo4ls9
         XjYvxxsxpdGeUKRpL0fNOv7NpYoyQyJRis+kHHJmOvLkm+HFapMwlDQIXuo/cmGxQeW1
         5XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=18ZZEP5bSGx8ICTbjTeg9TI0vsYwHtHiYc8Rf7hadgM=;
        b=YILJQBpEcMmIveWgyhfWxXAul/UAwHahaD7gUf8OscBu7TvhPE4pdAO0kxwEM37FVm
         6oQ0CT1jdFyaX6D21pfJ08M4hT557gDODTrhVZdtuPeIYAFKZtEhKNtRu9YACKh3urnF
         Aa3zPhv7rvW8CrNE3DNZP5MIyic2mWebFfKZhXMXbt+rFX3U3MBTfw8Y/rQKGE9r4YxZ
         Pd9eo7dxrOHN2cFFw1CIgmB12+sLZB3SNPZULceEDxe/28rB1Hb4ODYVAQZWgcggGD8l
         lCSrgBssUNoNcBhTrdGlA1lU62gN3MAen+SigGjS62pP5UCF7v7WeOselaPt2bOWp0e7
         sieg==
X-Gm-Message-State: AD7BkJJEKjcx7qK/c4XIY+dOqS+xhfKfX34Aar38ZkHOBhcXzYJ6qD1XQCO+nszT2pnltg==
X-Received: by 10.98.80.150 with SMTP id g22mr10518258pfj.132.1460098750882;
        Thu, 07 Apr 2016 23:59:10 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:10 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291015>

The merge-recursive logic already had the ability to ignore the working
directory and operate entirely on the index -- it needed to do this when
creating a virtual merge base, i.e. when o->call_depth > 0.

The only trick here is that o->call_depth > 0 was also checked to
determine whether all merges conflicts should be forcibly immediately
resolved (typically by treating a copy of the code with conflict markers
still in it as the resolution) in order to get us some actual base tree
to work with.

Introduce a new merge option o->index_only which is true whenver either
--index-only is passed or o->call_depth > 0, and make the portions of
merge-recursive that are about operating only on the index look at
o->index_only, and the portions that are about forcibly immediately
resolving conflicts check o->call_depth.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c           | 37 ++++++++++++++++++++++---------------
 t/t6043-merge-index-only.sh | 12 ++++++------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b346ed6..6af37ed 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -406,10 +406,11 @@ static void record_df_conflict_files(struct merge_options *o,
 	int i;
 
 	/*
-	 * If we're merging merge-bases, we don't want to bother with
-	 * any working directory changes.
+	 * If we're doing an index-only merge, we don't need to check for
+	 * which files to remove from the working copy to make room for
+	 * paths below directories of D/F conflicts; we can just exit early.
 	 */
-	if (o->call_depth)
+	if (o->index_only)
 		return;
 
 	/* Ensure D/F conflicts are adjacent in the entries list. */
@@ -581,7 +582,7 @@ static int remove_file(struct merge_options *o, int clean,
 		       const char *path, int no_wd)
 {
 	int update_cache = o->call_depth || clean;
-	int update_working_directory = !o->call_depth && !no_wd;
+	int update_working_directory = !o->index_only && !no_wd;
 
 	if (update_cache) {
 		if (remove_file_from_cache(path))
@@ -622,7 +623,7 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
 	base_len = newpath.len;
 	while (string_list_has_string(&o->current_file_set, newpath.buf) ||
 	       string_list_has_string(&o->current_directory_set, newpath.buf) ||
-	       (!o->call_depth && file_exists(newpath.buf))) {
+	       (!o->index_only && file_exists(newpath.buf))) {
 		strbuf_setlen(&newpath, base_len);
 		strbuf_addf(&newpath, "_%d", suffix++);
 	}
@@ -742,7 +743,7 @@ static void update_file_flags(struct merge_options *o,
 			      int update_cache,
 			      int update_wd)
 {
-	if (o->call_depth)
+	if (o->index_only)
 		update_wd = 0;
 
 	if (update_wd) {
@@ -813,7 +814,7 @@ static void update_file(struct merge_options *o,
 			unsigned mode,
 			const char *path)
 {
-	update_file_flags(o, sha, mode, path, o->call_depth || clean, !o->call_depth);
+	update_file_flags(o, sha, mode, path, o->call_depth || clean, !o->index_only);
 }
 
 /* Low level file merging, update and removal */
@@ -1017,7 +1018,7 @@ static void handle_change_delete(struct merge_options *o,
 				 const char *change, const char *change_past)
 {
 	char *renamed = NULL;
-	if (dir_in_way(path, !o->call_depth)) {
+	if (dir_in_way(path, !o->index_only)) {
 		renamed = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
 	}
 
@@ -1145,7 +1146,7 @@ static void handle_file(struct merge_options *o,
 		remove_file(o, 0, rename->path, 0);
 		dst_name = unique_path(o, rename->path, cur_branch);
 	} else {
-		if (dir_in_way(rename->path, !o->call_depth)) {
+		if (dir_in_way(rename->path, !o->index_only)) {
 			dst_name = unique_path(o, rename->path, cur_branch);
 			output(o, 1, _("%s is a directory in %s adding as %s instead"),
 			       rename->path, other_branch, dst_name);
@@ -1234,8 +1235,8 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	       a->path, c1->path, ci->branch1,
 	       b->path, c2->path, ci->branch2);
 
-	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
-	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
+	remove_file(o, 1, a->path, o->index_only || would_lose_untracked(a->path));
+	remove_file(o, 1, b->path, o->index_only || would_lose_untracked(b->path));
 
 	mfi_c1 = merge_file_special_markers(o, a, c1, &ci->ren1_other,
 					    o->branch1, c1->path,
@@ -1619,7 +1620,7 @@ static int merge_content(struct merge_options *o,
 			 o->branch2 == rename_conflict_info->branch1) ?
 			pair1->two->path : pair1->one->path;
 
-		if (dir_in_way(path, !o->call_depth))
+		if (dir_in_way(path, !o->index_only))
 			df_conflict_remains = 1;
 	}
 	mfi = merge_file_special_markers(o, &one, &a, &b,
@@ -1639,7 +1640,7 @@ static int merge_content(struct merge_options *o,
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
 			add_cacheinfo(mfi.mode, mfi.sha, path,
-				      0, (!o->call_depth), 0);
+				      0, (!o->index_only), 0);
 			return mfi.clean;
 		}
 	} else
@@ -1767,7 +1768,7 @@ static int process_entry(struct merge_options *o,
 			sha = b_sha;
 			conf = _("directory/file");
 		}
-		if (dir_in_way(path, !o->call_depth)) {
+		if (dir_in_way(path, !o->index_only)) {
 			char *new_path = unique_path(o, path, add_branch);
 			clean_merge = 0;
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
@@ -1819,7 +1820,7 @@ int merge_trees(struct merge_options *o,
 		return 1;
 	}
 
-	code = git_merge_trees(o->call_depth, common, head, merge);
+	code = git_merge_trees(o->index_only, common, head, merge);
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
@@ -1899,6 +1900,7 @@ int merge_recursive(struct merge_options *o,
 	struct commit *merged_common_ancestors;
 	struct tree *mrtree = mrtree;
 	int clean;
+	int prev_index_only_setting;
 
 	if (show(o, 4)) {
 		output(o, 4, _("Merging:"));
@@ -1929,9 +1931,12 @@ int merge_recursive(struct merge_options *o,
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
+	prev_index_only_setting = o->index_only;
+
 	for (iter = ca; iter; iter = iter->next) {
 		const char *saved_b1, *saved_b2;
 		o->call_depth++;
+		o->index_only = 1;
 		/*
 		 * When the merge fails, the result contains files
 		 * with conflict markers. The cleanness flag is
@@ -1954,6 +1959,8 @@ int merge_recursive(struct merge_options *o,
 			die(_("merge returned no commit"));
 	}
 
+	o->index_only = prev_index_only_setting;
+
 	discard_cache();
 	if (!o->call_depth)
 		read_cache();
diff --git a/t/t6043-merge-index-only.sh b/t/t6043-merge-index-only.sh
index 9bb64d8..2e1d953 100755
--- a/t/t6043-merge-index-only.sh
+++ b/t/t6043-merge-index-only.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup rename/modify merge' '
 	git commit -m C
 '
 
-test_expect_failure '--index-only with rename/modify works in non-bare-clone' '
+test_expect_success '--index-only with rename/modify works in non-bare-clone' '
 	git checkout B^0 &&
 
 	git merge --index-only -s recursive C^0 &&
@@ -43,7 +43,7 @@ test_expect_failure '--index-only with rename/modify works in non-bare-clone' '
 	test $(git rev-parse B:a) = $(git rev-parse :b)
 '
 
-test_expect_failure '--index-only with rename/modify works in a bare clone' '
+test_expect_success '--index-only with rename/modify works in a bare clone' '
 	git clone --bare . bare.clone &&
 	(cd bare.clone &&
 
@@ -136,7 +136,7 @@ test_expect_success 'setup single-file criss-cross resolvable with recursive str
 	rm -f answer
 '
 
-test_expect_failure 'recursive --index-only in non-bare repo' '
+test_expect_success 'recursive --index-only in non-bare repo' '
 	git reset --hard &&
 	git checkout L2^0 &&
 
@@ -150,7 +150,7 @@ test_expect_failure 'recursive --index-only in non-bare repo' '
 	test $(git rev-parse L2:contents) = $(git hash-object contents)
 '
 
-test_expect_failure 'recursive --index-only in bare repo' '
+test_expect_success 'recursive --index-only in bare repo' '
 	git clone --bare . bare.clone &&
 	(cd bare.clone &&
 
@@ -406,7 +406,7 @@ test_expect_success '--index-only ours, bare' '
 	)
 '
 
-test_expect_failure '--index-only subtree, non-bare' '
+test_expect_success '--index-only subtree, non-bare' '
 	git reset --hard &&
 	git checkout B^0 &&
 
@@ -420,7 +420,7 @@ test_expect_failure '--index-only subtree, non-bare' '
 	test ! -f e
 '
 
-test_expect_failure '--index-only subtree, bare' '
+test_expect_success '--index-only subtree, bare' '
 	rm -rf bare.clone &&
 	git clone --bare . bare.clone &&
 	(cd bare.clone &&
-- 
2.8.0.18.gc685494
