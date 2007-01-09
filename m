From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: I just pulled and built 'next'...
Date: Mon, 8 Jan 2007 22:21:24 -0500
Message-ID: <20070109032124.GA1904@spearce.org>
References: <E1H3uc2-0004m1-Ua@think.thunk.org> <7vvejhwa6g.fsf@assigned-by-dhcp.cox.net> <20070108210002.GA15121@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 04:21:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H47YM-0006ia-E8
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 04:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbXAIDVb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 22:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbXAIDVb
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 22:21:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48166 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbXAIDVa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 22:21:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H47Y4-0007f0-3m; Mon, 08 Jan 2007 22:21:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 49A9020FBAE; Mon,  8 Jan 2007 22:21:25 -0500 (EST)
To: Theodore Tso <tytso@mit.edu>
Content-Disposition: inline
In-Reply-To: <20070108210002.GA15121@thunk.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36300>

Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Jan 08, 2007 at 12:11:35PM -0800, Junio C Hamano wrote:
> > One question is how you would sort the result.  If you sort them
> > by taggerdate, you would get v1.4.4.4 anyway ;-).
> 
> I was assuming either lexigraphically, or via some really complicated
> rpm/dpkg version number comparison scheme.  :-)
> 
> > If we go with topology, we do not necessarily have to find all
> > the tags.  When we hit a commit that is tagged, we can stop the
> > traversal (so after finding v1.5.0-rc0, we do not have to go
> > back along the 'master' lineage to find v1.4.4 tag).  Traversing
> > from the tip of 'master' (or 'next') this way we will notice
> > that v1.5.0-rc0 and v1.4.4.4 are the candidates without going
> > any further in the past.
> > 
> > But the question still remains which one between the two to
> > pick.
> 
> Yeah, that is the question.  If we're willing to look at the tag name,
> it's pretty clear that if both v1.5.0-rc0 and v1.4.4.4 is reachable
> from the head, it should be based on the "newer" version, i.e.,
> v1.5.0-rc0.  A human can figure this out easily, but algorithimically
> we end up having to use something like the rpm or dpkg version
> comparison algorithm, both of which are hueristics that will sometimes
> get thigns wrong.

  $ git rev-list v1.5.0-rc0..next | wc -l
  687
  $ git rev-list v1.4.4.4..next | wc -l
  1051

So what about doing Junio's suggestion of going by topology and
coming up with the possible set of tags (v1.5.0-rc0 and v1.4.4.4
right now), and if more than one is found compute the number of
commits between each tag and the requested revision, and take the
tag that has a smallest number of commits?

I think it would come up right more often than not and avoids
any sort of tag name parsing algorithm.  It is also somewhat
explainable to users as it does have some common sense: the tag
"nearest" to the requested revision is the one that has the most
number of commits in common with the requested revision.

-- 
Shawn.
