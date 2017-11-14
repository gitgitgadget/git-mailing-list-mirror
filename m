Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C03C1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 17:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754713AbdKNRbd (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 12:31:33 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:45282 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754289AbdKNRb2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2017 12:31:28 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAEHRYWl003309;
        Tue, 14 Nov 2017 09:31:25 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e7p4992eq-1;
        Tue, 14 Nov 2017 09:31:25 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 41525221A293;
        Tue, 14 Nov 2017 09:31:25 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 3AAA92CDE60;
        Tue, 14 Nov 2017 09:31:25 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH] merge-recursive: Handle addition of submodule on our side of history
Date:   Tue, 14 Nov 2017 09:31:24 -0800
Message-Id: <20171114173124.25982-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.2.g63e86ab1a0
In-Reply-To: <ABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com>
References: <ABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711140238
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code for a newly added path assumed that the path was a normal file,
and thus checked for there being a directory still being in the way of
the file.  Note that since unpack_trees() does path-in-the-way checks
already, the only way for there to be a directory in the way at this
point in the code, is if there is some kind of D/F conflict in the merge.

For a submodule addition on HEAD's side of history, the submodule would
have already been present.  This means that we do expect there to be a
directory present but should not consider it to be "in the way"; instead,
it's the expected submodule.  So, when there's a submodule addition from
HEAD's side, don't bother checking the working copy for a directory in
the way.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
This commit is based on top of sb/test-cherry-pick-submodule-getting-in-a-way.

 merge-recursive.c                | 5 +++--
 t/t3512-cherry-pick-submodule.sh | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1d3f8f0d22..9fb0b9f8fd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1901,8 +1901,9 @@ static int process_entry(struct merge_options *o,
 			oid = b_oid;
 			conf = _("directory/file");
 		}
-		if (dir_in_way(path, !o->call_depth,
-			       S_ISGITLINK(a_mode))) {
+		if (dir_in_way(path,
+			       !o->call_depth && !S_ISGITLINK(a_mode),
+			       0)) {
 			char *new_path = unique_path(o, path, add_branch);
 			clean_merge = 0;
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index 1b1e31100f..ce48c4fcca 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -10,7 +10,7 @@ KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
 test_submodule_switch "git cherry-pick"
 
-test_expect_failure 'unrelated submodule/file conflict is ignored' '
+test_expect_success 'unrelated submodule/file conflict is ignored' '
 	test_create_repo sub &&
 
 	touch sub/file &&
-- 
2.15.0.2.g63e86ab1a0

