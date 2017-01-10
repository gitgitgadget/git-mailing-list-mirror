Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E667B20A93
	for <e@80x24.org>; Tue, 10 Jan 2017 11:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762340AbdAJLpQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 06:45:16 -0500
Received: from port70.net ([81.7.13.123]:43680 "EHLO port70.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757375AbdAJLpP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 06:45:15 -0500
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jan 2017 06:45:15 EST
Received: by port70.net (Postfix, from userid 1002)
        id 8A084ABEC08B; Tue, 10 Jan 2017 12:40:00 +0100 (CET)
Date:   Tue, 10 Jan 2017 12:40:00 +0100
From:   Szabolcs Nagy <nsz@port70.net>
To:     musl@lists.openwall.com
Cc:     Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
        git@vger.kernel.org, "A. Wilcox" <awilfox@adelielinux.org>
Subject: Re: [musl] Re: Test failures when Git is built with libpcre and grep
 is built without it
Message-ID: <20170110113959.GL17692@port70.net>
Mail-Followup-To: musl@lists.openwall.com, Jeff King <peff@peff.net>,
        Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
        "A. Wilcox" <awilfox@adelielinux.org>
References: <58688C9F.4000605@adelielinux.org>
 <20170102065351.7ymrm77asjbghgdg@sigill.intra.peff.net>
 <58736B2A.40003@adelielinux.org>
 <871swcjsd3.fsf@linux-m68k.org>
 <20170109213303.4rupe5cqwejfp6af@sigill.intra.peff.net>
 <5874B942.7070402@adelielinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5874B942.7070402@adelielinux.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* A. Wilcox <awilfox@adelielinux.org> [2017-01-10 04:36:50 -0600]:
> On 09/01/17 15:33, Jeff King wrote:
> > The problem is that we are expecting the regex "\x{2b}" to complain
> > in regcomp() (as an ERE), but it doesn't. And that probably _is_
> > related to musl, which is providing the libc regex (I know this
> > looks like a pcre test, but it's checking that "-P -E" overrides
> > the pcre option with "-E").
> > 
> > I'm not sure if musl is wrong for failing to complain about a
> > bogus regex. Generally making something that would break into
> > something that works is an OK way to extend the standard. So our
> > test is at fault for assuming that the regex will fail. I guess

\x is undefined in posix and musl is based on tre which
supports \x{hexdigits} in ere.

(i think some bsd platforms use tre as libc regex so
i'm surprised musl is the first to run into this.)

> > we'd need to find some more exotic syntax that pcre supports, but
> > that ERE doesn't. Maybe "(?:)" or something.

i think you would have to use something that's invalid
in posix ere, ? after empty expression is undefined,
not an error so "(?:)" is a valid ere extension.

since most syntax is either defined or undefined in ere
instead of being invalid, distinguishing pcre using
syntax is not easy.

there are semantic differences in subexpression matching:
leftmost match has higher priority in pcre, longest match
has higher priority in ere.

$ echo ab | grep -o -E '(a|ab)'
ab
$ echo ab | grep -o -P '(a|ab)'
a

unfortunately grep -o is not portable.
