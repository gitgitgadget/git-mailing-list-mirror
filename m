Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA96EC433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 21:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354021AbhLFVw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 16:52:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60139 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353285AbhLFVwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 16:52:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE92810302F;
        Mon,  6 Dec 2021 16:48:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JjDo2XbjAvmSCa1Lv/VtP4imX9ECojKWtYZAKC
        mdL/E=; b=J6D0ZQIsM7wIR3mT4boCqNiYj4ojfZ5Uko9R/spzBzUkRJeVIbNbdf
        zDyh2mQ8BO71p0mj9FadDAIXV/O5lVJ1kYBpUh2FZ5/R3hVkR3Y6maPte9NSn7lL
        WSXaxPxzXs8bup9W15TzlV+NrJ4iTVQqBQ7vtGtDH+qqupw/9Az8g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B600F10302E;
        Mon,  6 Dec 2021 16:48:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EE5610302D;
        Mon,  6 Dec 2021 16:48:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-compat-util(msvc): C11 does not imply support for
 zero-sized arrays
References: <pull.1094.git.1638823724410.gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 13:48:53 -0800
In-Reply-To: <pull.1094.git.1638823724410.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 06 Dec 2021 20:48:44
        +0000")
Message-ID: <xmqqtuflcsl6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E814554-56DE-11EC-915B-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 19943e214ba..c9f508b3a83 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -46,7 +46,7 @@
>  /*
>   * See if our compiler is known to support flexible array members.
>   */
> -#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) && (!defined(__SUNPRO_C) || (__SUNPRO_C > 0x580))
> +#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) && !defined(_MSC_VER) && (!defined(__SUNPRO_C) || (__SUNPRO_C > 0x580))
>  # define FLEX_ARRAY /* empty */
>  #elif defined(__GNUC__)
>  # if (__GNUC__ >= 3)

Is flex array a requirement for STDC 199901L or newer?

I am assuming it is (e.g. https://en.wikipedia.org/wiki/C99), and I
can see that it is an unreliable source of information, given that
we see the second vendor whose conformance statement __STDC_VERSION__
makes contradicts with what the compiler does.

It might be that future MSC starts supporting flex array and this
line will become even harder to grok when it happens.  I'd rather
see us cleaning up the mess first.

Specifically, I am wondering if we should use the test based on
__STDC_VERSION__ as the last resort, giving the precedence to more
vendor specific tests, to avoid future problems.  That way, we can
cater to both camps of compiler vendors, the ones where their
STDC_VERSION may not say they have C99 but they do support flex
array the modern way, and the others where their STDC_VERSION say
they have C99 but the don't do flex array.

How about a preliminary clean-up patch that brings us to the
preimage of the following patchlet in step [1/2]?  Then we can do
the single-liner addition of _MSC_VER to support you, and the end
result would be a lot easier to read and maintain?

    /* Vendor specific exceptions first */
    #if   defined(__SUNPRO_C) && (__SUNPRO_C <= 0x580)
   +#elif defined(_MSC_VER)
    #elif defined(__GNUC__)
    # if (__GNUC__ >= 3)
    #  define FLEX_ARRAY /* empty */
    # else
    #  define FLEX_ARRAY 0 /* older GNU extension */
    # endif
    #elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
    # define FLEX_ARRAY /* empty */
    #endif

    /* Otherwise default to safer but wasteful */
    #ifndef FLEX_ARRAY
    # define FLEX_ARRAY 1
    #endif

Thanks.
