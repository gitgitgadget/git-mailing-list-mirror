Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525B6C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213A56103D
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhHaQei (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:34:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50645 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhHaQei (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 12:34:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98E5C13F368;
        Tue, 31 Aug 2021 12:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IPa9H4vaujaTeIhRgaQWjElb9trW0wOP7dg19L
        kGXqs=; b=Po2Q3hP66uPg+uILUlFS0AAdhmynCWjxK3X8Q0oo+MmiC+X+iGFNLC
        BEnKBqYvcOGRjZFPgZj217yJgbjMP7vogTqqi7eyfW/RzVqrI/TxpEpIJt49vcfu
        tVmxJ5GMNXLZ88Elt28xY7No4JBojpSB7WxZmSxPMrQTPCzN9a3RY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 909F213F367;
        Tue, 31 Aug 2021 12:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 14BFE13F366;
        Tue, 31 Aug 2021 12:33:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
References: <xmqqr1eimtrp.fsf@gitster.g> <YSVjnSDaBXgXvT9W@nand.local>
        <xmqq35qymrcn.fsf@gitster.g> <xmqqy28qlcow.fsf@gitster.g>
        <YSVuUYFh7lmhNlEy@nand.local> <xmqqo89jbf49.fsf@gitster.g>
        <YSko4OwwPb7MwEMa@nand.local> <xmqq4kb797xc.fsf@gitster.g>
        <YSwhNxqAS8JajA7p@nand.local>
        <22366f81-65a6-55d1-706c-59f877127be0@gmail.com>
        <YS3AKhQJjMrFm1JO@coredump.intra.peff.net>
Date:   Tue, 31 Aug 2021 09:33:38 -0700
In-Reply-To: <YS3AKhQJjMrFm1JO@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 31 Aug 2021 01:37:46 -0400")
Message-ID: <xmqqk0k1wp3x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32C9520E-0A79-11EC-9A8E-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I think taking a look to see if ../config exists to use the data
>> might be helpful for some cases, but should not be a blocker for
>> completing the requested operation. The config from the non-alternate
>> repo should be sufficient for this (somewhat strange) case.
>
> Yes, agreed. We have long supported these kind of "bare" alternates, and
> I wouldn't be surprised if they are in wide use (though I do wonder how
> folks actually modify them, since most commands that touch objects
> really do want to be in a repository).

I kind of find the above two somewhat surprising, but I am willing
to go with the less safer option if that is what people want.

It has been perfectly OK in the pre-alternative-hash-algorithms
world, but we no longer live in such a world, so we'd need to come
up with a way to keep using alternates in a safer way.

I do not see the reasoning behind "should not be a blocker" from
Derrick substantiated.  What's the reason why that raw object store
cannot come from an existing repository, and what's the benefit we
get from not having to have a repository there?

> The natural extension for the hash-format problem would probably be to
> call check_repository_format_gently() on the parent directory of the
> alternate-objects dir. If it succeeds, then we can pull out the
> hash_algo parameter from its repository_format struct. And if not, then
> we just assume it matches the main repo.
>
> But I suspect all of this is moot for now, beyond being able to return a
> nicer error message. The rest of the code is not at all ready to handle
> packs with two different hashes in the same process.

I do not think it is all that urgent to make it possible for packs
with different algorithms to be used.  It is sufficient to _ignore_
(or error out) configured odb that is incompatible with the current
repository.

Thanks.
