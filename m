From: Nicolas Pitre <nico@cam.org>
Subject: Re: Delitifier broken (Re: diff-core segfault)
Date: Mon, 12 Dec 2005 21:45:16 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512122114090.26663@localhost.localdomain>
References: <1134404990.5928.4.camel@localhost.localdomain>
 <7vmzj6i206.fsf@assigned-by-dhcp.cox.net>
 <7virtui1kj.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512121620380.26663@localhost.localdomain>
 <7vek4igevq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512121529200.15597@g5.osdl.org>
 <7vlkypdcsb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512121720150.15597@g5.osdl.org>
 <Pine.LNX.4.64.0512121758410.15597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 03:48:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Em0B2-0002Wm-RY
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 03:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVLMCpT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 21:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVLMCpT
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 21:45:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49813 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751183AbVLMCpR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 21:45:17 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IRF00E4N0ZGEI10@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 Dec 2005 21:45:16 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0512121758410.15597@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13564>

On Mon, 12 Dec 2005, Linus Torvalds wrote:

> 
> 
> On Mon, 12 Dec 2005, Linus Torvalds wrote:
> > 
> >    As mentioned, pack-objects.c needs to check the size heuristics before 
> >    doing diff_delta() _anyway_, for performance reasons as well as simply 
> >    because the secondary use of diff_delta() is to estimate how big the 
> >    delta is, and it's always pointless to generate a delta that is 
> >    guaranteed to be bigger than the file (which is always the case with 
> >    either side being an empty file - the size difference will inevitably 
> >    be bigger than the size of the resulting file).
> 
> Side note: this isn't technically entirely true. A binary diff that has a 
> source file that is empty could in theory be smaller than the destination 
> file simply because it may involve a certain amount of automatic 
> compression in the form of "insert 100 spaces" kind of diff encoding. I'm 
> not sure whether xdelta actually does something like that, but it's 
> certainly possible at least in theory.

xdelta doesn't.  It only has two functions currently:

 1) copy x bytes from offset y in source file to current position in 
    destination file;

 2) paste the x following bytes straight from the delta stream to 
    current position into the destination file.

Of course in the GIT context files are buffers.

However I added the possibility for (1) to use the destination file as 
well as the "source" file for block copy in patch_delta().  However 
diff_delta() currently doesn't use that capability.  But if it did then 
the "insert 100 spaces" would be:

	- paste \x20\x20\x20\x20 to dest
	  (delta = 5 bytes, dest = 4 bytes)

	- copy 4 bytes from offset 0 of dest to dest
	  (delta = 7 bytes, dest = 8 bytes)

	- copy 8 bytes from offset 0 of dest to dest
	  (delta = 9 bytes, dest = 16 bytes)

	- copy 16 bytes from offset 0 of dest to dest
	  (delta = 11 bytes, dest = 32 bytes)

	- copy 32 bytes from offset 0 of dest to dest
	  (delta = 13 bytes, dest = 64 bytes)

	- copy 36 bytes from offset 0 of dest to dest
	  (delta = 15 bytes, dest = 100 bytes)

And yet that could be optimized further with a better size for the 
initial paste.  However adding that capability to diff_delta() might 
make it significantly slower for still unknown gain for real life data.  
But I should write the code some day.


Nicolas
