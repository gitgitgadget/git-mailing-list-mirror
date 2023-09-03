Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B66FC83F2C
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 15:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243194AbjICPLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238696AbjICPLi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 11:11:38 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2B5115
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 08:11:34 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 8F350243A6;
        Sun,  3 Sep 2023 11:11:32 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qcolA-6IB-00; Sun, 03 Sep 2023 17:11:32 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] sequencer: update abort safety file more sparingly
Date:   Sun,  3 Sep 2023 17:11:32 +0200
Message-Id: <20230903151132.739166-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only situation where the file's content matters is --continue'ing
(after a multi-cherry-pick merge conflict). This means that it is
sufficient to write it in a single place, when we are prematurely
exiting the main workhorse. This is much easier to reason about than the
three dispersed calls originally introduced in 1e41229d ("sequencer:
make sequencer abort safer", 2016-12-07). We now can also remove the
inefficient file-based check whether the file needs writing, which
wasn't even reliable: a single pick executed during an interrupted
sequence would bypass the safety.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
Cc: Stephan Beyer <s-beyer@gmx.net>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 sequencer.c                     | 9 ++-------
 t/t3510-cherry-pick-sequence.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a66dcf8ab2..716384cc7b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -575,10 +575,6 @@ static void update_abort_safety_file(void)
 {
 	struct object_id head;
 
-	/* Do nothing on a single-pick */
-	if (!file_exists(git_path_seq_dir()))
-		return;
-
 	if (!repo_get_oid(the_repository, "HEAD", &head))
 		write_file(git_path_abort_safety_file(), "%s", oid_to_hex(&head));
 	else
@@ -618,7 +614,6 @@ static int fast_forward_to(struct repository *r,
 	strbuf_release(&sb);
 	strbuf_release(&err);
 	ref_transaction_free(transaction);
-	update_abort_safety_file();
 	return 0;
 }
 
@@ -2435,7 +2430,6 @@ static int do_pick_commit(struct repository *r,
 	free_message(commit, &msg);
 	free(author);
 	strbuf_release(&msgbuf);
-	update_abort_safety_file();
 
 	return res;
 }
@@ -5269,8 +5263,9 @@ int sequencer_pick_revisions(struct repository *r,
 		return -1;
 	if (save_opts(opts))
 		return -1;
-	update_abort_safety_file();
 	res = pick_commits(r, &todo_list, opts);
+	if (todo_list.current < todo_list.nr)
+		update_abort_safety_file();
 	todo_list_release(&todo_list);
 	return res;
 }
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 3b0fa66c33..170b664c33 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -318,6 +318,15 @@ test_expect_success '--abort does not unsafely change HEAD' '
 	test_cmp_rev base HEAD
 '
 
+test_expect_success '--abort after single pick does not unsafely change HEAD' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick picked anotherpick &&
+	git reset --hard &&
+	git cherry-pick unrelatedpick &&
+	git cherry-pick --abort 2>actual &&
+	test_i18ngrep "You seem to have moved HEAD" actual
+'
+
 test_expect_success 'cherry-pick --abort to cancel multiple revert' '
 	pristine_detach anotherpick &&
 	test_expect_code 1 git revert base..picked &&
-- 
2.40.0.152.g15d061e6df

