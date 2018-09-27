Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7957B1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 17:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeI0X41 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 19:56:27 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:35268 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728255AbeI0X40 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Sep 2018 19:56:26 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8RHTCI5031191;
        Thu, 27 Sep 2018 10:36:59 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2mrdeaswss-1;
        Thu, 27 Sep 2018 10:36:59 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 16B0121021EE;
        Thu, 27 Sep 2018 10:36:59 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        andreastacchiotti@gmail.com,
        =?UTF-8?q?Eckhard=20Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv2] commit: fix erroneous BUG, 'multiple renames on the same target? how?'
Date:   Thu, 27 Sep 2018 10:36:57 -0700
Message-Id: <20180927173657.4723-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.222.gfbc440e6cd.dirty
In-Reply-To: <20180927072043.19130-1-newren@gmail.com>
References: <20180927072043.19130-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270163
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/commit.c:prepare_to_commit() can call run_status() twice if
using the editor, including status, and the user attempts to record a
non-merge empty commit without explicit --allow-empty.  If there is also
a rename involved as well (due to using 'git add -N'), then a BUG in
wt-status.c is triggered:

  BUG: wt-status.c:476: multiple renames on the same target? how?

The reason we hit this bug is that both run_status() calls use the same
struct wt_status * (named s), and s->change is not freed between runs.
Changes are inserted into s with string_list_insert, which usually means
that the second run just recomputes all the same results and overwrites
what was computed the first time.  However, ever since commit
176ea7479309 ("wt-status.c: handle worktree renames", 2017-12-27),
wt-status started checking for renames and copies but also added a
preventative check that d->rename_status wasn't already set and output a
BUG message if it was.  The problem isn't that there are multiple rename
targets to a single path as the error implies, the problem is that 's'
is not freed/cleared between the two run_status() calls.

Ever since commit dc6b1d92ca9c ("wt-status: use settings from
git_diff_ui_config", 2018-05-04), which stopped hardcoding
DIFF_DETECT_RENAME and allowed users to ask for copy detection, this bug
has also been triggerable with a copy instead of a rename.

Fix the bug by clearing s->change.  A better change might be to clean up
all of s between the two run_status() calls.  A good first step towards
such a goal might be writing a function to free the necessary fields in
the wt_status * struct; a cursory glance at the code suggests all of its
allocated data is probably leaked.  However, doing all that cleanup is a
bigger task for someone else interested to tackle; just fix the bug for
now.

Reported-by: Andrea Stacchiotti <andreastacchiotti@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---

Changes since v1:
  - Remove non-portable and unneccessary -a flag to cp (Flagged by Eric)
  - Move the string_list_clear() from just before the second run_status()
    call to just after the first one (As suggested by Duy)

 builtin/commit.c  |  1 +
 t/t7500-commit.sh | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index b57d8e4b82..342cc9cff0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -874,6 +874,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		s->use_color = 0;
 		commitable = run_status(s->fp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
+		string_list_clear(&s->change, 1);
 	} else {
 		struct object_id oid;
 		const char *parent = "HEAD";
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 170b4810e0..31ab608b67 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -359,4 +359,27 @@ test_expect_success 'new line found before status message in commit template' '
 	test_i18ncmp expected-template editor-input
 '
 
+test_expect_success 'setup empty commit with unstaged rename and copy' '
+	test_create_repo unstaged_rename_and_copy &&
+	(
+		cd unstaged_rename_and_copy &&
+
+		echo content >orig &&
+		git add orig &&
+		test_commit orig &&
+
+		cp orig new_copy &&
+		mv orig new_rename &&
+		git add -N new_copy new_rename
+	)
+'
+
+test_expect_success 'check commit with unstaged rename and copy' '
+	(
+		cd unstaged_rename_and_copy &&
+
+		test_must_fail git -c diff.renames=copy commit
+	)
+'
+
 test_done
-- 
2.19.0.222.gfbc440e6cd.dirty

