Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D04B1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 17:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403861AbfFKRdZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 13:33:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56705 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbfFKRdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 13:33:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 943551490DC;
        Tue, 11 Jun 2019 13:33:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QuqF279lnveTT5Gj8HZOttbFhtU=; b=TMXcnl
        KUPHp8t7AJHMkR1BDicdmlNmoF6lsgfNtwvELI03AtlPMOgmO9hWKcnblX5d9ijU
        ncfTDBYzcIbj6atgQzZ6yXTrIVaYEL1YZ2L0f6pvJ8TsKak5pUZAyKJjP4cXuASH
        jV74wYTPl2UQQzalEJa4JHHmAE+A6eiBmwxdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eSFWiXg52mQPNkzHeXxv2JVVxID9OXFT
        XDy2IaPaSVdIvr3pxP2PNF6HuC1EVEJf7Lt3oA1MjGoqh7fUqlLeNGaanC8LLN/8
        YGjVhw2z7EvWNRsMYsYsUb0udHGjHklh0RUPc8Di9LUcOwALXHAd1Kztgh7rwnSu
        Qw4ri3Ce0ao=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88EA61490DB;
        Tue, 11 Jun 2019 13:33:20 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E49F1490DA;
        Tue, 11 Jun 2019 13:33:19 -0400 (EDT)
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
Date:   Tue, 11 Jun 2019 10:33:18 -0700
In-Reply-To: <20190611003456.GB10396@comcast.net> (Matthew DeVore's message of
        "Mon, 10 Jun 2019 17:34:56 -0700")
Message-ID: <xmqqtvcwkowx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00D5831A-8C6F-11E9-8846-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@comcast.net> writes:

>> convention, and it may even be a useful one (i.e. it allows you to
>> calloc() a structure with an embedded strbuf in it and the "if
>> .buf==NULL, call strbuf_init() lazily" can become an established
>> pattern), but at the same time it feels a bit brittle.  
>
> Is it brittle because a strbuf may be initialized to non-zero memory, and so
> the "if (buf.buf == NULL)" may evaluate to false, and then go on treating
> garbage like a valid buffer?

It is brittle because callers are bound to forget doing "if
(!x->buf.buf) lazy_init(&x->buf)" at some point, and blindly use an
uninitialized x->buf.  Making sure x->buf is always initialized
before any caller touches is the only way to solve it, and as you
said, there are two possible ways to make that happen.  One way that
does not violate the current API contract is to make sure whoever
allocates and/or initializes the surrounding struct that embeds a
strbuf does strbuf_init(&x->buf) before any user sees the struct.

Another would be to update strbuf API so that strbuf_init() does not
even have to use slopbuf.  But that is a much larger change that
potentially breaks existing users of strbuf API.  When you have a
strbuf that has been prepared to be usable, the current API contract
allows its users to expect buf.buf is never NULL, so they assume
that they can safely write "if (!buf.buf)", so auditing strbuf.c and
making sure a strbuf with buf==NULL gets lazily initialized is not
enough.
