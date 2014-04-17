From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Thu, 17 Apr 2014 17:32:38 -0400
Message-ID: <20140417213238.GA14792@sigill.intra.peff.net>
References: <20140416141519.GA9684@camelia.ucw.cz>
 <20140416154653.GB4691@sigill.intra.peff.net>
 <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stepan Kasal <kasal@ucw.cz>,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:32:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WatvL-000521-Px
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 23:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbaDQVcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 17:32:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:33466 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750874AbaDQVcn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 17:32:43 -0400
Received: (qmail 19901 invoked by uid 102); 17 Apr 2014 21:32:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Apr 2014 16:32:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Apr 2014 17:32:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246454>

On Thu, Apr 17, 2014 at 07:31:54PM +0200, Johannes Schindelin wrote:

> > 	bash -c "ulimit -s 64 && git tag --contains HEAD" >actual &&
> [...]
> Please see https://github.com/msysgit/git/c63d196 for the fixup, and
> https://github.com/msysgit/git/compare/tag-contains%5E...tag-contains for
> the updated patch.

I tried running the test on my Linux box, but it doesn't fail with the
existing recursive code. So I tried a few different stack sizes, like:

  for i in `seq 1 64`; do
    bash -c "
      ulimit -s $i &&
      ../../git tag --contains HEAD ||
      echo fail $i"
  done

The results are strangely non-deterministic, but with -O0, we generally
die reliably below about 60. With -O2, though, it's more like 43. We
can't go _too_ low here, though, as lots of things start breaking around
32.

If we instead bump the size of the history to 2000 commits, then I
reliably fail with a 64k stack (even with -O2, it needs around 80k).

Of course those numbers are all black magic, and are going to vary based
on the system, the compiler, settings, etc. My system is 64-bit, and the
current code needs at least 3 pointers per recursive invocation. So
we're spending ~46K on those variables, not counting any calling
convention overhead (and presumably we at least need a function return
pointer there). So a 32-bit system might actually get by, as it would
need half as much.

So we can bump the depth further; probably 4000 is enough for any system
to fail with a 64k stack. The deeper we make it, the longer it takes to
run the test, though. At 4000, my machine seems to take about 300ms to
run it. That's may be OK.

-Peff
