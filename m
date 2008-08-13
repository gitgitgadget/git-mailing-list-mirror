From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 13:04:03 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <20080811030444.GC27195@spearce.org>
 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
 <87vdy71i6w.fsf@basil.nowhere.org>
 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
 <20080813145944.GB3782@spearce.org>
 <alpine.LFD.1.10.0808131123221.4352@xanadu.home>
 <20080813155016.GD3782@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Geert Bosch <bosch@adacore.com>, Andi Kleen <andi@firstfloor.org>,
	Ken Pratt <ken@kenpratt.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTJmg-0002hW-UT
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 19:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377AbYHMREO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 13:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756217AbYHMREN
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 13:04:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39088 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572AbYHMREM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 13:04:12 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5J0060LU2RQ6W0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 13 Aug 2008 13:04:03 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080813155016.GD3782@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92243>

On Wed, 13 Aug 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > Well, we are talking about 50MB which is not that bad.
> 
> I think we're closer to 100MB here due to the extra overheads
> I just alluded to above, and which weren't in your 104 byte
> per object figure.

Sure.  That should still be workable on a machine with 256MB of RAM.

> > However there is a point where we should be realistic and just admit 
> > that you need a sufficiently big machine if you have huge repositories 
> > to deal with.  Git should be fine serving pull requests with relatively 
> > little memory usage, but anything else such as the initial repack simply 
> > require enough RAM to be effective.
> 
> Yea.  But it would also be nice to be able to just concat packs
> together.  Especially if the repository in question is an open source
> one and everything published is already known to be in the wild,
> as say it is also available over dumb HTTP.  Yea, I know people
> like the 'security feature' of the packer not including objects
> which aren't reachable.

It is not only that, even if it is a point I consider important.  If you 
end up with 10 packs, it is likely that a base object in each of those 
packs could simply be a delta against a single common base object, and 
therefore the amount of data to transfer might be up to 10 times higher 
than necessary.

> But how many times has Linus published something to his linux-2.6
> tree that he didn't mean to publish and had to rewind?  I think
> that may be "never".  Yet how many times per day does his tree get
> cloned from scratch?

That's not a good argument.  Linus is a very disciplined git users, 
probably more than average.  We should not use that example to paper 
over technical issues.

> This is also true for many internal corporate repositories.
> Users probably have full read access to the object database anyway,
> and maybe even have direct write access to it.  Doing the object
> enumeration there is pointless as a security measure.

It is good for network bandwidth efficiency as I mentioned.

> I'm too busy to write a pack concat implementation proposal, so
> I'll just shutup now.  But it wouldn't be hard if someone wanted
> to improve at least the initial clone serving case.

A much better solution would consist of finding just _why_ object 
enumeration is so slow.  This is indeed my biggest grip with git 
performance at the moment.

|nico@xanadu:linux-2.6> time git rev-list --objects --all > /dev/null
|
|real    0m21.742s
|user    0m21.379s
|sys     0m0.360s

That's way too long for 1030198 objects (roughly 48k objects/sec).  And 
it gets even worse with the gcc repository:

|nico@xanadu:gcc> time git rev-list --objects --all > /dev/null
|
|real    1m51.591s
|user    1m50.757s
|sys     0m0.810s

That's for 1267993 objects, or about 11400 objects/sec.

Clearly something is not scaling here.


Nicolas
