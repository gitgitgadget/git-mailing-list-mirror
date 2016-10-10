Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44EF20989
	for <e@80x24.org>; Mon, 10 Oct 2016 22:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbcJJWNq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 18:13:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59897 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751743AbcJJWNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 18:13:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7B1B46B2D;
        Mon, 10 Oct 2016 18:13:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=usfM9+rOO2DvA1cXQALVxKdsghE=; b=fnssW0
        2hZifEhmc6htks+2KhXXwWHZ2lQGb//tUKpLFqVhYtHtjR46dNzLxKoUYeSQaiqf
        1arrW1ltnYcilrl/MDHt/kTapu2zxkhYLFUE8BWLiUvpQ9NM2nVq9qDkG9N8vqbN
        bMobPmDlJQE9iOxetyLCr8a1l4Zt4plL1uPuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eqATyScoeojWg4Ujt34Plpsjwvs6Se5k
        r11CP3bVFNLDUYOj2yPPTp3F9LEaH35nv5dS9EDkMmn3SiOmnggxp+829JsiE0Qg
        IqfEC1MvHpdVwO6rxQJBqQO7TWu5yQyWbH/BH0OqGxZKAwHt/Nd3UyZuKp77rrNj
        RaVMkPLJxeI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0E2046B2C;
        Mon, 10 Oct 2016 18:13:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48CFC46B2B;
        Mon, 10 Oct 2016 18:13:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script parsing
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de>
Date:   Mon, 10 Oct 2016 15:13:31 -0700
In-Reply-To: <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 10 Oct 2016 19:25:07 +0200
        (CEST)")
Message-ID: <xmqqlgxvdf90.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C850B48E-8F36-11E6-BC2E-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Let's just bite the bullet and rewrite the entire parser; the code now
> ...
> In particular, we choose to maintain the list of commands in an array
> instead of a linked list: this is flexible enough to allow us later on to
> even implement rebase -i's reordering of fixup!/squash! commits very
> easily (and with a very nice speed bonus, at least on Windows).
>
> While at it, do not stop at the first problem, but list *all* of the
> problems. This will help the user when the sequencer will do `rebase
> -i`'s work by allowing to address all issues in one go rather than going
> back and forth until the todo list is valid.

All sounds sensible.

>  	if (parent && parse_commit(parent) < 0)
> -		/* TRANSLATORS: The first %s will be "revert" or
> -		   "cherry-pick", the second %s a SHA1 */
> +		/*
> +		 * TRANSLATORS: The first %s will be a "todo" command like
> +		 * "revert" or "pick", the second %s a SHA1.
> +		 */

You may want to double check this with i18n folks; IIRC the tool
that extracts TRANSLATORS: comment was somewhat particular about
where that magic "TRANSLATORS:" token resides on a comment line and
that is why we have this multi-line comment formatted in an unusual
way.

Ahh, no you do not have to bug i18n folks.  47fbfded53 ("i18n: only
extract comments marked with "TRANSLATORS:"", 2014-04-17) is an
example of such an adjustment.

I just found it in CodingGuidelines, cbcfd4e3ea ("i18n: mention
"TRANSLATORS:" marker in Documentation/CodingGuidelines",
2014-04-18).

> +	while ((commit = get_revision(opts->revs))) {
> +		struct todo_item *item = append_new_todo(todo_list);
> +		const char *commit_buffer = get_commit_buffer(commit, NULL);
> +		const char *subject;
> +		int subject_len;
> +
> +		item->command = command;
> +		item->commit = commit;
> +		item->offset_in_buf = todo_list->buf.len;
> +		subject_len = find_commit_subject(commit_buffer, &subject);
> +		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
> +			find_unique_abbrev(commit->object.oid.hash,
> +				DEFAULT_ABBREV),
> +			subject_len, subject);

I am personally fine with this line; two things come to mind:

 - This would work just fine as-is with Linus's change to turn
   DEFAULT_ABBREV to -1.

 - It appears that it is more fashionable to use
   strbuf_add_unique_abbrev() these days.

Thanks.
