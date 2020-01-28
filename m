Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6C5C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36AD2173E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c0OY8h/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgA1SEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:04:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50752 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1SD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:03:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2FE6AF973;
        Tue, 28 Jan 2020 13:03:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Og7lscZujLC+jU1LtE3VVIPmprs=; b=c0OY8h
        /opkBLoT2gljQYR/uXGIVA4ghOUNQUFyjt8mURHFHLyA2AyoQgWMNp2rSmuLykn4
        EUIa+PetiMbVRUnjQWUvBqIWFRiZFk7Y5mko73j+/oK1OacG9S0IPkQX/nXAtDOU
        306klltYMwdBYV6JksN8rbJ2FLDeUSxRYSX6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n+Q0gmkO2hCcJzkWEw+90BDkNZzxdBha
        XsBuQmpQ7OAqoriL5JYHGrXbT0WtCwO8oIgsUOTHgxd6GmYXeI4mP/8Wqc56ww2F
        sTgJWKjffX7VyLG89ZwwWO2aDokZlqcrm7MWwfqLNr2Wzx6o66OKQHypN59GDXBh
        iaXm74PDr1I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB568AF972;
        Tue, 28 Jan 2020 13:03:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F36F2AF970;
        Tue, 28 Jan 2020 13:03:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] avoid computing zero offsets from NULL pointer
References: <20200125053542.GA744596@coredump.intra.peff.net>
        <20200125053834.GB744673@coredump.intra.peff.net>
        <xmqq7e1cbr9w.fsf@gitster-ct.c.googlers.com>
        <20200127211933.GA3794@coredump.intra.peff.net>
Date:   Tue, 28 Jan 2020 10:03:49 -0800
In-Reply-To: <20200127211933.GA3794@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 27 Jan 2020 16:19:33 -0500")
Message-ID: <xmqqtv4f8nlm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A887434-41F8-11EA-9CDF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> >  	const int blk = 1024;
>> >  	long trimmed = 0, recovered = 0;
>> > -	char *ap = a->ptr + a->size;
>> > -	char *bp = b->ptr + b->size;
>> > +	char *ap = a->ptr ? a->ptr + a->size : a->ptr;
>> > +	char *bp = b->ptr ? b->ptr + b->size : b->ptr;
>> >  	long smaller = (a->size < b->size) ? a->size : b->size;
>> >  
>> >  	while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {
>> 
>> Isn't it a bug for a->ptr or b->ptr to be NULL here?  Even if we
>> manage to assign ap = a->ptr = NULL without complaints, how would
>> that memcmp work?
>> 
>> Is it that the corresponding .size would always be 0 if .ptr is NULL
>> that protects us?
>
> If we want to be more defensive, we could do something like this:
>
>   /* dual inline/macro magic to avoid evaluating ptr twice but knowing
>    * enough about the type of *ptr to get the size. */
>   #define SAFE_END_PTR(ptr, len) safe_end_ptr(ptr, len, sizeof(*ptr))
>   static inline void *safe_end_ptr(void *ptr, size_t nr, size_t elem_size)
>   {
> 	if (!ptr) {
> 		if (nr)
> 			BUG("non-zero size coupled with NULL pointer");
> 		return NULL;
> 	}
> 	return (char *)ptr + nr * elem_size;
>   }
>
>   ...
>   char *ap = SAFE_END_PTR(a->ptr, a->size);
>
> I'm not sure if it's worth it, though.

As long as we make it clear to those who add new callers that
any mmfile_t with .ptr==NULL must come with .size==0, it is fine.

> Yet another alternative is to consider it a bug to use an mmfile_t with
> a NULL pointer, figure out where that's being set up, and fix it.

But that would still require us to make it clear to those who add
new callers that mmfile_t with .ptr==NULL is a bug, and the current
callers must be using that as it is convenient for them, I presume,
so I think a simple comment should probably be sufficient.

> As an aside, I also wondered whether we could run into problems with
> "memcmp(NULL, ..., 0)", which is also undefined behavior. But we don't
> here because the first half of the while() condition wouldn't trigger.

Yes, although the details slightly differ ;-)

What is problematic actually is "memcmp(NULL - 1024, ..., 1024)",
which is guarded with "1024 + trimmed <= smaller &&" that will never
be true as long as "mmfile_t with .ptr==NULL must have .size==0"
holds true, right?

Thanks.
