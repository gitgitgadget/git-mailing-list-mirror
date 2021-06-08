Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1075DC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 23:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8B660551
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 23:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhFHX5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:57:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60788 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhFHX5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 19:57:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C86E9B9CA5;
        Tue,  8 Jun 2021 19:55:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PbjkSYuJM0HT
        YGme9p4Dpo/o3ySVZaQCr8Iv9NVdNig=; b=I0OJ5b2isgEeHEs/okJ1QP/tJEGu
        i1TlGcvMsONlIf4dFQ/KSAeTQ8wcvsiYx6Dv02erx04glD6ET0LgboCq9HkXAf0I
        uroIaLiYYF0KW1p2pz9HDqXezmMmAjE9SsLbfOU/j27EBIqoONJ1yGVa/t3LuG/J
        TMtvf7ZKAdOA40c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEC58B9CA4;
        Tue,  8 Jun 2021 19:55:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BB6AB9CA0;
        Tue,  8 Jun 2021 19:55:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] builtins + test helpers: use return instead of
 exit() in cmd_*
References: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
        <patch-1.1-f225b78e01-20210608T104454Z-avarab@gmail.com>
Date:   Wed, 09 Jun 2021 08:55:29 +0900
In-Reply-To: <patch-1.1-f225b78e01-20210608T104454Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 8 Jun
 2021 12:48:03 +0200")
Message-ID: <xmqqwnr3nc7i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 01697F78-C8B5-11EB-8110-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change various cmd_* functions that claim no return an "int" to use

s/no return/to return/

> "return" instead of exit() to indicate an exit code. These were not
> marked with NORETURN,

Up to this point, it is well written.

> and by directly exit()-ing we'll skip the
> cleanup git.c would otherwise do (e.g. closing fd's, erroring if we
> can't). See run_builtin() in git.c.

But I think this is a hyperbole.  File descritors are closed when we
exit without git.c's help, thank-you-very-much ;-), and if we do
have clean-ups that are truly important, we would have arranged them
to happen in the atexit handler, so it is not a crime for functions
called from the subcommand dispatchers to exit themselves (as long
as they exit sensibly, e.g. without doing nonsense like exit(-1)).

It nevertheless is a good idea because it encourages good code
hygiene, just like marking with NORETURN if the function must exit.
Selling this change as if it were a correctness fix (i.e. we were
exiting and missed these important clean-ups that the caller wanted
to do after we return) is misleading.

> In the case of shell.c and sh-i18n--envsubst.c this was the result of
> an incomplete migration to using a cmd_main() in 3f2e2297b9 (add an
> extra level of indirection to main(), 2016-07-01).
>
> This was spotted by SunCC 12.5 on Solaris 10 (gcc210 on the gccfarm).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> Clarified the commit message, and made the same s/exit/return/g change
> in shell.c and sh-i18n--envsubst.c. I also missed an "exit(2)" in a
> brach in builtin/merge-ours.c.

The range diff looks good to me.  Thanks.
