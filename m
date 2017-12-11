Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF521F404
	for <e@80x24.org>; Mon, 11 Dec 2017 20:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbdLKUhq (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 15:37:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52041 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750886AbdLKUhp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 15:37:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B9CDB93E7;
        Mon, 11 Dec 2017 15:37:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mqJ+5GB+BsIjqUc7NgQ8KmMCMLY=; b=vvNyLR
        JjksmXfYIFhDwtZ+tLJ9I6ReZOFM4Zn+A9G0gMOYyUtiB/B3lBIdO/TaZYcHuGJ0
        ir8YEEbnWAu34j8UuxdRTCHL/0urDGK+Jqh+GStwkeavO/BLghHtUFeStEYDkXbd
        Rg/Bu0qZ1rz8dj1sTXVPus9szKWMoMPnOucro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fI0MATrkUh93UbRHUXw7i1OJjVn2Pq1p
        fE8h6VTwR8KCqNTr4rxLXSLLKacqvLsYgDNbucuaATgLZXvSxtQLeLKI89TBUVL/
        rlZ43Z2wQqP/G2NFvp91xpZufNA/IqfSjTQM01SGVMuG6S36FHdEg+UVjRrVYrE2
        jf3kWxJp1UY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53886B93E5;
        Mon, 11 Dec 2017 15:37:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BCDA4B93E4;
        Mon, 11 Dec 2017 15:37:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/4] t/Makefile: introduce TEST_SHELL_PATH
References: <20171208104647.GA4016@sigill.intra.peff.net>
        <20171208104722.GD4939@sigill.intra.peff.net>
        <alpine.DEB.2.21.1.1712081602570.4318@virtualbox>
        <20171208220046.GA26270@sigill.intra.peff.net>
        <alpine.DEB.2.21.1.1712091443560.4318@virtualbox>
        <20171210142309.GA19453@sigill.intra.peff.net>
Date:   Mon, 11 Dec 2017 12:37:42 -0800
In-Reply-To: <20171210142309.GA19453@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 10 Dec 2017 09:23:09 -0500")
Message-ID: <xmqq4lox57c9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23B81E62-DEB3-11E7-A354-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not sure that's true. Look at what already goes into
> GIT-BUILD-OPTIONS: TEST_OUTPUT_DIRECTORY, GIT_TEST_CMP, GIT_PERF_*, etc.
>
> Interestingly, many of those do something like this in the Makefile:
>
>   ifdef GIT_TEST_CMP
> 	@echo GIT_TEST_OPTS=... >>$@+
>   endif
>
> which seems utterly confusing to me. Because it means that if you build
> with those options set, then they will override anything in the
> environment. But if you don't, then you _may_ override them in the
> environment. In other words:
>
>   make
>   cd t
>   GIT_TEST_CMP=foo ./t0000-*
>
> will respect that variable. But:
>
>   make GIT_TEST_CMP=foo
>   cd t
>   GIT_TEST_CMP=bar ./t0000-*
>
> will not. Which seems weird.  But I guess we could follow that pattern
> with TEST_SHELL_PATH.

Or perhaps we can start setting a better example with the new
variable, and migrate those weird existing ones over to the new way
of not forbidding run-time overriding?

There is a long outstanding NEEDSWORK comment in help.c that wonders
if we want to embed contents from GIT-BUILD-OPTIONS in the resulting
binary, and the distinction Dscho brought up between "build" and
"test" phases would start to matter even more once we go in that
direction.


