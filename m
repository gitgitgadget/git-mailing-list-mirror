Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CBA20986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbcJDRjI (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:39:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:52193 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbcJDRjH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:39:07 -0400
Received: (qmail 5437 invoked by uid 109); 4 Oct 2016 17:39:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 17:39:07 +0000
Received: (qmail 7624 invoked by uid 111); 4 Oct 2016 17:39:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 13:39:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 13:39:04 -0400
Date:   Tue, 4 Oct 2016 13:39:04 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/4] git: make super-prefix option
Message-ID: <20161004173904.tu37rqn4rl26gabx@sigill.intra.peff.net>
References: <1475099443-145608-1-git-send-email-bmwill@google.com>
 <1475185723-36871-1-git-send-email-bmwill@google.com>
 <1475185723-36871-2-git-send-email-bmwill@google.com>
 <CAGZ79kax9g-FLMhPnDBP+7wJwYT884B5bGodpopo9GKgnE6+PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kax9g-FLMhPnDBP+7wJwYT884B5bGodpopo9GKgnE6+PQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 10:31:51AM -0700, Stefan Beller wrote:

> On Thu, Sep 29, 2016 at 2:48 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> >
> > +const char *get_super_prefix(void)
> > +{
> > +       if (!super_prefix)
> > +               super_prefix = getenv(GIT_SUPER_PREFIX_ENVIRONMENT);
> > +       return super_prefix;
> > +}
> > +
> 
> As said earlier, is the following a valid thought:
> 
> > The getenv() function returns a pointer to the value in the
> > environment, or NULL if there is no match.
> > So in case this is not set (when e.g. the user did not specify the
> > super prefix), we would probe it a couple of times.
> > The caching effect only occurs when the string is set. So this looks
> > like we save repetitive calls, but we do not always do that.

I think your concern is valid. If it is not set, we will do an O(n)
search through the whole environment on each call.

I also think the result of getenv() needs to be copied. In some
implementations it persists for the life of the program, but that's not
guaranteed; it may be overwritten by unrelated calls to getenv() or
setenv().

-Peff
