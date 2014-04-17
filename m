From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Thu, 17 Apr 2014 17:58:17 -0400
Message-ID: <20140417215817.GA822@sigill.intra.peff.net>
References: <20140416141519.GA9684@camelia.ucw.cz>
 <20140416154653.GB4691@sigill.intra.peff.net>
 <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info>
 <20140417213238.GA14792@sigill.intra.peff.net>
 <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stepan Kasal <kasal@ucw.cz>,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:58:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WauK8-0002iv-G2
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 23:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbaDQV6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 17:58:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:33482 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751019AbaDQV6T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 17:58:19 -0400
Received: (qmail 21312 invoked by uid 102); 17 Apr 2014 21:58:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Apr 2014 16:58:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Apr 2014 17:58:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246457>

On Thu, Apr 17, 2014 at 11:52:56PM +0200, Johannes Schindelin wrote:

> > I tried running the test on my Linux box, but it doesn't fail with the
> > existing recursive code.
> 
> I cannot recall how I came to choose 64, but I *think* I only tested on
> Windows, and I *think* I reduced the number of tags in order to make
> things faster (Windows is *unbearably* slow with spawn-happy programs such
> as Git's tests -- literally every single line in a shell script tests the
> patience of this developer, running the complete test suite with 15
> parallel threads takes several hours, no kidding).

Yeah, I figured speed had something to do with it. However, since you
are using a bash loop to generate the input (and it should all be done
as builtins in bash, I think), and fast-import to create the objects, I
don't think bumping it will actually increase your process count.

> > The results are strangely non-deterministic, but with -O0, we generally
> > die reliably below about 60. With -O2, though, it's more like 43. We
> > can't go _too_ low here, though, as lots of things start breaking around
> > 32.
> 
> How about using 40, then? I am more interested in reducing the runtime
> than reducing the number of false negatives. The problem will be exercised
> enough on Windows, but not if the test suite becomes even slower than it
> already is.

I'm OK with doing that. My biggest concern is that it will cause false
positives on systems that are hungrier for stack space, but we can
address that if it happens.

-Peff
