Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72F94202D7
	for <e@80x24.org>; Tue,  7 Mar 2017 11:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754599AbdCGLeT (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 06:34:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:39650 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbdCGLeR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 06:34:17 -0500
Received: (qmail 544 invoked by uid 109); 7 Mar 2017 08:47:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 08:47:20 +0000
Received: (qmail 24057 invoked by uid 111); 7 Mar 2017 08:47:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 03:47:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Mar 2017 03:47:18 -0500
Date:   Tue, 7 Mar 2017 03:47:18 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 1/1] config: add conditional include
Message-ID: <20170307084717.i2jru77v3rhd443e@sigill.intra.peff.net>
References: <20170223122346.12222-1-pclouds@gmail.com>
 <20170223122346.12222-2-pclouds@gmail.com>
 <CAGZ79kboaKfzMEyDjg-m2oK8CX6B56i52ZcWhCaq87ECE9x2Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kboaKfzMEyDjg-m2oK8CX6B56i52ZcWhCaq87ECE9x2Dw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2017 at 02:44:27PM -0800, Stefan Beller wrote:

> > +static int include_condition_is_true(const char *cond, size_t cond_len)
> > +{
> ...
> > +
> > +       error(_("unrecognized include condition: %.*s"), (int)cond_len, cond);
> > +       /* unknown conditionals are always false */
> > +       return 0;
> > +}
> 
> Thanks for putting an error message here. I was looking at what
> is currently queued as origin/nd/conditional-config-include,
> which doesn't have this error()  (yet / not any more?)

It's "not any more". It was in the original and I asked for it to be
removed during the last review.

> I'd strongly suggest to keep the error message here as that way
> a user can diagnose e.g. a typo in the condition easily.
> 
> If we plan to extend this list of conditions in the future, and a user
> switches between versions of git, then they may see this message
> on a regular basis (whenever they use the 'old' version).

That would make it unlike the rest of the config-include mechanism
(which quietly ignores things it doesn't understand, like include.foo,
or include.foo.path), as well as the config code in general (which
ignores misspelt keys).

Some of that "quiet when you don't understand it" is historical
necessity. Older versions _can't_ complain about not knowing
include.path, because they don't yet know it's worth complaining about.
Likewise here, if this ships in v2.13 and a new condition "foo:" ships
in v2.14, you get:

  v2.12 - no complaint; we don't even understand includeIf at all
  v2.13 - complain; we know includeIf, but not "foo:"
  v2.14 - works as expected

Which is kind of weird and inconsistent. But maybe the typo-detection
case is more important to get right than consistency across historical
versions.

-Peff
