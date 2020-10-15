Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92492C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1CE22210
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lpoMP5zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390084AbgJORCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:02:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60163 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389725AbgJORC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:02:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 934A2F31EC;
        Thu, 15 Oct 2020 13:02:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fmXgmXYAsTPK
        qfZXk3trzu3x/K8=; b=lpoMP5zq6bn1vEz3+b+wEOO8KQ+xAto21KsQX12Ufkms
        rdMUAczZ/8p4QoUDyBFFefZLvGfiKx81oJfAcB4z26DM2BXoDBLVKx4sp25ledFm
        0N4VaYkhSFedCjZHIx7zG6toxsVQtWjH7nus+MZTClk7msa8+NZjzEvBPaT7e+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=j9572l
        USZz8zWevibVKBbSUp+nm+aslZ8lu0q9XLgSMpzdsBAAk15dqo0IJiYkANBx0lZ5
        lovlS+7/MLsmdO3Pdv4666waTMOhlLvef9ow047P8YNCQ6B14MGZDOWlCMFF/rOd
        kFPJywcHA4+h2tjGuJsBFz3oycKgW0sf66l1M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B44EF31E9;
        Thu, 15 Oct 2020 13:02:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 686D8F31E7;
        Thu, 15 Oct 2020 13:02:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/3] sequencer: pass explicit --no-gpg-sign to merge
References: <20201013213021.3671432-1-samuel@cavoj.net>
        <20201013213021.3671432-3-samuel@cavoj.net>
Date:   Thu, 15 Oct 2020 10:02:20 -0700
In-Reply-To: <20201013213021.3671432-3-samuel@cavoj.net> ("Samuel
 =?utf-8?Q?=C4=8Cavoj=22's?=
        message of "Tue, 13 Oct 2020 23:30:24 +0200")
Message-ID: <xmqqd01jh17n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3131669C-0F08-11EB-ACF2-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel =C4=8Cavoj <samuel@cavoj.net> writes:

> The merge subcommand launched for merges with non-default strategy woul=
d
> use its own default behaviour to decide how to sign commits, regardless
> of what opts->gpg_sign was set to. For example the --no-gpg-sign flag
> given to rebase explicitly would get ignored, if commit.gpgsign was set
> to true.
>
> Fix the issue and add a test case excercising this behaviour.
>
> Signed-off-by: Samuel =C4=8Cavoj <samuel@cavoj.net>
> ---
> v2 -> v3:
>     - added test case
> ---
>  sequencer.c                | 2 ++
>  t/t3435-rebase-gpg-sign.sh | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 88ccff4838..043d606829 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3678,6 +3678,8 @@ static int do_merge(struct repository *r,
>  		strvec_push(&cmd.args, git_path_merge_msg(r));
>  		if (opts->gpg_sign)
>  			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> +		else
> +			strvec_push(&cmd.args, "--no-gpg-sign");

Makes sense, I guess.  As long as opts->gpg_sign reflects not just
the command line but also the configuration.  Otherwise, an
invocation of "git rebase" with no gpg-sign related command line
options would say "ah, opts->gpg_sign is false, we must have been
told from the command line not to sign, so pass --no-gpg-sign here"
and that is not correct.

> diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
> index 9d2faffa03..773c2a1d72 100755
> --- a/t/t3435-rebase-gpg-sign.sh
> +++ b/t/t3435-rebase-gpg-sign.sh
> @@ -81,4 +81,11 @@ test_expect_success 'rebase -r, GPG config and merge=
 strategies' '
>  	git verify-commit HEAD
>  '
> =20
> +test_expect_success 'rebase -r, --no-gpg-sign and merge strategies' '
> +	git reset --hard merged &&
> +	test_config commit.gpgsign true &&
> +	git rebase -fr --no-gpg-sign -s resolve --root &&
> +	test_must_fail git verify-commit HEAD
> +'

I think that before this patch, we've tested the "no command line
option, but configuration tells us to sign" combination already to
make sure the result is signed, so this new test is sufficient.

I briefly wondered if "test_must_fail git verify-commit" sufficient
to make sure that the rebased commits are not signed (i.e. verify
may fail for reasons other than the commit lacks signature, like the
commit is signed but with a wrong key, etc.), but I think it is OK
at least for now.  Others might have clever ideas to cleanly and
cheaply reject other kinds of failures, in which case we may want to
adopt such a solution.

Now that we know that the root cause of the bug you fixed was
because rebase rebase with the default merge strategy for two-head
merges use separate codepaths from and all other rebases, I wonder
if it is prudent to also test the same cases this series adds
without giving "-s resolve".  That would exercise the other codepath
that handles the default merge strategy for two-head merges.  Yes,
we know that other codepath has been working even before this fix,
but tests are not about showing off what we fixed, but are about
making sure similar breakage won't be introduced by mistake in the
future.

Thanks.
