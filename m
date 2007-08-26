From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: name-rev does not show the shortest path
Date: Sun, 26 Aug 2007 17:38:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708261733400.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20070823103817.GF6573@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0708241253050.8987@reaper.quantumfyre.co.uk>
 <20070824125230.GA12030@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0708241615040.7313@reaper.quantumfyre.co.uk>
 <7v6434eq9o.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0708251701150.16728@wbgn129.biozentrum.uni-wuerzburg.de>
 <20070826092323.GB30474@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 17:38:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPKC5-0008T0-3w
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 17:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbXHZPi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 11:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbXHZPi0
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 11:38:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:52718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751748AbXHZPiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 11:38:25 -0400
Received: (qmail invoked by alias); 26 Aug 2007 15:38:24 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp046) with SMTP; 26 Aug 2007 17:38:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DFmACD21DBkLbGhzAzbStNXE1KHnNgMMYPuyTUx
	0Jc1r3KTr0lFSG
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070826092323.GB30474@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56692>

Hi,

On Sun, 26 Aug 2007, Jeff King wrote:

> On Sat, Aug 25, 2007 at 05:04:33PM +0200, Johannes Schindelin wrote:
> 
> > I briefly looked into this, and did not find out why it is behaving that 
> > way.  It _should_ pick the closer one with this code:
> > 
> >         } else if (name->merge_traversals > merge_traversals ||
> >                         (name->merge_traversals == merge_traversals &&
> >                          name->generation > generation)) {
> > 
> > However, it did not even get to that code in my tests.  I'll have to look 
> > at that problem closer in a quiet moment (which I will not have for at 
> > least another 24 hours).
> 
> It does execute that code, just not for the rev in question. We hit the
> third part of that conditional and stop recursing on a different rev, so
> we only touch our "interesting" rev one time.

Yes, I guessed as much.

> That being said, I think this test is totally bogus. You're just looking
> at the generation and merge traversals from some tip. However, the tip
> _isn't_ the actual ref, but instead gets re-written as a string when we
> follow a merge. That string contains important generational information
> that is no longer taken into account, so you end up with things like
> "foo~999" with generation "3" is better than "bar~10" with generation
> "5".

But this did not happen here, right?  Just the first part was different...

> Here is a patch (below) that tracks an absolute "distance to ref" and at
> least names the rev in question after v2.6.22-rc1. However, because it
> is now preferring "distance to ref" strictly over merge traversals, it
> seems to generate some obscenely long names:
> 
> 0567a0c022d5b343370a343121f38fd89925de55 tags/v2.6.22-rc1~1^2^2^2~11^2~13^2~8^2~1^3~5
> 
> So perhaps there is a more sane metric, but I'd have to think about it
> more.

The old code _should_ have worked; it is more likely that your different 
metric just hides the bug.  The old metric tried to favour less merge 
traversals over more traversals, but at the same time, it favoured smaller 
numbers over larger ones (but as you found out, only in the last 
component).

I guess there is something else going on, such as the tag v2.6.22-rc1 
being marked uninteresting because v2.6.22 and its ancestors being 
traversed already.

Ciao,
Dscho
