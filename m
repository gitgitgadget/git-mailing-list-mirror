From: Nicolas Pitre <nico@cam.org>
Subject: Re: [JGIT PATCH] Improve the sideband progress scaper to be more
 accurate
Date: Tue, 06 Jan 2009 15:55:23 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901061546460.26118@xanadu.home>
References: <1230055423-9944-1-git-send-email-spearce@spearce.org>
 <20081231073505.GA22551@spearce.org> <20081231190401.GI29071@spearce.org>
 <200901032312.53148.robin.rosenberg@dewire.com>
 <alpine.LFD.2.00.0901061343000.26118@xanadu.home>
 <20090106192747.GD24578@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 21:57:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKIys-0008Jy-Af
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 21:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbZAFUza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 15:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbZAFUza
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 15:55:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64138 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbZAFUz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 15:55:29 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KD2003MDI4BAY00@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Jan 2009 15:55:24 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090106192747.GD24578@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104726>

On Tue, 6 Jan 2009, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > There may indeed be line fragments sent over the sideband channel, as 
> > well as the opposite which is multiple lines sent at once in a single 
> > packet.  If you look at sideband.c you'll find about all those cases.
> 
> Thanks, that's what I thought...
>  
> > In general, what you have to do is:
> > 
> >  - for each packet:
> >    - split into multiple chunks on line breaks ('\r' or '\n')
> >    - for each chunk:
> >      - if last chunk didn't end with a line break, or if current 
> >        chunk is empty or only contains a line break, then skip printing 
> >        the "remote:" prefix.  Otherwise print it.
> >      - print the current chunk up to any line break
> >      - if current chunk contains a line break and other characters then
> >        print a sequence to clear the remaining of the screen line
> >      - print the line break if any
> 
> Hmm.  I should note that C Git still screws this up sometimes.  I've
> seen 1.6.1 git fetch mess up the output from repo.or.cz's sideband.
> I'm sure Pasky isn't running JGit's daemon, its too damn fast. :-)
> 
> I don't have a spew of it handy, but late last week I saw it screw
> up while doing a clone off repo.or.cz.

Next time you see such things please send me a snapshot.

What is still possible and IMHO not worth the effort to fix is some 
interaction between local and remote displays which, if intermixed in 
some unlucky way, do screw up the final appearance.  For example, if the 
remote has sent a partial line, and before the remaining of it is 
received/printed you actually have some local process also displaying a 
line of its own.  If that was to become a real issue, then the fix would 
involve caching any partial line sent from the remote until the 
associated line break is received.


Nicolas
