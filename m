Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75B1C432C3
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 04:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6702073F
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 04:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VHFaT8Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKXEtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 23:49:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53066 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKXEto (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 23:49:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 61D9FA2B0D;
        Sat, 23 Nov 2019 23:49:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=n1XFm3A5xLlV
        NlqBK9s5mXKblOg=; b=VHFaT8Q2d3q27jdSYje3ky6uMBhN56g1jGkNDHOx0hOW
        U7yDAaWeNvG4bmcDCjbyBrm/c/DF8exSKXiot16Pi4MkcXh0cvId+f0GPlHyr6AY
        3skJCCGOoDRISd2djUV9AnGzL51/9bMhtIt7Vhm7mJ52QiDVUQULLEE4k1Wz9Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Psiwz5
        sAuKK0aMFQrK9k22/8Qo+5cCv7rY5sc57eZYo5VJ6S2ldGIhr+4atzalv3/8qGO3
        BTNmIwBuDDiEbcDTrOQjrjASbL4pNa27Bz0n9f/6UjFluBH4Rw9VbMnEhyCIFO7c
        TFBgd65XXqj3bl9E8YDZLDhbfZa/N/oXOx3tk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5ABA7A2B0C;
        Sat, 23 Nov 2019 23:49:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7EEACA2B09;
        Sat, 23 Nov 2019 23:49:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] sequencer: don't re-read todo for revert and cherry-pick
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
        <20191123172046.16359-1-szeder.dev@gmail.com>
Date:   Sun, 24 Nov 2019 13:49:33 +0900
In-Reply-To: <20191123172046.16359-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sat, 23 Nov 2019 18:20:46 +0100")
Message-ID: <xmqqk17p280y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D03567FA-0E75-11EA-91F1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> When 'git revert' or 'git cherry-pick --edit' is invoked with multiple
> commits, then after editing the first commit message is finished both

"commits, then after editing the first commit message, both of" I
would say.

> these commands should continue with processing the second commit and
> launch another editor for its commit message, assuming there are
> no conflicts, of course.
>
> Alas, this inadvertently changed with commit a47ba3c777 (rebase -i:
> check for updated todo after squash and reword, 2019-08-19): after
> editing the first commit message is finished, both 'git revert' and
> 'git cherry-pick --edit' exit with error, claiming that "nothing to
> commit, working tree clean".
> ...
>   - When invoking 'git revert' or 'git cherry-pick --edit' with
>     multiple commits they don't read a todo list file but assemble the
>     todo list in memory, thus the associated stat data used to check
>     whether the file has been updated is all zeroed out initially.
>
>     Then the sequencer writes all instructions (including the very
>     first) to the todo file, executes the first 'revert/pick'
>     instruction, and after the user finished editing the commit
>     message the changes of a47ba3c777 kick in, and it checks whether
>     the todo file has been modified.  The initial all-zero stat data
>     obviously differs from the todo file's current stat data, so the
>     sequencer concludes that the file has been modified.  Technically
>     it is not wrong, of course, because the file just has been written
>     indeed by the sequencer itself, though the file's contents still
>     match what the sequencer was invoked with in the beginning.
>     Consequently, after re-reading the todo file the sequencer
>     executes the same first instruction _again_, thus ending up in
>     that "nothing to commit" situation.

Hmph, that makes it sound as if the right fix is to re-read after
writing the first version of the todo file out, so that the stat
data matches reality and tells us that it has never been modified?

> The todo list was never meant to be edited during multi-commit 'git
> revert' or 'cherry-pick' operations, so perform that "has the todo
> file been modified" check only when the sequencer was invoked as part
> of an interactive rebase.

OK.  That is a valid fix, I think, but the explanation given in the
second bullet point gives a wrong impression that it is merely a
workaround (iow, we are assuming that the user would behave, instead
of making sure we can detect when the user touches the list), when
it is *not*.

> diff --git a/sequencer.c b/sequencer.c
> index 2adcf5a639..3b05d0277d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3791,7 +3791,7 @@ static int pick_commits(struct repository *r,
>  							item->commit,
>  							arg, item->arg_len,
>  							opts, res, 0);
> -		} else if (check_todo && !res) {
> +		} else if (is_rebase_i(opts) && check_todo && !res) {

It is a bit sad that setting of check_todo is not something a single
helper function can decide, so that this is_rebase_i(opts) can be
taken into account when that helper function (the logical place
would be do_pick_commit()) decides to set (or not set) check_todo.

Unfortunately, that is not sufficient, I suspect.  Why did a47ba3c7
("rebase -i: check for updated todo after squash and reword",
2019-08-19) decide to flip check_todo on when running TODO_EXEC?

