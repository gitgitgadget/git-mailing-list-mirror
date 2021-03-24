Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84462C433E0
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56AA361A2B
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbhCXT5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:57:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65129 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbhCXT5U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 15:57:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 198F5134F6E;
        Wed, 24 Mar 2021 15:57:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JQASmgxQP6J1WIIwo+SVpKcXoEY=; b=TzArQG
        xZ2Xt9kH8hCHDNK09g6P6M15al+LrInYM8sPmVFej6n+5ROoHyeMUlWh8TuQf3xo
        kNPoSjw58daASMR12vDl/bL8CDqJlSNmgGZES7/y/jgmYDzPDUSqaJIwsFj6VQE9
        Y6leJrXGzQuo2NPk7bpYKDbTEsEa0mLrr9NYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yb5kbBRoYoJmjUcILFhyw3jDZ6yXBK0J
        03bbkVQ/vPTQWyVg8mpqHZTwQUH5FjAVlRBaUdF7AodRPCxTqYuqtNni7T3fcLKg
        scrU9sfmbsAp+XacjKkWHukUCu7efMEZJO3VOBXx/jLbBLwycauFmASvYfBNGgpv
        dBmKMl5i4o8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 11145134F6D;
        Wed, 24 Mar 2021 15:57:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 57E54134F6C;
        Wed, 24 Mar 2021 15:57:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
References: <20210224195129.4004-1-avarab@gmail.com>
        <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
        <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
        <YFuPMMMYicFK6A/S@coredump.intra.peff.net>
Date:   Wed, 24 Mar 2021 12:57:15 -0700
In-Reply-To: <YFuPMMMYicFK6A/S@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 24 Mar 2021 15:12:48 -0400")
Message-ID: <xmqqsg4kxr38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22C15076-8CDB-11EB-81CC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Our callback function does _one_ type of selection (based on a "type"
> parameter), but not another (based on the name). That feels
> inconsistent, but is also the reason we have this awkward struct.

I wrote a very similar review but did not send it out, as I couldn't
pinpoint where the awkwardness come from exactly.

> Part
> of my confusion is the name: this is not something to be generically
> used with for_each_userdiff_driver(), but rather a type unique to
> find_by_namelen() to be passed through the opaque void pointer.
>
> So "struct find_by_namelen_data" would have been a lot more
> enlightening.

Yes.  The callback parameter being "void *" is the API, and it is
just this user that uses this particular structure.

And while "type" could also be made a part of this structure and
have the API always iterate over all entries regardless of "type",
i.e. the callback function could be the one responsible for finding
the entries in the table for one particular type, it is understandable
that potential callers can be helped by having the pre-filtering
based on the "type" thing on the API side.

>> +	if (!strncmp(driver->name, cb_data->k, cb_data->len) &&
>> +	    !driver->name[cb_data->len]) {
>> +		cb_data->driver = driver;
>> +		return -1; /* found it! */
>>  	}
>
> This "return -1" took me a while to grok, and the comment didn't help
> all that much. The point is to stop traversing the list, but "-1" to me
> signals error. I think returning "1" might be a bit more idiomatic, but
> also a comment that says "tell the caller to stop iterating" would have
> been more clear.

And the fact that it becomes the return value of "for_each_()" iterator
does not quite help to use a negative value, implying there was some
error condition X-<.

> Perhaps it would make more sense as:
>
>   USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
>   USERDIFF_DRIVER_TYPE_CUSTOM = 1<<0,
>   USERDIFF_DRIVER_TYPE_ALL = USERDIFF_DRIVER_TYPE_BUILTIN | USERDIFF_DRIVER_TYPE_CUSTOM
>
> Or the one caller who wants "ALL" could even do the OR themselves.

Great minds think alike ;-)

> I do kind of wonder if there's much value in having a single function
> with a type field at all, though, given that there's no overlap in the
> implementation. Would separate "for_each_custom" and "for_each_builtin"
> functions make sense? And then the existing caller would just call them
> sequentially.

Or a single for_each_driver() that gives <name, length, type> tuple
to the callback function, iterating over all drivers regardless of
the type.

