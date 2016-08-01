Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9381F855
	for <e@80x24.org>; Mon,  1 Aug 2016 20:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbcHAUUK (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 16:20:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751336AbcHAUUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 16:20:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FAE732BEA;
	Mon,  1 Aug 2016 16:05:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uJ7LuR0M5ugNJMAwRoaE5xy8jsU=; b=aPlcs5
	WDYWNaLhPH0WxN+OePiTuCEN7jZsO0eUkHK6YTrD6xYtNlqZmDY6jxzBkoci5rkz
	71II9meop2RvHSHT7IXCI7auZXBQRmYWQeYWArJ42PdJOwrDG9psvcNlRM656/UA
	gghg+128uc8ikzWFF6nnzuzRoU9sePS/VNtjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DbWTsZ9BMMdQWfDxa1XbjItF39byY+SE
	9N+YH1zBH8d/Efbjh8LRzlPsiIpjtYYGzahiuXZ/Z/WSZyW+bRNVWuB2dPDmHcc3
	60vtGX24hlZVxZSayBKO1ln1O4s2bUb8YQH4wDmTdR9iOmAD5+P1CjgtjweAWDFL
	8AZBfh2Kazg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 371C332BE9;
	Mon,  1 Aug 2016 16:05:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8951532BE7;
	Mon,  1 Aug 2016 16:05:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 1/4] patch-ids: stop using a hand-rolled hashmap implementation
References: <20160729161920.3792-1-kcwillford@gmail.com>
	<20160729161920.3792-2-kcwillford@gmail.com>
	<xmqqoa5gmas6.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607301056120.11824@virtualbox>
Date:	Mon, 01 Aug 2016 13:04:58 -0700
In-Reply-To: <alpine.DEB.2.20.1607301056120.11824@virtualbox> (Johannes
	Schindelin's message of "Mon, 1 Aug 2016 10:54:48 +0200 (CEST)")
Message-ID: <xmqqy44gi7bp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B713966-5823-11E6-9394-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It would be a serious bug if hashmap_entry_init() played games with
> references, given its signature (that this function does not have any
> access to the hashmap structure, only to the entry itself):
>
> 	void hashmap_entry_init(void *entry, unsigned int hash)

I do not think we are on the same page.  The "reference to other
resource" I wondered was inside the hashmap_entry structure, IOW,
"the entry itself".

Which is declared to be opaque to the API users, so whoever defined
that API cannot blame me for not checking its definition to see that
it only has "unsigned int hash" and no allocated memory or open file
descriptor in it that needs freeing.

By the way, the first parameter of the function being "void *" is
merely to help lazy API users, who have their own structure that
embeds the hashmap_entry as its first element, as API documentation
tells them to do, e.g.

	struct foo {
        	struct hashmap_entry e;
                ... other "foo" specific fields come here ...
	} foo;

and because of the lazy "void *", they do not have to do this:

	hashmap_entry_init(&foo->e, ...);

which would be required if the first parameter were "struct
hashmap_entry *", but they can just do this:

	hashmap_entry_init(&foo, ...);

I have a slight preference to avoid the lazy "void *", but that is
an unrelated tangent.

>> The fact that hashmap_entry_init() is there but there is no
>> corresponding hashmap_entry_clear() hints that there is nothing to
>> be worried about and I can see from the implementation of
>> hashmap_entry_init() that no extra resource is held inside, but an
>> API user should not have to guess.  We may want to do one of the two
>> things:
>> 
>>  * document that an embedded hashmap_entry does not hold any
>>    resource that need to be released and it is safe to free the user
>>    structure that embeds one; or
>> 
>>  * implement hashmap_entry_clear() that currently is a no-op.
>
> Urgh. The only reason we have hashmap_entry_init() is that we *may* want
> to extend `struct hashmap_entry` at some point. That is *already*
> over-engineered because that point in time seems quite unlikely to arrive,
> like, ever.

I am saying that an uneven over-enginnering is bad.

To be consistent with having _init() and declaring the entry
structure to be opaque, you would either need _clear() or document
you would never need to worry about the lack of _clear().
