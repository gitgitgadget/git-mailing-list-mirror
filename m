Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2BCC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DAE613B2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGNQZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:25:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62337 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhGNQZx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:25:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4305E12E70C;
        Wed, 14 Jul 2021 12:23:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=E7Wx4dd5JGQx
        xkOTAnOSnMV7+8sDtzuGqxCkPZvDh0I=; b=iUQ87EJlh28kdzYpwS8ogC8XKfT4
        laPM1aWhRaEXuZphawzshvOwWNgfN9klRO75Mlhl+ZBVp0+v4BCi7xNabx6bTG8y
        FSX/ioZXyyXMplwhOuxErQGutjbMmQ6LVt+wC+v1eBs38IIcvXqj+5dK1PnyQclM
        uQmK882QaGzcg3k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C9D712E70B;
        Wed, 14 Jul 2021 12:23:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ABE3C12E707;
        Wed, 14 Jul 2021 12:22:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/5] tests: replace [de]packetize() shell+perl
 test-tool pkt-line
References: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
        <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
        <patch-3.5-92bfd8a87b-20210714T005115Z-avarab@gmail.com>
        <YO5iOqWx46UxdhKX@nand.local>
Date:   Wed, 14 Jul 2021 09:22:57 -0700
In-Reply-To: <YO5iOqWx46UxdhKX@nand.local> (Taylor Blau's message of "Wed, 14
        Jul 2021 00:04:10 -0400")
Message-ID: <xmqqpmvkyie6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C0AA10FC-E4BF-11EB-9F86-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Jul 14, 2021 at 02:54:03AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> -extract_haves () {
>> -	depacketize | perl -lne '/^(\S+) \.have/ and print $1'
>> -}
>> -
>>  test_expect_success 'with core.alternateRefsCommand' '
>>  	write_script fork/alternate-refs <<-\EOF &&
>>  		git --git-dir=3D"$1" for-each-ref \
>> @@ -27,18 +23,40 @@ test_expect_success 'with core.alternateRefsComman=
d' '
>>  			refs/heads/public/
>>  	EOF
>>  	test_config -C fork core.alternateRefsCommand ./alternate-refs &&
>> -	git rev-parse public/branch >expect &&
>> -	printf "0000" | git receive-pack fork >actual &&
>> -	extract_haves <actual >actual.haves &&
>> -	test_cmp expect actual.haves
>> +
>> +	test-tool pkt-line pack >in <<-\EOF &&
>> +	0000
>> +	EOF
>> +
>> +	cat >expect <<-EOF &&
>> +	$(git rev-parse main) refs/heads/main
>> +	$(git rev-parse base) refs/tags/base
>> +	$(git rev-parse public) .have
>> +	0000
>> +	EOF
>> +
>> +	git receive-pack fork >out <in &&
>> +	test-tool pkt-line unpack <out >actual &&
>
> I don't think extracting the haves themselves (and stripping ".have"
> from the output) adds much verbosity at all. Wouldn't it be:
>
>   test-tool pkt-line unpack <out >actual &&
>   perl -lne '/^(\S+) \.have/ and print $1' <actual >actual.haves
>
> (in fact, it might be quite nice to leave extract_haves as-is changing
> depacketize for 'test-tool pkt-line unpack').

I tend to agree with you ane Peff, after reading the resulting tests
myself.

Specifically I have problem with this line of reasoning:

    The conversion away from extract_haves() in ... isn't strictly
    required for this migration, but in this case it's easy enough
    to test_cmp the whole output, so let's just do that.

as if using test_cmp to compare the whole output is always a better
way to test, which is far from cut-and-dried clear and obvious.  The
default ought to be to keep the original behaviour, unless you can
clearly convince others that either (1) the new way is better, or
(2) keeping the old way is too hard and the cost for doing so
outweighs the benefit.

While there certainly is some value in end-to-end tests, they
inevitably become brittle.  We prefer focused tests that verify
things we _care_ about, while keeping the expected vector unaffected
by future changes in details that do not matter in what is being
tested.  If we are interested in ".have"s, we shouldn't be affected
by irrelevant details like what other branches and tags appear in
the output and in what order, for example.

Of course, if there is a solid reason why we would care not just
".have" but other details, it is perfectly justifiable thing to do
to update the tests, but we'd want to see (1) such an unrelated
change done in a separate step and (2) with its own justification.

So...
