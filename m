Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638F3C433FE
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 18:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiBPSag (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:30:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiBPSae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 13:30:34 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290E4297210
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 10:30:21 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D074104782;
        Wed, 16 Feb 2022 13:30:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=M+s0TH9GOPu9
        7q/6RnpdjOBXzcWsxx+hkiTR5QeD2wo=; b=AWb5g2b0BQZT2NMhHWLHvJeqet+o
        LgOTe2jxu9jl+e6zzjgzHgqYr38sXBCk9oCPDqqtfK1ek9DoCa6ICM9zcYcDFxRY
        saJNdIDjpjTn+pMTn4rV0g7/nsnAVneCYcZaj9XyPzJqLZNybH+7NTsMwGsIQ1ZW
        cSi1cKGK8/ymh9g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14B81104781;
        Wed, 16 Feb 2022 13:30:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69FB910477E;
        Wed, 16 Feb 2022 13:30:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] commit: use strbuf_release() instead of UNLEAK()
References: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
        <patch-2.2-e3e78c9e40b-20220216T081844Z-avarab@gmail.com>
        <xmqqa6equ1rq.fsf@gitster.g>
Date:   Wed, 16 Feb 2022 10:30:18 -0800
In-Reply-To: <xmqqa6equ1rq.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        16 Feb 2022 10:03:53 -0800")
Message-ID: <xmqqtucyslz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7E88ED3C-8F56-11EC-A9C4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Convert the UNLEAK() added in 0e5bba53af7 (add UNLEAK annotation for
>> reducing leak false positives, 2017-09-08) to release the memory using
>> strbuf_release() instead.
>>
>> The tests being marked as passing with
>> "TEST_PASSES_SANITIZE_LEAK=3Dtrue" already passed before due to the
>> UNLEAK(), but now they really don't leak memory, so let's mark them as
>> such.
>
> That smells like a brave move.
>
> Specifically, the cited commit turned an existing strbuf_release()
> on &err into UNLEAK().  If that and the other strbuf (sb) were so
> easily releasable, why didn't we do so back then already?

I suspect that the answer to the above question is because these
allocations are in the top-level cmd_commit() function, which is
never called recursively or repeatedly as a subroutine.  The only
significant thing that happens after we return from it is to exit.

In such a code path, marking a variable as UNLEAK() is a better
thing to do than calling strbuf_release().  Both will work as a way
to squelch sanitizers from reporting a leak that does not matter,
but calling strbuf_release() means we'd spend extra cycles to return
pieces of memory to the pool, even though we know that the pool
itself will be cleaned immediately later at exit.

We already have UNLEAK to tell sanitizers not to distract us from
spotting and plugging real leaks by reporting these apparent leaks
that do not matter.  It is of somewhat dubious value to do a "we
care too much about pleasing sanitizer and spend extra cycles at
runtime while real users are doing real work" change.
