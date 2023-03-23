Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ED8C76196
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjCWQrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjCWQrG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:06 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945DDFF31
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:34 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id DAD5024248
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-B0P-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 5/8] rebase: preserve interactive todo file on checkout failure
Date:   Thu, 23 Mar 2023 17:22:32 +0100
Message-Id: <20230323162235.995574-6-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Creating a suitable todo file is a potentially labor-intensive process,
so be less cavalier about discarding it when something goes wrong (e.g.,
the user messed with the repo while editing the todo).

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 builtin/rebase.c              | 1 +
 sequencer.c                   | 4 ++++
 sequencer.h                   | 1 +
 t/t3404-rebase-interactive.sh | 3 ++-
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index a309addd50..728c869db4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -153,6 +153,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
 	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
 	replay.verbose = opts->flags & REBASE_VERBOSE;
+	replay.precious_todo = opts->flags & REBASE_INTERACTIVE_EXPLICIT;
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.committer_date_is_author_date =
 					opts->committer_date_is_author_date;
diff --git a/sequencer.c b/sequencer.c
index b1c29c8802..f8a7f4e721 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4570,6 +4570,10 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 		.default_reflog_action = sequencer_reflog_action(opts)
 	};
 	if (reset_head(r, &ropts)) {
+		// Editing the todo may have been costly; don't just discard it.
+		if (opts->precious_todo)
+			exit(1);  // Error was already printed
+
 		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));
diff --git a/sequencer.h b/sequencer.h
index 1a3e616af2..a1b8ca6eb1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -47,6 +47,7 @@ struct replay_opts {
 	int keep_redundant_commits;
 	int verbose;
 	int quiet;
+	int precious_todo;
 	int reschedule_failed_exec;
 	int committer_date_is_author_date;
 	int ignore_date;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff0afad63e..c625aad10a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -288,13 +288,14 @@ test_expect_success 'abort' '
 '
 
 test_expect_success 'abort with error when new base cannot be checked out' '
+	test_when_finished "git rebase --abort ||:" &&
 	git rm --cached file1 &&
 	git commit -m "remove file in base" &&
 	test_must_fail git rebase -i primary > output 2>&1 &&
 	test_i18ngrep "The following untracked working tree files would be overwritten by checkout:" \
 		output &&
 	test_i18ngrep "file1" output &&
-	test_path_is_missing .git/rebase-merge &&
+	test_path_is_dir .git/rebase-merge &&
 	rm file1 &&
 	git reset --hard HEAD^
 '
-- 
2.40.0.152.g15d061e6df

