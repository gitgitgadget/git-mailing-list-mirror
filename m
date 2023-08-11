Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14EAEB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbjHKRoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbjHKRox (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:44:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B95430D7
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:44:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71EA018D763;
        Fri, 11 Aug 2023 13:44:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tMx4wZTPCrrhCINPVHUf4M8RKRT/NkgGHgjkqz
        l0uvU=; b=MoNPWx7Uns9ayfidLAFurnaXLYKK6L/r3WS3gnQ7S0TuAWP8h4M3to
        TFzv1Gitf42a5wBJfhi7YoUSXKT4ZzaBhP7gYas2qobugmSesZ+5YOTnC7yzxaS5
        ufsTnJtOcY21i404jvE58mf8F8Xy4th4bseJR5sxItHPPvU1GwGro=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A8EE18D762;
        Fri, 11 Aug 2023 13:44:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D3AC818D761;
        Fri, 11 Aug 2023 13:44:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re* [PATCH v3 2/2] doc: revert: add discussion
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
        <owly8raih8ho.fsf@fine.c.googlers.com> <xmqqsf8ptsqf.fsf@gitster.g>
Date:   Fri, 11 Aug 2023 10:44:50 -0700
In-Reply-To: <xmqqsf8ptsqf.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        11 Aug 2023 10:05:12 -0700")
Message-ID: <xmqq5y5ltqwd.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C641AAAC-386E-11EE-96F9-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>>
>>> while thinking about what to write, i came up with an idea for another
>>> improvement: with (implicit) --edit, the template message would end up
>>> being:
>>>
>>>  This reverts commit <sha1>,
>>>  because <PUT REASON HERE>.
>>
>> This sounds great to me.
>
> Oh, absolutely.  I rarely do a revert myself (other than reverting a
> premature merge out of 'next'), but giving a better instruction in
> the commit log editor buffer as template is a very good idea.

It might be just the matter of doing something like the attached
patch on top of Oswald's, reusing the existing code to instruct the
user to describe the reversion.

------- >8 ------------- >8 ------------- >8 ------------- >8 -------
Subject: [PATCH 3/2] revert: force explaining overly complex revert chain

Once we revert reverts of revert and reach "Reapply "Reapply "..."",
it becomes too unweirdly to read a reversion of such a comit.

We instruct the user to explain why the reversion is done in their
own words when using the revert.reference mode, and the instruction
applies equally for such an overly complex revert chain.  The
rationale for such a sequence of events should be recorded to help
future developers.

Building on top of the recent Oswald's work to turn "revert revert"
into "reapply", let's turn the reference mode automatically on in
such a case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I left the reference to the second parent to honor the command
   line option and configuration variable even when this new
   mechanism kicks in and this is very much deliberate.  As a commit
   that is a revert (or reapply) should be single parent (because a
   revert of a merge is a single parent commit), the choice does not
   make any difference in practice.

 sequencer.c                   | 16 +++++++++++-----
 t/t3501-revert-cherry-pick.sh | 11 ++++++++++-
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git c/sequencer.c w/sequencer.c
index 7dc13fdcca..43bb558518 100644
--- c/sequencer.c
+++ w/sequencer.c
@@ -2130,10 +2130,10 @@ static int should_edit(struct replay_opts *opts) {
 	return opts->edit;
 }
 
-static void refer_to_commit(struct replay_opts *opts,
+static void refer_to_commit(int use_reference,
 			    struct strbuf *msgbuf, struct commit *commit)
 {
-	if (opts->commit_use_reference) {
+	if (use_reference) {
 		struct pretty_print_context ctx = {
 			.abbrev = DEFAULT_ABBREV,
 			.date_mode.type = DATE_SHORT,
@@ -2250,12 +2250,18 @@ static int do_pick_commit(struct repository *r,
 
 	if (command == TODO_REVERT) {
 		const char *orig_subject;
+		int use_reference = opts->commit_use_reference;
 
 		base = commit;
 		base_label = msg.label;
 		next = parent;
 		next_label = msg.parent_label;
-		if (opts->commit_use_reference) {
+
+		if (starts_with(msg.subject, "Reapply \"Reapply \""))
+			/* fifth time is too many - force reference format*/
+			use_reference = 1;
+
+		if (use_reference) {
 			strbuf_addstr(&msgbuf,
 				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
 		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
@@ -2273,11 +2279,11 @@ static int do_pick_commit(struct repository *r,
 			strbuf_addstr(&msgbuf, "\"");
 		}
 		strbuf_addstr(&msgbuf, "\n\nThis reverts commit ");
-		refer_to_commit(opts, &msgbuf, commit);
+		refer_to_commit(use_reference, &msgbuf, commit);
 
 		if (commit->parents && commit->parents->next) {
 			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
-			refer_to_commit(opts, &msgbuf, parent);
+			refer_to_commit(opts->commit_use_reference, &msgbuf, parent);
 		}
 		strbuf_addstr(&msgbuf, ".\n");
 	} else {
diff --git c/t/t3501-revert-cherry-pick.sh w/t/t3501-revert-cherry-pick.sh
index 7011e3a421..7a8715d3f4 100755
--- c/t/t3501-revert-cherry-pick.sh
+++ w/t/t3501-revert-cherry-pick.sh
@@ -190,7 +190,16 @@ test_expect_success 'title of fresh reverts' '
 	git revert --no-edit HEAD &&
 	echo "Revert \"Reapply \"B\"\"" >expect &&
 	git log -1 --pretty=%s >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	git revert --no-edit HEAD &&
+	echo "Reapply \"Reapply \"B\"\"" >expect &&
+	git log -1 --pretty=%s >actual &&
+	test_cmp expect actual &&
+
+	# Give the stronger instruction for unusually complex case
+	git revert --no-edit HEAD &&
+	git log -1 --pretty=%s >actual &&
+	grep -F -e "# *** SAY WHY WE ARE REVERTING" actual
 '
 
 test_expect_success 'title of legacy double revert' '
