From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Mon, 11 Feb 2008 15:41:06 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802111513360.2732@xanadu.home>
References: <20080210175812.GB12162@auto.tuwien.ac.at>
 <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802101929310.2732@xanadu.home>
 <20080211195623.GA21878@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 11 21:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOfTK-0004lG-3Z
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 21:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbYBKUlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 15:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbYBKUlJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 15:41:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57118 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbYBKUlH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 15:41:07 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW3004XRDGIHS30@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Feb 2008 15:41:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080211195623.GA21878@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73580>

On Mon, 11 Feb 2008, Martin Koegler wrote:

> On Sun, Feb 10, 2008 at 07:33:34PM -0500, Nicolas Pitre wrote:
> > On Sun, 10 Feb 2008, Junio C Hamano wrote:
> > 
> > > mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
> > > 
> > > > This patch adds a cache to keep the object data in memory. The delta
> > > > resolving code must also search in the cache.
> > > 
> > > I have to wonder what the memory pressure in real-life usage
> > > will be like.
> 
> > FWIW, I don't like this idea.
> >
> > I'm struggling to find ways to improve performances of 
> > pack-objects/index-pack with those large repositories that are becoming 
> > more common (i.e. GCC, OOO, Mozilla, etc.)  Anything that increase 
> > memory usage isn't very welcome IMHO.
> 
> Maybe I have missed something, but all repack problems reported on the
> git mailing list happen durring the deltifing phase. The problematic
> files are mostly bigger blobs. I'm aware of these problems, so my
> patch does not keep any blobs in memory.

This is not only repack, which is something that few people should run 
anyway.

It is also index-pack which takes an awful amount of time on the OOO 
repo (much less than the repack but still), and that's something that is 
visible to anyone cloning it.

So the comparison with pack-objects is useless.  In absolute terms, 
index-pack has to inprove, not regress.

> So my conclusion is, that the memory usage of index-pack with --strict
> should not be too worse compared to pack-objects.

Well, the comparison is flawed anyway.  Agressively repacking the OOO 
repo is reported to take around 14 GB of RAM if not bounded, whereas 
index-pack remained around 300MB.  But the buffer cache managed by the 
kernel is also a big performance factor and anything that requires more 
memory in user space will affect that cache.

Then remember that this repo has 2411764 objects.

> Please remember, that --strict is used for pushing data.

And what exactly does it provide in terms of safetiness that index-pack 
doesn't already do?  I'm not sure I fully understood the goal here.


Nicolas
