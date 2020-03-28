Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71486C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45006206F2
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgC1O5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:57:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:54490 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727067AbgC1O5n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 10:57:43 -0400
Received: (qmail 24317 invoked by uid 109); 28 Mar 2020 14:57:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Mar 2020 14:57:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2191 invoked by uid 111); 28 Mar 2020 15:07:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Mar 2020 11:07:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Mar 2020 10:57:41 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH] http-backend: write error packet if backend command
 fails
Message-ID: <20200328145741.GA1209174@coredump.intra.peff.net>
References: <b5f8b81498e1d152014acab92fa1b6e9701b3a0e.1585363771.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5f8b81498e1d152014acab92fa1b6e9701b3a0e.1585363771.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 10:50:32PM -0400, Denton Liu wrote:

> If one tries to fetch packs with an incorrectly formatted parameter
> while using the smart HTTP protocol v2, the client will block forever.
> This is seen with the following command which does not terminate:
> 
> 	$ git -c protocol.version=2 clone https://github.com/git/git.git --shallow-since=20151012
> 	Cloning into 'git'...

That can't possibly be fixed by a change to http-backend.c, because
github.com does not use git-http-backend. :)

We have a custom proxy layer that terminates the http connection, and
speaks to "upload-pack --stateless-rpc" on the backend. There may be a
bug in that proxy layer, but it's usually pretty robust to upload-pack
hanging up the connection.

But since it works for v1 (which also dies!), and since you were able to
reproduce the problem locally, I suspect it may be an issue in
upload-pack itself.

> This happens because when upload-pack detects invalid parameters, it
> will die(). When http-backend calls finish_command() and detects a
> non-zero exit code, it will simply call exit(1). Since there is no way
> in a CGI script to force a connection to terminate, the client keeps
> blocking on the read(), expecting more output.

When the CGI exits, that should close the descriptor it holds. If the
webserver hands off the socket to the CGI, that would be sufficient. If
it doesn't, then it should notice the CGI exiting and close the socket
itself.

> Write an error packet if the backend command fails to start or finishes
> with an error so that the client can terminate the connection.

This is probably not a good idea; we don't know what state the protocol
was in when the child died.

-Peff
