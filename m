From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Packfile can't be mapped
Date: Mon, 28 Aug 2006 12:48:55 -0400
Message-ID: <20060828164855.GB22451@spearce.org>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com> <20060828024720.GD24204@spearce.org> <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain> <Pine.LNX.4.64.0608272133390.27779@g5.osdl.org> <20060828060029.GB25285@spearce.org> <Pine.LNX.4.64.0608281026110.3683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 18:49:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHkIW-0006zW-P5
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 18:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWH1QtF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 12:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWH1QtF
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 12:49:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:1774 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751337AbWH1QtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 12:49:04 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GHkI7-0005Ty-Lx; Mon, 28 Aug 2006 12:48:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5531920FB7F; Mon, 28 Aug 2006 12:48:55 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608281026110.3683@localhost.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26166>

Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 28 Aug 2006, Shawn Pearce wrote:
> > Of course the major problem with pack-local, stream global
> > dictionaries is it voids the ability to reuse that zlib'd content
> > from that pack in another pack without wholesale copying the
> > dictionary as well.  This is an issue for servers which want to
> > copy out the pack entry without recompressing it but also want the
> > storage savings from the global dictionaries.
> 
> Why would copying the dictionary as well be a problem?  How large might 
> it be?  Can it be stored deflated itself?

Largest size is like 200 bytes smaller than the window size.  Times 3
as we would want to store 3 dictionaries, though maybe only 2 if the
blob dictionary proves to be worse than not having one at all for a
given project.  Since its just a binary buffer holding bytes which
frequently appear in our compressed objects its easily deflatable;
especially when you consider its primarily storing US-ASCII text.

I was definately planning on the dictionary being deflated in the
pack.

We could alawys use the SHA1 of a dictionary to signal to the client
what dictionary was in use.  If the dictionary itself was treated
like any other SHA1 object then we might be able to transfer the
server's current dictionaries to the client along with everything
else in the same pack if the client doesn't have the necessary
dictionary yet.

-- 
Shawn.
