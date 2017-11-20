Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951E6202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbdKTWTt (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:19:49 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:33218 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751159AbdKTWTq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:19:46 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKMI9Fa011620;
        Mon, 20 Nov 2017 14:19:44 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eajmr3dp0-1;
        Mon, 20 Nov 2017 14:19:44 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 9047A22F4661;
        Mon, 20 Nov 2017 14:19:44 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 894762CDEC1;
        Mon, 20 Nov 2017 14:19:44 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 3/9] merge-recursive: new function for better colliding conflict resolutions
Date:   Mon, 20 Nov 2017 14:19:38 -0800
Message-Id: <20171120221944.15431-4-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.323.g31fe956618
In-Reply-To: <20171120221944.15431-1-newren@gmail.com>
References: <20171120221944.15431-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711200299
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are three conflict types that represent two (possibly entirely
unrelated) files colliding at the same location:
  * add/add
  * rename/add
  * rename/rename(2to1)

These three conflict types already share more similarity than might be
immediately apparent from their description: (1) the handling of the
rename variants already involves removing any entries from the index
corresponding to the original file names[*], thus only leaving entries
in the index for the colliding path; (2) likewise, any trace of the
original file name in the working tree is also removed.  So, in all
three cases we're left with how to represent two colliding files in both
the index and the working copy.

[*] Technically, this isn't quite true because rename/rename(2to1)
conflicts in the recursive (o->call_depth > 0) case do an "unrename"
since about seven years ago.  But even in that case, Junio felt
compelled to explain that my decision to "unrename" wasn't necessarily
the only or right answer -- search for "Comment from Junio" in t6036 for
details.

My initial motivation for looking at these three conflict types was that
if the handling of these three conflict types is the "same" (defined
more precisely in a later commit), or is at least the "same" in the
limited set of cases where a renamed file is unmodified on the side of
history where the file is not renamed, then a significant performance
improvement for rename detection during merges is possible.  However,
while that served as motivation to look at these three types of
conflicts, the actual goal of this new function is to try to improve the
handling for all three cases, not to merely make them the same.

The previous behavior for these conflict types in regards to the
working tree (assuming the file collision occurs at 'foo') was:
  * add/add does a two-way merge of the two files and records it as 'foo'.
  * rename/rename(2to1) records the two different files into two new
    uniquely named files (foo~HEAD and foo~$MERGE), while removing 'foo'
    from the working tree.
  * rename/add records the two different files into two different
    locations, recording the add at foo~$SIDE and, oddly, recording
    the rename at foo (why is the rename more important than the add?)

So, the biggest question is whether the two colliding files should be
two-way merged and recorded in place, or recorded into separate files.
If the files are similar enough, the two-way merge is probably
preferable, but if they're not similar, recording as separate files is
probably preferable.  (The same logic that applies for the working
directory here would also apply to the recursive (i.e. o->call_depth >
0) case as well.)  The code handling the different types of conflicts
appear to have been written with different assumptions about whether the
colliding files would be similar.

But, rather than make an assumption about whether the two files will be
similar, why not just check?  If we simply call estimate_similarity(),
we can two-way merge the files if they are similar, and otherwise record
the two files at different locations.

Checking similarity in order to optimize worktree handling is the
primary improvement for these three conflict types.  Further
improvements will be discussed in subsequent commits that modify the
code to take advantage of this new shared function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.h            |   4 ++
 diffcore-rename.c |   6 +--
 merge-recursive.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/diff.h b/diff.h
