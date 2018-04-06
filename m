Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4ABC1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 16:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeDFQPJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 12:15:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:55984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751494AbeDFQPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 12:15:09 -0400
Received: (qmail 17760 invoked by uid 109); 6 Apr 2018 16:15:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 16:15:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26972 invoked by uid 111); 6 Apr 2018 16:16:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 12:16:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 12:15:07 -0400
Date:   Fri, 6 Apr 2018 12:15:07 -0400
From:   Jeff King <peff@peff.net>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: How to undo previously set configuration?
Message-ID: <20180406161506.GA28093@sigill.intra.peff.net>
References: <20180405092358.569e0315.olaf@aepfle.de>
 <874lkq11ug.fsf@evledraar.gmail.com>
 <20180405104948.276de0ca.olaf@aepfle.de>
 <8737092929.fsf@evledraar.gmail.com>
 <20180405152525.13d1c776.olaf@aepfle.de>
 <20180405163227.GA25224@sigill.intra.peff.net>
 <20180406175556.5b6e16f0.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180406175556.5b6e16f0.olaf@aepfle.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 05:55:56PM +0200, Olaf Hering wrote:

> > The general strategy in Git's config is that instead of "unsetting",
> > you
> > should overwrite with whatever value you _do_ want. So a config option
> > like sendemail.smtpauth should accept some kind of empty or "none" value
> > to disable auth.
> > 
> > Most single-value config options should work this way (and if one
> > doesn't, I'd say that's a bug we should fix).
> 
> This does not work. Initially I copied the global config into the repo
> and set all unwanted values to <empty>, like 'smtpuser='. Perhaps the
> config parser recognized that fact, but the consumer does not?

Yes. That logic is handled by the consumer (especially in the case of
send-email, which is a perl script, the code runs in a totally separate
process from the config parser). Naively I'd think that:

  [sendemail]
  smtpAuth =

would do what you want, and then we'd ignore smtpUser completely.
It looks like the smtp_auth_maybe function uses perl's "defined" there,
though. Perhaps it should treat the empty string the same there.

(Or maybe it's something else; I don't use send-email myself, and in a
few trivial examples I couldn't get it to complain about similar
config).

-Peff
