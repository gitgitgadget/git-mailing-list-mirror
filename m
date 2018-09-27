Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DF481F454
	for <e@80x24.org>; Thu, 27 Sep 2018 07:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeI0Nhj (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 09:37:39 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44382 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbeI0Nhj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Sep 2018 09:37:39 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8R7CgQ2032230;
        Thu, 27 Sep 2018 00:20:48 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2mnjmmyktq-1;
        Thu, 27 Sep 2018 00:20:47 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 9F2AB21021EE;
        Thu, 27 Sep 2018 00:20:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        andreastacchiotti@gmail.com,
        =?UTF-8?q?Eckhard=20Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        pclouds@gmail.com, Elijah Newren <newren@gmail.com>
Subject: Re: Triggering "BUG: wt-status.c:476: multiple renames on the same target? how?" 
Date:   Thu, 27 Sep 2018 00:20:43 -0700
Message-Id: <20180927072043.19130-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.222.g923d35e14f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270076
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 9:20 PM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Sep 26, 2018, 2:27 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > On Wed, Sep 26 2018, Andrea Stacchiotti wrote:
> >
> > > I'm very sorry, I indeed forgot the `diff.renames=copies`.
> > >
> > > The following script can reproduce the bug even with a blank config:
>
> Thanks for the bug report and the simple testcase.
>
> > > ---------------------
> > >
> > > # Make a test repo
> > > git init testrepo
> > > cd testrepo
> > > git config user.name A
> > > git config user.email B
> > > git config diff.renames copies
> > >
> > > # Add a file called orig
> > > echo 'a' > orig
> > > git add orig
> > > git commit -m'orig'
> > >
> > > # Copy orig in new and modify orig
> > > cp orig new
> > > echo 'b' > orig
> > >
> > > # add -N and then commit trigger the bug
> > > git add -N new
> > > git commit
> > >
> > > # Cleanup
> > > cd ..
> > > rm -rf testrepo
> >
> > Thanks. Bisecting shows that the bug is in dc6b1d92ca ("wt-status: use
> > settings from git_diff_ui_config", 2018-05-04) first released with
> > 2.18.0.
>
> The bisect is slightly misleading; the bug was introduced in 2.17.0
> for renames, and when copy detection became a thing in 2.18.0 it also
> incidentally would trigger with copies.  I'll post a patch soon.

-- 8< --
Subject: [PATCH] commit: fix erroneous BUG, 'multiple renames on the same
 target? how?'

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
 builtin/commit.c  |  1 +
 t/t7500-commit.sh | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index b57d8e4b82..ee98d703f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -921,6 +921,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (!commitable && whence != FROM_MERGE && !allow_empty &&
 	    !(amend && is_a_merge(current_head))) {
 		s->display_comment_prefix = old_display_comment_prefix;
+		string_list_clear(&s->change, 1);
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
 			fputs(_(empty_amend_advice), stderr);
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 170b4810e0..387637b9b0 100755
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
+		cp -a orig new_copy &&
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
2.19.0.222.g923d35e14f

