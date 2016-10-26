Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2F20203BD
	for <e@80x24.org>; Wed, 26 Oct 2016 17:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755891AbcJZRwq (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 13:52:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51418 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754722AbcJZRwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 13:52:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A0B847DDF;
        Wed, 26 Oct 2016 13:52:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oyhVDt9HBs83KK4q4ClepjBm/4E=; b=jlV5Xz
        WhuBfsyc/zLau9oZbtOAVePMgHrEDEWu/h3s8bSQ3AmtaGJlSBN0UV1vH4DN9ZnA
        8CXnOAXWR0K6qvDPvLVV05dF6sT2K706py8SLGCtrjICPmilSajcTBH58WPsYx5q
        2mqJek93IfXUt86A63D1F5N8Sk7V0GYzYQaV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fYNvnkqeJb2SjPfQ417LZWcnKnq4R/6X
        g1vZI9/T6sbvwM05Y5yPWvHr0CJYFqU1JN4h58CPkZrqXtCVFX3eiGyv5732VkG1
        1+pU12jgx87ZYDGC2H9Uvket3mCmTtsQPHSIXEhAXryM+AATmnFSTI9gurREU7d9
        s2e9I/1lc5o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21D1347DDE;
        Wed, 26 Oct 2016 13:52:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8668647DDD;
        Wed, 26 Oct 2016 13:52:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
        <20161025181621.4201-1-gitster@pobox.com>
        <20161025181621.4201-3-gitster@pobox.com>
        <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
        <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
        <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
Date:   Wed, 26 Oct 2016 10:52:41 -0700
In-Reply-To: <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 26 Oct 2016 12:47:46 -0400")
Message-ID: <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEFD342E-9BA4-11E6-8385-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Of the two flags, I would say CLOEXEC is the more important one to
> respect because it may actually impact correctness (e.g., leaking
> descriptors to sub-processes). Whereas O_NOATIME is purely a performance
> optimization.

I tend to agree.

> I actually wonder if it is worth carrying around the O_NOATIME hack at
> all.

Yes, I share the thought.  We no longer have too many loose objects
to matter.

I do not mind flipping the order, but I'd prefer to cook the result
even longer.  I am tempted to suggest we take two step route:

 - ship 2.11 with the "atime has been there and we won't regress it"
   shape, while cooking the "cloexec is semantically more
   important" version in 'next' during the feature freeze

 - immediately after 2.11 merge it to 'master' for 2.12 to make sure
   there is no fallout.

