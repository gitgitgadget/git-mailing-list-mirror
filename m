From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git pull is slow
Date: Sun, 13 Jul 2008 22:11:41 +0000
Message-ID: <20080713221141.GC12708@spearce.org>
References: <g5570s$d5m$1@ger.gmane.org> <g57jkp$ekm$1@ger.gmane.org> <48776169.20705@op5.se> <alpine.DEB.1.00.0807111443280.8950@racer> <4878A442.6020405@arcor.de> <alpine.DEB.1.00.0807121546590.8950@racer> <20080713011512.GB31050@spearce.org> <alpine.DEB.1.00.0807131555560.4816@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephan Hennig <mailing_list@arcor.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 00:12:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI9o8-0003Pl-Aa
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 00:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbYGMWLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 18:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbYGMWLm
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 18:11:42 -0400
Received: from george.spearce.org ([209.20.77.23]:37433 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbYGMWLm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 18:11:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 935963836B; Sun, 13 Jul 2008 22:11:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807131555560.4816@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88351>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 13 Jul 2008, Shawn O. Pearce wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > ...
> > > I expect this to touch the resolve_delta() function of index-pack.c in a 
> > > major way, though.
> > 
> > Yea, that's going to be ugly.  The "cache" you speak of above is held on 
> > the call stack as resolv_delta() recurses through the delta chain to 
> > reconstruct objects and generate their SHA-1s.  There isn't a way to 
> > release these objects when memory gets low so your worst case scenario 
> > is a 100M+ blob with a delta chain of 50 or more - that will take you 5G 
> > of memory to pass through index-pack.
> 
> Actually, there is...
> 
> You would only need to tap into the "release_pack_memory()" mechanism, 
> adding a sort of a "smart pointer" that knows how to reconstruct its 
> contents.

I guess you don't really know how index-pack is organized than.
It is not quite that simple.

I think we want to use the core.deltabasecachelimit parameter inside
of index-pack to limit the size of the cache, but evict based on
the callstack depth.  Objects deeper back in the callstack should
evict before objects closer to the top of the stack.

Reconstruction is a bit complex as we don't have the machinary in
sha1_file.c available to us, as the index is not available, as we
are still in the process of creating the damn thing.

I'm working up a patch series to resolve this.  I'm going to shutup
now and just try to post working code sometime this evening.

-- 
Shawn.
