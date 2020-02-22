Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1156C35671
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 17:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C1320702
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 17:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eONmXr30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgBVRM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:12:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52001 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgBVRM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 12:12:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E2D9BDC40;
        Sat, 22 Feb 2020 12:12:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7rbVpTPuihsc1K3aRbVywLFT9Yk=; b=eONmXr
        30p7sfLg02KrdEbgr9a3LuJ5cGkkv8iFJiL0yiBjdj4M4/ODPfqH9zxODqyzFeCe
        ipaE10GXXqHAgN/aImL3QmkbxuTP2D5cS/iOlyEHFwMUU9M4oTc1IvAj0fRoYUBw
        wKXmXZXOeJfr5eCnFn3cLxXj0YM6PplcesfPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ridQTZSU2GXPlAsRuJNUhKANSRjoX06M
        vgNsRmpH2Yu3sRQlr3nq2uUVmUDoe/qb69SY9/jdBOEOAToxfUdDbdSMrxX+rlk/
        nSMGbp92Xn+rCDNiVJCUhtfGLQogTn3Mpa25kPGW0z6eGPAymDkMyor4xjWoDIlq
        nxdewXgEUqw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6666DBDC3F;
        Sat, 22 Feb 2020 12:12:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9363EBDC3E;
        Sat, 22 Feb 2020 12:12:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Anthony Sottile <asottile@umich.edu>, git@vger.kernel.org
Subject: Re: [PATCH] run-command.c: ensure signaled hook scripts are waited upon
References: <20200221060636.4507-1-asottile@umich.edu>
        <20200221063954.GJ1280313@coredump.intra.peff.net>
Date:   Sat, 22 Feb 2020 09:12:19 -0800
In-Reply-To: <20200221063954.GJ1280313@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 21 Feb 2020 01:39:54 -0500")
Message-ID: <xmqqblpq7dho.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CD78A4E-5596-11EA-BC15-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we assume that most people would prefer this "wait until the hook has
> died" behavior, I think this shouldn't have any unwanted secondary
> effects. I'm on the fence on whether it's what most people would want or
> not (I guess most people don't care either way, because their scripts
> don't ignore SIGINT).

Yeah, and imagining why they deliberately ignore INT (i.e. "because
I want this hook not be interrupted and run to its completion") does
not help guess if they want git to wait for hook's completion or
just go ahead and die of its own signal death.  We could timeout the
waiting and kill such a child forcibly, and that may avoid these
hook script that ignore INT to hang around, but I do not know if
that is desirable.


