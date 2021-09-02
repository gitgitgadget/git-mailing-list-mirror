Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B38C433F5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 20:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D736108B
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 20:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345130AbhIBUJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 16:09:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64861 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhIBUJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 16:09:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC8E9E13D4;
        Thu,  2 Sep 2021 16:08:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=x2RG8dCPBzcy
        BWcI2ExiazBbfqDdts14mnNSMm7M/go=; b=iWQ6qc2wpnnoVOYU5eBmpn13+EcT
        v8QB+kKDm8gYICe2ejynQpIl73gnuXGf070v71xS4kR5JRbB1Ag0p/5a+SRLIXOq
        x39qgRazojqTdQ95VLLqKZuKTBWTsm46w26Uv/2GoeSqRLNkJwR5svFKGuQRkc6a
        43bb9hQnkIoln/Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C38B0E13D3;
        Thu,  2 Sep 2021 16:08:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4101FE13D2;
        Thu,  2 Sep 2021 16:08:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, hanwen@google.com
Subject: Re: [PATCH 3/3] fixup! reftable: add a heap-based priority queue
 for reftable records
References: <20210902053023.44006-1-carenas@gmail.com>
        <20210902053023.44006-4-carenas@gmail.com>
        <YTCU3F+0sKcrym6F@coredump.intra.peff.net>
Date:   Thu, 02 Sep 2021 13:08:58 -0700
In-Reply-To: <YTCU3F+0sKcrym6F@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 2 Sep 2021 05:09:48 -0400")
Message-ID: <xmqqeea6kaed.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9C0CE332-0C29-11EC-AD52-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 01, 2021 at 10:30:23PM -0700, Carlo Marcelo Arenas Bel=C3=B3=
n wrote:
>
>> diff --git a/reftable/pq.c b/reftable/pq.c
>> index 8918d158e2..a6acca006b 100644
>> --- a/reftable/pq.c
>> +++ b/reftable/pq.c
>> @@ -43,12 +43,14 @@ int merged_iter_pqueue_is_empty(struct merged_iter=
_pqueue pq)
>> =20
>>  void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
>>  {
>> +#ifndef NDEBUG
>>  	int i =3D 0;
>>  	for (i =3D 1; i < pq.len; i++) {
>>  		int parent =3D (i - 1) / 2;
>> =20
>>  		assert(pq_less(pq.heap[parent], pq.heap[i]));
>>  	}
>> +#endif
>>  }
>
> This will trigger -Wunused-parameter warnings, since the function body
> is now empty when NDEBUG is undefined. Probably switching the assert()
> to die() would be better, since the whole point of the function is just
> to exit on error.
>
> If there's a problem using die() from the reftable code, it could also
> return an error and the caller in the test helper could propagate it.

I agree that the patch as posted does not help but if this is
originally an assertion, then it should never trigger in real life,
so BUG() would be more appropriate than an error return, no?

