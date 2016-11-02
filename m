Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B0D620193
	for <e@80x24.org>; Wed,  2 Nov 2016 17:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756602AbcKBRkZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 13:40:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:37552 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756554AbcKBRkY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 13:40:24 -0400
Received: (qmail 6356 invoked by uid 109); 2 Nov 2016 17:40:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 17:40:23 +0000
Received: (qmail 4477 invoked by uid 111); 2 Nov 2016 17:40:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 13:40:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 13:40:21 -0400
Date:   Wed, 2 Nov 2016 13:40:21 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
Message-ID: <20161102174021.awhmbmuffbzv5b7t@sigill.intra.peff.net>
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
 <20161102170415.GA6420@tb-raspi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161102170415.GA6420@tb-raspi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2016 at 05:04:15PM +0000, Torsten Bögershausen wrote:

> > * ls/filter-process (2016-10-17) 14 commits
> >   (merged to 'next' on 2016-10-19 at ffd0de042c)
> 
> Some (late, as I recently got a new battery for the Mac OS 10.6 test system) 
> comments:
> t0021 failes here:
> 
> 
> Can't locate object method "flush" via package "IO::Handle" at /Users/tb/projects/git/git.next/t/t0021/rot13-filter.pl line 90.
> fatal: The remote end hung up unexpectedly
> 
> 
> perl itself is 5.10 and we use the one shipped with Mac OS.

Wow, haven't seen that bug in a while[1]. The problem is that STDIN is a
filehandle object, but older versions of perl do not automatically load
IO::Handle to get all of the methods. This was fixed in perl 5.13.

We can work around it with:

  use IO::Handle;

at the top of the script. That should work everywhere, as IO::Handle has
been part of the core system for ages. But another option would be to
just turn on autoflush, with:

  $| = 1;

at the top of the script (though it looks like we flush $debug, too, so
we'd probably need to "select $debug; $| = 1" there, too). The "use"
command is preferable IMHO.

> Why that ?
> t0021 uses the hard-coded path:
> t0021/rot13-filter.pl (around line 345) and the nice macro
> PERL_PATH from the Makefile is fully ignored.

Yeah, we should be using PERL_PATH. Doing so inside the filter config
value is probably a pain due to shell quoting issues. But we could
use write_script() to get a local copy.

I'll see if I can work up a patch.

-Peff

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=261953
