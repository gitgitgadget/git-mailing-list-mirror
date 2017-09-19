Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC5B20281
	for <e@80x24.org>; Tue, 19 Sep 2017 00:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750822AbdISAve (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 20:51:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63505 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750714AbdISAvd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 20:51:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1ACA5A8C94;
        Mon, 18 Sep 2017 20:51:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ND8ejI7IwgxN1bLsvyzqCThrgxo=; b=pKvJwX
        PNlyhjrP1Z6Quuemap/WNmRSNzlNmqQ1eUppnYoyPwTQOLDM1v/6b0HmaFQiV5U/
        ab4ERPfSp8v0PItxIQpEvSX70gWvbdSnHMofHtCWj/S7Dmi/+VFiT5H5hPaKYRNL
        0eWYk07j2ucVu6j5+jKe73bTYeaN7I9iSdStg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZVWYMxrT4wsy46MQbICUjQk3YFDyH5Ur
        tgndFmeGHgSELkQxqRC9IoLACFSVhS8W0egFsuYWUx94ar4zVXgjd/3eFAHDjRPJ
        tOjDhE9VsezChzsAkVkzG9sA+Prt6tr7mGq5ikygj/FA68cVXrAMdGc0fAuLBNpO
        xZ9ynAgp93g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 130D1A8C93;
        Mon, 18 Sep 2017 20:51:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E225A8C92;
        Mon, 18 Sep 2017 20:51:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        johannes.schindelin@gmx.de, git@jeffhostetler.com,
        kewillf@microsoft.com
Subject: Re: [PATCH 1/3] sha1_name: Create perf test for find_unique_abbrev()
References: <20170915165750.198201-1-dstolee@microsoft.com>
        <20170915165750.198201-2-dstolee@microsoft.com>
        <xmqqa81su8v9.fsf@gitster.mtv.corp.google.com>
        <960c73e2-6909-6894-a9ab-a191426aeda9@gmail.com>
Date:   Tue, 19 Sep 2017 09:51:25 +0900
In-Reply-To: <960c73e2-6909-6894-a9ab-a191426aeda9@gmail.com> (Derrick
        Stolee's message of "Mon, 18 Sep 2017 04:36:09 -0700")
Message-ID: <xmqqr2v3se7m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB0A33E4-9CD4-11E7-8648-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> But I do not think we want this "clever" optimization that involves
>> 'n' in the first place.
>>>> +	while (count++ < 100000) {
>>> +		for (i = 0; i < n; i++)
>>> +			((unsigned int*)oid.hash)[i] = hash_base;
>>
>> Does it make sense to assume that uint is always 4-byte (so this
>> code won't work if it is 8-byte on your platform) and doing this is
>> faster than using platform-optimized memcpy()?
>
> I'm not sure what you mean by using memcpy to improve this, because
> it would require calling memcpy in the inner loop, such as
>
> 	for (i = 0; i < n; i++)
> 		memcpy(oid.hash + i * sizeof(unsigned), &hash_base,
> 		       sizeof(unsigned));

Sorry, I left it without saying as I thought it was obvious, but
what I meant was to use a whole "struct oid", not just a single
unsigned (repeated), as the hash that is tested.  If you have an
array of object names you use in the test, then

	for (count = 0; count < limit; count++) {
		hashcpy(&oid.hash, &samples[count]);

		... do the probing ...
	}

> First, this doesn't just measure the time it takes to determine non-
> existence,

Sorry, my phrasing was indeed misleading.  I know the time we spend
to see if we have or do not have the object is the largest cycle
spender in these codepaths (and even if it were, I do not think that
is what you are trying to optimize in these patches anyway).  

But if I recall correctly, the way we come up with the unique
abbreviation for an object that exists and an object that does not
exist are different?  And because most of the time (think: "git log
-p" output) we would be finding abbreviation for objects that we do
have, benchmarking and tweaking the code that comes up with an
object that does not exist is not optimizing for the right case.

Back when I wrote that initial response, I didn't check how
different the code was between the two cases, but now I did.  It
seems that in both cases we start from the shortest-allowed length
and then extend the same way, and the only difference between these
two cases is that we return immediately when our candidate name is
long enough not to match any existing object when the full name
refers to an object we do not have, while we return only when
disambiguity is resolved.  I _think_ these amount to the same
computation (i.e. when an object with the full name we have exists,
the amount of computation we need to come up with its unique
abbreviation is the same as the computation we need to find the
unique abbreviation for the same name in another repository that has
identical set of objects, minus that single object), so from that
point of view, throwing random hashes, most of which would not name
any existing object, and measuring how much time it takes to run
get_short_oid() to compute the minimum length of the unique prefix
should be sufficient.

Thanks.

