From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git pull is slow
Date: Sun, 13 Jul 2008 01:15:12 +0000
Message-ID: <20080713011512.GB31050@spearce.org>
References: <g5570s$d5m$1@ger.gmane.org> <g57jkp$ekm$1@ger.gmane.org> <48776169.20705@op5.se> <alpine.DEB.1.00.0807111443280.8950@racer> <4878A442.6020405@arcor.de> <alpine.DEB.1.00.0807121546590.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephan Hennig <mailing_list@arcor.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 13 03:16:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHqCo-0001n1-1r
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 03:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbYGMBPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 21:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbYGMBPO
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 21:15:14 -0400
Received: from george.spearce.org ([209.20.77.23]:38759 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbYGMBPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 21:15:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 36B56382A6; Sun, 13 Jul 2008 01:15:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807121546590.8950@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88279>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 12 Jul 2008, Stephan Hennig wrote:
> > 
> > Thanks for having a look at this!  What does "problem with the pack" 
> > mean?  Do you think it is a Git problem (client or server side?) or just 
> > a misconfiguration?
> 
> I thought that the blobs in the pack are just too similar.  That makes for 
> a good compression, since you get many relatively small deltas.  But it 
> also makes for a lot of work to reconstruct the blobs.
> 
> I suspected that you run out of space for the cache holding some 
> reconstructed blobs (to prevent reconstructing all of them from scratch).
...
> Whoa. As you can see, your puny little 3.3 megabyte pack is blown to a 
> full 555 megabyte in RAM.
...
> I expect this to touch the resolve_delta() function of index-pack.c in a 
> major way, though.

Yea, that's going to be ugly.  The "cache" you speak of above is held
on the call stack as resolv_delta() recurses through the delta chain
to reconstruct objects and generate their SHA-1s.  There isn't a way to
release these objects when memory gets low so your worst case scenario
is a 100M+ blob with a delta chain of 50 or more - that will take you
5G of memory to pass through index-pack.

jgit isn't any better here.

What we need to do is maintain a list of the objects we are holding
on the call stack, and reduce ones up near the top when memory
gets low.  Then upon recursing back up we can just recreate the
object if we had to throw it out.  The higher up on the stack the
object is, the less likely we are to need it in the near future.

The more that I think about this, the easier it sounds to implement.
I may try to look at it a little later this evening.
 
> P.S.: It seems that "git verify-pack -v" only shows the sizes of the 
> deltas.  Might be interesting to some to show the unpacked _full_ size, 
> too.

It wouldn't be very difficult to get that unpacked size.  We just have
to deflate enough of the delta to see the delta header and obtain the
inflated object size from that.  Unfortunately there is not an API in
sha1_file.c to offer that information to callers.

-- 
Shawn.
