Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AF1C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 01:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440BF613C5
	for <git@archiver.kernel.org>; Thu, 27 May 2021 01:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhE0BNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 21:13:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52493 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhE0BNA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 21:13:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A88CBC205;
        Wed, 26 May 2021 21:11:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XrB9H0SZdnL2
        SMHjsdX8UNx+3sNs6sC0ugq0XB+ryHE=; b=fzku0Vo0qH7jPBGtTNxwXsIGZFpZ
        1o1qRmtnhu/L/5AlAImaBErPkd/k0QzB/tfLK2XOeIB4hCVbSgKlP13oXufC/m9P
        R5gwqt1RSoRPsI7NtX64aPSE0ck+Rp0I8lJS7arL6s7a18s9wSStt4jiO0RORyo6
        3Q6WoqhqJklwOtI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 716F1BC204;
        Wed, 26 May 2021 21:11:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F11B3BC203;
        Wed, 26 May 2021 21:11:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 10/13] send-email: lazily load modules for a big speedup
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
        <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
        <patch-10.13-61e3e3c93c5-20210524T074932Z-avarab@gmail.com>
Date:   Thu, 27 May 2021 10:11:24 +0900
In-Reply-To: <patch-10.13-61e3e3c93c5-20210524T074932Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 24 May
 2021 09:52:59
        +0200")
Message-ID: <xmqqv9759e0z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 74D7D34C-BE88-11EB-BE77-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -use File::Temp qw/ tempdir tempfile /;
> -use File::Spec::Functions qw(catdir catfile);
> ...
> +		require File::Spec;
> +		push @files, grep { -f $_ } map { File::Spec->catfile($f, $_) }
>  				sort readdir $dh;
> ...
> -	push @files, $repo->command('format-patch', '-o', tempdir(CLEANUP =3D=
> 1), @rev_list_opts);
> +	require File::Temp;
> +	push @files, $repo->command('format-patch', '-o', File::Temp::tempdir=
(CLEANUP =3D> 1), @rev_list_opts);

I suspect I would not be the only one who finds it curious to have
the distinction between the use of "->" in File::Spec->catfile() and
"::" in File::Temp::tempdir (and all the other function calls
touched by this patch).

Wouldn't it be more faithful to the original to do:

    require File::Spec::Functions;
    push @files, ... map { File::Spec::Functions::catfile($f, $_) }

in the first hunk?  It would save the time readers of "git log -p"
has to spend on wondering why "catfile" is an oddball.

Of course "man File::Spec" would educate readers where the
difference comes from, but it is not immediately obvious to me why
we want to switch in a "lazily load for speedup" that is supposed to
be optimization-only, even if the class method ends up calling the
same underlying thing.

Thanks.

