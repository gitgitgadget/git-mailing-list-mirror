From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 20:12:52 -0400
Message-ID: <20080513001252.GB29038@spearce.org>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <alpine.DEB.1.00.0805121810501.30431@racer> <20080512184334.GB5160@mithlond.arda.local> <alpine.LFD.1.10.0805121453250.23581@xanadu.home> <20080512190946.GC5160@mithlond.arda.local> <alpine.LFD.1.10.0805121527550.23581@xanadu.home> <20080512202414.GA8620@mithlond.arda.local> <20080512210304.GA17352@glandium.org> <20080512210807.GA22221@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue May 13 02:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvi9P-0004zB-18
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 02:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147AbYEMANA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 20:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756108AbYEMANA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 20:13:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60514 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068AbYEMANA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 20:13:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jvi8J-0006JD-LA; Mon, 12 May 2008 20:12:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C942F20FBAE; Mon, 12 May 2008 20:12:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080512210807.GA22221@glandium.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81973>

Mike Hommey <mh@glandium.org> wrote:
> On Mon, May 12, 2008 at 11:03:04PM +0200, Mike Hommey wrote:
> > On Mon, May 12, 2008 at 11:24:14PM +0300, Teemu Likonen wrote:
> > > But I have experienced the same earlier with some other post-1.5.5
> > > version so I believe you can reproduce this yourself. After cloning
> > > Linus's linux-2.6 repo its .git directory weights 209MB. After single
> > > "git pull" and "git gc" it was 298MB in my test.
> > 
> > I noticed that a while ago: when repacking multiple packs when one has a
> > .keep file, the resulting additional pack contains too many blobs and
> > trees, contrary to when only packing loose objects:
> (...)
> 
> That is, it seems to also contain all the blobs and subtrees for all the
> commits the pack contains, even when they already are in the pack having
> a .keep file.

I've noticed this too.  Like since day 1 when we added .keep.
But uh, nobody else complained and I forgot about it.

My theory (totally unproven) is that the new pack has objects we
copied from the .keep pack, because those objects were the best
delta-bases for the loose objects we have deltafied and want to
store in the new pack.  Except they aren't yet packed in the new
pack, so we pack them too.  Tada, duplicates.  :-\

Suddenly your repository nearly doubles in size if we have most
files/trees change, as those delta bases are copied whole into the
new pack.

-- 
Shawn.
