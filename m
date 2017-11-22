Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93AF2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 01:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbdKVBt2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 20:49:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57597 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751344AbdKVBt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 20:49:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DA1BBA140;
        Tue, 21 Nov 2017 20:49:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FWq61fQxkcJeCcNQOf18uOAE+rw=; b=sjJh8M
        N+F6bRbP6YajfiefYsjRgzWTERnTUYDOKQ3B5Pd67N2opNV91GH8On2h01AvPD8Y
        G2c3sXbNufEzdCHWBmLOWGvnfWB++ZtFsm4oZK9kmJmk92wbFIL0dTVqj5EYoCHY
        QR3HYvSUOGpeaLWAVVcZGu3Z2x4B/Dux5ft1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wnhAgspnku6BA4b8/5NmcUNY+rwgcVvk
        BPWTSecaNE4S9keTK8WE2i10X07romzQY1KHaxhoO2JxzbIhlZPDoJmaXcHQC8Tg
        OTfRM31JI/SctE2Qs+J+CuTGZhwmgL7I+rSXh79dZeRt5KuR9dW4/C7Fhc20UtPA
        DDMn9vOGW5A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8558ABA13F;
        Tue, 21 Nov 2017 20:49:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00952BA13E;
        Tue, 21 Nov 2017 20:49:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
        <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
        <xmqqwp2ki4x8.fsf@gitster.mtv.corp.google.com>
        <20171121231739.GB21197@sigill>
Date:   Wed, 22 Nov 2017 10:49:25 +0900
In-Reply-To: <20171121231739.GB21197@sigill> (Jeff King's message of "Tue, 21
        Nov 2017 18:17:39 -0500")
Message-ID: <xmqqr2srxeu2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F7370DC-CF27-11E7-967F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's a re-roll of patch 5 that behaves this way (the patch should be
> unsurprising, but I've updated the commit message to match).
>
> I did notice one other thing: the function looks up replace objects, so
> we have both the original and the replaced sha1 available. My earlier
> patch used the original sha1, but this one uses the replaced value.
> I'm not sure if that's sane or not. It lets the fast-path kick in if you
> point a replace ref at 0{40}. And it lets you point refs/replace/0{40}
> to something else. I doubt that's useful, but it could perhaps be for
> debugging, etc.
>
> In most cases, of course, it wouldn't matter (since pointing to or from
> the null sha1 is vaguely crazy in the first place).

I tend to agree that those who go crazy/fancy with replace mechanism
can keep both halves when it breaks.

WRT existing codepaths that pass 0{40} and refuses to notice a
potential repository corruption (from getting a NULL for a non null
object name), I think we would need a sweep of the codebase and fix
them in the longer term.  As long as that will happen someday, either
approach between "we know 'no loose object? let's redo the packs' is
the part that matters performance-wise, so let's do a short-cut only
for that" and "we know that callers that comes with 0{40} want to get
NULL back" should be OK, I would think.



