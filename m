Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FC1C433EF
	for <git@archiver.kernel.org>; Sun, 22 May 2022 04:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiEVEdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 00:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiEVEdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 00:33:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB2D3A5E3
        for <git@vger.kernel.org>; Sat, 21 May 2022 21:33:06 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BC701308B6;
        Sun, 22 May 2022 00:33:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=0
        sEFEjRhAjxIQscUnpZisZI+BN5epThch0VxiSVvEew=; b=sBS/cpo4I/Kr8HFDU
        nCdyjNjAGTTb1AGQGTIBjGl3wJedHIA8bFIULxOR1j1RF72IddhXPPZnzn9l7fMU
        Z9E/2LG6Sb/6m0z6aZUL3haYZFlWMAl6D0zGczUOilaOBhkw6QaGYxB0Q4OgDyZx
        WPImVV6TC3se3nuuNbPxN4MUl8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2326D1308B5;
        Sun, 22 May 2022 00:33:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53EE41308B3;
        Sun, 22 May 2022 00:33:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] revert: optionally refer to commit in the "reference" format
Date:   Sat, 21 May 2022 21:32:59 -0700
Message-ID: <xmqqsfp2b30k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43947D8C-D988-11EC-8DFA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A typical "git revert" commit uses the full title of the original
commit in its title, and starts its body of the message with:

    This reverts commit 8fa7f667cf61386257c00d6e954855cc3215ae91.

This does not encourage the best practice of describing not just
"what" (i.e. "Revert X" on the title says what we did) but "why"
(i.e. and it does not say why X was undesirable).

We can instead phrase this first line of the body to be more like

    This reverts commit 8fa7f667 (do this and that, 2022-04-25)

so that the title does not have to be

    Revert "do this and that"

We can instead use the title to describe "why" we are reverting the
original commit.

Introduce the "--reference" option to "git revert", and also the
revert.reference configuration variable, which defaults to false, to
tweak the title and the first line of the draft commit message for
when creating a "revert" commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/revert.txt |  3 +++
 Documentation/git-revert.txt    |  9 +++++++++
 builtin/revert.c                |  2 ++
 sequencer.c                     | 32 +++++++++++++++++++++++++++-----
 sequencer.h                     |  1 +
 t/t3501-revert-cherry-pick.sh   | 31 +++++++++++++++++++++++++++++++
 6 files changed, 73 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/config/revert.txt

diff --git a/Documentation/config/revert.txt b/Documentation/config/revert.txt
new file mode 100644
index 0000000000..797bfb6d62
--- /dev/null
+++ b/Documentation/config/revert.txt
@@ -0,0 +1,3 @@
+revert.reference::
+	Setting this variable to true makes `git revert` to behave
+	as if the `--reference` option is given.
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index bb92a4a451..8463fe9cf7 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -117,6 +117,15 @@ effect to your index in a row.
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
+--reference::
+	Instead of starting the body of the log message with "This
+	reverts <full object name of the commit being reverted>.",
+	refer to the commit using "--pretty=reference" format
+	(cf. linkgit:git-log[1]).  The `revert.reference`
+	configuration variable can be used to enable this option by
+	default.
+
+
 SEQUENCER SUBCOMMANDS
 ---------------------
 include::sequencer.txt[]
diff --git a/builtin/revert.c b/builtin/revert.c
index 51776abea6..ada51e46b9 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -116,6 +116,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			N_("option for merge strategy"), option_parse_x),
 		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_BOOL(0, "reference", &opts->commit_use_reference,
+			 N_("use the 'reference' format to refer to commits")),
 		OPT_END()
 	};
 	struct option *options = base_options;
diff --git a/sequencer.c b/sequencer.c
index a5f678f452..97abd5932b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -221,6 +221,9 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 		return ret;
 	}
 
+	if (!strcmp(k, "revert.reference"))
+		opts->commit_use_reference = git_config_bool(k, v);
+
 	status = git_gpg_config(k, v, NULL);
 	if (status)
 		return status;
