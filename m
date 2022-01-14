Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C16CC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 18:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243215AbiANSpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 13:45:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59336 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiANSpn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 13:45:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF897111E47;
        Fri, 14 Jan 2022 13:45:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FxfaWCLpUl1q
        AKf+F5p3MHahQoSpyzmMk+m50X/WiSE=; b=EqD5qFtRDX4CYolYjGaX+cuk9PVd
        fR+tDTYcpz4HmFAYTRkTHYXn+vzO2snubhFmVJcNzUlxY08aFRyIMltpFwsgAnvm
        criB/ZHP2IBFY4Hzhz2I+uxTHUdkP3VnAlWEDPfiIkEXzHXPDCehebJxyt+BJm6V
        wtS8RVKnoD0S0JI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A731E111E45;
        Fri, 14 Jan 2022 13:45:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F05B2111E44;
        Fri, 14 Jan 2022 13:45:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v7 1/6] object-name tests: add tests for ambiguous
 object blind spots
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
        <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
        <patch-v7-1.6-28c01b7f8a5-20220111T130811Z-avarab@gmail.com>
        <xmqq8rvjgszp.fsf@gitster.g>
        <220114.861r1att7j.gmgdl@evledraar.gmail.com>
Date:   Fri, 14 Jan 2022 10:45:40 -0800
In-Reply-To: <220114.861r1att7j.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 14 Jan 2022 13:07:53 +0100")
Message-ID: <xmqqh7a6cg17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2CCA0EBE-756A-11EC-8BF0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Jan 13 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> +test_cmp_failed_rev_parse () {
>>> +	cat >expect &&
>>> +	test_must_fail git -C "$1" rev-parse "$2" 2>actual.raw &&
>>> +	sed "s/\($2\)[0-9a-f]*/\1.../" <actual.raw >actual &&
>>> +	test_cmp expect actual
>>> +}
>>
>> That's dense, especially without a comment (or named variable) that
>> hints readers what the arguments to this helper (and its standard
>> input) ought to be.
>
> I got rid of the named variables from v6 in response to a "shift" that
> shifted the wrong number, but perhaps I should have just removed the
> "shift"?

I agree that is a more sensible thing you could have done.

>> As long as messages from rev-parse on the error stream never has
>> more than one abbreviated object name on a single line, the above
>> should give us a copy of the message with expected object name
>> abbreviated to $2; otherwise we might be missing a /g in the sed
>> script.
>
> In the v6 you rightly commented on the /g that was there previously not
> being needed :)
>
> So I dropped it, in this case we can rely on only getting the
> abbreviated output.

I do not care either way, as long as it is clearly stated why /g is
there (or why /g is missing) for the future developers.
