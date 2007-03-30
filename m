From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Packing large repositories
Date: Fri, 30 Mar 2007 02:23:25 -0400
Message-ID: <20070330062324.GU13247@spearce.org>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com> <Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 08:23:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXAWb-0001Iz-HO
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 08:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbXC3GXb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 02:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbXC3GXb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 02:23:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58400 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbXC3GXa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 02:23:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HXAWE-0006Z7-Od; Fri, 30 Mar 2007 02:23:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6AAE920FBAE; Fri, 30 Mar 2007 02:23:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43496>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 28 Mar 2007, Dana How wrote:
> > Of course this is unusable, since object_entry's in an .idx
> > file have only 32 bits in their offset fields.  I conclude that
> > for such large projects,  git-repack/git-pack-objects would need
> > new options to control maximum packfile size.
> 
> Either that, or update the index file format. I think that your approach 
> of having a size limiter is actually the *better* one, though. 

Nico and I were hoping we could push the index file format change back
until pack v4 was also worthy of merging.  So I had also started work
on an index-pack splitter:

  URL:    git://repo.or.cz/git/fastimport.git
  Branch: sp/splitpack
 
Its far from complete.

> Well, it does affect fetching, in that "git index-pack" obviously would 
> also need to be taught how to split the resulting indexed packs up into 
> multiple smaller ones from one large incoming one. But that shouldn't be 
> fundamentally hard either, apart from the inconvenience of having to 
> rewrite the object count in the pack headers..

We already do this if its a thin-pack that is being made non-thin.
So its annoying, yea, but we already have one toe in that particular
pond...
 
> To avoid that issue, it may be that it's actually better to split things 
> up at pack-generation time *even* for the case of --stdout

This is actually a pretty good idea.  index-pack knows when the end
of its current packfile is; if there are 12 more bytes available in
the input stream and it looks like another pack header then it can
just restart itself over again with that next pack.  This is actually
a pretty small change in index-pack, certainly a lot less intrusive
than what I was trying to do in my sp/splitpack topic above.
 
-- 
Shawn.
