From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Tue, 12 Feb 2008 15:22:17 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802121507310.2732@xanadu.home>
References: <20080210175812.GB12162@auto.tuwien.ac.at>
 <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802101929310.2732@xanadu.home>
 <20080211195623.GA21878@auto.tuwien.ac.at>
 <alpine.LFD.1.00.0802111513360.2732@xanadu.home>
 <20080211215806.GA24971@auto.tuwien.ac.at>
 <alpine.LFD.1.00.0802120937330.2732@xanadu.home>
 <20080212190411.GA23837@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Feb 12 21:22:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP1ea-00066s-Bd
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 21:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbYBLUWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 15:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbYBLUWU
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 15:22:20 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33321 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbYBLUWU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 15:22:20 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW5006N1795A2D0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Feb 2008 15:22:18 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080212190411.GA23837@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73687>

On Tue, 12 Feb 2008, Martin Koegler wrote:

> On Tue, Feb 12, 2008 at 11:02:06AM -0500, Nicolas Pitre wrote:
> > I think this is a good idea to always have some sanity checks on any 
> > incoming objects so to make sure they're well formed and valid before 
> > giving them a SHA1 value, and bail out as soon as any error is found.  
> > From my understanding that's what your patch is doing, right? (sorry I 
> > can't find them in my mailbox anymore). 
> 
> Yes. (=>http://marc.info/?l=git&m=120266631524947&w=2)
> 
> >  This can be done as objects are 
> > coming in just fine and requires no extra memory, and I would say this 
> > should be done unconditionally all the time.  After all, the Git 
> > coherency model is based on the SHA1 checksuming, and therefore it is a 
> > good idea to never validate any malformed objects with a SHA1.  So I'm 
> > all in favor of such validation always performed in index-pack and 
> > unpack-objects.
> 
> We will need some additional memory for struct blob/tree/tag/commit
> even for this check.

Why so?

Each received object is stored in memory when received, so why can't you 
simply validate it in place?  No need to keep trace of them afterward.

> > As to making sure those objects are well connected... well this is a 
> > technically different issue entirely, and I wonder if a special mode to 
> > fsck might not be a better solution.  For example, fsck could be made to 
> > validate object connectivity, starting from the new ref(s), and stopping 
> > object walking as soon as a reference to an object not included in the 
> > newly received pack is encountered.  This could be run from some hook to 
> > decide whether or not to update the new refs, and to delete the pack 
> > otherwise.
> 
> Do you really think, that this will need less memory? fsck loads first
> all objects and then verifies their connections.

Not all objects otherwise I wouldn't even be able to run it.

My point is that you can have fsck load only objects contained in the 
received pack (you can use the pack index to load them) and assume 
connectivity is good whenever an object in the pack reference an 
existing object outside of the pack.  At least this doesn't need to 
happen in parallel with pack indexing.


Nicolas
