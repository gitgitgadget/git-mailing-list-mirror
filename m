Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A29C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 18:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiGGSTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiGGSTv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 14:19:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC9B2FFCA
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 11:19:50 -0700 (PDT)
Received: (qmail 6381 invoked by uid 109); 7 Jul 2022 18:19:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jul 2022 18:19:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3249 invoked by uid 111); 7 Jul 2022 18:19:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jul 2022 14:19:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jul 2022 14:19:48 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t0301-credential-cache test failure on cygwin
Message-ID: <YscjxOWqf7GUvnps@coredump.intra.peff.net>
References: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
 <xmqqtu7t30uv.fsf@gitster.g>
 <4529b11a-e514-6676-f427-ffaec484e8f1@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4529b11a-e514-6676-f427-ffaec484e8f1@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 07, 2022 at 04:17:08PM +0100, Ramsay Jones wrote:

> > If this codepath was written like this (i.e. [PATCH 1C]) from the
> > beginning, I would have found it very sensible (i.e. instead of
> > caling exit() in the middle of the infinite client serving loop,
> > exiting the loop cleanly is easier to follow and maintain), even if
> > we didn't know the issue on Cygwin you investigated.
> 
> Yep, apart from the variable name, I quite like the approach taken by
> the 1C patch.
> [...]
> Also, I would like to understand why the code is written as it is
> currently. I'm sure there must be a good reason - I just don't know
> what it is! I suspect (ie I'm guessing), it has something to do with
> operating in a high contention context [TOCTOU on socket?] ... dunno. ;-)

I wrote a longer reply in the thread, but just to be clear here: your 1C
will indeed introduce a race.

IMHO it is not worth switching away from the current code which calls
exit() to return up the stock. But if you wanted to do so without
introducing a race, I think you could call delete_tempfile() before
closing any streams, like this (on top of your 1C):

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index fb9b1e04a6..9b9cc1b70e 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -131,6 +131,7 @@ static int serve_one_client(FILE *in, FILE *out)
 		}
 	}
 	else if (!strcmp(action.buf, "exit")) {
+		delete_tempfile(&socket_file);
 		/* stop serving clients */
 		serve = 0;
 	}

but you'd have to make the socket_file struct globally available. And of
course it does not fix your cygwin problem, which I believe is mutually
exclusive with keeping the race-free ordering. ;)

-Peff
