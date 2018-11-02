Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 978701F453
	for <e@80x24.org>; Fri,  2 Nov 2018 18:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbeKCEBp (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 00:01:45 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:35682 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731091AbeKCEBo (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 3 Nov 2018 00:01:44 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id wA2ImlD7009396;
        Fri, 2 Nov 2018 11:53:27 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2ncnvk80vp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 02 Nov 2018 11:53:26 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 2 Nov 2018 11:53:35 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 2 Nov 2018 11:53:35 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id A44A5210196B;
        Fri,  2 Nov 2018 11:53:24 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 04/10] merge-recursive: new function for better colliding conflict resolutions
Date:   Fri, 2 Nov 2018 11:53:12 -0700
Message-ID: <20181102185317.31015-5-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.232.gd14c2061fc
In-Reply-To: <20181102185317.31015-1-newren@gmail.com>
References: <20181019193111.12051-1-newren@gmail.com>
 <20181102185317.31015-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020166
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
if the handling of these three conflict types is the same, at least in
the limited set of cases where a renamed file is unmodified on the side
of history where the file is not renamed, then a significant performance
improvement for rename detection during merges is possible.  However,
while that served as motivation to look at these three types of
conflicts, the actual goal of this new function is to try to improve the
handling for all three cases, not to merely make them the same as each
other in that special circumstance.

=== Handling the working tree ===

The previous behavior for these conflict types in regards to the
working tree (assuming the file collision occurs at 'foo') was:
  * add/add does a two-way merge of the two files and records it as 'foo'.
  * rename/rename(2to1) records the two different files into two new
    uniquely named files (foo~HEAD and foo~$MERGE), while removing 'foo'
    from the working tree.
  * rename/add records the two different files into two different
    locations, recording the add at foo~$SIDE and, oddly, recording
    the rename at foo (why is the rename more important than the add?)

So, the question for what to write to the working tree boils down to
whether the two colliding files should be two-way merged and recorded in
place, or recorded into separate files.  As per discussion on the git
mailing lit, two-way merging was deemed to always be preferred, as that
makes these cases all more like content conflicts that users can handle
from within their favorite editor, IDE, or merge tool.  Note that since
renames already involve a content merge, rename/add and
rename/rename(2to1) conflicts could result in nested conflict markers.

=== Handling of the index ===

For a typical rename, unpack_trees() would set up the index in the
following fashion:
           old_path  new_path
   stage1: 5ca1ab1e  00000000
   stage2: f005ba11  00000000
   stage3: 00000000  b0a710ad
And merge-recursive would rewrite this to
           new_path
   stage1: 5ca1ab1e
   stage2: f005ba11
   stage3: b0a710ad
Removing old_path from the index means the user won't have to `git rm
old_path` manually every time a renamed path has a content conflict.
It also means they can use `git checkout [--ours|--theirs|--conflict|-m]
new_path`, `git diff [--ours|--theirs]` and various other commands that
would be difficult otherwise.

This strategy becomes a problem when we have a rename/add or
rename/rename(2to1) conflict, however, because then we have only three
slots to store blob sha1s and we need either four or six.  Previously,
this was handled by continuing to delete old_path from the index, and
just outright ignoring any blob shas from old_path.  That had the
downside of deleting any trace of changes made to old_path on the other
side of history.  This function instead does a three-way content merge of
the renamed file, and stores the blob sha1 for that at either stage2 or
stage3 for new_path (depending on which side the rename came from).  That
has the advantage of bringing information about changes on both sides and
still allows for easy resolution (no need to git rm old_path, etc.), but
does have the downside that if the content merge had conflict markers,
then what we store in the index is the sha1 of a blob with conflict
markers.  While that is a downside, it seems less problematic than the
downsides of any obvious alternatives, and certainly makes more sense
than the previous handling.  Further, it has a precedent in that when we
do recursive merges, we may accept a file with conflict markers as the
resolution for the merge of the merge-bases, which will then show up in
the index of the outer merge at stage 1 if a conflict exists at the outer
level.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index f795c92a69..24d979022e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1559,6 +1559,127 @@ static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 	return target;
 }
 
+#if 0 // #if-0-ing avoids unused function warning; will make live in next commit
+static int handle_file_collision(struct merge_options *o,
+				 const char *collide_path,
+				 const char *prev_path1,
+				 const char *prev_path2,
+				 const char *branch1, const char *branch2,
+				 const struct object_id *a_oid,
+				 unsigned int a_mode,
+				 const struct object_id *b_oid,
+				 unsigned int b_mode)
+{
+	struct merge_file_info mfi;
+	struct diff_filespec null, a, b;
+	char *alt_path = NULL;
+	const char *update_path = collide_path;
+
+	/*
+	 * In the recursive case, we just opt to undo renames
+	 */
+	if (o->call_depth && (prev_path1 || prev_path2)) {
+		/* Put first file (a_oid, a_mode) in its original spot */
+		if (prev_path1) {
+			if (update_file(o, 1, a_oid, a_mode, prev_path1))
+				return -1;
+		} else {
+			if (update_file(o, 1, a_oid, a_mode, collide_path))
+				return -1;
+		}
+
+		/* Put second file (b_oid, b_mode) in its original spot */
+		if (prev_path2) {
+			if (update_file(o, 1, b_oid, b_mode, prev_path2))
+				return -1;
+		} else {
+			if (update_file(o, 1, b_oid, b_mode, collide_path))
+				return -1;
+		}
+
+		/* Don't leave something at collision path if unrenaming both */
+		if (prev_path1 && prev_path2)
+			remove_file(o, 1, collide_path, 0);
+
+		return 0;
+	}
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
+	if (was_dirty(o, collide_path)) {
+		output(o, 1, _("Refusing to lose dirty file at %s"),
+		       collide_path);
+		update_path = alt_path = unique_path(o, collide_path, "merged");
+	} else if (would_lose_untracked(collide_path)) {
+		/*
+		 * Only way we get here is if both renames were from
+		 * a directory rename AND user had an untracked file
+		 * at the location where both files end up after the
+		 * two directory renames.  See testcase 10d of t6043.
+		 */
+		output(o, 1, _("Refusing to lose untracked file at "
+			       "%s, even though it's in the way."),
+		       collide_path);
+		update_path = alt_path = unique_path(o, collide_path, "merged");
+	} else {
+		/*
+		 * FIXME: It's possible that the two files are identical
+		 * and that the current working copy happens to match, in
+		 * which case we are unnecessarily touching the working
+		 * tree file.  It's not a likely enough scenario that I
+		 * want to code up the checks for it and a better fix is
+		 * available if we restructure how unpack_trees() and
+		 * merge-recursive interoperate anyway, so punting for
+		 * now...
+		 */
+		remove_file(o, 0, collide_path, 0);
+	}
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
+	if (merge_mode_and_contents(o, &null, &a, &b, collide_path,
+				    branch1, branch2, o->call_depth * 2, &mfi))
+		return -1;
+	mfi.clean &= !alt_path;
+	if (update_file(o, mfi.clean, &mfi.oid, mfi.mode, update_path))
+		return -1;
+	if (!mfi.clean && !o->call_depth &&
+	    update_stages(o, collide_path, NULL, &a, &b))
+		return -1;
+	free(alt_path);
+	/*
+	 * FIXME: If both a & b both started with conflicts (only possible
+	 * if they came from a rename/rename(2to1)), but had IDENTICAL
+	 * contents including those conflicts, then in the next line we claim
+	 * it was clean.  If someone cares about this case, we should have the
+	 * caller notify us if we started with conflicts.
+	 */
+	return mfi.clean;
+}
+#endif
+
 static int handle_file(struct merge_options *o,
 			struct diff_filespec *rename,
 			int stage,
-- 
2.19.0.232.gd14c2061fc

