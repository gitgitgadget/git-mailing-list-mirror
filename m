Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E3BCA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 01:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjILBlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 21:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjILBlG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 21:41:06 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0466A98A64
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 18:18:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAA491AC45E;
        Mon, 11 Sep 2023 18:34:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=edhnQXEcpK3w
        cl+toCyU+OzpJuWD69R8vOX3LdoKt6c=; b=ikW59A7akbzi+V/0JWrt77zBG53j
        Bg7q3HHNP3AfRGgLzCpgthnh7kdwBLwFtkYVwS5qs2+APq8gR1F3R8bPIm0ROczW
        JG927B26DaP8slLxFQRWnJnfCdd2yykzY6w+gNstf6nzCAIJhydEjcB/ECJ4ctnh
        HeDjEub5qAAV4Y0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D08F91AC45D;
        Mon, 11 Sep 2023 18:34:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BDD01AC45C;
        Mon, 11 Sep 2023 18:34:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathias Krause <minipli@grsecurity.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
In-Reply-To: <20230911121211.GA17401@redhat.com> (Oleg Nesterov's message of
        "Mon, 11 Sep 2023 14:12:11 +0200")
References: <20230911121126.GA17383@redhat.com>
        <20230911121211.GA17401@redhat.com>
Date:   Mon, 11 Sep 2023 15:34:06 -0700
Message-ID: <xmqq34zktk4h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 523CD328-50F3-11EE-9CF5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> 	$ git grep --untracked -pn xxx TEST.c
>
> before the patch:
>
> 	TEST.c=3D1=3Dvoid func(void);
> 	TEST.c:3:void func1(xxx)
> 	TEST.c:5:       use1(xxx);
> 	TEST.c:8:void func2(xxx)
> 	TEST.c:10:      use2(xxx);
>
> after the patch:
>
> 	TEST.c=3D1=3Dvoid func(void);
> 	TEST.c:3:void func1(xxx)
> 	TEST.c=3D3=3Dvoid func1(xxx)
> 	TEST.c:5:       use1(xxx);
> 	TEST.c:8:void func2(xxx)
> 	TEST.c=3D8=3Dvoid func2(xxx)
> 	TEST.c:10:      use2(xxx);
>
> which looks much better to me.

The "better" is often subjective.  The former is showing what is
going on in the TEST.c code very clearly without wasting valuable
vertical screen real estate, at least to me.  If we want to adopt
the proposed behaviour, which I would recommend against, the same
patch should update the documentation, which currently says

    Show the preceding line that contains the function name of the
    match, unless the matching line is a function name itself.

which has allowed the users to depend on the current behaviour for
practically forever since the feature was introduced by 2944e4e6
(grep: add option -p/--show-function, 2009-07-02).

As Ren=C3=A9 said, I think -p/--show-function is a rather less used
option in modern Git where "--function-context", which back in
2944e4e6 did not exist, tend to be a much more useful option, so the
fallout from such a change may be small, but it still is a backward
incompatible behaviour change that needs to be handled with care.

Thanks.

> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  grep.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 0904d55b24..7cad8352f4 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1350,12 +1350,11 @@ static void show_funcname_line(struct grep_opt =
*opt, struct grep_source *gs,
>  	while (bol > gs->buf) {
>  		const char *eol =3D --bol;
> =20
> +		if (--lno < opt->last_shown)
> +			break;
> +
>  		while (bol > gs->buf && bol[-1] !=3D '\n')
>  			bol--;
> -		lno--;
> -
> -		if (lno <=3D opt->last_shown)
> -			break;
> =20
>  		if (match_funcname(opt, gs, bol, eol)) {
>  			show_line(opt, bol, eol, gs->name, lno, 0, '=3D');
