Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D848C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 22:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiEWWsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 18:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiEWWsg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 18:48:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F08652B0B
        for <git@vger.kernel.org>; Mon, 23 May 2022 15:48:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E6DE11EBBA;
        Mon, 23 May 2022 18:48:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9Ltazm6RSsQXaTMaEjONEcyo0WXCRANNV7HHKv08m3s=; b=wP31
        cC6eRsa5P+rb1Q3nV+h6nJ32WK0LxILvDhf6IqvrY1eoLApVrA1O/d5VjSalhn1Q
        yh2x+f0CWeyRY291/Ut9hXFSt4gZ0yESeNwjIbKQBBq88rs3FhLg1UxE6a9SCre3
        sGMCEEj8UTlvMw/CLG2Pgyl7/R6SHUXo/Kc5zLA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 768D811EBB9;
        Mon, 23 May 2022 18:48:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE1C711EBB4;
        Mon, 23 May 2022 18:48:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revert: optionally refer to commit in the "reference"
 format
References: <xmqqsfp2b30k.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205231507350.352@tvgsbejvaqbjf.bet>
Date:   Mon, 23 May 2022 15:48:31 -0700
Message-ID: <xmqq35gzn9vk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78FC2B1A-DAEA-11EC-B095-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Good idea, the `reference` text is so much more pleasant to read (and it
> also makes things somewhat proof against rebasing and transitioning to
> SHA-256).

Never thought of that myself.  It does sound like another good
reason to see if this is a good alternative format to use.

> At some stage, we may even default to `revert.reference=true`?

Perhaps.  Wasn't planning to propose that in any near future,
either, though.  I would prefer to never think about changing the
default in the future when considering a new feature.  It should be
done as two separate steps (except that care must be taken so that
the feature could become default if we choose to).

>> +--reference::
>> ...
>> +	default.
>> +
>> +
>
> Is that extra empty line intentional?

It is very much so.  A single blank between each items in the
section, a larger blank between two sections, is what I aimed at
here.

>> +		if (!opts->commit_use_reference) {
>> +			strbuf_addstr(&msgbuf, "Revert \"");
>> +			strbuf_addstr(&msgbuf, msg.subject);
>> +			strbuf_addstr(&msgbuf, "\"");
>> +		} else {
>> +			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");
>> +		}
>
> We often tell newcomers that we prefer the shorter conditional block to
> come first. Maybe you want to do that here, too? I don't mind the current
> form, though.

Good point, but that is more applicable to new code (and not limited
to newcomers).  We also tell that your new feature is often not any
more important than the existing code, and think twice before
prepending the new code to existing code (iow, by default new code
should be appended, unless there is a good reason not to).

I kept the original behaviour first with optional new action as a
follow-up.  Besides, 3-line block is not all that larger than a
single-line block, and this did not trigger my "that one is larger"
sensor.

Let me try swapping the order.

>> @@ -174,4 +175,34 @@ test_expect_success 'advice from failed revert' '
>>  	test_must_fail git revert HEAD^ 2>actual &&
>>  	test_cmp expected actual
>>  '
>> +
>> +test_expect_success 'identification of reverted commit (vanilla)' '
>
> It might make sense to replace "vanilla" by "default format".

Sounds very sensible; thanks.

>> +	test_commit to-ident &&
>> +	test_when_finished "git reset --hard to-ident" &&
>> +	git checkout --detach to-ident &&
>> +	git revert --no-edit HEAD &&
>> +	git cat-file commit HEAD >actual.raw &&
>> +	grep "^This reverts " actual.raw >actual &&
>> +	echo "This reverts commit $(git rev-parse HEAD^)." >expect &&
>
> I was a bit puzzled about this dance, as I had expected this instead:
>
> 	grep "^This reverts commit $(git rev-parse HEAD^)\\.$" actual.raw
>
> but I guess you wanted to make sure that the file contents of `actual` are
> shown if no match was found?

My thought process was much simpler.

