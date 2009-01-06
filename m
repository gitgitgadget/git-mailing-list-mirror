From: Nicolas Pitre <nico@cam.org>
Subject: Re: [JGIT PATCH] Improve the sideband progress scaper to be more
 accurate
Date: Tue, 06 Jan 2009 14:23:02 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901061343000.26118@xanadu.home>
References: <1230055423-9944-1-git-send-email-spearce@spearce.org>
 <20081231073505.GA22551@spearce.org> <20081231190401.GI29071@spearce.org>
 <200901032312.53148.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:24:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKHXi-0000uT-44
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 20:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbZAFTXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 14:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbZAFTXW
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 14:23:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32207 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbZAFTXW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 14:23:22 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KD200KBEDT2AKU0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Jan 2009 14:22:14 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200901032312.53148.robin.rosenberg@dewire.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104708>

On Sat, 3 Jan 2009, Robin Rosenberg wrote:

> onsdag 31 december 2008 20:04:01 skrev Shawn O. Pearce:
> > By matching only whole lines we should be able to improve the
> > progress scaper so we avoid ugly output like we had been seeing:
> > 
> >   EGIT.contrib/jgit clone git://repo.or.cz/libgit2.git LIBGIT2
> >   Initialized empty Git repository in /home/me/SW/LIBGIT2/.git
> >   Counting objects:       547
> >   Compressing objects:    100% (192/192)
> >   ts:                     100% (192/192)
> >   Compressing objects:    100% (192/192)
> >   ng objects:             100% (192/192)
> > 
> > Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> > ---
> >  Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> >  > Would it be hard to get the progress look better?
> > 
> >  Maybe this does the trick.  Its hard to reproduce so its hard to
> >  come up with the condition that was giving us the problem before.
> >  I suspect its because we were getting line fragments on the sideband
> >  channel, but I'm not sure that was really the case.
> 
> Nasty. I couldn't reproduce it myself. I'll hold onto this one for a while and
> see if I'll get the opportunity to test it live with this problem.

There may indeed be line fragments sent over the sideband channel, as 
well as the opposite which is multiple lines sent at once in a single 
packet.  If you look at sideband.c you'll find about all those cases.

In general, what you have to do is:

 - for each packet:
   - split into multiple chunks on line breaks ('\r' or '\n')
   - for each chunk:
     - if last chunk didn't end with a line break, or if current 
       chunk is empty or only contains a line break, then skip printing 
       the "remote:" prefix.  Otherwise print it.
     - print the current chunk up to any line break
     - if current chunk contains a line break and other characters then
       print a sequence to clear the remaining of the screen line
     - print the line break if any

That should cover all cases.  Note that the case where a previous chunk 
didn't end with a line break is always seen when moving from one packet 
to another, so that state cannot be local to the inner loop.


Nicolas
