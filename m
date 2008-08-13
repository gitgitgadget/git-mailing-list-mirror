From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 11:43:38 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808131123221.4352@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <20080811030444.GC27195@spearce.org>
 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
 <87vdy71i6w.fsf@basil.nowhere.org>
 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
 <20080813145944.GB3782@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Geert Bosch <bosch@adacore.com>, Andi Kleen <andi@firstfloor.org>,
	Ken Pratt <ken@kenpratt.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 17:45:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTIX3-0001A5-CO
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 17:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbYHMPoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 11:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbYHMPoA
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 11:44:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11300 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYHMPn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 11:43:59 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5J00FNZQCQC1RA@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 13 Aug 2008 11:43:38 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080813145944.GB3782@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92232>

On Wed, 13 Aug 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > You'll have memory usage issues whenever such objects are accessed, 
> > loose or not.  However, once those big objects are packed once, they can 
> > be repacked (or streamed over the net) without really "accessing" them.  
> > Packed object data is simply copied into a new pack in that case which 
> > is less of an issue on memory usage, irrespective of the original pack 
> > size.
> 
> And fortunately here we actually do stream the objects we have
> chosen to reuse from the pack.  We don't allocate the entire thing
> in memory.  Its probably the only place in all of Git where we can
> handle a 16 GB (after compression) object on a machine with only
> 2 GB of memory and no swap.
> 
> Where little memory systems get into trouble with already packed
> repositories is enumerating the objects to include in the pack.
> This can still blow out their physical memory if the number of
> objects to pack is high enough.  We need something like 160 bytes
> of memory (my own memory is fuzzy on that estimate) per object.

I'm counting something like 104 bytes on a 64-bit machine for
struct object_entry.

> Have 500k objects and its suddenly something quite real in terms
> of memory usage.

Well, we are talking about 50MB which is not that bad.

However there is a point where we should be realistic and just admit 
that you need a sufficiently big machine if you have huge repositories 
to deal with.  Git should be fine serving pull requests with relatively 
little memory usage, but anything else such as the initial repack simply 
require enough RAM to be effective.


Nicolas
