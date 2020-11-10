Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACDFC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 06:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD07B206A1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 06:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tqzngzkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbgKJGAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 01:00:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53005 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731643AbgKJGAU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 01:00:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D122109E54;
        Tue, 10 Nov 2020 01:00:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ihEdnN+TX5Rd2jTboUiT/rKswi0=; b=tqzngz
        kINxpmPXtyLkfSTXpU8c2NWBt0gN+S1H5J4+jBPP8cFjWZOq3vjIBrTO6NLtwE4M
        jD6A02FUb7lpMAaNYJyldVRdpzHWLzhBe2PbBgVwfwtccPaGU+tseX567khVoe2j
        EhZZyFzD0eS2MxYOHnPmK9zauiHAXYon7V0WU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WiPyX34A1vqN49+ReHcfWAWu77WlXrZP
        DgHPYc9uMkjWxcJCm2ei654FtOipjsxHoOv5shVAH2RA5uLa/OwGc0EIHuQLCG5t
        GDb834YD1fNUEo972487Sl7sBZ1veWJqGd7Mz83dgJa7oNuz18/BWe1Is5NB5cAd
        cFn+yfFcsbA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44FAC109E53;
        Tue, 10 Nov 2020 01:00:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8A419109E50;
        Tue, 10 Nov 2020 01:00:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Daniel Gurney <dgurney99@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] compat/bswap.h: simplify MSVC endianness detection
References: <20201107234751.10661-1-dgurney99@gmail.com>
        <20201108095739.23144-1-dgurney99@gmail.com>
        <20201110003127.GA1268480@coredump.intra.peff.net>
        <20201110023620.GH6252@camp.crustytoothpaste.net>
Date:   Mon, 09 Nov 2020 22:00:13 -0800
In-Reply-To: <20201110023620.GH6252@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 10 Nov 2020 02:36:20 +0000")
Message-ID: <xmqqft5h92fm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00E12E0C-231A-11EB-8D32-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-11-10 at 00:31:27, Jeff King wrote:
>> On Sun, Nov 08, 2020 at 11:57:41AM +0200, Daniel Gurney wrote:
>> 
>> > Modern MSVC or Windows versions don't support big-endian, so it's
>> > unnecessary to consider architectures when using it.
>> 
>> This made me wonder if we support any non-modern versions (which would
>> be negatively impacted).
>
> I'm pretty sure we don't.  As I said, we're using several C99 features
> and that version precedes the C99 standard (and 1999).
>
>> From the earlier thread at [1], it sounds like probably not, but I
>> wonder if we can offer a stronger argument there (or just define
>> "modern" a little more clearly).
>
> According to Wikipedia[0]:
>
>   Visual C++ 2013 [12.0] finally added support for various C99 features
>   in its C mode (including designated initializers, compound literals,
>   and the _Bool type), though it was still not complete. Visual C++ 2015
>   further improved the C99 support, with full support of the C99
>   Standard Library, except for features that require C99 language
>   features not yet supported by the compiler.
>
> The version mentioned that supported MIPS, Alpha, and m68k was Visual
> C++ 2.0 RISC Edition.  While Wikipedia doesn't mention its release date,
> its successor, Visual C++ 4.0, was released in 1995.  The m68k version
> ran on Macs using those processors, and Apple abandoned m68k for PowerPC
> in 1994[1].

So, 

	The only versions of MSVC that support big-endian are too
	ancient and do not understand some C99 features we use in
	our codebase, so it is unnecessary...

would be sufficient?

> I'm entirely comfortable with requiring that people use a compiler and
> operating system newer than 25 years old to compile Git correctly.  As
> I've said or implied in previous threads, I'm also fine requiring C99
> (vendors having had over two decades to implement it) and only
> supporting OSes with vendor security support, although obviously these
> latter two items are much more controversial.

Maybe controversial, but worth at least laying the ground rules
ahead of time?

Do we have any specific feature we avoid only due to portability
concerns?  Declaring an identifier in the first part of for() is the
only thing that comes to my mind, but there may be others.  I think
we should consider how well each individual feature is supported by
systems we care about as we feel the need.

Thanks.
