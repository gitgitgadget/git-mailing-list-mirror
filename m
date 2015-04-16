From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/9] address packed-refs speed regressions
Date: Thu, 16 Apr 2015 04:47:34 -0400
Message-ID: <20150416084733.GA17811@peff.net>
References: <20150405010611.GA15901@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 10:47:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YifSb-0008Mh-7S
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 10:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933430AbbDPIrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 04:47:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:46075 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753714AbbDPIrh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 04:47:37 -0400
Received: (qmail 21470 invoked by uid 102); 16 Apr 2015 08:47:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 03:47:37 -0500
Received: (qmail 23364 invoked by uid 107); 16 Apr 2015 08:48:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 04:48:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 04:47:34 -0400
Content-Disposition: inline
In-Reply-To: <20150405010611.GA15901@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267261>

On Sat, Apr 04, 2015 at 09:06:11PM -0400, Jeff King wrote:

> As I've mentioned before, I have some repositories with rather large
> numbers of refs. The worst one has ~13 million refs, for a 1.6GB
> packed-refs file. So I was saddened by this:
> 
>   $ time git.v2.0.0 rev-parse refs/heads/foo >/dev/null 2>&1
>   real    0m6.840s
>   user    0m6.404s
>   sys     0m0.440s
> 
>   $ time git.v2.4.0-rc1 rev-parse refs/heads/foo >/dev/null 2>&1
>   real    0m19.432s
>   user    0m18.996s
>   sys     0m0.456s

Here's a re-roll incorporating feedback from the list. Thanks everybody
for your comments. Last time the final number was ~8.5s, which was
disappointingly slower than v2.0.0. In this iteration, my final numbers
are:

  real    0m5.703s
  user    0m5.276s
  sys     0m0.432s

which is quite pleasing.

The big changes that resulted in this additional speedup are:

  1. Use getdelim() when it is available. This is much faster than even
     a getc_unlocked() loop.

  2. The slowdown from d0f810f was from adding in refname_is_safe calls.
     But what I didn't notice before is that we run them in _addition_
     to check_refname_format, rather than instead of it. So in the
     common case of a sanely-formatted refname, we can skip the call,
     rather than writing a lot of code to micro-optimize it.

It was also mentioned in a nearby thread that the config code could
benefit from some of the same micro-optimizations. It can't make use of
getdelim(), as it really does want to do character-by-character parsing.
But it can still use getc_unlocked() and the strbuf_avail() trick, which
speeds up config reading by 47%. Those patches are included here.

  [1/9]: strbuf_getwholeline: use getc macro
  [2/9]: git-compat-util: add fallbacks for unlocked stdio
  [3/9]: strbuf_getwholeline: use getc_unlocked
  [4/9]: config: use getc_unlocked when reading from file
  [5/9]: strbuf_addch: avoid calling strbuf_grow
  [6/9]: strbuf_getwholeline: avoid calling strbuf_grow
  [7/9]: strbuf_getwholeline: use getdelim if it is available
  [8/9]: read_packed_refs: avoid double-checking sane refs
  [9/9]: t1430: add another refs-escape test

-Peff
