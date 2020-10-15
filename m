Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3CFC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C644F22240
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dp8J2/Y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbgJOQrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:47:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57252 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388946AbgJOQrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:47:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ABB95F3081;
        Thu, 15 Oct 2020 12:47:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ey7SVOJAg578
        uYinUpGsb7lNLGI=; b=dp8J2/Y7owYGC1b6tJCPdQJ19jdq107n2CwNLWu2IPZT
        CH2lrfV9gUTfySAxn3N3IxWi4iLLOls3uweH4rwmK6bnnI6S7sPRIgE7S4oTfAYv
        0D0aPK//4Q01Qf5lz/OCRFifIPwvy8TbeOvz59WtQ5mnLg1FG7k5Mhe9R5NYx9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hNQ9Yy
        46BCnRwqkGI/L9J09vIhZgmOUrbMXNRLa03zpYGWM0jghK7a5oJv3SAZhGH53hUU
        6DCEJNkNf25qBO5FiL36f3j8wR6owEx/cq9agJyC9FGQl3ZttpRU//1upANrcTaH
        Fzp18kmjGf+gu44rHdkPOrH1i7Aocvat1HaT0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DD50F307F;
        Thu, 15 Oct 2020 12:47:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BFEC9F307D;
        Thu, 15 Oct 2020 12:47:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/3] sequencer: fix gpg option passed to merge
 subcommand
References: <20201013213021.3671432-1-samuel@cavoj.net>
        <20201013213021.3671432-2-samuel@cavoj.net>
Date:   Thu, 15 Oct 2020 09:47:17 -0700
In-Reply-To: <20201013213021.3671432-2-samuel@cavoj.net> ("Samuel
 =?utf-8?Q?=C4=8Cavoj=22's?=
        message of "Tue, 13 Oct 2020 23:30:23 +0200")
Message-ID: <xmqqh7qvh1wq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1694DD66-0F06-11EB-9AF4-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel =C4=8Cavoj <samuel@cavoj.net> writes:

> diff --git a/sequencer.c b/sequencer.c
> index 00acb12496..88ccff4838 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3677,7 +3677,7 @@ static int do_merge(struct repository *r,
>  		strvec_push(&cmd.args, "-F");
>  		strvec_push(&cmd.args, git_path_merge_msg(r));
>  		if (opts->gpg_sign)
> -			strvec_push(&cmd.args, opts->gpg_sign);
> +			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);

Good.  And later you'd add "else" to explicitly turn it off, I presume?

> diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
> index 696cb6b6a4..9d2faffa03 100755
> --- a/t/t3435-rebase-gpg-sign.sh
> +++ b/t/t3435-rebase-gpg-sign.sh
> @@ -68,4 +68,17 @@ test_expect_failure 'rebase -p --no-gpg-sign overrid=
e commit.gpgsign' '
>  	test_must_fail git verify-commit HEAD
>  '
> =20
> +test_expect_success 'rebase -r, GPG --gpg-sign and merge strategies' '
> +	git reset --hard merged &&

Insert

	test_unconfig commit.gpgsign &&

here.  That would make it explicit that we are checking the base
case where only the command line option is given.

> +	git rebase -fr --gpg-sign -s resolve --root &&
> +	git verify-commit HEAD
> +'
> +
> +test_expect_success 'rebase -r, GPG config and merge strategies' '
> +	git reset --hard merged &&
> +	test_config commit.gpgsign true &&

Use "git config" for consistency.

> +	git rebase -fr -s resolve --root &&
> +	git verify-commit HEAD
> +'
> +

We'd want another one, which is to give --gpg-sign from the command
line when this is in effect:

	git config commit.gpgsign false

i.e. not "test_unconfig" that removes the configuration, but
explicitly configured not to sign

Thanks.
