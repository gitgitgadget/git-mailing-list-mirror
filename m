Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196B8207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 01:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933102AbdDSBlt (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 21:41:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:35682 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933047AbdDSBls (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 21:41:48 -0400
Received: (qmail 25304 invoked by uid 109); 19 Apr 2017 01:41:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Apr 2017 01:41:46 +0000
Received: (qmail 17882 invoked by uid 111); 19 Apr 2017 01:42:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 21:42:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Apr 2017 21:41:43 -0400
Date:   Tue, 18 Apr 2017 21:41:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] various: disallow --no-no-OPT for --no-opt options
Message-ID: <20170419014143.56io56xn6mawy5xi@sigill.intra.peff.net>
References: <20170418170914.9701-1-avarab@gmail.com>
 <de79d366-3609-8efe-b23a-7e793036b3ef@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de79d366-3609-8efe-b23a-7e793036b3ef@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 12:29:18AM +0200, René Scharfe wrote:

> Am 18.04.2017 um 19:09 schrieb Ævar Arnfjörð Bjarmason:
> > Change various --no-OPT options which don't supply PARSE_OPT_NONEG to
> > make --no-no-OPT an error.
> > 
> > All of these worked before this change, e.g. doing cloning by doing
> > "git clone --no-no-checkout" is equivalent to just "git clone", but
> > this was never intended, and is inconsistent with other --no-OPT
> > options which do pass PARSE_OPT_NONEG.
> 
> First: Why does that bother you, i.e. what's the harm?
> 
> Setting PARSE_OPT_NONEG takes away the ability to toggle the affected
> option.  E.g. git clone would reject --checkout.  Currently users can
> specify --no- options as defaults in aliases and override them on the
> command line if needed, with the patch that won't be possible anymore.
> 
> PARSE_OPT_NONEG should only be used for options where a negation doesn't
> make sense, e.g. for the --stage option of checkout-index.

I think we do strive to avoid "--no-no-foo", and instead have "--no-foo"
and "--foo" to cover both sides.  So for example:

> > -		OPT_BOOL(0, "no-add", &state->no_add,
> > +		OPT_BOOL_NONEG(0, "no-add", &state->no_add,
> >   			N_("ignore additions made by the patch")),

This could be more like:

  OPT_NEGBOOL(0, "add", &state->no_add, ...)

where NEGBOOL would be smart enough to show "--no-add" in the help as
the primary. It might even be possible to detect the existing line and
have parse-options automatically respect "--foo" when "--no-foo" is
present.  But that may run afoul of callers that add both "--foo" and
"--no-foo" manually.

-Peff
