From: Jeff King <peff@peff.net>
Subject: Re: Slow git pushes: sitting 1 minute in pack-objects
Date: Mon, 9 Mar 2015 03:53:02 -0400
Message-ID: <20150309075302.GB31866@peff.net>
References: <CAH8BJxH1uVv9J7yLx1D4GRPKfWYqDw8SRFZKGR_yhjcoTCCT2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 08:53:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUsUy-0003lk-GY
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 08:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbbCIHxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 03:53:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:59054 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750918AbbCIHxG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 03:53:06 -0400
Received: (qmail 9441 invoked by uid 102); 9 Mar 2015 07:53:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 02:53:05 -0500
Received: (qmail 4638 invoked by uid 107); 9 Mar 2015 07:53:13 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 03:53:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Mar 2015 03:53:02 -0400
Content-Disposition: inline
In-Reply-To: <CAH8BJxH1uVv9J7yLx1D4GRPKfWYqDw8SRFZKGR_yhjcoTCCT2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265134>

On Thu, Mar 05, 2015 at 04:03:07PM -0500, Stephen Morton wrote:

> I'm experiencing very slow git pushes. On the order of 1 minute to push a
> trivial one-line change. When I set GIT_TRACE=1, I see that it seems to be
> taking a lot of time in the pack-objects phase.

Can you tell what pack-objects is doing? Perhaps "strace -f -tt" might
help. Or even just "time git push", which will tell us whether we're
spinning on CPU or something else.

If you watch the progress meter, where does it spend its time? In
"counting objects", "compressing objects", or "writing objects"? Or
after that?

You said the repo is big. Is it reasonably packed (try running `git
gc`). Pack-objects may look at objects that you know the other side has
in order to create deltas against them. If you have some crazy situation
(e.g., you have several thousand packfiles) that can slow down object
access quite a bit. A minute is more than I would expect, but if VFS
operations in your VM are slow, that could be it.

-Peff
