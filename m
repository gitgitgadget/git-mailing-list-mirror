Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A453C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79DF206B2
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tyL/jkkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHKS6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:58:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57860 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKS6W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 14:58:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 218B0F4D3D;
        Tue, 11 Aug 2020 14:58:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Gh76MPFmIX/V
        QQwswBVrbo+H5JQ=; b=tyL/jkkN2YoCpzYQXfhDZHm7qg0UQIdGGVwY4Gl0iz87
        C7iib/TMykhJxclUpa4GH06pG497s0B0ZmUX5VCbOWfNmtzzhhBxkDPxO/oocdHo
        i6Gt94P8d6P9dDWIb/LxVUgabFtglmBRuehtHJzpDGUYVJ8CpAjWmkGiQb5W8qM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VVXkHF
        fvLm9bAVi+u20rnHsNnTFAcHR1VoeLsUj9+q/W5OhfWQbdDMCeCblVXN1buSuYxr
        EuVFX7MiCDYxBrmcAk4W5fEFIaQYdHTkEBNLLbF4h4e1REzQiPGZPoqvO9qLdF9x
        ELQez/RZM6AzjOq0V7kt5a836WO3XXUWT6i+A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A2D9F4D3C;
        Tue, 11 Aug 2020 14:58:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6368CF4D3B;
        Tue, 11 Aug 2020 14:58:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antti =?utf-8?Q?Ker=C3=A4nen?= <antti@keraset.fi>
Cc:     Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
        Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>,
        git@vger.kernel.org,
        Jussi =?utf-8?Q?Ker=C3=A4nen?= <jussike@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: Fix possibly wrong onto hash in todo
References: <20200811131313.3349582-1-detegr@rbx.email>
        <ebdc0bc7-f48e-9f38-328d-b1181ac974d7@gmail.com>
        <20200811153621.GD19871@syl.lan>
        <20200811181537.qt7jkoxy7qn3k7mo@haukka.localdomain>
Date:   Tue, 11 Aug 2020 11:58:14 -0700
In-Reply-To: <20200811181537.qt7jkoxy7qn3k7mo@haukka.localdomain> ("Antti
        =?utf-8?Q?Ker=C3=A4nen=22's?= message of "Tue, 11 Aug 2020 21:15:37 +0300")
Message-ID: <xmqqsgct9fi1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9DD5CE78-DC04-11EA-9A07-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antti Ker=C3=A4nen <antti@keraset.fi> writes:

> On Tue, Aug 11, 2020 at 11:36:21AM -0400, Taylor Blau wrote:
>> Ack, I noticed this too during my review, but apparently forgot to
>> comment on it. I'm puzzled by the first '..*'. If you're searching for
>> any non-empty string, how about '.+' instead?
>
> That's true. Good point. I pretty much copy&pasted the 'todo count' tes=
t
> so I didn't give this much thought. I'll fix this.

Please don't shorten ..* into .+ if you are writing a portable sed
script---stick to the BRE.

