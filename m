Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BE5C352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 21:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E33B206DB
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 21:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Et/91+1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgBLVLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:11:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64497 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgBLVLI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 16:11:08 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4DB5A4B93;
        Wed, 12 Feb 2020 16:11:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nNangZEPqPHkR5bFhmOEkPVybUs=; b=Et/91+
        1sOGzw6/fpsf0UZn/IQb+2DUwHk3Ur/wXswYHZezQS6EpKnLQbV5InALbQuCN1VJ
        utmxn/uKK9c0saYDU5bnd1pzv+WbhAwe5sfm8JrzXzGhc+SgYJX6OLR0yyoAPPnh
        DXGDREO3EbDY40Q+IcwyW0teNeP52KLuE5K3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E3BCwPBepNAvo18DAfP7HQsiUozOFUTv
        yE8eNPMLaGrXCw40R6LdkaQ+xy/fmsPE7HhDfjuIj3avZbvReu4Jxfoap1LmN7f9
        7RMvv1G1TcIvGj4rLpKwxxgJ3nDLmQ1Kfuex+cK1L4HZ7CB2z2cs8K/8eFuGuFf0
        NoKXtIX4XeA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BCDB3A4B92;
        Wed, 12 Feb 2020 16:11:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E6CE0A4B8C;
        Wed, 12 Feb 2020 16:11:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Parth Gala via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Parth Gala <parthpgala@gmail.com>
Subject: Re: [PATCH 2/5] object.c: lookup_unknown_object() accept 'r' as parameter
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
        <16dd64618ab6a086727685e9eca3850fabc46437.1581535151.git.gitgitgadget@gmail.com>
        <20200212202540.GD4364@syl.local>
Date:   Wed, 12 Feb 2020 13:11:02 -0800
In-Reply-To: <20200212202540.GD4364@syl.local> (Taylor Blau's message of "Wed,
        12 Feb 2020 12:25:40 -0800")
Message-ID: <xmqqtv3vtst5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E168D5E-4DDC-11EA-A6FC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> ... same question about why assigning:
>
>   struct repository *r = the_repository;
>
> and passing 'r' everywhere is preferable to simply passing
> 'the_repository' in directly.
> ...
>>  static void mark_object_for_connectivity(const struct object_id *oid)
>>  {
>> -	struct object *obj = lookup_unknown_object(oid);
>> +	struct repository *r = the_repository;
>> +	struct object *obj = lookup_unknown_object(r, oid);
>>  	obj->flags |= HAS_OBJ;
>>  }

I do not claim that it applies to this particular function, and the
function is too small for it to matter, but when a function is large
enough and it always works on one single repository, it would make
it easier to later update the function further to set up 'r'
upfront, making it point at the_repository for now, and to use 'r'
throughout the function.  That way, when the time comes to update
the function to work on an arbitrary repository, the only change
required will be to turn the local variable 'r' to an incoming
parameter the caller can supply.
