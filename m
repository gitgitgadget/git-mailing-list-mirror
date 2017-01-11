Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7E01FEB3
	for <e@80x24.org>; Wed, 11 Jan 2017 10:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbdAKKEH (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 05:04:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:37904 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbdAKKEG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 05:04:06 -0500
Received: (qmail 20504 invoked by uid 109); 11 Jan 2017 10:04:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 10:04:04 +0000
Received: (qmail 20531 invoked by uid 111); 11 Jan 2017 10:04:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 05:04:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2017 05:04:01 -0500
Date:   Wed, 11 Jan 2017 05:04:01 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     musl@lists.openwall.com, Andreas Schwab <schwab@linux-m68k.org>,
        "A. Wilcox" <awilfox@adelielinux.org>
Subject: Re: [musl] Re: Test failures when Git is built with libpcre and grep
 is built without it
Message-ID: <20170111100400.vhd5ytarqpujigbn@sigill.intra.peff.net>
References: <58688C9F.4000605@adelielinux.org>
 <20170102065351.7ymrm77asjbghgdg@sigill.intra.peff.net>
 <58736B2A.40003@adelielinux.org>
 <871swcjsd3.fsf@linux-m68k.org>
 <20170109213303.4rupe5cqwejfp6af@sigill.intra.peff.net>
 <5874B942.7070402@adelielinux.org>
 <20170110113959.GL17692@port70.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170110113959.GL17692@port70.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 12:40:00PM +0100, Szabolcs Nagy wrote:

> > > I'm not sure if musl is wrong for failing to complain about a
> > > bogus regex. Generally making something that would break into
> > > something that works is an OK way to extend the standard. So our
> > > test is at fault for assuming that the regex will fail. I guess
> 
> \x is undefined in posix and musl is based on tre which
> supports \x{hexdigits} in ere.

Thanks for confirming; I figured it was something like that.

> > > we'd need to find some more exotic syntax that pcre supports, but
> > > that ERE doesn't. Maybe "(?:)" or something.
> 
> i think you would have to use something that's invalid
> in posix ere, ? after empty expression is undefined,
> not an error so "(?:)" is a valid ere extension.

Reading through POSIX[1], hardly anything is explicitly labeled as
"invalid". Most things are just "undefined", which leaves rooms for
implementations to do what they like.

That's a good thing for a standard to do, but a bad thing when you are
trying to find behavior that differs reliably between PCRE and ERE. :)
In most cases, PCRE constructs could be viable extensions to ERE.

> since most syntax is either defined or undefined in ere
> instead of being invalid, distinguishing pcre using
> syntax is not easy.
> 
> there are semantic differences in subexpression matching:
> leftmost match has higher priority in pcre, longest match
> has higher priority in ere.
> 
> $ echo ab | grep -o -E '(a|ab)'
> ab
> $ echo ab | grep -o -P '(a|ab)'
> a
> 
> unfortunately grep -o is not portable.

In this case we're testing whether Git has internally fed the regex to
pcre or to regcomp(), not a system grep. So we'd need something like
"-o" for "git grep", which I don't think exists.

Another difference I found is that "[\d]" matches a literal "\" or "d"
in ERE, but behaves like "[0-9]" in PCRE. I'll work up a patch based on
that.

Thanks for your answer. I'll drop the musl list from the cc when I
follow-up, as this is most definitely not a musl problem, but a git one.

-Peff
