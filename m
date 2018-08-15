Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9599A1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 09:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeHOMbR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 08:31:17 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:57291 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbeHOMbR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 08:31:17 -0400
Received: from lindisfarne.localdomain ([92.22.33.100])
        by smtp.talktalk.net with SMTP
        id psHGfwZmBoI6LpsHNf4aEq; Wed, 15 Aug 2018 10:39:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1534325990;
        bh=sARCzSjGr++MlLx2tYa27kgkNeMzf2/Rmp37RmC4I9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=cob/0Uhyi+qBkAIis+qreskNdx8Pd+zZI5GADWOIXurORG8X4/YllbGdNkm3I/jWD
         BJu0TCrmqoNItfJCdR8HkPbyLdkO43/UDO9DaYa3xdx3vVyQ44ThkdS59eCqG86ZEF
         6ZOKLHKR/L6A39x/gjwuGUnKD9bW7TyPEd4qsZuA=
X-Originating-IP: [92.22.33.100]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=k9WtyX7eyn4O4XzWYcPtUg==:117
 a=k9WtyX7eyn4O4XzWYcPtUg==:17 a=evINK-nbAAAA:8 a=DcKE_VfHSGu-Zgv__vIA:9
 a=StuRZpykkMuD6I4Q:21 a=11VeXigJ_t3lwADh:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/2] rebase -i: fix SIGSEGV when 'merge <branch>' fails
Date:   Wed, 15 Aug 2018 10:39:35 +0100
Message-Id: <20180815093935.10222-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180815093935.10222-1-phillip.wood@talktalk.net>
References: <20180815093935.10222-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfMyKQR6U31V/n15ChOv3uWws0brIcpbcCv3dYd57Yrxj+erNurTB7BjFLuunr7Wi6JO+MTwLKinYo3xNYcub/y4AkGtBE3o0sYnG9tEmrPtFkKLQxhm0
 HScA60qw+OIhJvFPkpQallr7xwcqj7pZo6ALhp9RDjJmcRJaTqiQkpj7+6lt87c0R7SmfvTl6kMvoONd0Wgn9vR5WRUXyTiU3tH5PWoVTrgaNDiqZVRfG7YC
 l85wuwPBtaSz29ENL5hedzKMtqzHkeYjPirQGw+GGPodevS1hnFPTnIKMkVSQql9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a merge command in the todo list specifies just a branch to merge
with no -C/-c argument then item->commit is NULL. This means that if
there are merge conflicts error_with_patch() is passed a NULL commit
which causes a segmentation fault when make_patch() tries to look it up.

This commit implements a minimal fix which fixes the crash and allows
the user to successfully commit a conflict resolution with 'git rebase
--continue'. It does not write .git/rebase-merge/patch,
.git/rebase-merge/stopped-sha or update REBASE_HEAD. To sensibly get the
hashes of the merge parents would require refactoring do_merge() to
extract the code that parses the merge parents into a separate function
which error_with_patch() could then use to write the parents into the
stopped-sha file. To create meaningful output make_patch() and 'git
rebase --show-current-patch' would also need to be modified to diff the
merge parent and merge base in this case.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c              | 24 +++++++++++++++++++-----
 t/t3430-rebase-merges.sh | 15 ++++++++++++++-
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4034c0461b..df49199175 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2590,8 +2590,12 @@ static int error_with_patch(struct commit *commit,
 	const char *subject, int subject_len,
 	struct replay_opts *opts, int exit_code, int to_amend)
 {
-	if (make_patch(commit, opts))
-		return -1;
+	if (commit) {
+		if (make_patch(commit, opts))
+			return -1;
+	} else if (copy_file(rebase_path_message(), git_path_merge_msg(), 0666))
+		return error(_("unable to copy '%s' to '%s'"),
+			     git_path_merge_msg(), rebase_path_message());
 
 	if (to_amend) {
 		if (intend_to_amend())
@@ -2604,9 +2608,19 @@ static int error_with_patch(struct commit *commit,
 			"Once you are satisfied with your changes, run\n"
 			"\n"
 			"  git rebase --continue\n", gpg_sign_opt_quoted(opts));
-	} else if (exit_code)
-		fprintf(stderr, "Could not apply %s... %.*s\n",
-			short_commit_name(commit), subject_len, subject);
+	} else if (exit_code) {
+		if (commit)
+			fprintf(stderr, "Could not apply %s... %.*s\n",
+				short_commit_name(commit),
+				subject_len, subject);
+		else
+			/*
+			 * We don't have the hash of the parent so
+			 * just print the line from the todo file.
+			 */
+			fprintf(stderr, "Could not merge %.*s\n",
+				subject_len, subject);
+	}
 
 	return exit_code;
 }
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 31fe4268d5..2e767d4f1e 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -129,7 +129,7 @@ test_expect_success '`reset` refuses to overwrite untracked files' '
 	git rebase --abort
 '
 
-test_expect_success 'failed `merge` writes patch (may be rescheduled, too)' '
+test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout -b conflicting-merge A &&
 
@@ -151,6 +151,19 @@ test_expect_success 'failed `merge` writes patch (may be rescheduled, too)' '
 	test_path_is_file .git/rebase-merge/patch
 '
 
+SQ="'"
+test_expect_success 'failed `merge <branch>` does not crash' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout conflicting-G &&
+
+	echo "merge G" >script-from-scratch &&
+	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
+	test_tick &&
+	test_must_fail git rebase -ir HEAD &&
+	! grep "^merge G$" .git/rebase-merge/git-rebase-todo &&
+	grep "^Merge branch ${SQ}G${SQ}$" .git/rebase-merge/message
+'
+
 test_expect_success 'with a branch tip that was cherry-picked already' '
 	git checkout -b already-upstream master &&
 	base="$(git rev-parse --verify HEAD)" &&
-- 
2.18.0