"^This reverts" is common in both formats, so grep would extract the
commit reference(s) the command would have made to "actual".

What we need to make sure with the test_cmp are multifold.  We want
to make sure that the reference is made in the right format, refers
to the right commit, and we show the reference exactly the expected
number (i.e. one) of times.  So it was simpler to do so in a step
separate from the "extraction" step above.  We could go looser and
use test_contains but I usually try to avoid deliberately to be
loose.

>> +test_expect_success 'identification of reverted commit (reference)' '
>> +	git checkout --detach to-ident &&
>> +	git revert --reference --no-edit HEAD &&
>> +	git cat-file commit HEAD >actual.raw &&
>> +	grep "^This reverts " actual.raw >actual &&
>> +	echo "This reverts commit $(git show -s --pretty=reference HEAD^)." >expect &&
>> +	test_cmp expect actual
>> +'
>
> If it was up to me, I would combine these three test cases, if only to
> help the `--run=<single-number>` case (the latter two depend on the side
> effect of the first one to create a `to-ident` tag).

I wonder if our prereq infrastructure is lightweight and scalable
enough so that we can easily add a support a pseudo-prerequisite
PREVIOUS that lets us say

	test_expect_success PREVIOUS "identification ..." '
		...
	'

to mean that this test requires the previous test has not been
skipped.

Then we can organize them into four (one to create to-ident commit,
one uses vanilla, one uses --reference and one uses revert.reference),
and make the latter three depend on their previous step.

>> +test_expect_success 'identification of reverted commit (reference)' '
>> +	git checkout --detach to-ident &&
>> +	git -c revert.reference=true revert --no-edit HEAD &&
>> +	git cat-file commit HEAD >actual.raw &&
>> +	grep "^This reverts " actual.raw >actual &&
>> +	echo "This reverts commit $(git show -s --pretty=reference HEAD^)." >expect &&
>> +	test_cmp expect actual
>> +'
>> +
>>  test_done

Thanks for taking a look.

--- >8 ---
Subject: [PATCH v2] revert: optionally refer to commit in the "reference" format

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
Range-diff:
1:  26b60b56c0 ! 1:  c5b11efe7d revert: optionally refer to commit in the "reference" format
    @@ sequencer.c: static int do_pick_commit(struct repository *r,
     -		strbuf_addstr(&msgbuf, msg.subject);
     -		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
     -		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
    -+		if (!opts->commit_use_reference) {
    ++		if (opts->commit_use_reference) {
    ++			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");
    ++		} else {
     +			strbuf_addstr(&msgbuf, "Revert \"");
     +			strbuf_addstr(&msgbuf, msg.subject);
     +			strbuf_addstr(&msgbuf, "\"");
    -+		} else {
    -+			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");
     +		}
     +		strbuf_addstr(&msgbuf, "\n\nThis reverts commit ");
     +		refer_to_commit(opts, &msgbuf, commit);
    @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'advice from failed revert' '
      	test_cmp expected actual
      '
     +
    -+test_expect_success 'identification of reverted commit (vanilla)' '
    ++test_expect_success 'identification of reverted commit (default)' '
     +	test_commit to-ident &&
     +	test_when_finished "git reset --hard to-ident" &&
     +	git checkout --detach to-ident &&
    @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'advice from failed revert' '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'identification of reverted commit (reference)' '
    ++test_expect_success 'identification of reverted commit (--reference)' '
     +	git checkout --detach to-ident &&
     +	git revert --reference --no-edit HEAD &&
     +	git cat-file commit HEAD >actual.raw &&
    @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'advice from failed revert' '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'identification of reverted commit (reference)' '
    ++test_expect_success 'identification of reverted commit (revert.reference)' '
     +	git checkout --detach to-ident &&
     +	git -c revert.reference=true revert --no-edit HEAD &&
     +	git cat-file commit HEAD >actual.raw &&

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
index a5f678f452..92d301f0c4 100644
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
+		if (opts->commit_use_reference) {
+			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");
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
2.36.1-312-ge077cd1662

