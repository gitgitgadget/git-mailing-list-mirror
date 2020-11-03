Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EE8C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278CD206A5
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y9YHa5Oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbgKCVQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:16:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56913 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388792AbgKCVK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 16:10:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06DA09B36C;
        Tue,  3 Nov 2020 16:10:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1aZFbqJp34l3eeMDsCbvrvjm/lg=; b=Y9YHa5
        Oey0HMoheKh5/cluEQ5gWcGkFLNQK8WKGW2pV23QesLndakAdKiEM0qv3nJv5dBK
        9w2d6tOWM59lCUYWZ/ezChOvr0nyIhOnzn9uf++RodvskrIhh1eNp4iVNDPCNae6
        d9urKMgjvUOINRyrmu5N4o949kIRGJpEbF44E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PFWY0mqhbggCPqpcevQbewuhjHHPAgTc
        xkvAz8zm4MK1Zvkh9NtG+3W9ynfuJ2s3WyrYP6b+HHwm15FEm8ADpx35XHteZ84T
        CLK8I2aa/kOjMVmOrwH6dCQ7TZyQ35bjCoD23EOWftw9USjlZBdn0oPOxHzAxOyR
        k2P4si4lnXU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F18D89B36B;
        Tue,  3 Nov 2020 16:10:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63EDC9B36A;
        Tue,  3 Nov 2020 16:10:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Duvall <dan@mutual.io>, Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] upload-pack: allow stateless client EOF just prior to
 haves
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
        <20201030044012.GA3259692@coredump.intra.peff.net>
        <CANo+1gv0otfjRexAVW6E+yPEvGLo55_tQWN-81mQMm4U0seCJQ@mail.gmail.com>
        <20201030090902.GA3268509@coredump.intra.peff.net>
Date:   Tue, 03 Nov 2020 13:10:53 -0800
In-Reply-To: <20201030090902.GA3268509@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 30 Oct 2020 05:09:02 -0400")
Message-ID: <xmqqeelaqh7m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F4750F8-1E19-11EB-ACA1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm still uncertain whether it could all be done in one request for v0.
> But one possible solution is: let's not care. If v2 does it correctly,
> that's the future anyway (or present; it's now the default in v2.29).
> And the change you're proposing in upload-pack would be desirable anyway
> to help deal with older clients.
>
> If that's the route we go, we should make sure the commit message
> explains it.

Yeah, I'd agree that punting on v0 and making sure the current
version would work well is good enough.

I lost track and am not sure what's the current status of the topic
is.  Is v3 [*1*] the latest and satisfactory one?

Thanks.


[Reference]
*1* https://lore.kernel.org/git/20201031023901.48193-1-dan@mutual.io/
