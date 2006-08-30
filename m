From: Nicolas Pitre <nico@cam.org>
Subject: Re: Mozilla .git tree
Date: Wed, 30 Aug 2006 01:53:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608300124550.9796@xanadu.home>
References: <20060829165811.GB21729@spearce.org>
 <9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com>
 <20060829175819.GE21729@spearce.org>
 <9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
 <20060829190548.GK21729@spearce.org>
 <9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
 <20060829232007.GC22935@spearce.org>
 <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
 <20060830015122.GE22935@spearce.org>
 <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
 <20060830031029.GA23967@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 30 07:53:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIJ1N-0004Z8-Jz
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 07:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWH3Fxu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 01:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWH3Fxu
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 01:53:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10685 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750815AbWH3Fxt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Aug 2006 01:53:49 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4S007TKR1ORS50@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 30 Aug 2006 01:53:48 -0400 (EDT)
In-reply-to: <20060830031029.GA23967@spearce.org>
X-X-Sender: nico@xanadu.home
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26224>

On Tue, 29 Aug 2006, Shawn Pearce wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > The git tools can be modified to set the compression level to 0 before
> > compressing tree deltas. There is no need to change the decoding code.
> > Even with compression level 0 they still get slightly larger because
> > zlib tacks on a header.
> 
> See my followup email to myself; I think we're talking a zlib
> overhead of 9.2 bytes on average per tree delta.  That's with a
> compression level of -1 (default, which is 6).

In fact, the bulk of a tree delta is most likely to contain the 
literal sha1 of one or more directory entries that changed, and this is 
hardly compressible.  There is nothing to gain by forcing zlib level to 
0 for tree deltas since it never makes the deflated stream smaller from 
the tests I've performed in the past.  It seems that zlib is smart 
enough not to attempt any compression when there is no gain.  That 
leaves the zlib header as the only overhead.

And the zlib header contains a CRC which we're about to use for 
validating the data when doing delta data reuse in order to prevent pack 
corruption propagation like the one recently posted on the list.  
Without that a pack corruption (from a bad disk sector for example) is 
likely to go unnoticed when doing a repack.  The data could be validated 
by expanding deltas and verifying the sha1 on the end result but this is 
a really expensive operation if performed on all deltas which is best 
left to git-fsck-objects --full. So I think the small overhead relative 
to total pack size might be worth it for better data integrity.

Using an offset instead of a sha1 to reference a delta base object is 
certainly a good idea though.  But I'd use the same variable encoding as 
the object size to avoid the 32-bit limit issue.  When generating a thin 
pack the real sha1 of the delta object could be substituted for the 
offset quite easily if the base object is not sent a part of the same 
pack.


Nicolas
