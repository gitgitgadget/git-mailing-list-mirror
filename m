From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 08:50:16 -0700
Message-ID: <20080813155016.GD3782@spearce.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com> <alpine.LFD.1.10.0808131024460.4352@xanadu.home> <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geert Bosch <bosch@adacore.com>, Andi Kleen <andi@firstfloor.org>,
	Ken Pratt <ken@kenpratt.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 17:51:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTId7-0003za-GM
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 17:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbYHMPuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 11:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbYHMPuS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 11:50:18 -0400
Received: from george.spearce.org ([209.20.77.23]:49062 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbYHMPuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 11:50:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4B53938375; Wed, 13 Aug 2008 15:50:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808131123221.4352@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92233>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 13 Aug 2008, Shawn O. Pearce wrote:
> > 
> > Where little memory systems get into trouble with already packed
> > repositories is enumerating the objects to include in the pack.
> 
> I'm counting something like 104 bytes on a 64-bit machine for
> struct object_entry.

Don't forget that we need not just struct object_entry, but
also the struct commit/tree/blob, their hash tables, and the
struct object_entry* in the sorted object list table, and
the pack reverse index table.  It does add up.
 
> > Have 500k objects and its suddenly something quite real in terms
> > of memory usage.
> 
> Well, we are talking about 50MB which is not that bad.

I think we're closer to 100MB here due to the extra overheads
I just alluded to above, and which weren't in your 104 byte
per object figure.

> However there is a point where we should be realistic and just admit 
> that you need a sufficiently big machine if you have huge repositories 
> to deal with.  Git should be fine serving pull requests with relatively 
> little memory usage, but anything else such as the initial repack simply 
> require enough RAM to be effective.

Yea.  But it would also be nice to be able to just concat packs
together.  Especially if the repository in question is an open source
one and everything published is already known to be in the wild,
as say it is also available over dumb HTTP.  Yea, I know people
like the 'security feature' of the packer not including objects
which aren't reachable.

But how many times has Linus published something to his linux-2.6
tree that he didn't mean to publish and had to rewind?  I think
that may be "never".  Yet how many times per day does his tree get
cloned from scratch?

This is also true for many internal corporate repositories.
Users probably have full read access to the object database anyway,
and maybe even have direct write access to it.  Doing the object
enumeration there is pointless as a security measure.

I'm too busy to write a pack concat implementation proposal, so
I'll just shutup now.  But it wouldn't be hard if someone wanted
to improve at least the initial clone serving case.

-- 
Shawn.
