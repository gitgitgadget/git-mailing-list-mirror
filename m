Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B9E211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 01:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbeLDBf1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 20:35:27 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65407 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLDBf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 20:35:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A84FA192D1;
        Mon,  3 Dec 2018 20:35:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j3CWNNDm2n456n2XWU/C7o3NqJI=; b=c8EmC3
        CQygfXlB4sZUYP+34Zb30RzoybH8QOX/dtA/ruDNXFa2/Xo8Jt68pE7QlCuzfPGG
        ygmhB8EA0sFsuOLKoPDBKSpqnMSP9nNtMo4lyuSPFu1pXIhnLN2uQO4QjX9e5WLp
        HobWvUaxogL8HjQM1yrOzkpNYz1BKl8BW6mmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RoPmbla9C/ZBDeEyPiirkhQ3GX8kVj6u
        rNGd3wQPhi1ZSDBnK/XopROtYYSvHXlKdRZKIU7yEtP6xuUY6uJoV/cgAB9iw62u
        vilYnJiVnYndARNCC9PFgtPq4Nenh1pKWFNlVXLLKESnyouspTmpWSFnelQw96dE
        tzzsLKH5fAo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FD94192D0;
        Mon,  3 Dec 2018 20:35:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9EB47192CC;
        Mon,  3 Dec 2018 20:35:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3] range-diff: always pass at least minimal diff options
References: <20181203200734.527341-1-martin.agren@gmail.com>
        <20181203212131.11299-1-sunshine@sunshineco.com>
Date:   Tue, 04 Dec 2018 10:35:19 +0900
In-Reply-To: <20181203212131.11299-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 3 Dec 2018 16:21:31 -0500")
Message-ID: <xmqqbm62gjl4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD507D2C-F764-11E8-9CD9-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This is a re-roll of Martin's v2[1]. The only difference from v2 is that
> it retains coloring when emitting to the terminal (plus an in-code
> comment was simplified).
>
> The regression introduced by d8981c3f88, in which the range-diff only
> ever gets emitted to the terminal, and never to the cover letter or
> commentary section of a standalone patch, makes the --range-diff option
> rather useless, so this fix probably ought to be fast-tracked.

Yup.  Thanks.  The only thing that makes me wonder is why any of the
existing tests (among which I think I saw range-diff driven from
format-patch) did not catch this rather obvious glitch.

> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index e497c1358f..048feaf6dd 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -248,18 +248,24 @@ test_expect_success 'dual-coloring' '
>  for prev in topic master..topic
>  do
>  	test_expect_success "format-patch --range-diff=$prev" '
> -		git format-patch --stdout --cover-letter --range-diff=$prev \
> +		git format-patch --cover-letter --range-diff=$prev \
>  			master..unmodified >actual &&

Ah, of course.  Then the "actual" file gets the names of the output
files; we expect to see 5 of them.

But now we have lost all the range-diff tests run under "--stdout",
so next time some other change regresses only that codepath, we will
not notice (which is fine for now but would want to be addressed
before the end of the year around which time we certainly will all
forget).

Thanks.

> -		grep "= 1: .* s/5/A" actual &&
> -		grep "= 2: .* s/4/A" actual &&
> -		grep "= 3: .* s/11/B" actual &&
> -		grep "= 4: .* s/12/B" actual
> +		test_when_finished "rm 000?-*" &&
> +		test_line_count = 5 actual &&
> +		test_i18ngrep "^Range-diff:$" 0000-* &&
> +		grep "= 1: .* s/5/A" 0000-* &&
> +		grep "= 2: .* s/4/A" 0000-* &&
> +		grep "= 3: .* s/11/B" 0000-* &&
> +		grep "= 4: .* s/12/B" 0000-*
>  	'
>  done
>  
>  test_expect_success 'format-patch --range-diff as commentary' '
> -	git format-patch --stdout --range-diff=HEAD~1 HEAD~1 >actual &&
> -	test_i18ngrep "^Range-diff:$" actual
> +	git format-patch --range-diff=HEAD~1 HEAD~1 >actual &&
> +	test_when_finished "rm 0001-*" &&
> +	test_line_count = 1 actual &&
> +	test_i18ngrep "^Range-diff:$" 0001-* &&
> +	grep "> 1: .* new message" 0001-*
>  '
>  
>  test_done
