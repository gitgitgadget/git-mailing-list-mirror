From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull is slow
Date: Sun, 13 Jul 2008 15:59:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807131555560.4816@eeepc-johanness>
References: <g5570s$d5m$1@ger.gmane.org> <g57jkp$ekm$1@ger.gmane.org> <48776169.20705@op5.se> <alpine.DEB.1.00.0807111443280.8950@racer> <4878A442.6020405@arcor.de> <alpine.DEB.1.00.0807121546590.8950@racer> <20080713011512.GB31050@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Hennig <mailing_list@arcor.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 15:59:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI26v-0002ZZ-0V
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 15:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbYGMN6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 09:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbYGMN6f
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 09:58:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:35501 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753296AbYGMN6e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 09:58:34 -0400
Received: (qmail invoked by alias); 13 Jul 2008 13:58:32 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp007) with SMTP; 13 Jul 2008 15:58:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TDkRThx+TaveGAAyzQHZbr30A99zG6EbLg9Imj5
	+WBJceVlWc+A83
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080713011512.GB31050@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88314>

Hi,

On Sun, 13 Jul 2008, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sat, 12 Jul 2008, Stephan Hennig wrote:
> > > 
> > > Thanks for having a look at this!  What does "problem with the pack" 
> > > mean?  Do you think it is a Git problem (client or server side?) or just 
> > > a misconfiguration?
> > 
> > I thought that the blobs in the pack are just too similar.  That makes for 
> > a good compression, since you get many relatively small deltas.  But it 
> > also makes for a lot of work to reconstruct the blobs.
> > 
> > I suspected that you run out of space for the cache holding some 
> > reconstructed blobs (to prevent reconstructing all of them from scratch).
> ...
> > Whoa. As you can see, your puny little 3.3 megabyte pack is blown to a 
> > full 555 megabyte in RAM.
> ...
> > I expect this to touch the resolve_delta() function of index-pack.c in a 
> > major way, though.
> 
> Yea, that's going to be ugly.  The "cache" you speak of above is held on 
> the call stack as resolv_delta() recurses through the delta chain to 
> reconstruct objects and generate their SHA-1s.  There isn't a way to 
> release these objects when memory gets low so your worst case scenario 
> is a 100M+ blob with a delta chain of 50 or more - that will take you 5G 
> of memory to pass through index-pack.

Actually, there is...

You would only need to tap into the "release_pack_memory()" mechanism, 
adding a sort of a "smart pointer" that knows how to reconstruct its 
contents.

Ciao,
Dscho
