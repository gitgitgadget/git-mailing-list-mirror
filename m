Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B1DE1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 19:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbeDMT40 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 15:56:26 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:57976 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751912AbeDMT4Q (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Apr 2018 15:56:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3DJrIsk030445;
        Fri, 13 Apr 2018 12:56:10 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h96v3w6ys-1;
        Fri, 13 Apr 2018 12:56:09 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id E274D2215BAB;
        Fri, 13 Apr 2018 12:56:09 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id D9D902CDE68;
        Fri, 13 Apr 2018 12:56:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     torvalds@linux-foundation.org, gitster@pobox.com,
        sbeller@google.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v9 29.25/30] merge-recursive: improve output precision around skipping updates
Date:   Fri, 13 Apr 2018 12:56:04 -0700
Message-Id: <20180413195607.18091-2-newren@gmail.com>
X-Mailer: git-send-email 2.16.0.35.g6dd7ede834
In-Reply-To: <20180413195607.18091-1-newren@gmail.com>
References: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
 <20180413195607.18091-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804130184
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a merge results in contents that already existed in HEAD (because the
changes on a side branch were a subset of what was changed by HEAD), and
those contents were already at the right path, the working directory
updates can be skipped.  However, the relevant code would sometimes claim
the working directory update could be skipped despite the fact that the
contents were at the wrong path.  Make the output reflect the situation
more precisely, including an additional message that tests can check for
to make sure we are getting correct behavior.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c       | 11 ++++++-----
 t/t6022-merge-rename.sh |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4a1ecdea03..05250939c7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2761,21 +2761,22 @@ static int merge_content(struct merge_options *o,
 				       o->branch2, path2, &mfi))
 		return -1;
 
-	if (mfi.clean && !df_conflict_remains &&
-	    oid_eq(&mfi.oid, a_oid) && mfi.mode == a_mode) {
+	if (mfi.clean && oid_eq(&mfi.oid, a_oid) && mfi.mode == a_mode) {
 		int path_renamed_outside_HEAD;
-		output(o, 3, _("Skipped %s (merged same as existing)"), path);
 		/*
 		 * The content merge resulted in the same file contents we
 		 * already had.  We can return early if those file contents
 		 * are recorded at the correct path (which may not be true
-		 * if the merge involves a rename).
+		 * if the merge involves a rename or there's a D/F conflict).
 		 */
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
-		if (!path_renamed_outside_HEAD) {
+		if (!df_conflict_remains && !path_renamed_outside_HEAD) {
+			output(o, 3, _("Skipped %s (merged same as existing)"), path);
 			add_cacheinfo(o, mfi.mode, &mfi.oid, path,
 				      0, (!o->call_depth), 0);
 			return mfi.clean;
+		} else {
+			output(o, 3, _("Had correct contents for %s, but not at right path"), path);
 		}
 	} else
 		output(o, 2, _("Auto-merging %s"), path);
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 05ebba7afa..574088bfaf 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -245,7 +245,7 @@ test_expect_success 'merge of identical changes in a renamed file' '
 	GIT_MERGE_VERBOSITY=3 git merge change | test_i18ngrep "^Skipped B" &&
 	git reset --hard HEAD^ &&
 	git checkout change &&
-	GIT_MERGE_VERBOSITY=3 git merge change+rename | test_i18ngrep "^Skipped B"
+	GIT_MERGE_VERBOSITY=3 git merge change+rename | test_i18ngrep "^Had correct contents for B, but not at right path"
 '
 
 test_expect_success 'setup for rename + d/f conflicts' '
-- 
2.16.0.35.g6dd7ede834

