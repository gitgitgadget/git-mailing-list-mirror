Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9124C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925B261100
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhIJLlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:41:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:43762 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232613AbhIJLlG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:41:06 -0400
Received: (qmail 5418 invoked by uid 109); 10 Sep 2021 11:39:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 11:39:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23759 invoked by uid 111); 10 Sep 2021 11:39:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 07:39:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 07:39:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
Message-ID: <YTtECuP2/A6+EI4J@coredump.intra.peff.net>
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
 <YTOW352xtsbvJcKy@coredump.intra.peff.net>
 <20210907211128.mauwgxupbredgx7w@meerkat.local>
 <YTiVDo4m5B5RcfCg@coredump.intra.peff.net>
 <YTiXEEEs36NCEr9S@coredump.intra.peff.net>
 <xmqqee9x1wvh.fsf@gitster.g>
 <xmqqa6kl1wjs.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6kl1wjs.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 10:35:51AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> @@ -789,6 +790,9 @@ int cmd_main(int argc, const char **argv)
> >>  	http_config();
> >>  	max_request_buffer = git_env_ulong("GIT_HTTP_MAX_REQUEST_BUFFER",
> >>  					   max_request_buffer);
> >> +	proto_header = getenv("HTTP_GIT_PROTOCOL");
> >> +	if (proto_header)
> >> +		setenv(GIT_PROTOCOL_ENVIRONMENT, proto_header, 1);
> 
> Since this overwrites (I noticed the "1" at the end), the server
> operator cannot force a particular protocol with their server
> configuration, no?
> 
> Would a weaker form to use 0 (set if there isn't any, but keep the
> value if somebody else already has set it) work OK?  Would that have
> a downside?

Yeah, I wondered about that while writing it, but struggled to think of
a reason why the server operator would want to set it at all.

But maybe as a workaround for some misbehaving client (e.g., recognizing
it by a user-agent header). Or we could even perhaps use this in our
tests to test the v2-client-to-v0-server fallback behavior.

I'll re-roll with that change, plus some documentation changes adapted
to this new approach.

-Peff
