From: Nicolas Pitre <nico@cam.org>
Subject: Re: index-pack died on pread
Date: Fri, 27 Jul 2007 09:38:44 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707270913270.3484@xanadu.home>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
 <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org>
 <200707260115.13234.robin.rosenberg.lists@dewire.com>
 <alpine.LFD.0.999.0707251636490.3607@woody.linux-foundation.org>
 <81b0412b0707260542o58fcb73bu81ae09aa1df84c81@mail.gmail.com>
 <alpine.LFD.0.999.0707260911040.3442@woody.linux-foundation.org>
 <7vps2e5x4y.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0707262231280.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Michal Rokos <michal.rokos@gmail.com>,
	GIT <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 15:39:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEQ26-0007rL-BJ
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 15:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbXG0Ni7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 09:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbXG0Ni7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 09:38:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35856 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbXG0Ni6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 09:38:58 -0400
Received: from localhost ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JLU0003NB8NNJ20@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 27 Jul 2007 09:38:54 -0400 (EDT)
In-reply-to: <alpine.LFD.0.999.0707262231280.3442@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53926>

On Thu, 26 Jul 2007, Linus Torvalds wrote:

> 
> 
> On Thu, 26 Jul 2007, Junio C Hamano wrote:
> > 
> > If you mean the offset associated with fd, we actually do.
> 
> Ahh, for some reason I thought we didn't (probably because the user likely 
> doesn't care at all), but right you are..

The (only) user in Git does care indeed.  The sequence of events goes 
like this:

 - Receive pack from remote location, parsing objects along and writing
   a copy to the local pack file, as well as computing the SHA1 of non
   delta objects.

 - When all objects are parsed, the received pack SHA1 is verified.  
   If SHA1 doesn't match due to corruption in received data then everything 
   stops here with a "pack is corrupted (SHA1 mismatch)" error.

 - For each received deltas: resolve those deltas to compute their 
   object SHA1.  This is where pread() is involved on the local pack 
   file. If pread() fails to return proper data then the data won't 
   inflate properly and everything stops here with a "serious inflate 
   inconsistency" error.

 - [OPTIONAL] Complete a thin pack with missing base objects for deltas 
   that weren't resolved yet.  This involves pread() again, but it 
   _also_ append data to the same local pack file in the process.  In 
   this case it is important that pread() restores the file position 
   when it returns or the appended objects won't be written where they 
   should.  

   This is optional because a thin pack is not received all the time, 
   not on a clone for example.

 - Write trailing SHA1 to the local pack before moving it to its final 
   location.  This also relies on pread() restoring the file position on 
   the local pack file or the trailing pack SHA1 won't be written where 
   it should.

So if pread() doesn't properly restore the file position then local pack 
corruption will occur and the pack will be unusable.  If pread() doesn't 
properly read the asked data then index-pack will die.

> It really isn't that complex a system call. So I'm surprised at bugs 
> there, and that makes me worry that there is something in git that 
> triggers this.

Well, we have usage cases for a real pread() as well as our own 
emulation which work.  And the emulated pread() works in all cases so 
far, so...


Nicolas
