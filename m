Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689DCC433E1
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 23:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3344A20663
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 23:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gcm2Cl+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGYXB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jul 2020 19:01:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61278 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgGYXB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jul 2020 19:01:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 542796915C;
        Sat, 25 Jul 2020 19:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KE9XvQDpRBZW0RX4kpbcpZpJ+7U=; b=gcm2Cl
        +QS+eqBhJKYmhwmYNonAlrKXHklYVt76KafPISlIW3rLIKP5PmznptiBI4soxoRe
        JFfB/9TQbQziyJI2rXmjM0fwOqYkdyzaGj5JtNjvtEkMW8vPXl6zZTGwiYnYv487
        AEugCWvAK2hq8QzT1Ofcyaj/YxtvvzRCdGg0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QMTKx7C5CzRIPJOPtHj1uEoSMWzMTiXY
        69iKjyIZxp0ZldHDziszPopimySTZM26EZC+LwpCoZplrD0V+oyVYWWESzytodmh
        PIEBiujwbOphu9rH5Y6ixIfzdlvG7yIEOGeTU4fUIVti9Tu9UdULaoEATAciyEih
        jFfjQdCMc80=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BCD86915B;
        Sat, 25 Jul 2020 19:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BCC436915A;
        Sat, 25 Jul 2020 19:01:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Modify fetch-pack to no longer die on error?
References: <20200724223844.2723397-1-jonathantanmy@google.com>
        <xmqq7dusjyos.fsf@gitster.c.googlers.com>
        <20200725214118.GA4508@coredump.intra.peff.net>
Date:   Sat, 25 Jul 2020 16:01:25 -0700
In-Reply-To: <20200725214118.GA4508@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 25 Jul 2020 17:41:18 -0400")
Message-ID: <xmqqft9fi4hm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4C0B03A-CECA-11EA-B033-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it was this one:
>
>   https://lore.kernel.org/git/20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net/
>
> I still think it's a good idea, but the hard part is lib-ifying all of
> the functions that call die() to instead return an error up the stack
> (and handle cleanup, etc). Which is why I never really pushed it
> further. But if we're going to be lib-ifying such calls anyway, I think
> it's nice to do this flexible thing (from their perspective it's no more
> work to trigger the callback than it is to call error() and return).

Yeah, I almost 80%+ agree.

The remainder of 20% is that I am not so convinced that (fmt_string
+ va_list) that isn't pretty much usable for anything but generating
human readable error messages is enough.  It is certainly a good
enough replacement for (and much better than) the approach to
prepare an error string in a "struct strbuf err" that was passeed by
the caller, but I am not sure if that is a good bar to aim to pass
to begin with ;-).

> That said, I do think for this particular case, your "just run it in a
> sub-process" suggestion may be simpler and more robust.

For this particular case, with the performance and all, I agree that
the stupid and robust approach would be the best.

