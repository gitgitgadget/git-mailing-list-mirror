Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B78C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3002074A
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bv3fw++I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbgJLTrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:47:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56739 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbgJLTrI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 15:47:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BED878D677;
        Mon, 12 Oct 2020 15:47:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4ZqFWEoa7A25
        dyPG2oNBOyqFsmI=; b=Bv3fw++ICdsKUu0PKuE8nsXm7mJ8wHewCDPeF1uLlqte
        0mv+8vajXdM0+Wru8BPvCQC5InM6QrtLW96hVRv2NPVxhy+F8YIUDYGACV293eeG
        1qv87sjLKS6FJbvyspT3gEaushVl7N9Up186lC2SMbFvjDNRV+WomWJqi494B+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=c5TSaH
        e6oHmZm18PI2ILMggGA/mCL8g3+A9dDY1SMRar1zIw2Z4tp/HCZYUYdyvh2iPPkr
        pIuWYMRJ/+3oSTcRlsEJedne0o1jPHj7a3FKc8d3p19La+jvBLVJ03ld30Ba0VHX
        QFJv6hfNrBJD7FWaoJxbGxC7bI5Tp/1jA0Mxs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5E868D676;
        Mon, 12 Oct 2020 15:47:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 820718D674;
        Mon, 12 Oct 2020 15:47:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] sequencer: fix gpg option passed to octopus merge
References: <20201011224804.722607-1-samuel@cavoj.net>
Date:   Mon, 12 Oct 2020 12:47:02 -0700
In-Reply-To: <20201011224804.722607-1-samuel@cavoj.net> ("Samuel
 =?utf-8?Q?=C4=8Cavoj=22's?=
        message of "Mon, 12 Oct 2020 00:48:04 +0200")
Message-ID: <xmqqy2kbns5l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B426888A-0CC3-11EB-8C47-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel =C4=8Cavoj <samuel@cavoj.net> writes:

> Subject: Re: [PATCH] sequencer: fix gpg option passed to octopus merge

Puzzling.  Why do you single out octopus merge like this?

sequencer.c::do_merge() is called from pick_commits() whenever we
see a "merge" insn, and not limited to an octopus merge.

Can we have a test to demonstrate the existing failure, so that we
can notice if this fix is broken in the future?

> When performing octopus merges with interactive rebase with gpgsign
> enabled (either using rebase -S or config commit.gpgsign), the operatio=
n
> would fail on the merge. Instead of "-S%s" with the key id substituted,
> only the bare key id would get passed to the underlying merge command,
> which tried to interpret it as a ref.
>
> Signed-off-by: Samuel =C4=8Cavoj <samuel@cavoj.net>
> ---
> It is unclear to me whether I should have based this off of maint or
> master, master made more sense to me. I apologize if maint was the
> correct one, please tell and I will resubmit.
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
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
> =20
>  		/* Add the tips to be merged */
>  		for (j =3D to_merge; j; j =3D j->next)
