Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCDB207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 20:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756310AbdD0USH (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 16:18:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:41317 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754875AbdD0USH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 16:18:07 -0400
Received: (qmail 20559 invoked by uid 109); 27 Apr 2017 20:18:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 20:18:06 +0000
Received: (qmail 5025 invoked by uid 111); 27 Apr 2017 20:18:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 16:18:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Apr 2017 16:18:04 -0400
Date:   Thu, 27 Apr 2017 16:18:04 -0400
From:   Jeff King <peff@peff.net>
To:     Andrew Watson <andwatsresearch@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: push fails with return code 22
Message-ID: <20170427201804.3abt5ht6dkwwqo4r@sigill.intra.peff.net>
References: <CAH6sfJUn99ezs-uZuYVj15qOeMv79ji7r0Ldvoreef0z3LzG8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH6sfJUn99ezs-uZuYVj15qOeMv79ji7r0Ldvoreef0z3LzG8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 02:37:19PM -0400, Andrew Watson wrote:

> I'm trying to setup git with Smart HTTP so we can move off of SVN.
> 
> I've used the blog post: https://git-scm.com/blog/2010/03/04/smart-http.html

I'm not sure how that post will have aged. You might check your setup
against the documentation in "git help http-backend", which is kept more
up to date.

> My system is CentOS 7 which reports git version 1.8.3.1 and Apache
> 2.4.6. I also tried on Ubuntu 16.04 with git 2.7.4 and Apache 2.4.18.
> 
> Using GIT_CURL_VERBOSE I can see it fail after a PROPFIND.

That means the client isn't using smart-http. PROPFIND is part of the
"dumb" http push-over-webdav.

So the problem is likely in the very first request Git makes to
/info/refs/?service=git-receive-pack. The response there is what the
client uses to decide whether the server understands smart-http or not.

> My stackoverflow post with all the debug info I could think of is
> here: http://stackoverflow.com/questions/43643152/git-push-results-in-return-code-22

I notice the response for that first request has:

  Content-Length: 0
  Content-Type: text/plain; charset=UTF-8

which implies to me that the git-http-backend CGI isn't being run.

-Peff
