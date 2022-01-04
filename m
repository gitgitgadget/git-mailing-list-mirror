Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB29C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 21:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiADVjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 16:39:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52252 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiADVjn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 16:39:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E7B6175F7F;
        Tue,  4 Jan 2022 16:39:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YYE+JR1uqP8fF/g93SBDCFWFmhb5+8WfH25SuZ
        ZGoWo=; b=IZ+/K/5i02SXsxA/K+b1VCuT9S53+PfIDsxtV0Gh9Ff/yiWPx6tEAd
        dR+nWMrn0lbQDC9KnH84sG7PPNUvOOVUMqIy0mYgt+dULar/DC3fvF0bc5RYjN3z
        x21oRUy/e96ywh+TfQBEPKDHF/MCtnmHtjKIaGXMmGcQkCe3uKj1c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26B7F175F7E;
        Tue,  4 Jan 2022 16:39:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A924175F7D;
        Tue,  4 Jan 2022 16:39:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
        <20220104015555.3387101-2-sandals@crustytoothpaste.net>
        <xmqqsfu3b4gw.fsf@gitster.g>
Date:   Tue, 04 Jan 2022 13:39:37 -0800
In-Reply-To: <xmqqsfu3b4gw.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        04 Jan 2022 13:01:19 -0800")
Message-ID: <xmqqlezvb2p2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1E60E78-6DA6-11EC-B3FF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +ifeq ($(strip $(CSPRNG_METHOD)),arc4random)
>> +	BASIC_CFLAGS += -DHAVE_ARC4RANDOM
>> +endif
>> +
>> +ifeq ($(strip $(CSPRNG_METHOD)),arc4random-libbsd)
>> +	BASIC_CFLAGS += -DHAVE_ARC4RANDOM_LIBBSD
>> +	EXTLIBS += -lbsd
>> +endif
>> +
>> +ifeq ($(strip $(CSPRNG_METHOD)),getrandom)
>> +	BASIC_CFLAGS += -DHAVE_GETRANDOM
>> +endif
>> +
>> +ifeq ($(strip $(CSPRNG_METHOD)),getentropy)
>> +	BASIC_CFLAGS += -DHAVE_GETENTROPY
>> +endif
>> +
>> +ifeq ($(strip $(CSPRNG_METHOD)),rtlgenrandom)
>> +	BASIC_CFLAGS += -DHAVE_RTLGENRANDOM
>> +endif
>> +
>> +ifeq ($(strip $(CSPRNG_METHOD)),openssl)
>> +	BASIC_CFLAGS += -DHAVE_OPENSSL_CSPRNG
>> +endif
>
> Use of $(strip ($VAR)) looks a bit different from what everybody
> else does with ifeq in this Makefile.  Was there a particular reason
> to use it that I am missing?

Another thought.  As far as I can see on the C code side in the
later part of the patch, we are prepared to see multiple HAVE_* for
CSPRNG defined by the builders, and let us choose the best one for
them.  I wonder if it makes sense to allow

    make CSPRNG_METHOD='arc4random getentropy'

as a way to tell us that they have these two and want us to pick the
best one for them.  

It does not add much value for human builders, but I suspect that it
would make it simpler when we need to add autoconf support.  

If we do not allow multiple methods listed on the CSPRNG_METHOD
variable, the configure script will be forced to pick one in some
way when multiple methods are possible on the platform, either by
detecting all and picking one, or detecting serially from most
preferred and stopping at the first hit.
