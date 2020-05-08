Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA19C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E1120CC7
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Op+5ojgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEHP5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 11:57:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59318 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgEHP5N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 11:57:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F098F5B367;
        Fri,  8 May 2020 11:57:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OpUGY4rne+fr+StqfJpH9oRkYGI=; b=Op+5oj
        gtcFre2yFJNzFePRttaDviOgd+GmylBKI1vRFfR/NQ8PZI+pyJHTBONtJz/volWr
        HbAx2/401yK78mXmcCtQJado6ustBP0x9hOA0DUukmbWyFsrQ0RxG+mL02z3HZ85
        lamYskuoUYlXMm5yFPecNqq0r1ZcEorDWzcGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tHx46yTf1tRPhuM8iIwhejUIBRdLNfMn
        9lpwaVXZ1VdsMiyYvkQfNw+bSlmf0ozjclEUyEy9sKv+u7+Bhs4VoRT9L2XI1k7l
        Kj3BpMuLBoZNgVDdGFrEO47VED5Kef2ELWCDBAU2sUxFp9sye1kBXPbOcXQKAncP
        ff9IScM7I1I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E59185B366;
        Fri,  8 May 2020 11:57:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 024845B365;
        Fri,  8 May 2020 11:57:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        chrisitan.couder@gmail.com, Denton Liu <liu.denton@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Re* [PATCH v4] submodule: port subcommand 'set-url' from shell to C
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
        <xmqqtv0t6l84.fsf@gitster.c.googlers.com>
        <20200506181239.GA5683@konoha>
        <xmqqwo5o6hzp.fsf@gitster.c.googlers.com>
        <20200507044028.GA5168@konoha>
        <xmqqv9l849i4.fsf@gitster.c.googlers.com>
        <20200508054728.GA8615@konoha>
        <CAP8UFD0=_8D8hkT5VVPV_F++dr131bkjby357fA+QfhQxktcMg@mail.gmail.com>
        <xmqq8si21mlz.fsf_-_@gitster.c.googlers.com>
        <CAPig+cQP_9onrq-z5db1GhXSSHaeKJ+UhNewWP25wLCsMRzSrA@mail.gmail.com>
Date:   Fri, 08 May 2020 08:57:09 -0700
In-Reply-To: <CAPig+cQP_9onrq-z5db1GhXSSHaeKJ+UhNewWP25wLCsMRzSrA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 8 May 2020 11:38:34 -0400")
Message-ID: <xmqqpnbezaga.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 931F10BC-9144-11EA-9698-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, May 8, 2020 at 11:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>> + - Do not explicitly compare an integral value with constant 0 or a
>> +   pointer value with constant NULL for equality; just say !value
>> +   instead.  To validate a counted array at ptr that has cnt elements
>> +   in it, write:
>> +
>> +       if (!ptr || !cnt)
>> +               BUG("array should not be empty at this point");
>> +
>> +   and not:
>> +
>> +       if (ptr == NULL || cnt == 0);
>> +               BUG("array should not be empty at this point");
>
> This talks only about '=='.

Yup.  The text would need a matching change, though.

> People might still use 0 or NULL with
> '!='. I wonder if the example can include '!=', as well. Perhaps:
>
>     if (!ptr)
>         BUG("...");
>     if (cnt)
>         foo(ptr, cnt);
>
> instead of:
>
>     if (ptr == NULL)
>         BUG("...");
>     if (cnt != 0)
>         foo(ptr, cnt);
>
> or something.

Or more succinctly:

	if (!ptr || cnt)
		BUG("we must have an empty array at this point");

perhaps?

> Also, would you want to talk about not comparing against NUL character?
>
>     if (*s)
>         foo(s);
>
> instead of:
>
>     if (*s != '\0')
>         foo(s);
>
> Maybe that's overkill since NUL is an integral value which is already
> covered by your earlier statement (but perhaps some people would
> overlook that).

Yeah, it might be worth saying it explicitly.  I dunno.


