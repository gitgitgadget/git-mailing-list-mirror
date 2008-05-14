From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Tue, 13 May 2008 21:03:31 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805132005550.23581@xanadu.home>
References: <20080512122900.GA13050@mithlond.arda.local>
 <20080512155243.GA3592@mithlond.arda.local>
 <alpine.DEB.1.00.0805121810501.30431@racer>
 <20080512184334.GB5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
 <20080512190946.GC5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
 <20080512202414.GA8620@mithlond.arda.local>
 <20080512210304.GA17352@glandium.org> <20080512210807.GA22221@glandium.org>
 <20080513001252.GB29038@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Mike Hommey <mh@glandium.org>, Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 14 03:05:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw5QQ-0002Tp-Ki
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 03:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760482AbYENBEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 21:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760272AbYENBEH
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 21:04:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34297 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759917AbYENBEF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 21:04:05 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0U00J4F2XV8JH0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 13 May 2008 21:03:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080513001252.GB29038@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82057>

On Mon, 12 May 2008, Shawn O. Pearce wrote:

> Mike Hommey <mh@glandium.org> wrote:
> > On Mon, May 12, 2008 at 11:03:04PM +0200, Mike Hommey wrote:
> > > On Mon, May 12, 2008 at 11:24:14PM +0300, Teemu Likonen wrote:
> > > > But I have experienced the same earlier with some other post-1.5.5
> > > > version so I believe you can reproduce this yourself. After cloning
> > > > Linus's linux-2.6 repo its .git directory weights 209MB. After single
> > > > "git pull" and "git gc" it was 298MB in my test.
> > > 
> > > I noticed that a while ago: when repacking multiple packs when one has a
> > > .keep file, the resulting additional pack contains too many blobs and
> > > trees, contrary to when only packing loose objects:
> > (...)
> > 
> > That is, it seems to also contain all the blobs and subtrees for all the
> > commits the pack contains, even when they already are in the pack having
> > a .keep file.
> 
> I've noticed this too.  Like since day 1 when we added .keep.
> But uh, nobody else complained and I forgot about it.

Well, now that I've reproduced Teemu Likonen's test case, I can confirm 
this is actually a problem.  Here I get:

|remote: Counting objects: 523, done.
|remote: Compressing objects: 100% (57/57), done.
|remote: Total 362 (delta 305), reused 362 (delta 305)
|Receiving objects: 100% (362/362), 65.37 KiB, done.
|Resolving deltas: 100% (305/305), completed with 105 local objects.
|From ../test1
|   492c2e4..9404ef0  master     -> master

The received pack is 449135 bytes large.  This is much larger than the 
actually received data which is 65.37 KiB, but we're completing a thin 
pack with 105 undeltified objects accounting for the size increase which 
is expected.  So far so good.

Now, in theory, running 'git gc' should only repack those 362 + 105 
objects, since the remaining ones are all found in the .keep flagged 
pack.  But that's not what's happening at all:

|Counting objects: 26559, done.
|Compressing objects: 100% (24708/24708), done.
|Writing objects: 100% (26559/26559), done.
|Total 26559 (delta 3054), reused 14011 (delta 1613)

So... there is something definitively wrong here.  The expectation was 
to get a pack in the same size range as the one received during the 
pack, or somewhat smaller due to a better delta compression of the added 
objects.  But instead we get a pack containing  26559 objects!!!  And in 
that lot, only 3054 (11%) are deltas.  That makes for a pack that 
started from 449135 bytes and grew to 72395940 bytes.

> My theory (totally unproven) is that the new pack has objects we
> copied from the .keep pack, because those objects were the best
> delta-bases for the loose objects we have deltafied and want to
> store in the new pack.  Except they aren't yet packed in the new
> pack, so we pack them too.  Tada, duplicates.  :-\

Well, not exactly.

Let's see what happens here even before any packing is attempted

|$ git rev-list --objects 492c2e4..9404ef0
|362
|
|$ git rev-list --objects --all \
|   --unpacked=pack-6a3438b2702be06697023d80b77e67a73a0b0b5c.pack |
|	wc -l
|26559

So this --unpacked= argument (which undocumented semantics I still have 
issues with) is certainly not doing what is expected.


Nicolas
