Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA19C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AC260E9B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhINTfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:35:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:47374 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233489AbhINTfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:35:15 -0400
Received: (qmail 25383 invoked by uid 109); 14 Sep 2021 19:33:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 19:33:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27338 invoked by uid 111); 14 Sep 2021 19:33:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 15:33:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 15:33:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: What should happen in credential-cache on recoverable error
 without SPAWN option?
Message-ID: <YUD5I/hwxpcyocEU@coredump.intra.peff.net>
References: <20210913085600.35506-1-carenas@gmail.com>
 <20210914072600.11552-1-carenas@gmail.com>
 <20210914072600.11552-3-carenas@gmail.com>
 <xmqqilz30yap.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilz30yap.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 12:09:18PM -0700, Junio C Hamano wrote:

> While reviewing Carlo's "credential-cache: check for windows
> specific errors", I noticed this piece of code, that came from
> 8ec6c8d7 (credential-cache: report more daemon connection errors,
> 2012-01-09):
> 
> 	if (send_request(socket, &buf) < 0) {
> 		if (errno != ENOENT && errno != ECONNREFUSED)
> 			die_errno("unable to connect to cache daemon");
> 		if (flags & FLAG_SPAWN) {
> 			spawn_daemon(socket);
> 			if (send_request(socket, &buf) < 0)
> 				die_errno("unable to connect to cache daemon");
> 		}
> 	}
> 
> What would happen when we get a resumable error and then weren't
> given the SPAWN flag?  It seems that do_cache() simply returns
> without dying.  Shouldn't we get "unable to connect" in such a case?

It's subtle, but I think we end up doing the right thing. Those errors
aren't just "resumable"; they are "we do not have a daemon to talk to at
all".

The "exit", "get", and "erase" operations do not pass the SPAWN flag.
But if there is no daemon, they are all noops.

The "store" operation is the only one which uses SPAWN, and of course
there we want to spin up a daemon so that we can put something in it.

It may be that SPAWN could have a better name to make this more clear.

> diff --git c/builtin/credential-cache.c w/builtin/credential-cache.c
> index 78c02ad531..a41a17e58f 100644
> --- c/builtin/credential-cache.c
> +++ w/builtin/credential-cache.c
> @@ -101,13 +101,11 @@ static void do_cache(const char *socket, const char *action, int timeout,
>  	}
>  
>  	if (send_request(socket, &buf) < 0) {
> -		if (connection_fatally_broken(errno))
> +		if (connection_fatally_broken(errno) && !(flag & FLAG_SPAWN))
> +			die_errno("unable to connect to cache daemon");
> +		spawn_daemon(socket);
> +		if (send_request(socket, &buf) < 0)
>  			die_errno("unable to connect to cache daemon");
> -		if (flags & FLAG_SPAWN) {
> -			spawn_daemon(socket);
> -			if (send_request(socket, &buf) < 0)
> -				die_errno("unable to connect to cache daemon");
> -		}
>  	}
>  	strbuf_release(&buf);
>  }

If you do this, then I think we'll start producing spurious errors
during normal use of the helper. Most interaction will generally start
with a "get" request to the helpers. So if you don't have anything
cached and the daemon stopped running, right now we just don't return a
credential. With this we'd complain "unable to connect to daemon".

And then of course we'd follow that up by asking for the credential and
spinning up a daemon to store it. But that first request after the
daemon times out will always say "unable to connect".

-Peff
