Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91131C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F396115A
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbhIVUxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:53:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60088 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbhIVUxL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:53:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0CBBE9C05;
        Wed, 22 Sep 2021 16:51:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZL41D28+bDl15ZfPs99N72WbXFTZ7T8mwbI9u8
        VhIDI=; b=O2Ep78gJaidspKOgs4OgZJCoHrR4puITCHgmvK+vUoqLaicCSAKEq/
        30ZJTU7f5xtqdAeLtFwVlRVNgb3Njs3k+UTCF/bhAjEa2ZXvg1n3Zi9iNd7dY8lY
        qglDh81UEXyJHMiQGynWkwhvWcvNRr7wkmSxDGTpk0biPhwZV2gSM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E44F7E9C04;
        Wed, 22 Sep 2021 16:51:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E338E9C03;
        Wed, 22 Sep 2021 16:51:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
        <xmqq8rzo770h.fsf@gitster.g>
        <YUuNXOb5blV7iN6P@coredump.intra.peff.net>
Date:   Wed, 22 Sep 2021 13:51:39 -0700
In-Reply-To: <YUuNXOb5blV7iN6P@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 22 Sep 2021 16:09:00 -0400")
Message-ID: <xmqqk0j85o6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2CFEE8C-1BE6-11EC-9198-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 22, 2021 at 12:19:26PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > 	# Ensure that there is no "Basic" followed by a base64 string, but that
>> > 	# the auth details are redacted
>> > 	! grep "Authorization: Basic [0-9a-zA-Z+/]" trace &&
>> > 	grep "Authorization: Basic <redacted>" trace
>> >
>> > gets confused. It sees the "<redacted>" one from the pre-upgrade
>> > HTTP/1.1 request, but fails to see the unredacted HTTP/2 one, because it
>> > does not match the lower-case "authorization".
>> 
>> Neither pattern of the above two will not match the HTTP/2 one, so
>> the first one would report "there is no leakage of Auth with a
>> caplital letter"; the second one may see only one pre-upgrade Auth
>> with a capital letter, but as long as it does find one, it should be
>> happy, no?
>> 
>> I am a bit puzzled how the test gets confused.
>
> The first one matches nothing, because the HTTP/2 one which fails to
> redact has a lower-case "A". The second one _does_ match, because ...

I thought we were talking about the original case sensitive test
getting confused when testing the software that is fixed,
i.e. HTTP/2 lowercase "authorization" line properly redacted.

> I get (with some extraneous headers omitted):
> ...
>   => Send header: GET /auth/smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
>   => Send header: Authorization: Basic <redacted>

So, this is what we see in HTTP/1.1 (with capitalization).  And then
...

> ...
>   => Send header: POST /auth/smart/repo.git/git-upload-pack HTTP/2
>   => Send header: authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA==

this one, once the redaction code is fixed by applying this patch,
would show that we redacted it, too, no?

With or without the fix in the code, I agree that neither of the two
"grep" patterns without "grep -i" change will match this line.  So
the end result is that the test finds no unredacted line, and one
redacted one (instead of two).

I agree that it is *not* testing what we want to test, and if you
said so, I wouldn't have been puzzled.  I just wanted to know if
there is something _else_ (other than "gee, we are not testing the
HTTP/2 case at all") going on that I failed to read in your
"... gets confused".

Thanks.
