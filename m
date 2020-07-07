Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BE6C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 01:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4726D20708
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 01:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g5WzyvQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGGBsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:48:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63394 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgGGBsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 21:48:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BDA9D8049;
        Mon,  6 Jul 2020 21:48:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yQ2+Dn8DZQNA8Rr/MagWLkNv+Ko=; b=g5Wzyv
        Q2TwOr5Z4BJPoPWBVtvAqyjbXCuhygyk3WZjzle9UD030RjK/9ybiOUQp5xJ8Dqy
        frHXPkEMg4/kpUcqdPuLMFlryyQupVl3iaUIjnGVGtsct8T87SgcufVXi/81EwrW
        2qM42yumwEkB00L+5B3ep7qmqyfe+vbySpfx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ecgfLfiZKIQW4L6/4KuhgN0emz1K1pMW
        sXZc5pY8+xT1CtR/58ye39jLRVFg2OwhV/mnE8aXkK7JsWSMD0JDIbMIyrLSZmR6
        LmSG+PGIlbbIMc7YFYCVnCYFMfNo6VqxcJuuwMJ2MIHlkxSzsucYh3NVBIajZBDx
        Sc9kPDJGMQU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63744D8048;
        Mon,  6 Jul 2020 21:48:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9579D8046;
        Mon,  6 Jul 2020 21:48:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Trygve Aaberge <trygveaa@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH 1/2] Wait for child on signal death for aliases to builtins
References: <20200704221839.421997-1-trygveaa@gmail.com>
        <nycvar.QRO.7.76.6.2007050410100.50@tvgsbejvaqbjf.bet>
Date:   Mon, 06 Jul 2020 18:48:07 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2007050410100.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 5 Jul 2020 04:15:56 +0200 (CEST)")
Message-ID: <xmqq1rlo859k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8838ED8-BFF3-11EA-A0E3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thank you for those references. I did try to make sure that b914084007
> would not regress on anything, but apparently I failed to verify the final
> form. Since all it did was to remove `#if 0`...`#endif` guards, it was
> unfortunately quite easy for this regression to slip in.

Yeah, I recall wondering why it was safe to suddenly enable the
segment of the disabled code all of sudden.

