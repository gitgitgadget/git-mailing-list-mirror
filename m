Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCE9C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 16:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243335AbiD0Q0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243173AbiD0Q0o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 12:26:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE0D59963
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:21:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FAB1191E54;
        Wed, 27 Apr 2022 12:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f+LeLUjP6lzgzRNgFG+wjd+8SvFwj9DsB6kIS7
        5CSTU=; b=DqtZ+AlJZkrBNy+yzF1BTBhqYDdS00M6SyjsKPY0LZMVPbBfW4+G1O
        kTYE1XhrAx8m/C5/XFu8RF+QEhRPHHyfZfga0uRJ8nXUs+2hrrP5AwAT/kZyOa1J
        BlcLOCVqLRB+BvLgGc23ovoBdXBtlU7YRW+DNO+imiVMlnbIbbfmc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46912191E53;
        Wed, 27 Apr 2022 12:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BBB8A191E52;
        Wed, 27 Apr 2022 12:19:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        philipoakley@iee.email, me@ttaylorr.com, guy.j@maurel.de,
        szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        derrickstolee@github.com, Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
References: <20220426183105.99779-1-carenas@gmail.com>
        <20220427000522.15637-1-carenas@gmail.com>
        <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
        <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
Date:   Wed, 27 Apr 2022 09:19:07 -0700
In-Reply-To: <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
        (Carlo Arenas's message of "Wed, 27 Apr 2022 08:38:46 -0700")
Message-ID: <xmqqczh2o5xg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C42B814E-C645-11EC-96A1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> > +     if (real_uid && *real_uid) {
>> > +             char *error;
>> > +             long extracted_id = strtol(real_uid, &error, 10);
>> > +             if (!*error && LONG_MIN < extracted_id &&
>> > +                             extracted_id < LONG_MAX) {
>>
>> strtol() returns a long so the last two checks are redundant.
>
> The last two checks were to check for underflow or overflow and to
> make sure that the bogus values this function returns in case of those
> errors are not taken into consideration.
>
>>The standard is silent on what happens to error when the value is out of
>> range.

Actually the standard is is very clear what happens to endptr (no,
don't call it "error", that is not the point of the parameter).

    A pointer to the final string shall be stored in the object
    pointed to by endptr, provided that endptr is not a null
    pointer.

where "final string" has a precise definition much earlier:

    First, they decompose the input string into three parts:

    1. An initial, possibly empty, sequence of white-space
       characters (as specified by isspace())

    2. A subject sequence interpreted as an integer represented in
       some radix determined by the value of base

    3. A final string of one or more unrecognized characters,
       including the terminating null byte of the input string.

    Then they shall attempt to convert the subject sequence to an
    integer, and return the result.

So, leading whitespace is stripped, then "subject sequence" that is
the sequence of digits (with optional +/- sign) to be turned into a
long is recognised, and what remains is the "final string".  endptr
is made to point at that "final string", and it does not matter what
kind of value the interpretation of "subject sequence" yields.

And that is why it is wrong to call it "error".  It is not about
errors, but is about the shape of the input string, i.e. where the
run of digits ends.

> Which is why instead I was avoiding LONG_{MIN,MAX} which are
> described[1] as the bogus values that will be used in that case

strtol() is designed to return LONG_MIN and LONG_MAX when values
overflow or underflow, but that does not mean it returns these two
values only when the input overflows or underflows.  If it were
strtouint8(), giving it "255" will give 255, while you would get
UCHAR_MAX when the input makes it overflow, e.g. "1000", and from
the returned value you cannot tell which is which because UCHAR_MAX
is 255 ;-)

IOW, you are reading the standard wrong.  It does not say that
LONG_MIN and LONG_MAX are bogus values at all.

And theree is this note:

    Since 0, {LONG_MIN} or {LLONG_MIN}, and {LONG_MAX} or {LLONG_MAX}
    are returned on error and are also valid returns on success, an
    application wishing to check for error situations should set errno
    to 0, then call strtol() or strtoll(), then check errno.

So, no, I do not think the range check gives us anything
meaningful.

At this point, it is tempting to say that it is not worth trying to
do it right by avoiding atoi(), as we are bound to make more of this
kind of mistakes X-<.  But at the same time, I hope we can learn
together and get this right ;-).
