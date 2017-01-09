Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0601E1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 21:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030798AbdAIVdK (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 16:33:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:37186 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941378AbdAIVdH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 16:33:07 -0500
Received: (qmail 16720 invoked by uid 109); 9 Jan 2017 21:33:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 21:33:06 +0000
Received: (qmail 7817 invoked by uid 111); 9 Jan 2017 21:33:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 16:33:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jan 2017 16:33:03 -0500
Date:   Mon, 9 Jan 2017 16:33:03 -0500
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     "A. Wilcox" <awilfox@adelielinux.org>, git@vger.kernel.org
Subject: Re: Test failures when Git is built with libpcre and grep is built
 without it
Message-ID: <20170109213303.4rupe5cqwejfp6af@sigill.intra.peff.net>
References: <58688C9F.4000605@adelielinux.org>
 <20170102065351.7ymrm77asjbghgdg@sigill.intra.peff.net>
 <58736B2A.40003@adelielinux.org>
 <871swcjsd3.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871swcjsd3.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 09, 2017 at 02:05:44PM +0100, Andreas Schwab wrote:

> On Jan 09 2017, "A. Wilcox" <awilfox@adelielinux.org> wrote:
> 
> > Interestingly enough, you seem to be right.  The failure is very
> > bizarre and has nothing to do with system /bin/grep:
> >
> > test_must_fail: command succeeded: git grep -G -F -P -E a\x{2b}b\x{2a}c ab
> > not ok 142 - grep -G -F -P -E pattern
> > #
> > #               >empty &&
> > #               test_must_fail git grep -G -F -P -E "a\x{2b}b\x{2a}c"
> > ab >actual &&
> > #               test_cmp empty actual
> > #
> >
> > However:
> >
> > elaine trash directory.t7810-grep # git grep -G -F -P -E
> > a\x{2b}b\x{2a}c ab >actual
> 
> You need to quote the regexp argument, see the line starting with
> "test_must_fail" above.

Oh, duh. I checked that the line in the test was quoted, and didn't
notice that only the unquoted version he ran later complained. Thanks
for noticing, as that explains the mystery, I think.

The problem is that we are expecting the regex "\x{2b}" to complain in
regcomp() (as an ERE), but it doesn't. And that probably _is_ related to
musl, which is providing the libc regex (I know this looks like a pcre
test, but it's checking that "-P -E" overrides the pcre option with
"-E").

I'm not sure if musl is wrong for failing to complain about a bogus
regex. Generally making something that would break into something that
works is an OK way to extend the standard. So our test is at fault for
assuming that the regex will fail. I guess we'd need to find some more
exotic syntax that pcre supports, but that ERE doesn't. Maybe "(?:)" or
something.

-Peff
