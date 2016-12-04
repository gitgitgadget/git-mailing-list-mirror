Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A6B1FF40
	for <e@80x24.org>; Sun,  4 Dec 2016 04:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbcLDEz5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 23:55:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:51307 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752142AbcLDEz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 23:55:56 -0500
Received: (qmail 30021 invoked by uid 109); 4 Dec 2016 04:55:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Dec 2016 04:55:56 +0000
Received: (qmail 25390 invoked by uid 111); 4 Dec 2016 04:56:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Dec 2016 23:56:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Dec 2016 23:55:54 -0500
Date:   Sat, 3 Dec 2016 23:55:54 -0500
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Git v2.11.0 breaks max depth nested alternates
Message-ID: <20161204045554.advzvylytdmt2bh2@sigill.intra.peff.net>
References: <fe33de5b5f0b3da68b249cc4a49a6d7@3c843fe6ba8f3c586a21345a2783aa0>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe33de5b5f0b3da68b249cc4a49a6d7@3c843fe6ba8f3c586a21345a2783aa0>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 03, 2016 at 04:24:02PM -0800, Kyle J. McKay wrote:

> When the incoming quarantine takes place the current objects directory  
> is demoted to an alternate thereby increasing its depth (and any  
> alternates it references) by one and causing any object store that was  
> previously at the maximum nesting depth to be ignored courtesy of the  
> above hard-coded maximum depth.
> 
> If the incoming push happens to need access to some of those objects  
> to perhaps "--fix-thin" its pack it will crash and burn.

Yep, that makes sense. I didn't really worry about this because the
existing "5" is totally arbitrary, and meant to be so high that nobody
reaches it (it's just there to break cycles).

So I do think this is worth dealing with, but I'm also curious why
you're hitting the depth-5 limit. I'm guessing it has to do with hosting
a hierarchy of related repos. But is your system then always in danger
of busting the 5-limit if people create too deep a repository hierarchy?

Specifically, I'm wondering if it would be sufficient to just bump it to
6. Or 100.

Of course any static bump runs into the funny case where a repo
_usually_ works, but fails when pushed to. Which is kind of nasty and
unintuitive. And your patch fixes that, and we can leave the idea of
bumping the static depth number as an orthogonal issue (that personally,
I do not care about much about either way).

> diff --git a/common-main.c b/common-main.c
> index c654f955..9f747491 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -37,5 +37,8 @@ int main(int argc, const char **argv)
>  
>  	restore_sigpipe_to_default();
>  
> +	if (getenv(GIT_QUARANTINE_ENVIRONMENT))
> +		alt_odb_max_depth++;
> +
>  	return cmd_main(argc, argv);

After reading your problem description, my initial thought was to
increment the counter when we allocate the tmp-objdir, and decrement
when it is destroyed. Because the parent receive-pack process adds it to
its alternates, too. But:

  1. Receive-pack doesn't care; it adds the tmp-objdir as an alternate,
     rather than adding it as its main object dir and bumping down the
     main one.

  2. There would have to be some way of communicating to sub-processes
     that they should bump their max-depth by one.

You've basically used the quarantine-path variable as the
inter-process flag for (2). Which feels a little funny, because its
value is unrelated to the alt-odb setup. But it is a reliable signal, so
there's a certain elegance. It's probably the best option, given that
the alternative is a specific variable to say "hey, bump your
max-alt-odb-depth by one". That's pretty ugly, too. :)

-Peff
