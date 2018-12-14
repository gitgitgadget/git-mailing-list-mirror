Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18D420A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 10:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeLNKE7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 05:04:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:41864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727579AbeLNKE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 05:04:59 -0500
Received: (qmail 25654 invoked by uid 109); 14 Dec 2018 10:04:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Dec 2018 10:04:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2356 invoked by uid 111); 14 Dec 2018 10:04:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Dec 2018 05:04:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2018 05:04:57 -0500
Date:   Fri, 14 Dec 2018 05:04:57 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: [Question] Complex textconv text
Message-ID: <20181214100457.GB13465@sigill.intra.peff.net>
References: <004501d492f5$98f0fcc0$cad2f640$@nexbridge.com>
 <xmqqo99odcou.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo99odcou.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 12:12:01PM +0900, Junio C Hamano wrote:

> > I have a strange situation and need help with resolving funky characters in
> > .git/config. My situation is this:
> >
> > [diff "*.dat"]
> > 	textconv = enscribe-conv
> > --format=-a1\(A=-a1,-a16,-a32\|P=-a1,-a32,-a16\|=-a1,-d,a14\),-a224
> >
> > Basically this is a formatter for diff so that I can show structured binary
> > data. The unquoted syntax of the format string is:
> >  --format=-a1(A=-a1,-a16,-a32|P=-a1,-a32,-a16|=-a1,-d,a14),-a224
> >
> > Content is not really important. The issue is that git is reporting fatal:
> > bad config line 2 in file .git/config when I escape the (, ), and |
> > characters.
> 
> That failure is understandable, as
> 
>     The following escape sequences (beside `\"` and `\\`) are recognized:
>     `\n` for newline character (NL), `\t` for horizontal tabulation (HT, TAB)
>     and `\b` for backspace (BS).  Other char escape sequences (including octal
>     escape sequences) are invalid.
> 
> is what Documentation/config.txt says.  \(, \) and \| is not a way
> to escape these letters from the .git/config parser (they do not
> need to be escaped from .git/config parser)..

Yes. It's a little unfriendly that we don't pass them through, since
that would do what Randall wants here. But doing so would be unfriendly
to somebody who _did_ want to quote them, and is confused why there are
passed through literally.

At any rate, the "right" way here is to quote the backslashes that are
meant to be passed through to the shell, like:

  textconv = foo \\(X\\|\\)

Note that if you write the config using git-config, that's what it
produces:

  $ git config -f file foo.bar '\(X\|Y\)'
  $ cat file
  [foo]
	bar = \\(X\\|Y\\)

I agree that your double-quote suggestion is more readable (or as
Randall eventually figured out, hiding it all in a real script ;) ).

-Peff
