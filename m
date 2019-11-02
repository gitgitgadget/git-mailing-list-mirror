Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A72D01F454
	for <e@80x24.org>; Sat,  2 Nov 2019 05:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfKBFzO (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 01:55:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55629 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKBFzO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 01:55:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 605FA37B88;
        Sat,  2 Nov 2019 01:55:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9kYYQ9zLgqIaRO0vZgaQ50HmQVM=; b=WmjNkq
        djCt/6cexQum3M3dUQzfgjERoAU9lrGUnmAOhMWW4FqI/7kuIEYx7bHF4EMaUGCh
        bVnFEjGLJviuwqzOVwLmXRfP5WTJgO8VsYZ28u5HRQ2mC/B9g0wOUizv6VOTtFBQ
        jEeXonrhwIOQhne7yfw7vch/GJRTwipLtaiYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uZtxGDyukiqEXPPgr+KNdPtxs6lHKpc+
        wJXxxsS5bodMsWe8zM8tX0Tc0Fa92bt0YhJ2fXBN3I4Antk99RDtYndjI2/I3UMC
        npAA/uuPAWYSMHcmotPPEr9+jAQHgEFXP2JlKALKMcAFXC/gN63VEMV/Px/Rw0IN
        0/g7xowjIq0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 589D737B86;
        Sat,  2 Nov 2019 01:55:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF8DF37B85;
        Sat,  2 Nov 2019 01:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] fetch: remove fetch_if_missing=0
References: <20191101203830.231676-1-jonathantanmy@google.com>
        <20191101220537.GA249573@google.com>
Date:   Sat, 02 Nov 2019 14:55:10 +0900
In-Reply-To: <20191101220537.GA249573@google.com> (Jonathan Nieder's message
        of "Fri, 1 Nov 2019 15:05:37 -0700")
Message-ID: <xmqqv9s23jr5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55516F9E-FD35-11E9-B52B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> @@ -1755,8 +1756,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>>  
>>  	packet_trace_identity("fetch");
>>  
>> -	fetch_if_missing = 0;
>> -
>
> This is the scary part, but in an "uncomfortably exciting" sense rather
> than a worrying one.  Thanks for adding a test.
>
> [...]
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -673,7 +673,8 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>>  		struct object *o;
>>  
>>  		if (!has_object_file_with_flags(&ref->old_oid,
>> -						OBJECT_INFO_QUICK))
>> +						OBJECT_INFO_QUICK |
>> +							OBJECT_INFO_SKIP_FETCH_OBJECT))
>
> Should we make OBJECT_INFO_QUICK always imply
> OBJECT_INFO_SKIP_FETCH_OBJECT?  I would suspect that if we are willing to
> avoid checking thoroughly locally, checking remotely would be even more
> undesirable.

I think I've seen this mentioned a few times during this cycle in
the list archive ;-)

>> +	for i in $(seq 1 100)
>> +	do
>> +		echo line $i >>big-blob.txt
>> +	done &&
>
> Should this use test_seq for better portability?

Yup.

> nit: can avoid a subshell:
>
> 	test_seq 1 100 | sed -e 's/^/line /' >big-blob.txt

Yeah, but it costs process start-up and "sed" that may be rather
heavyweight.  At least

	for i in $(test_seq ...)
	do
		echo line $i
	done >big-blob.txt

would save repeated opening and closing the file, I'd think.

>> +	git hash-object big-blob.txt >hash &&
>> +	grep "want $(cat hash)" trace
>
> nit: can avoid using cat:
>
> 	hash=$(git hash-object big-blob.txt) &&
> 	grep "want $hash" trace
>
> Thanks and hope that helps,

Thanks, both.

