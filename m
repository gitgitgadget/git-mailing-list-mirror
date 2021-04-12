Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF90C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321CB61222
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbhDLRRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:17:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56328 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbhDLRRs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:17:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B789312E8CD;
        Mon, 12 Apr 2021 13:17:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jO2e5UIw2PFp
        1hDmV3cNqAjI6Oc=; b=ooKAuomWKgiGiwRLrO/mUVqOxUm/wAE/8VwBZDzfrX0F
        nDXltl1Om69Kxzr0gByTBDpdycesWiZ/ShIxaWf2RrOI/HpqNTdmwmZ2GHICSuFf
        3ket7xRdCqG7Gki9s86xog/SDYuoBuhVNPy+/L2MehSNgZbkT67sTJ5khjA7jJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NLlQMK
        AVqvp2vtmGB3RzUtn+fymUWFZzubJlb+JbjBfluT1H7/muSpqLhz/mf+Ii5skjdE
        fWTgjv03mzDSav5xxSP6+LDkcJWjwFd0Tfh2jOtdmhhphuL4ZYVgmBGuZn9g+D1w
        1Ii4gWqvXzWEJZa61R+Hx5N61tNyionGepJp4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B000612E8CC;
        Mon, 12 Apr 2021 13:17:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D7D8C12E8CB;
        Mon, 12 Apr 2021 13:17:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t0091-bugreport.sh: actually verify some content of report
References: <20210409212724.GE2947267@szeder.dev>
        <20210411143354.25134-1-martin.agren@gmail.com>
Date:   Mon, 12 Apr 2021 10:17:25 -0700
In-Reply-To: <20210411143354.25134-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sun, 11 Apr 2021 16:33:54 +0200")
Message-ID: <xmqqwnt7e82i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F43BE2C0-9BB2-11EB-B33F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> In the first test in this script, 'creates a report with content in the
> right places', we generate a report and pipe it into our helper
> `check_all_headers_populated()`. The idea of the helper is to find all
> lines that look like headers ("[Some Header Here]") and to check that
> the next line is non-empty. This is supposed to catch erroneous outputs
> such as the following:
>
>   [A Header]
>   something
>   more here
>
>   [Another Header]
>
>   [Too Early Header]
>   contents
>
> However, we provide the lines of the bug report as filenames to grep,
> meaning we mostly end up spewing errors:
>
>   grep: : No such file or directory
>   grep: [System Info]: No such file or directory
>   grep: git version:: No such file or directory
>   grep: git version 2.31.1.164.g984c2561cd: No such file
>
> This doesn't disturb the test, which tugs along and reports success, no=
t
> really having verified the contents of the report at all.
>
> Note that after 788a776069 ("bugreport: collect list of populated
> hooks", 2020-05-07), the bug report, which is created in our hook-less
> test repo, contains an empty section with the enabled hooks. Thus, even
> the intention of our helper is a bit misguided: there is nothing
> inherently wrong with having an empty section in the bug report.
>
> Let's instead grep for some contents that we expect to find in a bug
> report. We won't verify that they appear in the right order, but at
> least we end up verifying the contents more than before this commit.

Nicely described.  I agree that the original intent (let alone the
implementation) is misguided and we should allow an empty section as
a perfectly normal thing.

> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  > It does scare me..
>
>  Maybe something like this?
> ...
> +test_expect_success 'creates a report with content' '
>  	test_when_finished rm git-bugreport-check-headers.txt &&
>  	git bugreport -s check-headers &&
> -	check_all_headers_populated <git-bugreport-check-headers.txt
> +	grep "^Please answer " git-bugreport-check-headers.txt &&
> +	grep "^\[System Info\]$" git-bugreport-check-headers.txt &&
> +	grep "^git version:$" git-bugreport-check-headers.txt &&
> +	grep "^\[Enabled Hooks\]$" git-bugreport-check-headers.txt
>  '

It is a different matter if it is sufficient to ensure only certain
selected lines appear in the report, though.  As all the lines lost
by this fix comes from 238b439d (bugreport: add tool to generate
debugging info, 2020-04-16), it would be nice to hear from Emily.

Thanks.

