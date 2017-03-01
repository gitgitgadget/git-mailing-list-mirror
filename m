Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54BF92023D
	for <e@80x24.org>; Wed,  1 Mar 2017 19:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbdCATYU (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 14:24:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:36560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753252AbdCATYT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 14:24:19 -0500
Received: (qmail 6533 invoked by uid 109); 1 Mar 2017 19:22:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 19:22:33 +0000
Received: (qmail 7073 invoked by uid 111); 1 Mar 2017 19:22:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 14:22:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Mar 2017 14:22:30 -0500
Date:   Wed, 1 Mar 2017 14:22:30 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Adrian Dudau <Adrian.Dudau@enea.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] pretty: use fmt_output_email_subject()
Message-ID: <20170301192230.fslurnghqvktuyou@sigill.intra.peff.net>
References: <1488297556.2955.11.camel@enea.com>
 <20170228181719.t67abnnnsdcx2xfd@sigill.intra.peff.net>
 <58e05599-5dc4-9881-d8c0-89ad1f2e3838@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58e05599-5dc4-9881-d8c0-89ad1f2e3838@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 01, 2017 at 12:37:07PM +0100, René Scharfe wrote:

> Add the email-style subject prefix (e.g. "Subject: [PATCH] ") directly
> when it's needed instead of letting log_write_email_headers() prepare
> it in a static buffer in advance.  This simplifies storage ownership and
> code flow.

This looks much cleaner to me.

I suspect we can do the same thing with the mime headers below there.
They end up in extra_headers, which is shown via after_subject. But we
could mostly replace after_subject with a call to fmt_output_email_mime()
or similar.

The only other use of extra_headers seems to be the static to/cc fields
one can add via format-patch. But those _should_ be treated differently,
as they can be allocated once in the rev_info, not per-commit. Which I
think shows off another bug. If you have a large to/cc list, that all
gets lumped into the same 1024-byte buffer, and may cause truncation.

I think the diffopt.stat_sep thing could get similar handling, too. It
appears to be set only in this one spot, and gets looked at in exactly
one. That could be replaced with an on-the-fly function call.

> This slows down the last three tests in p4000 by ca. 3% for some reason,
> so we may want to only do the first part for now, which is performance
> neutral on my machine.

It sounds like the bitfield was the cause, so that should be an easy
fix. The other question is whether it makes "--format=email" any slower.
It shouldn't, as your new approach doesn't do any extra per-commit
allocations (and in fact, it avoids some useless buffer-copying).

I couldn't measure any difference.

-Peff
