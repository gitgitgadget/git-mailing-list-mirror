From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 13:26:14 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808131304560.4352@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <20080811030444.GC27195@spearce.org>
 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
 <87vdy71i6w.fsf@basil.nowhere.org>
 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
 <3E057C8D-FF72-47A2-BBA8-27A22AD67167@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:27:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTK84-000399-R2
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 19:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbYHMR0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 13:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbYHMR0V
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 13:26:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8231 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbYHMR0V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 13:26:21 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5J00GFLV3QIJ75@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 13 Aug 2008 13:26:15 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <3E057C8D-FF72-47A2-BBA8-27A22AD67167@adacore.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92246>

On Wed, 13 Aug 2008, Geert Bosch wrote:

> On Aug 13, 2008, at 10:35, Nicolas Pitre wrote:
> > On Tue, 12 Aug 2008, Geert Bosch wrote:
> > 
> > > I've always felt that keeping largish objects (say anything >1MB)
> > > loose makes perfect sense. These objects are accessed infrequently,
> > > often binary or otherwise poor candidates for the delta algorithm.
> > 
> > Or, as I suggested in the past, they can be grouped into a separate
> > pack, or even occupy a pack of their own.
> 
> This is fine, as long as we're not trying to create deltas
> of the large objects, or do other things that requires keeping
> the inflated data in memory.

First, there is the delta attribute:

|commit a74db82e15cd8a2c53a4a83e9a36dc7bf7a4c750
|Author: Junio C Hamano <junkio@cox.net>
|Date:   Sat May 19 00:39:31 2007 -0700
|
|    Teach "delta" attribute to pack-objects.
|
|    This teaches pack-objects to use .gitattributes mechanism so
|    that the user can specify certain blobs are not worth spending
|    CPU cycles to attempt deltification.
|
|    The name of the attrbute is "delta", and when it is set to
|    false, like this:
|
|        == .gitattributes ==
|        *.jpg   -delta
|
|    they are always stored in the plain-compressed base object
|    representation.

This could probably be extended to take a size limit argument as well.

> > As soon as you have more than
> > one revision of such largish objects then you lose again by keeping them
> > loose.
> 
> Yes, you lose potentially in terms of disk space, but you avoid the
> large memory footprint during pack generation. For very large blobs,
> it is best to degenerate to having each revision of each file on
> its own (whether we call it a single-file pack, loose object or whatever).
> That way, the large file can stay immutable on disk, and will only
> need to be accessed during checkout. GIT will then scale with good
> performance until we run out of disk space.

Loose objects, though, will always be selected for potential delta 
generation.  Packed objects, deltified or not, are always streamed as is 
when serving pull requests.  And by default delta compression is not 
(re)attempted between objects which are part of the same pack, the 
reason being that if they were not deltified on the first packing 
attempt then there is no point trying again when streaming them over the 
net. So you always benefit from having your large objects packed with 
the rest.  This, plus the delta prevention mechanism above should cover 
most cases.

> > You'll have memory usage issues whenever such objects are accessed,
> > loose or not.
> Why? The only time we'd need to access their contents for checkout
> or when pushing across the network. These should all be steaming operations
> with small memory footprint.

Pushing across the network, or repacking without -f, is streamed.  
Checking out currently isn't (although it probably could).  Repacking 
with -f definitely isn't and probably shouldn't because of complexity 
issues.

> > However, once those big objects are packed once, they can
> > be repacked (or streamed over the net) without really "accessing" them.
> > Packed object data is simply copied into a new pack in that case which
> > is less of an issue on memory usage, irrespective of the original pack
> > size.
> Agreed, but still, at least very large objects. If I have a 600MB
> file in my repository, it should just not get in the way. If it gets
> copied around during each repack, that just wastes I/O time for no
> good reason. Even worse, it causes incremental backups or filesystem
> checkpoints to become way more expensive. Just leaving large files
> alone as immutable objects on disk avoids all these issues.

Pack them in a pack of their own and stick a .keep file along with it.  
At that point they will never be rewritten.


Nicolas
