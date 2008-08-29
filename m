From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 0/3] don't let disk corruptions escape pack SHA1 checksum
Date: Thu, 28 Aug 2008 22:05:56 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808282142490.1624@xanadu.home>
References: <20080825164602.GA2213@fieldses.org>
 <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org>
 <20080825213104.GI2213@fieldses.org>
 <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org>
 <20080825221321.GL2213@fieldses.org>
 <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org>
 <48B46B04.70102@gmail.com> <48B46F46.9090302@gmail.com>
 <alpine.LFD.1.10.0808270937340.3363@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808271458320.1624@xanadu.home>
 <alpine.LFD.1.10.0808271222250.3363@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808271627540.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 04:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYtPV-0004BH-Ia
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 04:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbYH2CGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 22:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbYH2CGe
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 22:06:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56621 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbYH2CGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 22:06:34 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6C001WLB51RCA0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Aug 2008 22:05:26 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0808271627540.1624@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94242>

On Wed, 27 Aug 2008, Nicolas Pitre wrote:

> On Wed, 27 Aug 2008, Linus Torvalds wrote:
> 
> > However, we do have this odd case of fixing up the pack after-the-fact 
> > when we receive it from somebody else (because we get a thin pack and 
> > don't know how many objects the final result will have). And that case 
> > seems to be not as safe, because it
> > 
> >  - re-reads the file to recompute the SHA1
> > 
> >    This is understandable, and it's fairly ok, but it does mean that there 
> >    is a bigger chance of the SHA1 matching if something has corrupted the 
> >    file in the meantime!
> 
> I think that can be fixed.  When reading the file back, it is possible 
> to compute 2 sha1s: one to compare with the recieved one using original 
> pack header, and the second which would be the final one.  FRom a 
> certain offset, new objects were added, so that first sha1 is validated 
> against the received one and reset, and at the end, it should correspond 
> to the sha1 of added objects that we should compute when writing them.

So here is 3 patches for this in C git (Shawn already did it for jgit).

There are 3 spots where this needs to be plugged: in pack-objects, 
index-pack and fast-import.  I did the first two.

I don't think this is that pertinent in fast-import because:

 - we want fast-import to be fast

 - after fast-import is done, a full repack is typically done which 
   would revalidate everything (maybe fast-import should use index v2 
   with its per object CRC32 though)

But maybe I'm wrong about that. In any case, I am leaving the 
fast-import to someone more knowledgeable about its code than I do.

Nicolas Pitre (3):
      improve reliability of fixup_pack_header_footer()
      pack-objects: use fixup_pack_header_footer()'s validation mode
      index-pack: use fixup_pack_header_footer()'s validation mode


Nicolas
