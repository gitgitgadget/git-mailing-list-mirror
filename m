From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 16:53:57 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031639470.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <7vbqi5w62c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:54:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYq13-0005BH-Rb
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 22:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbXDCUyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 16:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbXDCUyG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 16:54:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45797 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbXDCUyD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 16:54:03 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX00CSAWPXOE10@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 16:53:58 -0400 (EDT)
In-reply-to: <7vbqi5w62c.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43660>

On Tue, 3 Apr 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > That whole "verify no SHA1 hash collision" code is really pretty damn 
> > paranoid. Maybe we shouldn't have it enabled by default.
> >
> > So how about this updated patch? We could certainly make "git pull" imply 
> > "--paranoid" if we want to, but even that is likely pretty unnecessary. 
> > It's not like anybody has ever shown a SHA1 collision, and if the *local* 
> > repository is corrupt (and has an object with the wrong SHA1 - that's what 
> > the testsuite checks for), then it's probably good to get the valid object 
> > from the remote..
> 
> I agree with that reasoning.

For the record, I don't agree.  I stated why in my other email.

> We did not do paranoid in git-pull long after we introduced the .keep 
> thing anyway,

That doesn't make it more "correct".

> so I do not
> think the following patch is even needed, but I am throwing it
> out just for discussion.

1) None of the objects in a pack should exist in the local repo when 
   fetching, meaning that the paranoia code should not be executed 
   normally.

2) Running index-pack on a pack _inside_ a repository is a dubious thing 
   to do with questionable usefulness already.

3) It is unefficient to run pack-objects with --stdout just to feed the 
   result to index-pack afterwards while repack-objects can create the 
   index itself, which is the source of this discussion.
   
4) I invite you to read the commit log for 8685da42561 where the 
   _perception_ of GIT's security is discussed which led to the paranoia 
   check, and sometimes the perception is more valuable than the 
   reality, especially when it is free.

Therefore Linus' patch and this one are working around the wrong issue 
as described in (3) IMHO.

What could be done instead, if really really needed, is to have the 
paranoia test be made conditional on index-pack --stdin instead.  But 
please no bogus extra switches pretty please.


Nicolas