@@ -2059,6 +2062,20 @@ static int should_edit(struct replay_opts *opts) {
 	return opts->edit;
 }
 
+static void refer_to_commit(struct replay_opts *opts,
+			    struct strbuf *msgbuf, struct commit *commit)
+{
+	if (opts->commit_use_reference) {
+		struct pretty_print_context ctx = {
+			.abbrev = DEFAULT_ABBREV,
+			.date_mode.type = DATE_SHORT,
+		};
+		format_commit_message(commit, "%h (%s, %ad)", msgbuf, &ctx);
+	} else {
+		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
+	}
+}
+
 static int do_pick_commit(struct repository *r,
 			  struct todo_item *item,
 			  struct replay_opts *opts,
@@ -2167,14 +2184,19 @@ static int do_pick_commit(struct repository *r,
 		base_label = msg.label;
 		next = parent;
 		next_label = msg.parent_label;
-		strbuf_addstr(&msgbuf, "Revert \"");
-		strbuf_addstr(&msgbuf, msg.subject);
-		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
-		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
+		if (!opts->commit_use_reference) {
+			strbuf_addstr(&msgbuf, "Revert \"");
+			strbuf_addstr(&msgbuf, msg.subject);
+			strbuf_addstr(&msgbuf, "\"");
+		} else {
+			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");
+		}
+		strbuf_addstr(&msgbuf, "\n\nThis reverts commit ");
+		refer_to_commit(opts, &msgbuf, commit);
 
 		if (commit->parents && commit->parents->next) {
 			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
-			strbuf_addstr(&msgbuf, oid_to_hex(&parent->object.oid));
+			refer_to_commit(opts, &msgbuf, parent);
 		}
 		strbuf_addstr(&msgbuf, ".\n");
 	} else {
diff --git a/sequencer.h b/sequencer.h
index da64473636..698599fe4e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -49,6 +49,7 @@ struct replay_opts {
 	int reschedule_failed_exec;
 	int committer_date_is_author_date;
 	int ignore_date;
+	int commit_use_reference;
 
 	int mainline;
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 8617efaaf1..36f9565b92 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -159,6 +159,7 @@ test_expect_success 'cherry-pick works with dirty renamed file' '
 '
 
 test_expect_success 'advice from failed revert' '
+	test_when_finished "git reset --hard" &&
 	test_commit --no-tag "add dream" dream dream &&
 	dream_oid=$(git rev-parse --short HEAD) &&
 	cat <<-EOF >expected &&
@@ -174,4 +175,34 @@ test_expect_success 'advice from failed revert' '
 	test_must_fail git revert HEAD^ 2>actual &&
 	test_cmp expected actual
 '
+
+test_expect_success 'identification of reverted commit (vanilla)' '
+	test_commit to-ident &&
+	test_when_finished "git reset --hard to-ident" &&
+	git checkout --detach to-ident &&
+	git revert --no-edit HEAD &&
+	git cat-file commit HEAD >actual.raw &&
+	grep "^This reverts " actual.raw >actual &&
+	echo "This reverts commit $(git rev-parse HEAD^)." >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'identification of reverted commit (reference)' '
+	git checkout --detach to-ident &&
+	git revert --reference --no-edit HEAD &&
+	git cat-file commit HEAD >actual.raw &&
+	grep "^This reverts " actual.raw >actual &&
+	echo "This reverts commit $(git show -s --pretty=reference HEAD^)." >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'identification of reverted commit (reference)' '
+	git checkout --detach to-ident &&
+	git -c revert.reference=true revert --no-edit HEAD &&
+	git cat-file commit HEAD >actual.raw &&
+	grep "^This reverts " actual.raw >actual &&
+	echo "This reverts commit $(git show -s --pretty=reference HEAD^)." >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.36.1-298-g81715a4e6d

