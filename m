Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0DB4203BD
	for <e@80x24.org>; Thu, 27 Oct 2016 23:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034394AbcJ0XgZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 19:36:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60867 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034266AbcJ0XgY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 19:36:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3649C4AAF6;
        Thu, 27 Oct 2016 19:36:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iwmDvHgKelFGf4NAUW14yqpYH74=; b=TKHSp/
        5fK5IIQ+bEXXjmV5GYZNr2jOuSzzcXydxQQvpSwmqXPmpCQj7KhilU9X4utGEw68
        Vc+uUMG8k3Ym2+wmRgTmJlwl4i6wDJ3GcA2Jh7lh4RVIiaL7wM2GmFxEVTSkWMyc
        jVFJwwNoj+eW0zAouqMwqquqdPHbEqGlhPEUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Sy+rdv9WcBfzpAHDfNh8KI8RxdQgRREX
        0l45HEwuKsKKfj0SQ4q7DjDvrDiqeXTzhd6934ANumGTrZmE5Uw/wvsyLulJ50ik
        chhvjg9FN6kYwn6SQ7iZTnoFN7j2tbvpjZ18+z2CUthTE/bXA1Cdim+gVuS6JVaE
        mwDhbsDKUso=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C2714AAF5;
        Thu, 27 Oct 2016 19:36:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A167C4AAF4;
        Thu, 27 Oct 2016 19:36:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
        <20161025181621.4201-1-gitster@pobox.com>
        <20161025181621.4201-3-gitster@pobox.com>
        <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
        <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
        <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
        <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
        <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net>
        <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
        <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
        <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
        <xmqqoa254czs.fsf@gitster.mtv.corp.google.com>
        <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
        <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
Date:   Thu, 27 Oct 2016 16:36:20 -0700
In-Reply-To: <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 27 Oct 2016 16:19:37 -0700")
Message-ID: <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B4F4D74-9C9E-11E6-9FB2-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But the basic issue still remains - I'd really prefer to have NOATIME
> stay around for all those poor misguided souls that for some reason
> don't like "relatime" or run old kernels. But whether it is with
> O_NOATIME at open time or with F_SETFL, I don't care.

Understood.  

Would the best endgame shape for this function be to open with
O_NOATIME (and retry without), and then add CLOEXEC with fcntl(2)
but ignoring an error from it, I guess?  That would be the closest
to what we historically had, I would think.



