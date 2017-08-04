Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4832047F
	for <e@80x24.org>; Fri,  4 Aug 2017 20:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbdHDUW6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 16:22:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:58092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752319AbdHDUW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 16:22:58 -0400
Received: (qmail 15594 invoked by uid 109); 4 Aug 2017 20:22:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Aug 2017 20:22:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28597 invoked by uid 111); 4 Aug 2017 20:23:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Aug 2017 16:23:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Aug 2017 16:22:55 -0400
Date:   Fri, 4 Aug 2017 16:22:55 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [RFC] imap-send: escape backslash in password
Message-ID: <20170804202255.3oia7ivsoa6vu4me@sigill.intra.peff.net>
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
 <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
 <87bmnvktee.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bmnvktee.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 04, 2017 at 09:46:49PM +0200, Andreas Schwab wrote:

> > For example, FRC3501 "9. Formal Syntax" says that both "password"
> > and "userid" are "astring"; it looks strange that the code with this
> > patch only touches cred.password while sending cred.username as-is.
> 
> astring         = ... / string
> string          = quoted / ...
> quoted          = DQUOTE *QUOTED-CHAR DQUOTE
> QUOTED-CHAR     = <any TEXT-CHAR except quoted-specials> /
>                   "\" quoted-specials
> quoted-specials = DQUOTE / "\"
> 
> Thus the quoting applies to any element that is a string (and a double
> quote needs to be quoted as well).

It's been a long time since I've done anything with IMAP, but I think
another alternative would be to send it as a "literal", like:

  {6}
  foobar

That's relatively easy to format correctly using the current printf
specifiers that imap_exec() takes. Though as I said elsewhere in the
thread, perhaps imap_exec() should provide a different interface.

I also think it might be reasonable to scrap all of this ad-hoc imap
code in favor of curl, which already gets these cases right. We already
have a curl-backed implementation. I think we just left the old code out
of conservatism. But it seems somewhat buggy and unmaintained, and I
wonder if we aren't better off to simply encourage people to install
curl.

-Peff
