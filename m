Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D70C43333
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC5920674
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbhAZWCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:02:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59462 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389200AbhAZSru (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:47:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ACB33112417;
        Tue, 26 Jan 2021 13:47:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=V+p4bf/pYSmo
        7UdpD3NKV1euams=; b=HVzhdyBZN2hqgJX0NDKkKVu1V7JET+flhfoS/wACxSN0
        q1fuWQCoB4dvvChiZUuj9t4xPILKWDebg3mLQtgAURId17Bxqj0gKPTfWSIqbhh8
        7WIsKNWWZ8PkF/M471OKurlax3jAiPDiuBWgZEHVoJRVM3omVZXE6D0KMWsIdTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xNkTXw
        aGZx3z7wIZs92JEhqpF9VQruN+AlKLSELPmbF6KhBm+GtHXVsX4gyRi1vyjEJ9QG
        7NNc8R4C1Ea5cZy2xpHcOxgZIFqKrTOBBNyMxmd7mm/PEMQT0tAhKbqLJ7H3Bohg
        6WYk+27qzYRALalC0ze3vy2IQBoY9wacXgzRM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A536D112416;
        Tue, 26 Jan 2021 13:47:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8FDA9112412;
        Tue, 26 Jan 2021 13:47:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Cc:     =?utf-8?B?6Zi/5b6354OI?= via GitGitGadget 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] strbuf.c: optimize program logic
References: <pull.846.git.1611637582625.gitgitgadget@gmail.com>
        <xmqqy2gg2pdm.fsf@gitster.c.googlers.com>
        <CAOLTT8T1N2FSK3GiLaQUZt-OO5qzjQz7iq2cuKxasmuwnEZoXw@mail.gmail.com>
Date:   Tue, 26 Jan 2021 10:47:01 -0800
In-Reply-To: <CAOLTT8T1N2FSK3GiLaQUZt-OO5qzjQz7iq2cuKxasmuwnEZoXw@mail.gmail.com>
        (=?utf-8?B?IuiDoeWTsuWugSIncw==?= message of "Tue, 26 Jan 2021 18:44:57
 +0800")
Message-ID: <xmqq8s8f3596.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E19ACA4C-6006-11EB-B808-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E8=83=A1=E5=93=B2=E5=AE=81 <adlternative@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:17=E5=86=99=E9=81=93=EF=BC=9A
>>
>> "=E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGadget" <gitgitgadget@gmail.com=
> writes:
>>
>> > From: ZheNing Hu <adlternative@gmail.com>
>> >
>> > the usage in strbuf.h tell us"Alloc is somehow a
>> > "private" member that should not be messed with.
>> > use `strbuf_avail()`instead."
>>
>> When we use the word "private", it generally means it is private to
>> the implementation of the API.  IOW, it is usually fine for the
>> implementation of the API (i.e. for strbuf API, what you see in
>> strbuf.c) to use private members.
>>
> Well, I just think most other functions in strbuf.c follow the use
> of `strbuf_avail()` instead of "sb->alloc-sb->len-1", and the
> "sb->alloc-sb->len-1" that appears in `strbuf_read()` is not so uniform=
.

I actually wouldn't have minded if this were sold as "code clean-up
to use _avail() when we open-code in the implementation of strbuf
API in codepaths that are not performance critical."

I am not sure about the _setlen() side of the thing.  It is quite
obvious what is going on in the original, and it falls into "when it
is written one way that is good enough, replacing it with another
that is not significantly better often ends up being mere code
churn.", I would think.

Thanks.
