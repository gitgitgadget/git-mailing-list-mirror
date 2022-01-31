Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1503EC433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 17:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380758AbiAaRNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:13:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60341 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380741AbiAaRNT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 12:13:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18315162B99;
        Mon, 31 Jan 2022 12:13:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ne5xPykQlLNVdlZOVsXDzLz1V5Rf8noTq5oFpH
        UCITs=; b=fGCRt7himMVDmk89bMjwy4JknvubP7jACIcMDXueZNx+5tlfpzIx/h
        CJuUStVhKGKmPasMcXcAVGucdPXmZMGvLML4Zav7mB1rYkdYF8mf2CDvpwW3udFU
        /ygVdks4H2AiH/SdzqWdG7SDZIj5fEwz43jioUOFFuOW/1p1nibgY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F23DC162B98;
        Mon, 31 Jan 2022 12:13:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 61C8F162B97;
        Mon, 31 Jan 2022 12:13:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>
Subject: Re: flags types/names
References: <xmqq35lc53e9.fsf@gitster.g> <YfOd7QRK4zjLwJci@ncase>
        <xmqqilu3woj2.fsf@gitster.g>
        <CAFQ2z_M_SXENMU6Y3Evrz9-G_+pqjd-zPQiZjnA_y2hvb+Egkw@mail.gmail.com>
Date:   Mon, 31 Jan 2022 09:13:15 -0800
In-Reply-To: <CAFQ2z_M_SXENMU6Y3Evrz9-G_+pqjd-zPQiZjnA_y2hvb+Egkw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 31 Jan 2022 10:50:16 +0100")
Message-ID: <xmqqbkzrkevo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1461EBEC-82B9-11EC-8B33-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> My questions:
>
> * am I the only one who struggles with the different flavor of `flags` ?

Probably no.

> * if no, what should be done about this? Maybe
>
>   typedef unsigned int ref_flags;
>   #define REF_IS_SYMREF 0x1
>   char *refs_resolve_ref_unsafe(const char *refname, ref_flags *flags, ... );
>
> or
>
>   typedef enum ref_flags {
>      REF_IS_SYMREF = 0x1,
>   };
>   char *refs_resolve_ref_unsafe(const char *refname, enum ref_flags
> *flags, ... );

It is very good to use symbolic constants implemented either as C
preprocessor macros or enums, I would think.

However, I am not enthused to see typedefs; I've never seen multiple
typedefs of the same integral type did anything useful in C.  Perhaps
things are different in the C++ land, but we do not live there.

> A somewhat related gripe is that some code uses `int flags` and other
> code uses `unsigned flags`. It would be great to standardize this.

I agree.  Unless there is very compelling reason to single out the
topmost bit and treat it as special, a set of flag bits should be
"unsigned".
