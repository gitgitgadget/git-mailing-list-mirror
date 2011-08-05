From: Jeff King <peff@peff.net>
Subject: Re: git-fast-export is returning streams with source code inside
Date: Fri, 5 Aug 2011 03:36:19 -0600
Message-ID: <20110805093618.GA19062@sigill.intra.peff.net>
References: <CAFC9htxwRg=+RD68hnnRy0hfptq23x3bL+xxHieK1evfFCTPjw@mail.gmail.com>
 <20110804070528.GA11805@sigill.intra.peff.net>
 <CAFC9htxRD0z3O_k_OLp08KZFUOL_T3AryCXD+OqqXx9ZYeRutg@mail.gmail.com>
 <20110804183218.GA15943@sigill.intra.peff.net>
 <CAFC9htyFKm7NCNFvrUkxXpmj1jwatWkxrnRSEdztY4Syo+EQ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James Gregory <j.gregory@epigenesys.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 05 11:36:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpGpS-00025m-Hx
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 11:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab1HEJgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 05:36:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58062
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab1HEJgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 05:36:25 -0400
Received: (qmail 27761 invoked by uid 107); 5 Aug 2011 09:36:58 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Aug 2011 05:36:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2011 03:36:19 -0600
Content-Disposition: inline
In-Reply-To: <CAFC9htyFKm7NCNFvrUkxXpmj1jwatWkxrnRSEdztY4Syo+EQ-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178783>

On Fri, Aug 05, 2011 at 10:24:07AM +0100, James Gregory wrote:

> I've attached the valgrind.out file. If I'm reading the output
> properly, it does look like it is suffering from a memory leak.

It looks pretty innocuous:

> ==3267== Conditional jump or move depends on uninitialised value(s)
> ==3267==    at 0x4E39510: inflateReset2 (in /lib/x86_64-linux-gnu/libz.so.1.2.3.4)
> ==3267==    by 0x4E39605: inflateInit2_ (in /lib/x86_64-linux-gnu/libz.so.1.2.3.4)
> ==3267==    by 0x4D5B02: ??? (in /usr/bin/git)
> ==3267==    by 0x4BB059: ??? (in /usr/bin/git)
> ==3267==    by 0x4BC464: ??? (in /usr/bin/git)
> ==3267==    by 0x4BCA29: ??? (in /usr/bin/git)
> ==3267==    by 0x4BCAFD: ??? (in /usr/bin/git)
> ==3267==    by 0x4BD161: ??? (in /usr/bin/git)
> ==3267==    by 0x49AEAC: ??? (in /usr/bin/git)
> ==3267==    by 0x4B38AA: ??? (in /usr/bin/git)
> ==3267==    by 0x4B422A: ??? (in /usr/bin/git)
> ==3267==    by 0x4A9CD2: ??? (in /usr/bin/git)

This is a well-known false positive caused by zlib, and is nothing to
worry about.

> ==3267== LEAK SUMMARY:
> ==3267==    definitely lost: 48,016 bytes in 3 blocks
> ==3267==    indirectly lost: 30,226 bytes in 1,889 blocks

These are actual leaks, but minor.

> ==3267==      possibly lost: 0 bytes in 0 blocks
> ==3267==    still reachable: 2,743,134 bytes in 4,334 blocks

These are not really leaks, but rather things we don't bother cleaning
up since we're about to exit and let the OS reclaim memory (e.g., all of
the commit objects).

So yes, there's leaking, but it's not much. And more importantly, I was
looking not for leaks, but for memory access errors (of which there are
none, except for the zlib false positive).

So I'm not sure where to go from here. I can't reproduce the problem
locally. Is there anything else you can tell us about the problem? Does
it always happen on the same commit? If you export just that commit,
does the problem happen? Is there anything noteworthy in the contents of
that commit?

-Peff
