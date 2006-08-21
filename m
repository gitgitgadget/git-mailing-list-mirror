From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Mon, 21 Aug 2006 03:06:09 -0400
Message-ID: <20060821070609.GC24054@spearce.org>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com> <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain> <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com> <Pine.LNX.4.64.0608181057440.11359@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 09:06:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF3rb-0004Bg-EO
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 09:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWHUHGT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 03:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWHUHGT
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 03:06:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:7913 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964967AbWHUHGT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 03:06:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GF3rP-00029C-5P; Mon, 21 Aug 2006 03:06:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 97ED520FB7D; Mon, 21 Aug 2006 03:06:09 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608181057440.11359@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25782>

Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 18 Aug 2006, Jon Smirl wrote:
> 
> > On 8/18/06, Nicolas Pitre <nico@cam.org> wrote:
> > > A better way to get such a size saving is to increase the window and
> > > depth parameters.  For example, a window of 20 and depth of 20 can
> > > usually provide a pack size saving greater than 11% with none of the
> > > disadvantages mentioned above.
> > 
> > Our window size is effectively infinite. I am handing him all of the
> > revisions from a single file in optimal order. This includes branches.
> 
> In GIT packing terms this is infinite delta _depth_ not _window_.

We're not using infinite anything.

fast-import is basically doing window=1 and depth=10.

We only examine the last blob to see if we can get a delta against
it.  If we do we write that delta out; otherwise we reset our delta
chain and write the complete object.  We also reset our chain after
writing out 10 deltas, each of which used the immediately prior
object as its base.

Since I just found out that in some cases the Mozilla repository has
1000s of revisions per file[*1*] and in others only 1 revision per
file we probably should be adjusting this depth to have a maximum
of 500 while also having the frontend send us a "I'm switching
files now" marker so we know to not even bother trying to delta
the new blob against the last blob as they are likely to not
delta well[*2*].
 
> Default delta params (window=10 depth=10) : 122103455 
> Agressive deltas (window=50 depth=5000) : 105870516
> Agressive and grouped deltas (window=50 depth=5000 : 99860685

Although complex the aggressive and grouped deltas appears to
have saved you 18.2% on this repository.  That's not something
to ignore.  A reasonably optimal local pack dictionary could save
at least 4%[*3*].  Whacking 22% off a 400 MB pack is saving 88 MB.
Transferring that over the network on an initial clone is like
downloading all of Eclipse.  Or an uncompressed kernel tarball...


[*1*] Jon noted this in another email in this thread but I'm too
      lazy to lookup the hyperlink right now.

[*2*] Granted in some cases they may delta very well against each
      other but I think the probablity of that occuring is low
	  enough that its not worth worrying about in fast-import.c;
	  we can let repack's strategy deal with it instead.

[*3*] I wrote a brain-dead simple local dictionary selecter in Perl.
      Its horribly far from being ideal.  But it is consistently
      saving us 4% on the GIT and the Mozilla repository and its
	  pretty darn fast.  Shockingly the C keywords didn't gain
	  us very much here; its project specific text that's the
	  real win.

	  Looking at chunks which are frequently copied in deltas
	  from base objects and breaking those chunks up into
	  smaller common chunks, then loading those most frequent
	  common chunks into the pack dictionary would most likely
	  produce far better results.

-- 
Shawn.
