Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03BD92027B
	for <e@80x24.org>; Wed,  1 Mar 2017 18:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbdCASXW (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 13:23:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50521 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752742AbdCASXF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 13:23:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B10AC75B99;
        Wed,  1 Mar 2017 13:08:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=08ICZQ9MeoLD
        F11lncC6VBbGMFg=; b=pFCEAJQzyPx6EBVvnZzZH4ELDqlGam4MnbFqRj1qGZ41
        p4UkN2uOmz08SB1aLEXG0y3XgTJIkssOY0E0qoMECjsWEBfTEWoJFDEhsGtKAEEZ
        W5LnvK/bs7Zs6HAN4U1qasjM2EsHn3cL+YKF+4IA67lS8Z+AfluQo9Lh7WgSHG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sVe48n
        EcAC2SkfXAFEBLzZe3EPMuxN3BfrdZbOlopaFyLe89Zk8NWrmwSFTRshvPNUGHRK
        XOINJuxu0y6rbkBXZWuDuoX3djmqV+Ioo8TFTl0EvN4zoD0AXLLznFx5tFa6K1Vw
        giILDYGIeYIpJ6/dYmNlNTXlqbHIK2rBbUcuM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8E1675B98;
        Wed,  1 Mar 2017 13:08:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FF3175B97;
        Wed,  1 Mar 2017 13:08:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Adrian Dudau <Adrian.Dudau@enea.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] pretty: use fmt_output_email_subject()
References: <1488297556.2955.11.camel@enea.com>
        <20170228181719.t67abnnnsdcx2xfd@sigill.intra.peff.net>
        <58e05599-5dc4-9881-d8c0-89ad1f2e3838@web.de>
Date:   Wed, 01 Mar 2017 10:08:10 -0800
In-Reply-To: <58e05599-5dc4-9881-d8c0-89ad1f2e3838@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 1 Mar 2017 12:37:07 +0100")
Message-ID: <xmqqfuiwhnud.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 086F20E0-FEAA-11E6-B28E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Add the email-style subject prefix (e.g. "Subject: [PATCH] ") directly
> when it's needed instead of letting log_write_email_headers() prepare
> it in a static buffer in advance.  This simplifies storage ownership an=
d
> code flow.

It certainly does.  At first I wondered if there are places other
than log-write-email-headers that sets its own string to pp.subject,
but this patch removes the field from the structure to guarantee
that such a place, if existed, is properly dealt with.  Otherwise,
the resulting code would not compile.

> @@ -1005,6 +1004,8 @@ static void make_cover_letter(struct rev_info *re=
v, int use_stdout,
>  	msg =3D body;
>  	pp.fmt =3D CMIT_FMT_EMAIL;
>  	pp.date_mode.type =3D DATE_RFC2822;
> +	pp.rev =3D rev;
> +	pp.print_email_subject =3D 1;

These two are always set together?  We'll shortly see that it is not
the case below.

>  	pp_user_info(&pp, NULL, &sb, committer, encoding);
>  	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
>  	pp_remainder(&pp, &msg, &sb, 0);
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index c9585d475d..f78bb4818d 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -148,7 +148,7 @@ void shortlog_add_commit(struct shortlog *log, stru=
ct commit *commit)
> =20
>  	ctx.fmt =3D CMIT_FMT_USERFORMAT;
>  	ctx.abbrev =3D log->abbrev;
> -	ctx.subject =3D "";
> +	ctx.print_email_subject =3D 1;

Here we see .rev is left to NULL here, with print_email_subject set
to true.  And in the entire patch this is the only such place.

> diff --git a/pretty.c b/pretty.c
> index 5e683830d9..d0f86f5d85 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1607,8 +1607,9 @@ void pp_title_line(struct pretty_print_context *p=
p,
>  				pp->preserve_subject ? "\n" : " ");
> =20
>  	strbuf_grow(sb, title.len + 1024);
> -	if (pp->subject) {
> -		strbuf_addstr(sb, pp->subject);
> +	if (pp->print_email_subject) {
> +		if (pp->rev)
> +			fmt_output_email_subject(sb, pp->rev);

A hidden assumption this code makes is that anybody who does not
want .rev (aka "doing it as part of format-patch that may want
nr/total etc") does not want _any_ "Subject: ".  It obviously holds
true in today's code (the one in shortlog-add-commit is the only one
and it sets an empty string to .subject).

Does the loss of flexibility to the future callers matter, though?
I cannot tell offhand.

Thanks.  Let's see what others think.
