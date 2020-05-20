Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925F1C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C669207E8
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sMbXvvUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgETUUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 16:20:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57401 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgETUUS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 16:20:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECF5A45ED7;
        Wed, 20 May 2020 16:20:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8qaTWamqpd9M
        etDzWcHpTXzsE78=; b=sMbXvvUDNtednw79rTiE/PeeLcZwVwRx2DKwOhaeyjr6
        EXxo68gW1xmsv1vdJ+6/SCWLilB1pP0J27B15BvuDJD2fuk6Kd+DoUpsXfm1ttAA
        4dozJHQho8qu8OplkROnE+PMf8E1VGmZ1OaLffszArkLpW47F8SLQjQztOkoq3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=muNRLp
        XHB5tM9ESm4byNu8T88PoWjGVJ0M3XJ8k4wZy2726HK+W4yc30/CdLHptMQFomTR
        iUBbS3ncIlUWcIWlRSSBTjA3zVTQwrsIIv1vAIvl0Io5NCQWlPttjwR4wVBZI9c/
        g0ObS5IdGLdCI1apquGSUeqb6J4V7OT9Qw7ZU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4F2545ED4;
        Wed, 20 May 2020 16:20:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F37F45ED2;
        Wed, 20 May 2020 16:20:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, pranit.bauva@gmail.com
Subject: Re: [PATCH] bisect--helper: avoid segfault with bad syntax in start --term-.+
References: <20200520195214.62655-1-carenas@gmail.com>
Date:   Wed, 20 May 2020 13:20:16 -0700
In-Reply-To: <20200520195214.62655-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 20 May 2020 12:52:14 -0700")
Message-ID: <xmqqimgquznj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5216A688-9AD7-11EA-A601-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 06f5608c14 (bisect--helper: `bisect_start` shell function partially in =
C,
> 2019-01-02) adds a lax parser for `git bisect start` which could result
> in a segfault under a bad syntax call.
>
> Detect if they are enough arguments left in the command line to use for
> --term-{old,good,new,bad} and throw the same syntax error the old shell
> script will show if not.

Thanks for a quick discovery and fix.  The bug is more than a year
old---I guess nobody uses custom bisect terms?

> While at it, remove and unnecessary (and incomplete) check for unknown
> arguments.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  builtin/bisect--helper.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index c1c40b516d..37db7d2afa 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -455,6 +455,8 @@ static int bisect_start(struct bisect_terms *terms,=
 int no_checkout,
>  			no_checkout =3D 1;
>  		} else if (!strcmp(arg, "--term-good") ||
>  			 !strcmp(arg, "--term-old")) {
> +			if (argc - i <=3D 1)
> +				return error(_("'' is not a valid term"));
>  			must_write_terms =3D 1;
>  			free((void *) terms->term_good);
>  			terms->term_good =3D xstrdup(argv[++i]);

As the variable that counts up in the loop is "i", it is easier to
make the condition about "i", not about "difference between argc and
i", e.g.

			if (argc - 1 <=3D i)
				return error(...)

i.e. "The variable 'i' approached from 0 toward argc, and it went
past (argc - 1) already."  I used "<=3D" so that "went past" is more
obvious (i.e. imagine a number-line where things on the left hand
side are smaller than things on the right hand side).

I think incrementing 'i' upfront, once we know we want to read one
more from argv[], may make it even easier to read:

		} else if (... this is about term-good or term-old ...) {
			i++;
			if (argc <=3D i)
				return error(... missing arg ...);
			...
			terms->term_good =3D xstrdup(argv[i]);

The same comment applies to the handling of bad/new.

Thanks.
