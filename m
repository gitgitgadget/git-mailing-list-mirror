Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE4FC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AAC601FF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349991AbhIHQwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:52:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33144 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232509AbhIHQwG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 12:52:06 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7B32A1F8C6;
        Wed,  8 Sep 2021 16:50:57 +0000 (UTC)
Date:   Wed, 8 Sep 2021 16:50:57 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
Message-ID: <20210908165057.GA14162@dcvr>
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
 <YTOW352xtsbvJcKy@coredump.intra.peff.net>
 <20210907211128.mauwgxupbredgx7w@meerkat.local>
 <YTiVDo4m5B5RcfCg@coredump.intra.peff.net>
 <YTiXEEEs36NCEr9S@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTiXEEEs36NCEr9S@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Wed, Sep 08, 2021 at 06:48:47AM -0400, Jeff King wrote:
> 
> > Both of the included examples here have been tested to work. The one for
> > lighttpd is a little less direct than I'd like, but I couldn't find a
> > way to directly set an environment variable to the value of a request
> > header. From my reading of the documentation, lighttpd will set
> > HTTP_GIT_PROTOCOL automatically, but git-http-backend looks only at
> > GIT_PROTOCOL. Arguably http-backend should do this translation itself.
> 
> So having discovered this, I kind of wonder if these documentation
> patches are barking up the wrong tree. There is no reason we would not
> want v2 to work out of the box (after all, it does for git://).

Agreed.

> The patch below does that (and could replace both my and Konstantin's
> documentation patches).

<snip>

> -- >8 --
> Subject: [PATCH] http-backend: handle HTTP_GIT_PROTOCOL CGI variable
> 
> When a client requests the v2 protocol over HTTP, they set the
> Git-Protocol header. Webservers will generaly make that available to our

"generally"

> CGI as HTTP_GIT_PROTOCOL in the environment. However, that's not
> sufficient for upload-pack, etc, to respect it; they look in
> GIT_PROTOCOL (without the HTTP_ prefix).
> 
> Either the webserver or the CGI is responsible for relaying that HTTP
> header into the GIT_PROTOCOL variable. Traditionally, our tests have
> configured the webserver to do so, but that's a burden on the server
> admin. We can make this work out of the box by having the http-backend
> CGI copy the contents.

Agreed.  I've completely overlooked GIT_PROTOCOL support, so far...

This seems to be the right thing to do; I think I'll add support
for it when I spawn git-http-backend in something I work on.
(I also don't currently pass all HTTP headers in env when
spawning CGI, maybe I should *shrug*)
