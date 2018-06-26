Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A751F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeFZUDW (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:03:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:55888 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751911AbeFZUDV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:03:21 -0400
Received: (qmail 2519 invoked by uid 109); 26 Jun 2018 20:03:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Jun 2018 20:03:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1074 invoked by uid 111); 26 Jun 2018 20:03:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Jun 2018 16:03:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jun 2018 16:03:19 -0400
Date:   Tue, 26 Jun 2018 16:03:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] url schemes should be case-insensitive
Message-ID: <20180626200319.GA2230@sigill.intra.peff.net>
References: <20180624085622.GA28575@sigill.intra.peff.net>
 <xmqqvaa6ohiw.fsf@gitster-ct.c.googlers.com>
 <20180626122143.GA14052@sigill.intra.peff.net>
 <xmqq1sctmq3d.fsf@gitster-ct.c.googlers.com>
 <20180626182739.GA28358@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180626182739.GA28358@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 02:27:39PM -0400, Jeff King wrote:

> So yeah, we would not want to allow EXT::"rm -rf /" to slip past the
> known-unsafe match. Any normalization should happen before then
> (probably right in transport_helper_init).
> 
> Come to think of it, that's already sort-of an issue now. If you have a
> case-insensitive filesystem, then EXT:: is going to pass this check, but
> still run git-remote-ext. We're saved there somewhat by the fact that
> the default is to reject unknown helpers in submodules (otherwise, we'd
> have that horrible submodule bug all over again).
> 
> That goes beyond just cases, too. On HFS+ I wonder if I could ask for
> "\u{0200}ext::" and run git-remote-ext.

That should be \u{200c}, of course, to get the correct sneaky character.
And the good news is that no, it doesn't work. We are protected by this
code in transport_get():

          /* maybe it is a foreign URL? */
          if (url) {
                  const char *p = url;

                  while (is_urlschemechar(p == url, *p))
                          p++;     
                  if (starts_with(p, "::"))
                          helper = xstrndup(url, p - url);
          }

So we'll only allow remote-helper names with valid url characters, which
are basically [A-Za-z0-9+.-]. So I think we probably only have to worry
about true case issues, and not any kind of weird filesystem-specific
behaviors.

-Peff
