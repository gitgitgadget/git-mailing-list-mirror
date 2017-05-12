Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5C120188
	for <e@80x24.org>; Fri, 12 May 2017 08:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757481AbdELIVE (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 04:21:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:50179 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755606AbdELIVB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 04:21:01 -0400
Received: (qmail 607 invoked by uid 109); 12 May 2017 08:21:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 08:21:00 +0000
Received: (qmail 22111 invoked by uid 111); 12 May 2017 08:21:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 04:21:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 04:20:58 -0400
Date:   Fri, 12 May 2017 04:20:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0KDQsNC50YbQuNC9INCQ0L3RgtC+0L0=?= <anton@smarthead.ru>
Cc:     git@vger.kernel.org
Subject: Re: Git credential helper store flushes randomly
Message-ID: <20170512082058.ivvsmzc44cildp7l@sigill.intra.peff.net>
References: <cdedf063-5f53-04c9-5ac0-2acf7e26696e@smarthead.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdedf063-5f53-04c9-5ac0-2acf7e26696e@smarthead.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 11:05:19AM +0300, Райцин Антон wrote:

> I have very strange git credentials store behavior on one of my servers.
> I Use Ubuntu 14.04 LTS and git  2.10.2. The server have multiple users with
> multiple projects, so they have got many different git credentials to
> different repositories.
> I set git config --global credential.helper store, but the credential record
> strings from file ~/.git-credentials for one specific user disappears
> randomly. Especially for one specific repository.
> 
> I do not see any TTL for git credentials in credential.helper store on git
> documentation, so I can't even imagine, what could cause such strange
> behavior.
> 
> Is this a known problem and is there any solution to fix this problem?

I've never heard of a bug like this, and the credential-store code
hasn't really changed in the 5+ years since it was introduced.

The only time it should remove an entry is when Git asks it to. And the
only time that happens is when Git sees the credential rejected by the
server (e.g., an HTTP 401 even after we fed the stored credential). I
don't know why that would happen unless there's some non-determinism on
the server.

Running with GIT_TRACE=/path/to/logfile in the environment would let you
know when Git invokes the helper with the "erase" argument. But the
credential data itself is sent over stdin, so it won't be logged. And if
this is something that happens occasionally and randomly, you might have
to log for quite a while.

Likewise, running with GIT_CURL_VERBOSE=1 might show what's going on,
but you'd have to actually catch the offending git command (in more
recent versions of curl there is GIT_TRACE_CURL, which you can point at
a specific logfile rather than just stderr). Do note if you try logging
with GIT_CURL_VERBOSE that it includes your password in the output, so
treat it appropriately.

-Peff
