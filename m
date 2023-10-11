Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17DACDB46F
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 17:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjJKRaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 13:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjJKR37 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 13:29:59 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D9B8F
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 10:29:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79C2930179;
        Wed, 11 Oct 2023 13:29:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oxYo+xFzWe+B
        yKrs3ZjHdyGozveF2cgvnyClgCg3h/Q=; b=uBQwwi9Indhgw+9u6El/M8DEBD1s
        Al16Z8BaFBVtvxbCOOyEr/Lck87Z67kTeGAjYoFA8lrwOfOqwYg1nTCfKkLmlrRC
        UXyGft6BXk2cfQJJWZsF5P+hlDZncDB+dI1RmxVkf7/cCf8+/R7nv7gwJTLieE1F
        8JIvME+U4eaSnVw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 726D330178;
        Wed, 11 Oct 2023 13:29:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A2DA030177;
        Wed, 11 Oct 2023 13:29:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Singh <siddhartth@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com
Subject: Re: [PATCH] t-progress.c : unit tests for progress.c
In-Reply-To: <20231011082716.901048-1-siddhartth@google.com> (Siddharth
        Singh's message of "Wed, 11 Oct 2023 10:27:08 +0200")
References: <20231011082716.901048-1-siddhartth@google.com>
Date:   Wed, 11 Oct 2023 10:29:52 -0700
Message-ID: <xmqq34yhm5in.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CA15FA94-685B-11EE-9778-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Singh <siddhartth@google.com> writes:

> These tests are directly inspired from the tests inside
> t/t0500-progress-display.sh
>
> The existing shell tests for the Git progress library only test the out=
put of the library, not the correctness of the progress struct fields. Un=
it tests can fill this gap and improve confidence that the library works =
as expected. For example, unit tests can verify that the progress struct =
fields are updated correctly when the library is used.
>
> Change-Id: I190522f29fdab9291af71b7788eeee2c0f26282d
> Signed-off-by: Siddharth Singh <siddhartth@google.com>
> ---

The contents is of course important, but please also pay attention
to the formatting to make what you write readable.  Writing good
things does not help if it is not read.  Wrap lines to appropriate
lengths.

Documentation/SubmittingPatches is your friend.

>
> Dear Git Community,

> As you may be aware, my colleague Josh is proposing a unit testing
> framework[1] on the mailing list. I attempted to use the latest
> version of that series to convert t/helper/test-progress.c to unit
> tests. However, while writing the tests, I realized that the way
> progress.c is implemented makes it very difficult to test it in
> units.
>
> Firstly, most unit tests are typically written as a method that
> takes the expected output and the actual output of the unit being
> tested, and compares them for equality. However, because it's
> intended to print user-facing output on an interactive terminal,
> progress.c prints everything out to stderr, which makes it
> difficult to unit test.

It sounds like you found where the test framework is lacking.  If
making sure what we spew out to the standard error stream is worth
covering in the unit tests, the test framework needs to support it,
right?


> There are a few ways to work around this issue in my opinion. One
> way is to modify the library that does not print to output stream
> and returns the data to the caller:
>
> static void display(struct progress *progress, uint64_t n, char *done){
> =E2=80=A6
> }
>
> becomes
>
> struct strbuf display(struct progress *progress,uint64_t n,char *done){
> =E2=80=A6
> }

The approach adds a feature for outside callers to access this bit
of internal implementation detail of the progress code.  If no real
callers want to exercise that feature and it is only useful for
testing, it smells like the tail wagging the dog, though.

It certainly is not worth butchering the real code for the sake of
working around the lack of current unit test framework to
contaminate the global namespace with way too generically named
function "display()".

Assuming that you *must* work around the lack of stderr support, it
probably would make much more sense to add a new member that points
at an output stream to "struct progress".  Make it a thin wrapper
around "FILE *" that supports whatever display() and the helper
functions it calls needs, like write(2) or fprintf(3).  And you can
mock that "output stream" in your unit tests to append to an in-core
buffer if you wanted to.  The production code does not have to care
about your mock that way.
