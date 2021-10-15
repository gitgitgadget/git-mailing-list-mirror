Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64759C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D20461053
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbhJOUFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 16:05:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61608 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhJOUFP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 16:05:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56747160054;
        Fri, 15 Oct 2021 16:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ot0Gz6o0pgltzsucq10krR1PNmeee6EFEdtRl6
        wdi1o=; b=RLoPviNUJQygsVChMjrZuEDjKXi3T6jB3Jy67QAcZMnlO7kNMCpbl+
        CjgEn4lCevDg7Kzt4OdvFABq6xpYcKCuxr8u/6x24iYGONdFrytTE0UK60f8s4S+
        lMeyBwlTUIUw5t2R6F486KW95BGBi1W+ggio9dDHMOETSrlgk7hL8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EBCF160053;
        Fri, 15 Oct 2021 16:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B208C160052;
        Fri, 15 Oct 2021 16:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
References: <20211015161356.3372-1-someguy@effective-light.com>
        <20211015161356.3372-3-someguy@effective-light.com>
Date:   Fri, 15 Oct 2021 13:03:04 -0700
In-Reply-To: <20211015161356.3372-3-someguy@effective-light.com> (Hamza
        Mahfooz's message of "Fri, 15 Oct 2021 12:13:56 -0400")
Message-ID: <xmqq4k9i5a4n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E914FB2A-2DF2-11EC-AC3E-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hamza Mahfooz <someguy@effective-light.com> writes:

> If we attempt to grep non-ascii log message text with an ascii pattern, we

"with an ascii pattern, when Git is built with and told to use pcre2, we"

> run into the following issue:
>
>     $ git log --color --author='.var.*Bjar' -1 origin/master | grep ^Author
>     grep: (standard input): binary file matches
>
> So, to fix this teach the grep code to use PCRE2_UTF, as long as the log
> output is encoded in UTF-8.

> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
> -	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
> +	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
> +	    (!opt->ignore_locale && is_utf8_locale() &&
> +	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
> +					    (p->fixed || p->is_fixed))))

That's a mouthful.  It is not obvious what new condition is being
added.  I had to flip the order to see the only difference is, that

> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
> -	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
> +	if ((!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
> +	    !(!opt->ignore_case && (p->fixed || p->is_fixed))) ||
> +	    (!opt->ignore_locale && !has_non_ascii(p->pattern)))

... in addition to the case where the original condition holds, if
we do not say "ignore locale" and the pattern is ascii-only, we
apply these two option flags.  And that matches what the proposed
log message explained as the condition the problem appears.

So,... looks good, I guess.

Thanks, will queue.


Addendum.

If we were reordering pieces in the condition, I wonder if there is
a better way to reorganize it, though.  The original is already
barely explainable with words, and with this new condition added, I
am not sure if anybody can phrase the condition in simple words to
others after staring it for a few minutes.  I can't.

But straightening it out is best left as a future clean-up patch,
separate from this series.