index 0fb18dd735..34dbc3cc05 100644
--- a/diff.h
+++ b/diff.h
@@ -438,4 +438,8 @@ extern void print_stat_summary(FILE *fp, int files,
 			       int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
 
+extern int estimate_similarity(struct diff_filespec *src,
+			       struct diff_filespec *dst,
+			       int minimum_score);
+
 #endif /* DIFF_H */
diff --git a/diffcore-rename.c b/diffcore-rename.c
index fe37e3b861..4fe5d0471c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -127,9 +127,9 @@ struct diff_score {
 	short name_score;
 };
 
-static int estimate_similarity(struct diff_filespec *src,
-			       struct diff_filespec *dst,
-			       int minimum_score)
+int estimate_similarity(struct diff_filespec *src,
+			struct diff_filespec *dst,
+			int minimum_score)
 {
 	/* src points at a file that existed in the original tree (or
 	 * optionally a file in the destination tree) and dst points
diff --git a/merge-recursive.c b/merge-recursive.c
index 09b6092abb..9dda13bf4f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1293,6 +1293,127 @@ static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 	return target;
 }
 
+static int handle_file_collision(struct merge_options *o,
+				 const char *collide_path,
+				 const char *prev_path1,
+				 const char *prev_path2,
+				 const char *branch1, const char *branch2,
+				 const struct object_id *a_oid,
+				 unsigned int a_mode,
+				 const struct object_id *b_oid,
+				 unsigned int b_mode,
+				 unsigned int conflict_markers_already_present)
+{
+	struct merge_file_info mfi;
+	struct diff_filespec null, a, b;
+	int minimum_score;
+
+	/* Remove rename sources if rename/add or rename/rename(2to1) */
+	if (prev_path1)
+		remove_file(o, 1, prev_path1,
+			    o->call_depth || would_lose_untracked(prev_path1));
+	if (prev_path2)
+		remove_file(o, 1, prev_path2,
+			    o->call_depth || would_lose_untracked(prev_path2));
+
+	/*
+	 * Remove the collision path, if it wouldn't cause dirty contents
+	 * or an untracked file to get lost.  We'll either overwrite with
+	 * merged contents, or just write out to differently named files.
+	 */
+	if (was_dirty(o, collide_path))
+		output(o, 1, _("Refusing to lose dirty file at %s"),
+		       collide_path);
+	else if (would_lose_untracked(collide_path))
+		/*
+		 * Only way we get here is if both renames were from
+		 * a directory rename AND user had an untracked file
+		 * at the location where both files end up after the
+		 * two directory renames.  See testcase 10d of t6043.
+		 */
+		output(o, 1, _("Refusing to lose untracked file at "
+			       "%s, even though it's in the way."),
+		       collide_path);
+	else
+		/*
+		 * FIXME: It's possible that neither of the two files have
+		 * conflict markers already present, and that they're
+		 * identical, and that the current working copy happens to
+		 * match, in which case we are unnecessarily touching the
+		 * working tree file.  It's not a likely enough scenario
+		 * that I want to code up the checks for it and a better
+		 * fix is available if we restructure how unpack_trees()
+		 * and merge-recursive interoperate anyway, so punting for
+		 * now...
+		 */
+		remove_file(o, 0, collide_path, 0);
+
+	/* Store things in diff_filespecs for functions that need it */
+	memset(&a, 0, sizeof(struct diff_filespec));
+	memset(&b, 0, sizeof(struct diff_filespec));
+	null.path = a.path = b.path = (char *)collide_path;
+	oidcpy(&null.oid, &null_oid);
+	null.mode = 0;
+	oidcpy(&a.oid, a_oid);
+	a.mode = a_mode;
+	a.oid_valid = 1;
+	oidcpy(&b.oid, b_oid);
+	b.mode = b_mode;
+	b.oid_valid = 1;
+
+	/*
+	 * If the colliding files are similar enough, we can simply merge
+	 * them.  But we don't want to merge files that have conflict
+	 * markers in them already, because nested conflict markers are
+	 * too confusing.
+	 */
+	minimum_score = o->rename_score ? o->rename_score
+					: DEFAULT_RENAME_SCORE;
+	if (!conflict_markers_already_present && minimum_score <=
+	    estimate_similarity(&a, &b, o->rename_score)) {
+		if (merge_file_1(o, &null, &a, &b, branch1, branch2, &mfi))
+			return -1;
+		if (update_file(o, mfi.clean, &mfi.oid, mfi.mode, collide_path))
+			return -1;
+		if (!mfi.clean && !o->call_depth &&
+		    update_stages(o, collide_path, NULL, &a, &b))
+			return -1;
+		return mfi.clean;
+	}
+
+	/*
+	 * Put the colliding files into different paths, and record the
+	 * updated sha1sums in the index
+	 */
+	char *new_path1 = (o->call_depth && prev_path1) ? strdup(prev_path1) :
+			  unique_path(o, collide_path, branch1);
+	char *new_path2 = (o->call_depth && prev_path2) ? strdup(prev_path2) :
+			  unique_path(o, collide_path, branch2);
+	output(o, 1, _("Renaming collisions at %s to %s and %s instead"),
+	       collide_path, new_path1, new_path2);
+
+	if (update_file(o, 0, a_oid, a_mode, new_path1))
+		return -1;
+	if (update_file(o, 0, b_oid, b_mode, new_path2))
+		return -1;
+
+	/* Update index too, making sure to get stage order correct. */
+	if (!o->call_depth) {
+		if (o->branch1 == branch1) {
+			if (update_stages(o, collide_path, NULL, &a, &b))
+				return -1;
+		} else {
+			if (update_stages(o, collide_path, NULL, &b, &a))
+				return -1;
+		}
+	}
+
+	free(new_path2);
+	free(new_path1);
+
+	return 0; /* not clean */
+}
+
 static int handle_file(struct merge_options *o,
 			struct diff_filespec *rename,
 			int stage,
-- 
2.15.0.323.g31fe956618

