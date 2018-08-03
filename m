Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 781E5208ED
	for <e@80x24.org>; Fri,  3 Aug 2018 22:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbeHDAF5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 20:05:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:42392 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729968AbeHDAF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:05:57 -0400
Received: (qmail 24812 invoked by uid 109); 3 Aug 2018 22:07:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Aug 2018 22:07:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8993 invoked by uid 111); 3 Aug 2018 22:07:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 Aug 2018 18:07:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2018 18:07:46 -0400
Date:   Fri, 3 Aug 2018 18:07:46 -0400
From:   Jeff King <peff@peff.net>
To:     Tacitus Aedifex <aedifex@SDF.ORG>
Cc:     git@vger.kernel.org
Subject: Re: abstracting commit signing/verify to support other signing
 schemes
Message-ID: <20180803220746.GA5404@sigill.intra.peff.net>
References: <20180803213834.GB7619@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180803213834.GB7619@SDF.ORG>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 03, 2018 at 09:38:34PM +0000, Tacitus Aedifex wrote:

> I'm looking at the existing commit signing and verification
> integration and it is all GPG specific. I'm interested in refactoring
> the code to have a generic signing/verifying interface so that "drivers"
> for other signing tools can be created and other signing tools can be
> used (e.g. OpenBSD signify).
> [...]
> Any other thoughts and/or suggestions?

There's been some work on this lately. See this patch and the response
thread:

  https://public-inbox.org/git/20180409204129.43537-9-mastahyeti@gmail.com/

One of the main complaints there was that it was doing just enough to
make gpgsm work, and it was unclear if some of the abstractions would be
insufficient for something like signify.

The more recent work focused on just doing the minimum to provide
gpg/gpgsm variants:

  https://public-inbox.org/git/cover.1531831244.git.henning.schild@siemens.com/

That replaces the earlier patch series, and is currently merged to the
'next' branch and is on track to get merged to 'master' before Git 2.19
is released.

One of the downsides there is that if we eventually move to a generic
signing-tool config, we'd have to support two layers of historical
abstraction (the original "gpg.program" config, and the new
"gpg.<tool>.*" config).

So _if_ we knew what it would take to support signify, we could
potentially adjust what's going into 2.19 in order to skip straight to
the more generic interface. But on the OTOH, it may not be worth
rushing, and there is already a vague plan of how the gpg.<tool>.*
config would interact with a more generic config.

Anyway. Hopefully that gives you a sense of what the current state is,
and that work should answer the questions you asked about how to
approach the code changes.

-Peff
