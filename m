Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E39C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 21:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhLTVaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 16:30:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55610 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhLTVaL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 16:30:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42F30FC301;
        Mon, 20 Dec 2021 16:30:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KvsR4BtIaA169hEwxFyHQSIQLgR+usa0t/P45m
        2Xtho=; b=ZEjmXl7mY9t7fFShlGq1R/XJGtCNmJHzOyOt+l4eaxEppPws8wSHPW
        TUPasio12GVkA/ezibm9zUnuwAl1PCinhXGFG43UzIPHOr0LpxAMzI5MXutJfiRP
        /ms76SesSiYzOUcOeFVyJ25XJ9qXuJ1sk0qgzcWbltA5IjHVU5v98=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28D8CFC2FF;
        Mon, 20 Dec 2021 16:30:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C8C9FC2FE;
        Mon, 20 Dec 2021 16:30:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] builtin add -p: fix hunk splitting
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
        <5d5639c2b0474680850b7adbb7c5ec81d124eb50.1640010777.git.gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 13:30:08 -0800
In-Reply-To: <5d5639c2b0474680850b7adbb7c5ec81d124eb50.1640010777.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 20 Dec 2021 14:32:57
        +0000")
Message-ID: <xmqq4k73ufq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01E2BE40-61DC-11EC-82AD-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> To determine whether a hunk can be split a counter is incremented each
> time a context line follows an insertion or deletion. If at the end of
> the hunk the value of this counter is greater than one then the hunk
> can be split into that number of smaller hunks. If the last hunk in a
> file ends with an insertion or deletion then there is no following
> context line and the counter will not be incremented. This case is
> already handled at the end of the loop where counter is incremented if
> the last hunk ended with an insertion or deletion. Unfortunately there
> is no similar check between files (likely because the perl version
> only ever parses one diff at a time).

In other words, the original laid out the code in such a way that
such a bug will be impossible, and the rewrite broke it because it
rolled both "next file" and "next hunk" into the same loop?

> Fix this by checking if the last
> hunk ended with an insertion or deletion when we see the diff header
> of a new file and extend the existing regression test.

You should be able to explain what end-user visible bug is in a
simple single sentence before all of the above.

"The C reimplementation of 'add -p' fails to split a hunk when the
hunk ends with addition or deletion without post context line." or
something like that.

>  		if (starts_with(p, "diff ")) {
> +			if (marker == '-' || marker == '+')
> +				/*
> +				 * Last hunk ended in non-context line (i.e. it
> +				 * appended lines to the file, so there are no
> +				 * trailing context lines).
> +				 */
> +				hunk->splittable_into++;

This looks correct but unsatisfactory.  We have the same processing
immediately after loop---what is common between them is that this is
a process to "conclude" the hunks for the file we have been reading
the patch for.

Can we at least make a helper function that identifies what it does
clearly by its name, and use it here and after the loop, to clarify
what is going on?  Then you do not need the 5-line comment there.

		if (starts_with(p, "diff ")) {
+			conclude_file(hunk, marker);

or something like that, perhaps.

Thanks.
