Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBEFC433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 06:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbiE0GBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 02:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241641AbiE0GBt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 02:01:49 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974DDFC7
        for <git@vger.kernel.org>; Thu, 26 May 2022 23:01:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14D2912A330;
        Fri, 27 May 2022 02:01:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=994V6HXQQarWHZaOPkDeFlOcbLAM7RO3lWA74b
        qOuZE=; b=YaK/VZBuH8SA6GeKS7bDYouFsixxrIaxg6GZCzrYOL7wwF53yUqM/A
        PekPx5RQvk2OpAKv5Jgl4l9HG6i4WfI9uLLmv0CTB1DoLFHIPcZpW8nOy+rWMyfG
        NVZOgYO3XyvQ+aZUMjZW3C/miPbiccuHVhw8SYNbRVH+aoXz3ROdI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3B6F12A32F;
        Fri, 27 May 2022 02:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 556CB12A32E;
        Fri, 27 May 2022 02:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v3] revert: optionally refer to commit in the "reference"
 format
References: <xmqqsfp2b30k.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205231507350.352@tvgsbejvaqbjf.bet>
        <xmqq35gzn9vk.fsf@gitster.g>
Date:   Thu, 26 May 2022 23:01:39 -0700
In-Reply-To: <xmqq35gzn9vk.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        23 May 2022 15:48:31 -0700")
Message-ID: <xmqq8rqn7buk.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A949D96-DD82-11EC-9BAD-5E84C8D8090B-77302942!pb-smtp1.pobox.com
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

When this option is in use, the first line of the pre-filled editor
buffer becomes a comment line that tells the user to say _why_.  If
the user exits the editor without touching this line by mistake,
what we prepare to become the first line of the body, i.e. "This
reverts commit 8fa7f667 (do this and that, 2022-04-25)", ends up to
be the title of the resulting commit.  This behaviour is designed to
help such a user to identify such a revert in "git log --oneline"
easily so that it can be further reworded with "git rebase -i" later.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The only difference since the second one is that the first line of
   the log message template is commented out and has asterisks to
   draw more attention.  The last paragraph (new) in the proposed
   log message explains the rationale behind this design.

   Third-time a charm, hopefully.

Range-diff against v2:
1:  4152fc2092 ! 1:  f4325a503a revert: optionally refer to commit in the "reference" format
    @@ Commit message
         tweak the title and the first line of the draft commit message for
         when creating a "revert" commit.
     
    +    When this option is in use, the first line of the pre-filled editor
    +    buffer becomes a comment line that tells the user to say _why_.  If
    +    the user exits the editor without touching this line by mistake,
    +    what we prepare to become the first line of the body, i.e. "This
    +    reverts commit 8fa7f667 (do this and that, 2022-04-25)", ends up to
    +    be the title of the resulting commit.  This behaviour is designed to
    +    help such a user to identify such a revert in "git log --oneline"
    +    easily so that it can be further reworded with "git rebase -i" later.
    +
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/config/revert.txt (new) ##
    @@ sequencer.c: static int do_pick_commit(struct repository *r,
     -		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
     -		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
     +		if (opts->commit_use_reference) {
    -+			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");
    ++			strbuf_addstr(&msgbuf,
    ++				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
     +		} else {
     +			strbuf_addstr(&msgbuf, "Revert \"");
     +			strbuf_addstr(&msgbuf, msg.subject);

 Documentation/config/revert.txt |  3 +++
 Documentation/git-revert.txt    |  9 +++++++++
 builtin/revert.c                |  2 ++
 sequencer.c                     | 33 ++++++++++++++++++++++++++++-----
 sequencer.h                     |  1 +
 t/t3501-revert-cherry-pick.sh   | 31 +++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 5 deletions(-)
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
index a5f678f452..96fec6ef6d 100644
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
@@ -2167,14 +2184,20 @@ static int do_pick_commit(struct repository *r,
 		base_label = msg.label;
 		next = parent;
 		next_label = msg.parent_label;
-		strbuf_addstr(&msgbuf, "Revert \"");
-		strbuf_addstr(&msgbuf, msg.subject);
-		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
-		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
+		if (opts->commit_use_reference) {
+			strbuf_addstr(&msgbuf,
+				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
+		} else {
+			strbuf_addstr(&msgbuf, "Revert \"");
+			strbuf_addstr(&msgbuf, msg.subject);
+			strbuf_addstr(&msgbuf, "\"");
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
index 8617efaaf1..a386ae9e88 100755
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
+test_expect_success 'identification of reverted commit (default)' '
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
+test_expect_success 'identification of reverted commit (--reference)' '
+	git checkout --detach to-ident &&
+	git revert --reference --no-edit HEAD &&
+	git cat-file commit HEAD >actual.raw &&
+	grep "^This reverts " actual.raw >actual &&
+	echo "This reverts commit $(git show -s --pretty=reference HEAD^)." >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'identification of reverted commit (revert.reference)' '
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
2.36.1-331-g1b5d92e060

