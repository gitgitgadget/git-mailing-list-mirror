Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3953A1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbeISVxQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 17:53:16 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44154 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731812AbeISVxQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Sep 2018 17:53:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JGDNTU004983;
        Wed, 19 Sep 2018 09:14:38 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2mgxyj7gq6-1;
        Wed, 19 Sep 2018 09:14:38 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 0F2F4228A04A;
        Wed, 19 Sep 2018 09:14:38 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/4] merge-recursive: set paths correctly when three-way merging content
Date:   Wed, 19 Sep 2018 09:14:31 -0700
Message-Id: <20180919161434.3272-2-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.12.gc6760fd9a9
In-Reply-To: <20180919161434.3272-1-newren@gmail.com>
References: <20180919161434.3272-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190158
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merge_3way() has code to mark different sides of the conflict with info
about where the content comes from.  If the names of the files involved
match, it simply uses the branch name.  If the names of the files do not
match, it uses branchname:filename.  Unfortunately, merge_content()
previously always called it with one.path = a.path = b.path.  Granted,
it didn't have other path information available to it for years, but
that was corrected by passing rename_conflict_info in commit
3c217c077a86 ("merge-recursive: Provide more info in conflict markers
with file renames", 2011-08-11).  In that commit, instead of just fixing
the bug with the pathnames, it created fake branch names incorporating
both the branch name and file name.

This "fake branch" workaround was extended further when I pulled that
logic out into a special function in commit dac4741554e7
("merge-recursive: Create function for merging with branchname:file
markers", 2011-08-11), and a number of other sites outside of
merge_content() have been added which call into that.  However, this
Rube-Goldberg-esque setup is not merely duplicate code and unnecessary
work, it also risked having other callsites invoke it in a way that
would result in markers of the form branchname:filename:filename (i.e.
with the filename repeated).

Fix this whole mess by:
  - setting one.path, a.path, and b.path appropriately
  - calling merge_file_1() directly
  - deleting the merge_file_special_markers() workaround wrapper

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 49 +++++++++--------------------------------------
 1 file changed, 9 insertions(+), 40 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 45a163c555..99a7ac5ec7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1366,35 +1366,6 @@ static int merge_file_1(struct merge_options *o,
 	return 0;
 }
 
-static int merge_file_special_markers(struct merge_options *o,
-				      const struct diff_filespec *one,
-				      const struct diff_filespec *a,
-				      const struct diff_filespec *b,
-				      const char *target_filename,
-				      const char *branch1,
-				      const char *filename1,
-				      const char *branch2,
-				      const char *filename2,
-				      struct merge_file_info *mfi)
-{
-	char *side1 = NULL;
-	char *side2 = NULL;
-	int ret;
-
-	if (filename1)
-		side1 = xstrfmt("%s:%s", branch1, filename1);
-	if (filename2)
-		side2 = xstrfmt("%s:%s", branch2, filename2);
-
-	ret = merge_file_1(o, one, a, b, target_filename,
-			   side1 ? side1 : branch1,
-			   side2 ? side2 : branch2, mfi);
-
-	free(side1);
-	free(side2);
-	return ret;
-}
-
 static int merge_file_one(struct merge_options *o,
 			  const char *path,
 			  const struct object_id *o_oid, int o_mode,
@@ -1729,14 +1700,10 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 
 	path_side_1_desc = xstrfmt("%s (was %s)", path, a->path);
 	path_side_2_desc = xstrfmt("%s (was %s)", path, b->path);
-	if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
-				       path_side_1_desc,
-				       o->branch1, c1->path,
-				       o->branch2, ci->ren1_other.path, &mfi_c1) ||
-	    merge_file_special_markers(o, b, &ci->ren2_other, c2,
-				       path_side_2_desc,
-				       o->branch1, ci->ren2_other.path,
-				       o->branch2, c2->path, &mfi_c2))
+	if (merge_file_1(o, a, c1, &ci->ren1_other, path_side_1_desc,
+			 o->branch1, o->branch2, &mfi_c1) ||
+	    merge_file_1(o, b, &ci->ren2_other, c2, path_side_2_desc,
+			 o->branch1, o->branch2, &mfi_c2))
 		return -1;
 	free(path_side_1_desc);
 	free(path_side_2_desc);
@@ -3059,14 +3026,16 @@ static int merge_content(struct merge_options *o,
 		path2 = (rename_conflict_info->pair2 ||
 			 o->branch2 == rename_conflict_info->branch1) ?
 			pair1->two->path : pair1->one->path;
+		one.path = pair1->one->path;
+		a.path = (char *)path1;
+		b.path = (char *)path2;
 
 		if (dir_in_way(path, !o->call_depth,
 			       S_ISGITLINK(pair1->two->mode)))
 			df_conflict_remains = 1;
 	}
-	if (merge_file_special_markers(o, &one, &a, &b, path,
-				       o->branch1, path1,
-				       o->branch2, path2, &mfi))
+	if (merge_file_1(o, &one, &a, &b, path,
+			 o->branch1, o->branch2, &mfi))
 		return -1;
 
 	/*
-- 
2.19.0.12.gc6760fd9a9

