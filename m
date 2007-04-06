From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 09/13] drop objects larger than --blob-limit if specified
Date: Thu, 05 Apr 2007 23:20:44 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704052257200.28181@xanadu.home>
References: <56b7f5510704051536s7de9638fs8cd811d580f6a7dc@mail.gmail.com>
 <alpine.LFD.0.98.0704052103410.28181@xanadu.home>
 <56b7f5510704051919v7daac590m6ac52c4fcabd5321@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 05:21:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZf0L-0003xp-UL
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 05:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767514AbXDFDUr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 23:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767516AbXDFDUr
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 23:20:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55225 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767514AbXDFDUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 23:20:45 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG200DNS3YKCKN0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Apr 2007 23:20:44 -0400 (EDT)
In-reply-to: <56b7f5510704051919v7daac590m6ac52c4fcabd5321@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43897>

On Thu, 5 Apr 2007, Dana How wrote:

> On 4/5/07, Nicolas Pitre <nico@cam.org> wrote:
> > I still consider this feature to make no sense.
> 
> Well, suppose I'm packing my 55GB of data into 2GB
> packfiles.  There seemed to be some agreement that
> limiting packfile size was useful.  700MB is another example.
> 
> Now,  suppose there is an object whose packing would
> result in a packfile larger than the limit.  What should we do?

You error out.

> (1) Refuse to run.  This solution means I can't pack my repository.

Exactly.  If you want packs not to be larger than 10MB and you have a 
100MB blob then you are screwed.  Just lift your pack size limit in such 
case.

> (2) Pack the object any way and let the packfile size exceed
>     my specification.  Ignoring a clear preference from the user
>     doesn't seem good.

It is not indeed.

> (3) Pack the object by itself in its own pack. This is better than the
>     previous since I haven't wrapped up any small object in a pack
>     whose size I dont't want to deal with.  The resulting pack is too big,
>     but the original object was also too big so at least I haven't made
>     the problem worse.  But why bother wrapping the object so?
>     I just made the list of packs to look through longer for every access,
>     instead of leaving the big object in the objects/xx directories which
>     are already used to handle exceptions (usually meaning more recent).
>     In my 55GB example, I have 9 jumbo objects, and this solution
>     would more than double the number of packs to step through.
>     Having them randomly placed in 256 subdirectories seems better.

You forget about the case where those jumbo blobs could delta well 
against each other.  That means that one pack could possibly contain 
those 9 objects because 8 of them are tiny deltas against the first big 
one.

> (4) Just leave the jumbo object by itself, unpacked.

Hmmmmm.

> What do you think?

Let's say I wouldn't mind much if it was implemented differently.  The 
objects array is probably the biggest cost in terms of memory usage for 
pack-objects.  When you have 4 milions objects like in the kde repo that 
means each new field you add will cost between 4 to 16 MB of memory.  I 
think this is too big a cost for filtering out a couple big objects once 
in a while.

Instead, I think you should apply the filtering in add_object_entry() 
directly and simply skip adding the unwanted object to the list 
altogether.


Nicolas
