Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4181B205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 14:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759715AbdAKOBo (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 09:01:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:37978 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752550AbdAKOBn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 09:01:43 -0500
Received: (qmail 805 invoked by uid 109); 11 Jan 2017 14:01:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 14:01:42 +0000
Received: (qmail 22062 invoked by uid 111); 11 Jan 2017 14:02:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 09:02:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2017 09:01:39 -0500
Date:   Wed, 11 Jan 2017 09:01:39 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] sanitizing error message contents
Message-ID: <20170111140138.5p647xuqpqrej63b@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When adding a warning() call in 50d341374 (http: make redirects more
obvious, 2016-12-06), somebody brought up that evil servers can redirect
you to something like:

  https://evil.example.com/some/repo?unused=\rwarning:+rainbows+and_unicorns_ahead

(where "\r" is a literal CR), and instead of seeing:

  warning: redirecting to https://evil.example.com/...

you just get:

  warning: rainbows and unicorns ahead

or whatever innocuous looking line they prefer (probably just ANSI
"clear to beginning of line" would be even more effective).

Since it's hard to figure out which error messages could potentially
contain malicious contents, and since spewing control characters to the
terminal is generally bad anyway, this series sanitizes at the lowest
level.

Note that this doesn't cover "remote:" lines coming over the sideband.
Those are already covered for "\r", as we have to parse it to handle
printing "remote:" consistently. But you can play tricks like putting:

  printf '\0331K\033[0Efatal: this looks local\n'

into a pre-receive hook. I'm not sure if we would want to do more
sanitizing there. The goal of this series is not so much that a remote
can't send funny strings that may look local, but that they can't
prevent local strings from being displayed. OTOH, I suspect clever use
of ANSI codes (moving the cursor, clearing lines, etc) could get you
pretty far.

I'd be hesitant to disallow control codes entirely, though, as I suspect
some servers do send colors over the sideband. So I punted on that here,
but I think this is at least an incremental improvement.

  [1/2]: Revert "vreportf: avoid intermediate buffer"
  [2/2]: vreport: sanitize ASCII control chars

 usage.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

-Peff
