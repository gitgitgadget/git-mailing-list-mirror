Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945141FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 17:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753814AbdA3R1g (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 12:27:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:46841 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753811AbdA3R1f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 12:27:35 -0500
Received: (qmail 23538 invoked by uid 109); 30 Jan 2017 17:27:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Jan 2017 17:27:34 +0000
Received: (qmail 27408 invoked by uid 111); 30 Jan 2017 17:27:36 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Jan 2017 12:27:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jan 2017 18:27:31 +0100
Date:   Mon, 30 Jan 2017 18:27:31 +0100
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: git-daemon shallow checkout fail
Message-ID: <20170130172730.x5guphyqf5fsfi7m@sigill.intra.peff.net>
References: <20170129002932.GA19359@dismay.proulx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170129002932.GA19359@dismay.proulx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 28, 2017 at 05:29:32PM -0700, Bob Proulx wrote:

> However the problem driving me crazy is that this only fails this way
> on one machine.  Unfortunately failing on the machine I need to use.
> If I try this same setup on any other machine I try then there is no
> failure and it works okay.  Therefore I conclude that in the failing
> case it is trying to write a shallow_XXXXXX file in the repository but
> in all of the passing cases it does not.  I browsed through the
> git-daemon source but couldn't deduce the flow yet.
> 
> Does anyone know why one system would try to create shallow_XXXXXX
> files in the repository while another one would not?

It depends on the git version on the server. The interesting code is in
upload-pack.c, which is spawned by git-daemon to serve a fetch or clone
request.

See commit b790e0f67 (upload-pack: send shallow info over stdin to
pack-objects, 2014-03-11), which lays out the history. Since that commit
(in git v2.0.0), there should be no tmpfile needed.

> Of course git-daemon running as nobody can't create a temporary file
> shallow_XXXXXX in the /srv/git/test-project.git because it has no
> permissions by design.  But why does this work on other systems and
> not work on my target system?
> 
>   git --version  # from today's git clone build
>   git version 2.11.0.485.g4e59582

This shouldn't be happening with git v2.11. Are you sure that the "git
daemon" invocation is running that same version? I notice you set up a
restricted PATH. Is it possible that /usr/local/bin or /usr/bin has an
older version of git?

-Peff
