Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBFFD1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 18:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbdAZSz5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:55:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52097 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752247AbdAZSzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:55:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7CBC621B9;
        Thu, 26 Jan 2017 13:54:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Pos36eBgLBkR
        Y37kojNIH+Lf6SA=; b=GTxVRtennJ2ERWbfu4NYwX2m7kAeur5sHNv2N85plQ4W
        mU0bXUmi4l0Ix0Qjt0LcTtBtBGcUWPNAQ3Hk3tqBiMKI9ROu7A6q06wqZAgL2RAT
        OYlfis8itkdAfth+X22KvLBynEW4w0C6PcTNOj0h/rRERe7gFEcCrzpJ9N5g+sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rKQY4q
        8KMIU7qjN2Sp6C7Z3jSzX8TGO2sPQ7ejxsLR3CJNZp39UnYbxhqUHevNzP15jvTE
        UyNz6IyA6nd/I3TGTsYVG64W2//zRaAmBNM4TzQhEmK63c4rDNlLN+xmM4T4Jn8X
        seKQB8VlShtTX7znFrOZ47YNMb7XX2gpkBcYc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF545621B8;
        Thu, 26 Jan 2017 13:54:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A56D621B6;
        Thu, 26 Jan 2017 13:54:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] ref-filter: add function to parse atoms from a nul-terminated string
References: <20161207160923.7028-1-szeder.dev@gmail.com>
        <20161207160923.7028-3-szeder.dev@gmail.com>
        <CAM0VKjntATMwDTdu1fSmjeLbwVe73iTo2NQizNXjZchBzqG44w@mail.gmail.com>
Date:   Thu, 26 Jan 2017 10:54:57 -0800
In-Reply-To: <CAM0VKjntATMwDTdu1fSmjeLbwVe73iTo2NQizNXjZchBzqG44w@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 26 Jan 2017 14:15:38
 +0100")
Message-ID: <xmqqvat14poe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EFA2A40E-E3F8-11E6-A9B6-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Wed, Dec 7, 2016 at 5:09 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com=
> wrote:
>> ref-filter's parse_ref_filter_atom() function parses an atom between
>> the start and end pointers it gets as arguments.  This is fine for two
>> of its callers, which process '%(atom)' format specifiers and the end
>> pointer comes directly from strchr() looking for the closing ')'.
>> However, it's not quite so straightforward for its other two callers,
>> which process sort specifiers given as plain nul-terminated strings.
>> Especially not for ref_default_sorting(), which has the default
>> hard-coded as a string literal, but can't use it directly, because a
>> pointer to the end of that string literal is needed as well.
>> The next patch will add yet another caller using a string literal.
>>
>> Add a helper function around parse_ref_filter_atom() to parse an atom
>> up to the terminating nul, and call this helper in those two callers.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>>  ref-filter.c | 8 ++------
>>  ref-filter.h | 4 ++++
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> Ping?
>
> It looks like that this little two piece cleanup series fell on the flo=
or.

I am still waiting for somebody else to comment on the changes, and
the final reroll after such a review discussion to address your own
comment in <CAM0VKjk1mnNzQX6LThq1t7keesBz_fjE9x2e0ywsBKSNKP9SCw@mail.gmai=
l.com>



