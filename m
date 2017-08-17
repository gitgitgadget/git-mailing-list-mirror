Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EA0820899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbdHQViB (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:38:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56990 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753297AbdHQViA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:38:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7030CAE2DC;
        Thu, 17 Aug 2017 17:37:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lVNeHXWTniHfkx40sP355R8Rew0=; b=gGSWjd
        M9YwyxCejT5nykbuMOTJE5sMN33Ep4LkvuXHwZsw1xGL3n1+XRxeWMcvw3WnMSfF
        Fmlr3lEFxseqLz9Upu6RRMA/sJm/uk8qtCgsiYqbByYpaovNxkmrsu+eO1EQxiLr
        8QkoukGY76I+5wDSM664lkt8bvXn763oHbMTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pEt7qbnWavXNrqKSMOeylV0/99PkBVhQ
        Nel6UrKXZEWSy7cApuK9Z3fVPEMxRIWWQJ0QzTSeEvKy02CkqzNU2d2kV0MePLFR
        Dv6clet3Gg6/Lvv73N2TZJekqHdKvA3ohuVMTvBnsqaeGC4njjeD2vtbA+rOIH15
        Np2gB4r411E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67E6CAE2DB;
        Thu, 17 Aug 2017 17:37:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C77CAAE2D2;
        Thu, 17 Aug 2017 17:37:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>, s@kazlauskas.me,
        git@vger.kernel.org
Subject: Re: [PATCH] files-backend: cheapen refname_available check when locking refs
References: <20170709112932.njac5m6jmgmjywoz@sigill.intra.peff.net>
        <4e81f1ecf190082d3415d96650014841cd4c5b19.1502982012.git.mhagger@alum.mit.edu>
        <20170817152240.coioktoqfkcvxldj@sigill.intra.peff.net>
Date:   Thu, 17 Aug 2017 14:37:51 -0700
In-Reply-To: <20170817152240.coioktoqfkcvxldj@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 17 Aug 2017 11:22:40 -0400")
Message-ID: <xmqqtw15euz4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52F549F4-8394-11E7-B172-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index e9b95592b6..f2a420c611 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -631,11 +631,11 @@ static int lock_raw_ref(struct files_ref_store *refs,
>>  
>>  		/*
>>  		 * If the ref did not exist and we are creating it,
>> -		 * make sure there is no existing ref that conflicts
>> -		 * with refname:
>> +		 * make sure there is no existing packed ref that
>> +		 * conflicts with refname:
>>  		 */
>>  		if (refs_verify_refname_available(
>> -				    &refs->base, refname,
>> +				    refs->packed_ref_store, refname,
>>  				    extras, skip, err))
>>  			goto error_return;
>>  	}
>
> This seems too easy to be true. :) But I think it matches what we were
> doing before 524a9fdb51 (so it's correct), and the performance numbers
> don't lie.

Thanks, all.  The log message explained the change very well, even
though I agree that the patch text does indeed look too easy to be
true ;-).

Will queue.
