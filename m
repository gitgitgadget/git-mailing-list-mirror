From: Jeff King <peff@peff.net>
Subject: Re: Slow git pushes: sitting 1 minute in pack-objects
Date: Thu, 19 Mar 2015 17:07:31 -0400
Message-ID: <20150319210731.GA8363@peff.net>
References: <CAH8BJxH1uVv9J7yLx1D4GRPKfWYqDw8SRFZKGR_yhjcoTCCT2g@mail.gmail.com>
 <20150309075302.GB31866@peff.net>
 <CAH8BJxHQnMkXq1J_wMi2KktTH5uHjj+vd69ihXuYGRfq9cOt=g@mail.gmail.com>
 <20150316221532.GA16679@peff.net>
 <CAH8BJxErCMk1JQMMKm9_j4bckB7bEVB+r28_zYovE=pe1nUa_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:07:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYhfG-0006nm-Px
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbbCSVHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:07:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:35449 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750734AbbCSVHe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:07:34 -0400
Received: (qmail 4875 invoked by uid 102); 19 Mar 2015 21:07:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 16:07:33 -0500
Received: (qmail 17428 invoked by uid 107); 19 Mar 2015 21:07:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 17:07:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 17:07:31 -0400
Content-Disposition: inline
In-Reply-To: <CAH8BJxErCMk1JQMMKm9_j4bckB7bEVB+r28_zYovE=pe1nUa_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265832>

On Thu, Mar 19, 2015 at 04:31:36PM -0400, Stephen Morton wrote:

> > Hmm. The "push" process must feed the set of object boundaries to
> > "pack-objects" so it knows what to pack (i.e., what we want to send, and
> > what the other side has).
> >
> > 120,000 is an awfully large number of objects to be pass there, though.
> > Does the repo you are pushing to by any chance have an extremely large
> > number of refs (e.g., on the order of 120K tags)?
> 
> No. There are on the order of 9,500 refs (mostly tags) but nowhere near 120k.

I think you mentioned that it uses alternates to share objects with
other repos. Does the repository (or repositories) pointed to by the
alternates file have a large number of refs (especially distinct refs,
as I think modern git will squelch duplicate sha1s).

> It did _not_ happen in a new clone --a push took just 5s -- and I
> think the culprit could have been "repack.writebitmaps=true". Although
> I had thought writebitmaps was not originally enabled, I now suspect
> that it was. Let me follow up on that first, before I recompile git
> with your changes.

It's certainly possible that bitmaps have an impact here. They should
not contribute to the 120K objects being passed to pack-objects, but
it's possible that size is a red herring (or possibly the number of
objects is choking something in the bitmap code path that does not have
problems otherwise).

-Peff
