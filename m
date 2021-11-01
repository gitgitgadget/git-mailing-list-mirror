Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194B9C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 06:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F294460231
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 06:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhKAGKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 02:10:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57011 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhKAGKw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 02:10:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA449F4DBD;
        Mon,  1 Nov 2021 02:08:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KaA2evnmWAS+
        EOK4oj77MIUxbzQvrNGCC66cb/LEhr0=; b=V2sETsByTQtWl1vt2w/bdVtK0hT7
        izFtr2YwJdjLd+SFSI+8QhCGNavYJy31lPONWzlipNj7YxxgF0JFdrtMF2eHEMpq
        Kzl7bpFHJx9oJiWSdsIlCT7wFaNFWlhC4/F4UhRhp9xya+/QeqVvN0QEusV25Cdm
        F7CRkXKRb3wp6yI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EF64F4DBC;
        Mon,  1 Nov 2021 02:08:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02DAFF4DBB;
        Mon,  1 Nov 2021 02:08:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH 1/2] gpg-interface: handle missing " with " gracefully
 in parse_ssh_output()
References: <f6fca7c0-079c-4337-23d9-cd970c79b8ad@web.de>
Date:   Sun, 31 Oct 2021 23:08:18 -0700
In-Reply-To: <f6fca7c0-079c-4337-23d9-cd970c79b8ad@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 30 Oct 2021 19:04:56 +0200")
Message-ID: <xmqqy268csrx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1C187E04-3ADA-11EC-8BF1-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> If the output of ssh-keygen starts with "Good \"git\" signature for ",
> but is not followed by " with " for some reason, then parse_ssh_output(=
)
> uses -1 as the len parameter of xmemdupz(), which in turn will end the
> program.  Reject the signature and carry on instead in that case.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> This code was added after v2.33.0.
> Patch formatted with --inter-hunk-context=3D2 for easier review.

Nice spotting.

> Silly bonus question: What's the purpose of the "+ 1" and "- 1", which
> seem to cancel each other out?

Fabian, we are in -rc phase where we concentrate on fixing bugs in
the new code in 'master'.  A quick ack, "here is a better way to fix
it", or "no, that won't be needed because..." is very much
appreciated.

Thanks.

>
>  gpg-interface.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 800d8caa67..62d340e78a 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -387,17 +387,19 @@ static void parse_ssh_output(struct signature_che=
ck *sigc)
>  	line =3D to_free =3D xmemdupz(sigc->output, strcspn(sigc->output, "\n=
"));
>
>  	if (skip_prefix(line, "Good \"git\" signature for ", &line)) {
> -		/* Valid signature and known principal */
> -		sigc->result =3D 'G';
> -		sigc->trust_level =3D TRUST_FULLY;
> -
>  		/* Search for the last "with" to get the full principal */
>  		principal =3D line;
>  		do {
>  			search =3D strstr(line, " with ");
>  			if (search)
>  				line =3D search + 1;
>  		} while (search !=3D NULL);
> +		if (line =3D=3D principal)
> +			goto cleanup;
> +
> +		/* Valid signature and known principal */
> +		sigc->result =3D 'G';
> +		sigc->trust_level =3D TRUST_FULLY;
>  		sigc->signer =3D xmemdupz(principal, line - principal - 1);
>  	} else if (skip_prefix(line, "Good \"git\" signature with ", &line)) =
{
>  		/* Valid signature, but key unknown */
> --
> 2.33.1
