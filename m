Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C32FC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 16:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC5F61260
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 16:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJTQa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 12:30:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58158 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhJTQa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 12:30:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 639F2F36D8;
        Wed, 20 Oct 2021 12:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X23Z0KxjcqcTbGhK6yi5G7noWjxSPZFA+pDFC/
        ytee0=; b=sZriFwgqmo1yaH/mCkc/7hNXtsH/DhnL3scAw73XNAWGwzDETx0sPe
        t3Y43Liy2ao1Yud4TQtJfH15h+iUg0crcU7cybZPjhLlr79iVxOJ63uTXK3vaJGg
        S+hMUPjwQVvT0uSwWhWHmbEqRbFtUVGjsF9NEQCgcJa0TyXjN1pM0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A534F36D7;
        Wed, 20 Oct 2021 12:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BB5DF36D5;
        Wed, 20 Oct 2021 12:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kenneth Arnold <ka37@calvin.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "Not possible to fast-forward" when pull.ff=only and new
 commits on remote
References: <CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com>
        <YW83JG9t2JaX92xV@coredump.intra.peff.net>
Date:   Wed, 20 Oct 2021 09:28:08 -0700
In-Reply-To: <YW83JG9t2JaX92xV@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 19 Oct 2021 17:22:44 -0400")
Message-ID: <xmqqzgr3pso7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6671AC2-31C2-11EC-A75F-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks for reporting, this is an interesting case. I agree that it
> probably ought to continue to be a noop. There is nothing to pull, and
> so the question of ff-versus-merge should not even enter into it.

Probably something along this line?  Hasn't been tested beyond
compiling and passing

    $ git checkout master && ./git pull --ff-only -v . maint

but that should be sufficient, I hope.


 builtin/pull.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git c/builtin/pull.c w/builtin/pull.c
index ae9f5bd7cc..d925999543 100644
--- c/builtin/pull.c
+++ w/builtin/pull.c
@@ -931,6 +931,33 @@ static int get_can_ff(struct object_id *orig_head,
 	return ret;
 }
 
+/*
+ * Is orig_head is a descendant of _all_ merge_heads?
+ * Unfortunately is_descendant_of() cannot be used as it 
+ * asks if orig_head is a descendant of at least one of them.
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
@@ -1072,7 +1099,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	/* ff-only takes precedence over rebase */
 	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
-		if (!can_ff)
+		if (!can_ff && !already_up_to_date(&orig_head, &merge_heads))
 			die_ff_impossible();
 		opt_rebase = REBASE_FALSE;
 	}
