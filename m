Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75011FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 08:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750944AbcL1ICe (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 03:02:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:60914 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750870AbcL1ICd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 03:02:33 -0500
Received: (qmail 9997 invoked by uid 109); 28 Dec 2016 08:02:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 08:02:33 +0000
Received: (qmail 16777 invoked by uid 111); 28 Dec 2016 08:03:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 03:03:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Dec 2016 03:02:30 -0500
Date:   Wed, 28 Dec 2016 03:02:30 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [RFH] gpg --import entropy while running tests
Message-ID: <20161228080230.wygcmdmwvifcthvl@sigill.intra.peff.net>
References: <20161228072303.4wbhkwf37fvgpi7h@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161228072303.4wbhkwf37fvgpi7h@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 02:23:03AM -0500, Jeff King wrote:

> That's a lot of time not using any CPU. What's going on? Running with
> "sh -x" shows that we spend most of the time in this line from
> lib-gpg.sh:
> 
>   gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
> 	  "$TEST_DIRECTORY"/lib-gpg/keyring.gpg
> 
> And running gpg with "--debug-level guru" shows that we are blocking
> while waiting for entropy. Has anybody else seen this? I feel like I
> noticed it starting a few weeks ago, and indeed dropping back to gpg
> 2.0.26 (from 2.1.17) makes the problem go away.
> 
> Is it a bug in gpg (oddly, the kernel reports lots of entropy available,
> and generating the signatures themselves is quite fast)? Or is the new
> version doing something special in the import process that we need to
> work around or disable?

Answering my own question (somewhat): this is bisectable in the gnupg
repository, and it turns out to be caused by their 4473db1ef (agent:
Kludge to mitigate blocking calls in Libgcrypt., 2016-11-11), which
introduces a 100ms sleep (yuck) that is presumably triggering way more
than it needs to. More details at:

  https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=commit;h=4473db1ef24031ff4e26c9a9de95dbe898ed2b97

So this does seem like a gpg bug.

-Peff
