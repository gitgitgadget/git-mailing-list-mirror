Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1A6C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 04:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6925E20872
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 04:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iQH4YJB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbgJMEp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 00:45:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54700 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgJMEp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 00:45:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A90F90D8E;
        Tue, 13 Oct 2020 00:45:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wzMU/4tls1JDzgdVznOVrNTGvYg=; b=iQH4YJ
        B1oC0jbVMHVOiCu092cz2v2+5uKQdPVNnP8sq+kFzMfHUhlXEBfrO676iPsXG37Y
        9LGX2mL/AIkmOz9ruAKzZ3xTr0agCBEw3szpkJCA3xDuovRdGxaMBznmLymWfbPz
        EACRhzqSdfi+VLnDLTJatrjRQC1v7QO46nh6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DgkZcy/1gWUi61aItusQy8dQlBE0iBPK
        2uHPh47z/xGQzgTexZbFoD1alsYtzZlxXC3xDHcJpwCYqxxhXQYm7AuLfxmXmasw
        ywqEb4N3/GMui44ZynyXuq9bkf7q5gRLUaQKSOAHvfU6WQ8dEUxQs6Hg7LXx9S18
        1MN2ncarEwU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72F7290D8C;
        Tue, 13 Oct 2020 00:45:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE90B90D8B;
        Tue, 13 Oct 2020 00:45:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] sequencer: fix gpg option passed to octopus merge
References: <20201011224804.722607-1-samuel@cavoj.net>
        <xmqqy2kbns5l.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010122239430.50@tvgsbejvaqbjf.bet>
Date:   Mon, 12 Oct 2020 21:45:21 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010122239430.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 12 Oct 2020 22:55:42 +0200 (CEST)")
Message-ID: <xmqq362in38e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6ECB640-0D0E-11EB-9B42-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Puzzling.  Why do you single out octopus merge like this?
>>
>> sequencer.c::do_merge() is called from pick_commits() whenever we
>> see a "merge" insn, and not limited to an octopus merge.
>>
>> Can we have a test to demonstrate the existing failure, so that we
>> can notice if this fix is broken in the future?
>
> Yes, now that I understand that not only octopus merges are affected, I
> would be very much in favor of adding a test case.

Ah, I see why the initial description was focused on octopus.  The
code special cases the two-parent merge using the recursive strategy
and uses completely separate codepath for it, which does not have
this problem but the codepath that handles octopus merges and merges
with the non-default strategy have the problem.

> If I may suggest to add a new test case to t3435 based on t3430's
> '--rebase-merges with strategies' and t3404's 'rebase -i
> --gpg-sign=<key-id>'? Something along these lines:

In addition, a test that passes --no-gpg-sign from the command line, 
because commit.gpgsign is set in the repository used in these tests,
would be necessary---we want to make sure the command line overrides
the configured default (which is the topic of [patch 2/1]).

>
> -- snipsnap --
> diff --git a/sequencer.c b/sequencer.c
> index 00acb124962..88ccff4838d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3677,7 +3677,7 @@ static int do_merge(struct repository *r,
>  		strvec_push(&cmd.args, "-F");
>  		strvec_push(&cmd.args, git_path_merge_msg(r));
>  		if (opts->gpg_sign)
> -			strvec_push(&cmd.args, opts->gpg_sign);
> +			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>
>  		/* Add the tips to be merged */
>  		for (j = to_merge; j; j = j->next)
> diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
> index b47c59c190b..f70b280f5c1 100755
> --- a/t/t3435-rebase-gpg-sign.sh
> +++ b/t/t3435-rebase-gpg-sign.sh
> @@ -68,4 +68,10 @@ test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
>  	test_must_fail git verify-commit HEAD
>  '
>
> +test_expect_success 'rebase -r, GPG and merge strategies' '
> +	git reset --hard merged &&
> +	git rebase -fr --gpg-sign -s resolve --root &&
> +	git verify-commit HEAD
> +'
> +
>  test_done
