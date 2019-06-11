Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9D51F462
	for <e@80x24.org>; Tue, 11 Jun 2019 21:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407695AbfFKVs7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 17:48:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51261 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405081AbfFKVs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 17:48:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A653069574;
        Tue, 11 Jun 2019 17:48:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xr1m5s/QGuyYy8T4irnapsAou/8=; b=aJnji1
        wKDFfyEuDQ6V2bTUHkGWf++c80HS8DWLMWTNzf1URunAxT5Wz1lYuj+ad2pptQvR
        16Qw+jEBLyij9u7ZmyIr73Yl8JjQ/Qyrbsz2ltkql3QBcjatDG/FyeufiYVV+KIv
        J/laKSFgASPl5Yq94Ato2NP2f74Gf5H9NeUOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bAaQUdBu4h8dzYzeyf5XlzN6OvvTy5IB
        3MdYtkqI+RIKiQBHnqZcGZoh5yYuXb7ylK+oteDEA+SmNjAFf/miYa5DeXvoRE5H
        6NN0d13GVNPDdhrDilZHrcuCXrovWvzes9uKitQGUcF6XmOBvjjJC+TllGhUvGSf
        m3gQLVmcqMo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F03269573;
        Tue, 11 Jun 2019 17:48:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D413069572;
        Tue, 11 Jun 2019 17:48:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrn@google.com, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 6/9] list-objects-filter-options: make filter_spec a strbuf
References: <20190601003603.90794-1-matvore@google.com>
        <20190601003603.90794-7-matvore@google.com>
        <xmqqimtdmc59.fsf@gitster-ct.c.googlers.com>
        <20190611003456.GB10396@comcast.net>
        <xmqqtvcwkowx.fsf@gitster-ct.c.googlers.com>
        <20190611184426.GB58112@comcast.net>
Date:   Tue, 11 Jun 2019 14:48:51 -0700
In-Reply-To: <20190611184426.GB58112@comcast.net> (Matthew DeVore's message of
        "Tue, 11 Jun 2019 11:44:27 -0700")
Message-ID: <xmqqmuinkd30.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4DABE34-8C92-11E9-9CF8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@comcast.net> writes:

>> It is brittle because callers are bound to forget doing "if
>> (!x->buf.buf) lazy_init(&x->buf)" at some point, and blindly use an
>> uninitialized x->buf.  Making sure x->buf is always initialized
>
> A corallary proposition would be to make this particular strbuf a "struct
> strbuf *" rather than an inline strbuf. It should then be rather clear to users
> that it may be null.

Would make it less likely for uses of an uninitialized strbuf to be
left undetected as errors?  I guess so, and if that is the case it
would definitely be an improvement.

But initializing the strbuf at the point where the enclosing
structure is initialized (or calloc()'ed) is also a vaiable option,
and between the two, I think that would be even more robust.

There may be reasons why it is cumbersome to arrange it that way,
though (e.g. if the code does not introduce a "new_stuff()"
allocator that also initializes, and instead uses xcalloc() from
many places, initializing the enclosing structure properly might
take a preliminary clean-up step before the main part of the patch
series can begin).
