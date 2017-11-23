Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C7620954
	for <e@80x24.org>; Thu, 23 Nov 2017 02:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbdKWCTp (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 21:19:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58166 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751860AbdKWCTo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 21:19:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36090C0D01;
        Wed, 22 Nov 2017 21:19:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lQ7C/sLpAAGOCvF9KXZeIYsBNiw=; b=xt4Lzm
        cLX1MbZJNec8P45P7sYGwkdCIvUSFWNuWsiAhz6vITuo2gTbRalnApUU9qzXkIb5
        Nehu5gC8LniJ4PFvIPxS7u5JRQ+6zn5Q+CBOFS/HB2yUZ2NR/n28ZSrUpFpEA+hK
        rUFaFxrjm9u4oOB+FMZsCbpNauU82V1I3Esn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KV3IvBnem10fuzFgVZ9nnpSQy1990XCF
        npsmudlF6Ien/iufdG4Yf8m1eIvpKRSuNwYYeCY649RwLKH3X67ZG+DMu3c7XTlN
        9iMmO08aUrFoqmA1pfRDlIv2C8fYHbVJXHj9tLET3r0S0XDZD+MyWmxADn3N3nAc
        LTLEsCFi4Jw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EC00C0CFE;
        Wed, 22 Nov 2017 21:19:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BA1BC0CFB;
        Wed, 22 Nov 2017 21:19:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: [PATCH] defer expensive load_ref_decorations until needed
References: <20171121234336.10209-1-phil.hord@gmail.com>
        <20171122212710.GB2854@sigill>
        <CABURp0rq9pwFWuBbrSB-FNUQ6B-7V8uL=Drw6O1-151u_cRKww@mail.gmail.com>
        <20171122234841.GD8577@sigill>
Date:   Thu, 23 Nov 2017 11:19:42 +0900
In-Reply-To: <20171122234841.GD8577@sigill> (Jeff King's message of "Wed, 22
        Nov 2017 18:48:41 -0500")
Message-ID: <xmqqy3mxrb29.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4A9FBEC-CFF4-11E7-BFBD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And lazy-load wouldn't help you there for a normal:
>
>   git log
>
> But what's interesting in your command is the pretty-format. Even though
> decoration is turned on, your format doesn't show any. So we never
> actually ask "is this commit decorated" and the lazy-load helps.

Hmph, I wonder if we can detect this case and not make a call to
load decorations in the first place.  That would remove the need to
remember the options when load is called so that we can use it when
we load decorations lazily later.
