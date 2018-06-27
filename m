Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D621F516
	for <e@80x24.org>; Wed, 27 Jun 2018 07:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932701AbeF0HXs (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 03:23:48 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36898 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932549AbeF0HXj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jun 2018 03:23:39 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5R7N5gd023661;
        Wed, 27 Jun 2018 00:23:22 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ju94mtgp4-2;
        Wed, 27 Jun 2018 00:23:22 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id E544222FD1A9;
        Wed, 27 Jun 2018 00:23:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id DCD182CDEED;
        Wed, 27 Jun 2018 00:23:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v5 9/9] git-rebase: make --allow-empty-message the default
Date:   Wed, 27 Jun 2018 00:23:19 -0700
Message-Id: <20180627072319.31356-10-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180627072319.31356-1-newren@gmail.com>
References: <20180625161300.26060-1-newren@gmail.com>
 <20180627072319.31356-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270087
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rebase backends currently behave differently with empty commit messages,
largely as a side-effect of the different underlying commands on which
they are based.  am-based rebases apply commits with an empty commit
message without stopping or requiring the user to specify an extra flag.
(It is interesting to note that am-based rebases are the default rebase
type, and no one has ever requested a --no-allow-empty-message flag to
change this behavior.)  merge-based and interactive-based rebases (which
are ultimately based on git-commit), will currently halt on any such
commits and require the user to manually specify what to do with the
commit and continue.

One possible rationale for the difference in behavior is that the purpose
of an "am" based rebase is solely to transplant an existing history, while
an "interactive" rebase is one whose purpose is to polish a series before
making it publishable.  Thus, stopping and asking for confirmation for a
possible problem is more appropriate in the latter case.  However, there
are two problems with this rationale:

  1) merge-based rebases are also non-interactive and there are multiple
     types of rebases that use the interactive machinery but are not
     explicitly interactive (e.g. when either --rebase-merges or
     --keep-empty are specified without --interactive).  These rebases are
     also used solely to transplant an existing history, and thus also
     should default to --allow-empty-message.

  2) this rationale only says that the user is more accepting of stopping
     in the case of an explicitly interactive rebase, not that stopping
     for this particular reason actually makes sense.  Exploring whether
     it makes sense, requires backing up and analyzing the underlying
     commands...

If git-commit did not error out on empty commits by default, accidental
creation of commits with empty messages would be a very common occurrence
(this check has caught me many times).  Further, nearly all such empty
commit messages would be considered an accidental error (as evidenced by a
huge amount of documentation across version control systems and in various
blog posts explaining how important commit messages are).  A simple check
for what would otherwise be a common error thus made a lot of sense, and
git-commit gained an --allow-empty-message flag for special case
overrides.  This has made commits with empty messages very rare.

There are two sources for commits with empty messages for rebase (and
cherry-pick): (a) commits created in git where the user previously
specified --allow-empty-message to git-commit, and (b) commits imported
into git from other version control systems.  In case (a), the user has
already explicitly specified that there is something special about this
commit that makes them not want to specify a commit message; forcing them
to re-specify with every cherry-pick or rebase seems more likely to be
infuriating than helpful.  In case (b), the commit is highly unlikely to
have been authored by the person who has imported the history and is doing
the rebase or cherry-pick, and thus the user is unlikely to be the
appropriate person to write a commit message for it.  Stopping and
expecting the user to modify the commit before proceeding thus seems
counter-productive.

Further, note that while empty commit messages was a common error case for
git-commit to deal with, it is a rare case for rebase (or cherry-pick).
The fact that it is rare raises the question of why it would be worth
checking and stopping on this particular condition and not others.  For
example, why doesn't an interactive rebase automatically stop if the
commit message's first line is 2000 columns long, or is missing a blank
line after the first line, or has every line indented with five spaces, or
any number of other myriad problems?

Finally, note that if a user doing an interactive rebase does have the
necessary knowledge to add a message for any such commit and wants to do
so, it is rather simple for them to change the appropriate line from
'pick' to 'reword'.  The fact that the subject is empty in the todo list
that the user edits should even serve as a way to notify them.

As far as I can tell, the fact that merge-based and interactive-based
rebases stop on commits with empty commit messages is solely a by-product
of having been based on git-commit.  It went without notice for a long
time precisely because such cases are rare.  The rareness of this
situation made it difficult to reason about, so when folks did eventually
notice this behavior, they assumed it was there for a good reason and just
added an --allow-empty-message flag.  In my opinion, stopping on such
messages not desirable in any of these cases, even the (explicitly)
interactive case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---

My commit messsage seems like one of those things that someone else will
instantly see how to shrink to less than a quarter of its size while still
retaining all essential reasoning.  I can't seem to find the simple way to
state it, though.

 Documentation/git-rebase.txt  | 10 ----------
 git-rebase.sh                 |  2 +-
 t/t3404-rebase-interactive.sh |  7 ++++---
 t/t3405-rebase-malformed.sh   | 11 +++--------
 4 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a67df4caba..9e136ee16e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -563,16 +563,6 @@ BEHAVIORAL DIFFERENCES
     The `--keep-empty` option exists for interactive rebases to allow
     it to keep commits that started empty.
 
-  * empty commit messages:
-
-    am-based rebase will silently apply commits with empty commit
-    messages.
-
-    merge-based and interactive-based rebases will by default halt
-    on any such commits.  The `--allow-empty-message` option exists to
-    allow interactive-based rebases to apply such commits without
-    halting.
-
   * directory rename detection:
 
     merge-based and interactive-based rebases work fine with
diff --git a/git-rebase.sh b/git-rebase.sh
index 18ac8226c4..031dbd2ec8 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -95,7 +95,7 @@ rebase_cousins=
 preserve_merges=
 autosquash=
 keep_empty=
-allow_empty_message=
+allow_empty_message=--allow-empty-message
 signoff=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 case "$(git config --bool commit.gpgsign)" in
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 352a52e59d..81ce9fe7f9 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -553,15 +553,16 @@ test_expect_success '--continue tries to commit, even for "edit"' '
 '
 
 test_expect_success 'aborted --continue does not squash commits after "edit"' '
+	test_when_finished "git rebase --abort" &&
 	old=$(git rev-parse HEAD) &&
 	test_tick &&
 	set_fake_editor &&
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
 	echo "edited again" > file7 &&
 	git add file7 &&
-	test_must_fail env FAKE_COMMIT_MESSAGE=" " git rebase --continue &&
-	test $old = $(git rev-parse HEAD) &&
-	git rebase --abort
+	echo all the things >>conflict &&
+	test_must_fail git rebase --continue &&
+	test $old = $(git rev-parse HEAD)
 '
 
 test_expect_success 'auto-amend only edited commits after "edit"' '
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index cb7c6de84a..da94dddc86 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -77,19 +77,14 @@ test_expect_success 'rebase commit with diff in message' '
 '
 
 test_expect_success 'rebase -m commit with empty message' '
-	test_must_fail git rebase -m master empty-message-merge &&
-	git rebase --abort &&
-	git rebase -m --allow-empty-message master empty-message-merge
+	git rebase -m master empty-message-merge
 '
 
 test_expect_success 'rebase -i commit with empty message' '
 	git checkout diff-in-message &&
 	set_fake_editor &&
-	test_must_fail env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
-		git rebase -i HEAD^ &&
-	git rebase --abort &&
-	FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
-		git rebase -i --allow-empty-message HEAD^
+	env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
+		git rebase -i HEAD^
 '
 
 test_done
-- 
2.18.0.9.g431b2c36d5

