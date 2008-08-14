From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 14:38:28 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808141416540.4352@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <20080811030444.GC27195@spearce.org>
 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
 <87vdy71i6w.fsf@basil.nowhere.org>
 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
 <20080813145944.GB3782@spearce.org>
 <alpine.LFD.1.10.0808131123221.4352@xanadu.home>
 <20080813155016.GD3782@spearce.org>
 <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
 <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 20:39:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KThjf-000305-7Z
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 20:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbYHNSin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 14:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbYHNSin
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 14:38:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25277 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbYHNSim (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 14:38:42 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5L006XIT4B7MJ0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Aug 2008 14:38:36 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92385>

On Thu, 14 Aug 2008, Linus Torvalds wrote:

> 
> 
> On Wed, 13 Aug 2008, Nicolas Pitre wrote:
> > 
> > A much better solution would consist of finding just _why_ object 
> > enumeration is so slow.  This is indeed my biggest grip with git 
> > performance at the moment.
> > 
> > |nico@xanadu:linux-2.6> time git rev-list --objects --all > /dev/null
> > |
> > |real    0m21.742s
> > |user    0m21.379s
> > |sys     0m0.360s
> > 
> > That's way too long for 1030198 objects (roughly 48k objects/sec).
> 
> Why do you think that's horribly slow?

Call it gut feeling.  Or 60% CPU wasted in zlib.

> Doing a rev-list of all objects is a fairly rare operation, but even if 
> you want to clone/repack all of your archives the whole time, please 
> realize that listing objects is _not_ a simple operation. It opens up and 
> parses every single tree in the whole history. That's a _lot_ of data to 
> unpack.

I disagree.  Well, right _now_ it is not a simple operation.  But if you 
remember, I'm one of the co-investigator of the pack v4 format which 
goal is to make history and tree walking much much cheaper, while making 
their packed representation denser too.  Even with early prototypes of 
the format with the overhead of converting objects back into the current 
format on the fly in unpack_entry() the object enumeration was _faster_ 
than current git.

So this might just be what was needed to bring back some incentive 
behind the pack v4 effort.


Nicolas
