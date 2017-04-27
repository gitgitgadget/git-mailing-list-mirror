Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C78C2207E4
	for <e@80x24.org>; Thu, 27 Apr 2017 09:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937891AbdD0Jbf (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 05:31:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:41168 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935827AbdD0Jbd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 05:31:33 -0400
Received: (qmail 8396 invoked by uid 109); 27 Apr 2017 09:31:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 09:31:32 +0000
Received: (qmail 26159 invoked by uid 111); 27 Apr 2017 09:31:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 05:31:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Apr 2017 05:31:30 -0400
Date:   Thu, 27 Apr 2017 05:31:30 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Wallace <dwallace@saltstack.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible regression in git-http-backend
Message-ID: <20170427093130.jnbuxuhksi33okry@sigill.intra.peff.net>
References: <CAA2+9hC4d0+igaSV6ziC55=KZGYrZN2A+8-Enhm0F4hExH3m_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA2+9hC4d0+igaSV6ziC55=KZGYrZN2A+8-Enhm0F4hExH3m_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 05:39:16PM -0600, Daniel Wallace wrote:

> I am not sure if this is a regression or not, but I wanted to get feedback.
> 
> It looks like this commit changed some behavior in git-http-backend
> 
> https://git.kernel.org/pub/scm/git/git.git/commit/?id=6bc0cb5176a5e42ca4a74e3558e8f0790ed09bb1
> 
> The change that it has made is that it no git-upload-pack hangs when
> uwsgi doesn't close stdin.

Yeah, I think that could be considered an unintended regression. The
original code _also_ didn't respect CONTENT_LENGTH and would potentially
just keep reading. But because it was reading formatted data, as long as
the data was well-formed, it would generally stop reading where the
webserver expected it. So it mostly worked; even though there were cases
that would hang, they were presumably rare.

People using IIS ran into a similar thing, I think. There was a patch,
but it had a lot of problems. I do think it would be reasonable to:

  1. Respect CONTENT_LENGTH if it's set, and never read more than that
     many bytes.

  2. Handle sentinel values for CONTENT_LENGTH that tell us the data is
     streaming in and we must read until EOF (Apache leaves
     CONTENT_LENGTH unset in this case, and apparently IIS sets it to
     -1).

  3. Ideally, do both of those not just in the buffering case added by
     6bc0cb517, but for other input as well. That might be hard, though,
     because I think we literally hand off the descriptor to
     sub-programs for some operations. So even if we just handled the
     one case, that would at least fix any regressions caused by
     6bc0cb517.

Here are links to the previous discussion:

  http://public-inbox.org/git/F0F5A56A22F20D4CB4A03BB8D6658797E260E0E3@SERVER2011.CS-SOFTWARE.local/

  http://public-inbox.org/git/F0F5A56A22F20D4CB4A03BB8D6658797E261A3D6@SERVER2011.CS-SOFTWARE.local/

-Peff
