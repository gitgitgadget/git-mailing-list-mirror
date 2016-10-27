Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20882035F
	for <e@80x24.org>; Thu, 27 Oct 2016 06:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754809AbcJ0GdG (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 02:33:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64946 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754835AbcJ0GdF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 02:33:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42A6D42883;
        Thu, 27 Oct 2016 02:33:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Q73U2SyUtrxOw6lD3Raw40k7Lg=; b=C+7mcI
        8AU8TpFsyteLYj/prNE6IuG6X8zz5ISda9fseOaVq1NF/q+BqZViSCwCGNJyrCfK
        wwerDp5ytbHrfY6vWis/N0ZMx92X4LK86fKc00tdB/3gAqLiC8yBbP6r+Tyg40uQ
        5TTtwcP2TWYMEvmxTwbjkSmFK8i3SDJPtlg/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s7sxQi6DUuxYeLB2HMTXM7psxw7LjXcY
        otY+95WJcPGueKNEtai6faahHA6lh9Y6tuTMUiHoKScfNZygCdY4TtY+2P/o7Z4H
        pVQPtirpN2GiLhGnrkYGU3u9VLjKtnpOEL3n+I1/Dx5maV9RmIwV4fFnkoBh9IP9
        uGz+LCACWqA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3996C42881;
        Thu, 27 Oct 2016 02:33:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FFD842880;
        Thu, 27 Oct 2016 02:33:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org, simon@ruderich.org, peff@peff.net
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
References: <20161026215732.16411-1-sbeller@google.com>
        <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
        <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com>
        <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
        <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 26 Oct 2016 23:33:01 -0700
In-Reply-To: <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 26 Oct 2016 23:21:51 -0700")
Message-ID: <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36B0149E-9C0F-11E6-B307-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>>> As many codepaths may not even need access to the attributes, I
>>> doubt that would be a very productive direction to go.
>>
>> So, what is productive then? Pessimizing one (not exactly minor) platform?
>
> Lazy on-demand initialization as needed, perhaps?  The on-demand
> initialization mechanism may become no-op on some platforms that can
> do static initialization.

Ah, I think I misunderstood your "please rewrite".  Did you mean to
add "void attr_start(void)" helper function to attr.c that does
series of pthread_mutex_init() calls as needed?  That function can
be called from main() of platforms that cannot statically initialize
mutices, while on other platforms it can be a no-op as long as the
variables are statically initialized?  If so, that would not pessimize
any platform, I would think.


    
