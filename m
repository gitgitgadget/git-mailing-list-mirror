Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456C91F404
	for <e@80x24.org>; Wed, 12 Sep 2018 21:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeIMCZY (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 22:25:24 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:35900 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbeIMCZY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Sep 2018 22:25:24 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CL999W014026;
        Wed, 12 Sep 2018 14:18:51 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2mcc9gqpsb-1;
        Wed, 12 Sep 2018 14:18:51 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 3F1C7228A125;
        Wed, 12 Sep 2018 14:18:51 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 334492CDE77;
        Wed, 12 Sep 2018 14:18:51 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, gitster@pobox.com,
        phillip.wood@dunelm.org.uk, johannes.schindelin@gmx.de,
        sunshine@sunshineco.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH] sequencer: fix --allow-empty-message behavior, make it smarter
Date:   Wed, 12 Sep 2018 14:18:48 -0700
Message-Id: <20180912211848.26949-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.612.g68a16e0245
In-Reply-To: <20180912024241.GA27036@localhost>
References: <20180912024241.GA27036@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120208
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit b00bf1c9a8dd ("git-rebase: make --allow-empty-message the
default", 2018-06-27), several arguments were given for transplanting
empty commits without halting and asking the user for confirmation on
each commit.  These arguments were incomplete because the logic clearly
assumed the only cases under consideration were transplanting of commits
with empty messages (see the comment about "There are two sources for
commits with empty messages).  It didn't discuss or even consider
rewords, squashes, etc. where the user is explicitly asked for a new
commit message and provides an empty one.  (My bad, I totally should
have thought about that at the time, but just didn't.)

Rewords and squashes are significantly different, though, as described
by SZEDER:

    Let's suppose you start an interactive rebase, choose a commit to
    squash, save the instruction sheet, rebase fires up your editor, and
    then you notice that you mistakenly chose the wrong commit to
    squash.  What do you do, how do you abort?

    Before [that commit] you could clear the commit message, exit the
    editor, and then rebase would say "Aborting commit due to empty
    commit message.", and you get to run 'git rebase --abort', and start
    over.

    But [since that commit, ...] saving the commit message as is would
    let rebase continue and create a bunch of unnecessary objects, and
    then you would have to use the reflog to return to the pre-rebase
    state.

Also, he states:

    The instructions in the commit message template, which is shown for
    'reword' and 'squash', too, still say...

    # Please enter the commit message for your changes. Lines starting
    # with '#' will be ignored, and an empty message aborts the commit.

These are sound arguments that when editing commit messages during a
sequencer operation, that if the commit message is empty then the
operation should halt and ask the user to correct.  The arguments in
commit b00bf1c9a8dd (referenced above) still apply when transplanting
previously created commits with empty commit messages, so the sequencer
should not halt for those.

Furthermore, all rationale so far applies equally for cherry-pick as for
rebase.  Therefore, make the code default to --allow-empty-message when
transplanting an existing commit, and to default to halting when the
user is asked to edit a commit message and provides an empty one -- for
both rebase and cherry-pick.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
This patch cleanly applies to both 2.19.0 and pu.  There are some related
code cleanups that I'd like to make, but doing that cleanup conflicts wit=
h
the various rewrite-rebase-in-C topics sitting in pu; since those are
fairly lengthy, I really don't want to cause problems there, but I think
SZEDER really wants this 2.19.0 regression fix before 2.20.0 and thus
before those other topics.


 sequencer.c                   |  4 ++--
 t/t3404-rebase-interactive.sh |  7 +++----
 t/t3405-rebase-malformed.sh   |  2 +-
 t/t3505-cherry-pick-empty.sh  | 18 ++++++++----------
 4 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index dc2c58d464..638ee151f2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -899,7 +899,7 @@ static int run_git_commit(const char *defmsg, struct =
replay_opts *opts,
 	if ((flags & ALLOW_EMPTY))
 		argv_array_push(&cmd.args, "--allow-empty");
=20
-	if (opts->allow_empty_message)
+	if (!(flags & EDIT_MSG))
 		argv_array_push(&cmd.args, "--allow-empty-message");
=20
 	if (cmd.err =3D=3D -1) {
@@ -1313,7 +1313,7 @@ static int try_to_commit(struct strbuf *msg, const =
char *author,
=20
 	if (cleanup !=3D COMMIT_MSG_CLEANUP_NONE)
 		strbuf_stripspace(msg, cleanup =3D=3D COMMIT_MSG_CLEANUP_ALL);
-	if (!opts->allow_empty_message && message_is_empty(msg, cleanup)) {
+	if ((flags & EDIT_MSG) && message_is_empty(msg, cleanup)) {
 		res =3D 1; /* run 'git commit' to display error message */
 		goto out;
 	}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.s=
h
index 86bba5ed7c..ff89b6341a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -569,16 +569,15 @@ test_expect_success '--continue tries to commit, ev=
en for "edit"' '
 '
=20
 test_expect_success 'aborted --continue does not squash commits after "e=
dit"' '
-	test_when_finished "git rebase --abort" &&
 	old=3D$(git rev-parse HEAD) &&
 	test_tick &&
 	set_fake_editor &&
 	FAKE_LINES=3D"edit 1" git rebase -i HEAD^ &&
 	echo "edited again" > file7 &&
 	git add file7 &&
-	echo all the things >>conflict &&
-	test_must_fail git rebase --continue &&
-	test $old =3D $(git rev-parse HEAD)
+	test_must_fail env FAKE_COMMIT_MESSAGE=3D" " git rebase --continue &&
+	test $old =3D $(git rev-parse HEAD) &&
+	git rebase --abort
 '
=20
 test_expect_success 'auto-amend only edited commits after "edit"' '
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index da94dddc86..860e63e444 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -83,7 +83,7 @@ test_expect_success 'rebase -m commit with empty messag=
e' '
 test_expect_success 'rebase -i commit with empty message' '
 	git checkout diff-in-message &&
 	set_fake_editor &&
-	env FAKE_COMMIT_MESSAGE=3D" " FAKE_LINES=3D"reword 1" \
+	test_must_fail env FAKE_COMMIT_MESSAGE=3D" " FAKE_LINES=3D"reword 1" \
 		git rebase -i HEAD^
 '
=20
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index fbdc47cfbd..5f911bb529 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -11,17 +11,14 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m "first" &&
=20
-	git checkout -b empty-branch &&
-	test_tick &&
-	git commit --allow-empty -m "empty" &&
-
+	git checkout -b empty-message-branch &&
 	echo third >> file1 &&
 	git add file1 &&
 	test_tick &&
 	git commit --allow-empty-message -m "" &&
=20
 	git checkout master &&
-	git checkout -b empty-branch2 &&
+	git checkout -b empty-change-branch &&
 	test_tick &&
 	git commit --allow-empty -m "empty"
=20
@@ -29,7 +26,7 @@ test_expect_success setup '
=20
 test_expect_success 'cherry-pick an empty commit' '
 	git checkout master &&
-	test_expect_code 1 git cherry-pick empty-branch^
+	test_expect_code 1 git cherry-pick empty-change-branch
 '
=20
 test_expect_success 'index lockfile was removed' '
@@ -37,8 +34,9 @@ test_expect_success 'index lockfile was removed' '
 '
=20
 test_expect_success 'cherry-pick a commit with an empty message' '
+	test_when_finished "git reset --hard empty-message-branch~1" &&
 	git checkout master &&
-	test_expect_code 1 git cherry-pick empty-branch
+	git cherry-pick empty-message-branch
 '
=20
 test_expect_success 'index lockfile was removed' '
@@ -47,7 +45,7 @@ test_expect_success 'index lockfile was removed' '
=20
 test_expect_success 'cherry-pick a commit with an empty message with --a=
llow-empty-message' '
 	git checkout -f master &&
-	git cherry-pick --allow-empty-message empty-branch
+	git cherry-pick --allow-empty-message empty-message-branch
 '
=20
 test_expect_success 'cherry pick an empty non-ff commit without --allow-=
empty' '
@@ -55,12 +53,12 @@ test_expect_success 'cherry pick an empty non-ff comm=
it without --allow-empty' '
 	echo fourth >>file2 &&
 	git add file2 &&
 	git commit -m "fourth" &&
-	test_must_fail git cherry-pick empty-branch2
+	test_must_fail git cherry-pick empty-change-branch
 '
=20
 test_expect_success 'cherry pick an empty non-ff commit with --allow-emp=
ty' '
 	git checkout master &&
-	git cherry-pick --allow-empty empty-branch2
+	git cherry-pick --allow-empty empty-change-branch
 '
=20
 test_expect_success 'cherry pick with --keep-redundant-commits' '
--=20
2.19.0.612.g68a16e0245

