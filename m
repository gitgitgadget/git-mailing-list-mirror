Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB41B1FF6D
	for <e@80x24.org>; Thu,  1 Dec 2016 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758397AbcLAJEs (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 04:04:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:49661 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756554AbcLAJEm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 04:04:42 -0500
Received: (qmail 4901 invoked by uid 109); 1 Dec 2016 09:03:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 09:03:38 +0000
Received: (qmail 30657 invoked by uid 111); 1 Dec 2016 09:04:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 04:04:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 04:03:37 -0500
Date:   Thu, 1 Dec 2016 04:03:37 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>
Subject: [PATCH 0/6] restricting http redirects
Message-ID: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jann Horn brought up on the git-security list some interesting
social-engineering attacks around the way Git handles HTTP redirects.
These patches are my attempt to harden our redirect handling against
these attacks.

Out of the box, they should make it more obvious to the user when we are
redirecting, and avoid intermingling objects between multiple dumb-http
repositories. There's also a config flag (not on by default) to disable
redirects entirely if you're operating in a more paranoid environment.

The individual commits have more details on the attack scenarios.

I gave some thought to how this might interact with the
bw/transport-protocol-policy topic, which lets you distinguish between
"from the user" and "from some other system" when allowing protocols. I
think that topic is missing some bits when it comes to HTTP, which I
outlined elsewhere:

  http://public-inbox.org/git/20161201083005.dui572o4jxsqacas@sigill.intra.peff.net/

I also wondered if the new http.followRedirects option in this series
could be replaced by just setting protocol.allow to "user".  But it's
not quite the same:

  1. That only covers setting http.followRedirects to "false". There is
     a special value "initial", which allows redirects on the initial
     ref advertisement (see patch 4 for details).

  2. The http.* options can be applied on a per-server basis. So you
     might allow a trusted server to redirect you, but not others. The
     protocol config is less flexible in that regard (it's less about
     "who are you contacting" and more about "what situation are you
     in").

So I think it's fine for the two to co-exist. There's some small
overlap, but which is appropriate depends on what problem you're trying
to solve.

Thanks Jann for the initial report and for good discussion on the
security list.

  [1/6]: http: simplify update_url_from_redirect
  [2/6]: http: always update the base URL for redirects
  [3/6]: remote-curl: rename shadowed options variable
  [4/6]: http: make redirects more obvious
  [5/6]: http: treat http-alternates like redirects
  [6/6]: http-walker: complain about non-404 loose object errors

 Documentation/config.txt      | 10 +++++++
 http-walker.c                 | 15 +++++++----
 http.c                        | 56 ++++++++++++++++++++++++++++++---------
 http.h                        | 10 ++++++-
 remote-curl.c                 | 22 +++++++++-------
 t/lib-httpd/apache.conf       | 14 ++++++++++
 t/t5550-http-fetch-dumb.sh    | 61 +++++++++++++++++++++++++++++++++++++++++++
 t/t5551-http-fetch-smart.sh   |  4 +++
 t/t5812-proto-disable-http.sh |  1 +
 9 files changed, 165 insertions(+), 28 deletions(-)

