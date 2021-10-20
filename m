Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00363C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 19:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D4C611EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 19:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhJTTE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:04:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54214 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhJTTE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 15:04:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9046CE208A;
        Wed, 20 Oct 2021 15:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=qk5vpwZbXtWypreXxb0dhX5CEK0XTdvMP4oCpnJ4Ucs=; b=Wpxw
        LyWlFyIFVoUa/sK8OisCjZtMnP4clb465gFKR53kRvD5bbZ5sJvXOK8uCqjVbgzc
        9+2vuAmBVQUtE8t5TrbtACyuMdeIT+620A08vxfUc+OxkKrQ48MzYrxhFytICb/q
        znDAJFiJofgGU7On/+OJVCCxY27x+nx9KY7Kqag=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 850E7E2088;
        Wed, 20 Oct 2021 15:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C53BDE2087;
        Wed, 20 Oct 2021 15:02:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Kenneth Arnold <ka37@calvin.edu>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] pull: --ff-only should make it a noop when
 already-up-to-date
References: <CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com>
        <YW83JG9t2JaX92xV@coredump.intra.peff.net>
        <xmqqzgr3pso7.fsf@gitster.g>
Date:   Wed, 20 Oct 2021 12:02:09 -0700
Message-ID: <xmqqh7dbplji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AA67E30-31D8-11EC-B92A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier, we made sure that "git pull --ff-only" (and "git -c
pull.ff=only pull") errors out when our current HEAD is not an
ancestor of the tip of the history we are merging, but the condition
to trigger the error was implemented incorrectly.

Imagine you forked from a remote branch, built your history on top
of it, and then attempted to pull from them again.  If they have not
made any update in the meantime, our current HEAD is obviously not
their ancestor, and this new error triggers.

Without the --ff-only option, we just report that there is no need
to pull; we did the same historically with --ff-only, too.

Make sure we do not fail with the recently added check to restore
the historycal behaviour.

Reported-by: Kenneth Arnold <ka37@calvin.edu>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * With tests and a proposed log message.

 builtin/pull.c               | 29 ++++++++++++++++++++++++++++-
 t/t7601-merge-pull-config.sh | 16 +++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index b311ea6b9d..05f1f0e446 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -933,6 +933,33 @@ static int get_can_ff(struct object_id *orig_head,
 	return ret;
 }
 
+/*
+ * Is orig_head is a descendant of _all_ merge_heads?
+ * unfortunately is_descendant_of() cannot be used as it is to
+ * ask if orig_head is a descendant of at least one of them.
+ */
+static int already_up_to_date(struct object_id *orig_head,
+			      struct oid_array *merge_heads)
+{
+	int i;
+	struct commit *ours;
+
+	ours = lookup_commit_reference(the_repository, orig_head);
+	for (i = 0; i < merge_heads->nr; i++) {
+		struct commit_list *list = NULL;
+		struct commit *theirs;
+		int ok;
+
+		theirs = lookup_commit_reference(the_repository, &merge_heads->oid[i]);
+		commit_list_insert(theirs, &list);
+		ok = repo_is_descendant_of(the_repository, ours, list);
+		free_commit_list(list);
+		if (!ok)
+			return 0;
+	}
+	return 1;
+}
+
 static void show_advice_pull_non_ff(void)
 {
 	advise(_("You have divergent branches and need to specify how to reconcile them.\n"
@@ -1074,7 +1101,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	/* ff-only takes precedence over rebase */
 	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
-		if (!can_ff)
+		if (!can_ff && !already_up_to_date(&orig_head, &merge_heads))
 			die_ff_impossible();
 		opt_rebase = REBASE_FALSE;
 	}
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 1f652f433e..6275641b9c 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -2,7 +2,7 @@
 
 test_description='git merge
 
-Testing pull.* configuration parsing.'
+Testing pull.* configuration parsing and other things.'
 
 . ./test-lib.sh
 
@@ -387,6 +387,20 @@ test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
 	test_must_fail git pull . c3
 '
 
+test_expect_success 'already-up-to-date pull succeeds with "only" in pull.ff' '
+	git reset --hard c1 &&
+	test_config pull.ff only &&
+	git pull . c0 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
+'
+
+test_expect_success 'already-up-to-date pull/rebase succeeds with "only" in pull.ff' '
+	git reset --hard c1 &&
+	test_config pull.ff only &&
+	git -c pull.rebase=true pull . c0 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
+'
+
 test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
 	git reset --hard c1 &&
 	git config pull.twohead ours &&
-- 
2.33.1-904-gfba30156dd


