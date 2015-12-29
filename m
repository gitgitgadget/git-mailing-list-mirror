From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] compiling with -fsanitize=undefined
Date: Tue, 29 Dec 2015 01:34:49 -0500
Message-ID: <20151229063449.GA28755@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 07:35:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDnsX-0008Jh-8J
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 07:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbbL2Gey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 01:34:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:46529 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751097AbbL2Gew (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 01:34:52 -0500
Received: (qmail 15619 invoked by uid 102); 29 Dec 2015 06:34:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:34:52 -0600
Received: (qmail 18781 invoked by uid 107); 29 Dec 2015 06:35:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:35:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 01:34:49 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283074>

I was playing around with the new-ish "-fsanitize=undefined" compiler
flag, and it detected a few problems:

  1. We sometimes bit-shift signed constants too far (fixed by the first
     patch).

  2. We have some unaligned memory accesses that presumably work OK on
     x86, but would blow up on ARM or other platforms (I didn't test).

The latter looks like it's in the untracked cache code (Duy and
Christian cc'd). Running t7063 gets me this:

dir.c:2631:45: runtime error: member access within misaligned address 0x7f19806ff185 for type 'const struct ondisk_untracked_cache', which requires 4 byte alignment
0x7f19806ff185: note: pointer points here
 31 33 29 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00
             ^

We also do unaligned loads in the get_be* functions, but only on x86 and
similar platforms.  I'm counting these as a false positive, since it is
presumably OK there. The second patch makes it easier to squelch these.

I also got false positives from feeding NULL to qsort(). This is
technically wrong, but OK in practice when we tell it we have zero
elements. Compiling with INTERNAL_QSORT silences these (and if somebody
is on a platform where their qsort() segfaults, it's what I'd tell them
to use).

So if you want to play along at home, my build is something like:

  make \
    CC=clang \
    INTERNAL_QSORT=YesPlease \
    CFLAGS='-O2 -g -fsanitize=undefined -fno-sanitize-recover=undefined -DNO_UNALIGNED_LOADS' \
    test

and it passes except for t7063.

The patches are:

  [1/2]: avoid shifting signed integers 31 bits
  [2/2]: bswap: add NO_UNALIGNED_LOADS define

-Peff
