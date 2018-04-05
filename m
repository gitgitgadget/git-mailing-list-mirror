Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723F01F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeDERe7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:34:59 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39118 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751410AbeDERew (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Apr 2018 13:34:52 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w35HYngJ006435;
        Thu, 5 Apr 2018 10:34:49 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h286rvn7s-1;
        Thu, 05 Apr 2018 10:34:49 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id EB3C72212A7C;
        Thu,  5 Apr 2018 10:34:48 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id D69EE2CDEEA;
        Thu,  5 Apr 2018 10:34:48 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sxlijin@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 4/7] dir: Directories should be checked for matching pathspecs too
Date:   Thu,  5 Apr 2018 10:34:43 -0700
Message-Id: <20180405173446.32372-5-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.7.g0b50f94d69
In-Reply-To: <20180405173446.32372-1-newren@gmail.com>
References: <20180405173446.32372-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=889 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804050181
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if a directory doesn't match a pathspec, it is possible, depending
on the precise pathspecs, that some file underneath it might.  So we
special case and recurse into the directory for such situations.  However,
we previously always added any untracked directory that we recursed into
to the list of untracked paths, regardless of whether the directory
itself matched the pathspec.

For the case of git-clean and a set of pathspecs of "dir/file" and "more",
this caused a problem because we'd end up with dir entries for both of
  "dir"
  "dir/file"
Then correct_untracked_entries() would try to helpfully prune duplicates
for us by removing "dir/file" since it's under "dir", leaving us with
  "dir"
Since the original pathspec only had "dir/file", the only entry left
doesn't match and leaves nothing to be removed.  (Note that if only one
pathspec was specified, e.g. only "dir/file", then the common_prefix_len
optimizations in fill_directory would cause us to bypass this problem,
making it appear in simple tests that we could correctly remove manually
specified pathspecs.)

Fix this by actually checking whether the directory we are about to add
to the list of dir entries actually matches the pathspec; only do this
matching check after we have already returned from recursing into the
directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c            | 5 +++++
 t/t7300-clean.sh | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index c915a69385..e783431948 100644
--- a/dir.c
+++ b/dir.c
@@ -1973,6 +1973,11 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 							 check_only, stop_at_first_file, pathspec);
 			if (subdir_state > dir_state)
 				dir_state = subdir_state;
+
+			if (!match_pathspec(pathspec, path.buf, path.len,
+					    0 /* prefix */, NULL,
+					    0 /* do NOT special case dirs */))
+				state = path_none;
 		}
 
 		if (check_only) {
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 3d260e21ea..31f2d0d8ba 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -677,7 +677,7 @@ test_expect_failure 'git clean handles being told what to clean' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_failure 'git clean handles being told what to clean, with -d' '
+test_expect_success 'git clean handles being told what to clean, with -d' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -ffd */ut &&
@@ -693,7 +693,7 @@ test_expect_failure 'git clean handles being told a glob to clean' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_failure 'git clean handles being told a glob to clean with -d' '
+test_expect_success 'git clean handles being told a glob to clean with -d' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -ffd "*ut" &&
-- 
2.17.0.7.g0b50f94d69

