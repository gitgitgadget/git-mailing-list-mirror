From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone sending unneeded objects
Date: Sat, 26 Sep 2009 21:27:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909262059520.4997@xanadu.home>
References: <m2tz0j154o.fsf@igel.home>
 <alpine.LFD.2.00.0908082246020.440@xanadu.home>
 <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com>
 <vpqvdj6izt6.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0909251551290.4997@xanadu.home> <4ABD25FE.2040902@redhat.com>
 <alpine.LFD.2.00.0909251629330.4997@xanadu.home> <4ABD4F7B.4030701@redhat.com>
 <4ABD9C2C.60800@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Hin-Tak Leung <hintak.leung@gmail.com>
To: Jason Merrill <jason@redhat.com>
X-From: git-owner@vger.kernel.org Sun Sep 27 03:28:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MriYX-0006Y1-Sx
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 03:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbZI0B1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 21:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbZI0B1V
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 21:27:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19657 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbZI0B1K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 21:27:10 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQL00HFYW1DK330@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 26 Sep 2009 21:27:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4ABD9C2C.60800@redhat.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129190>

On Sat, 26 Sep 2009, Jason Merrill wrote:

> Incidentally, somewhat related to this issue, I've noticed that if I fetch a
> branch which I don't currently have in my repository, and I have most of the
> commits on that branch in my object store (or in an alternate repository) but
> not the most recent commit, git fetch isn't smart enough to only grab the
> commits I'm actually missing, it wants to fetch much more.
> 
> I would expect that since the clone pulled down everything in the gcc.git
> repository, I could then do
> 
> git config remote.origin.fetch 'refs/remotes/*:refs/remotes/origin/*'
> git fetch
> 
> and have all the branches, not just the ones in refs/heads.  But when I do
> this git fetch wants to fetch some 500k redundant objects.

Well...  Assuming a fixed git using the patch I posted yesterday, my 
clone of gcc.git has 988941 objects.  The source repository used for the 
clone has 1399551 objects.  Of course the source repo has more objects 
because it has extra branches in the refs/remotes/ namespace that the 
clone didn't fetch.  If you wish to also fetch those branches as you 
illustrated above then you'll get the difference i.e. 410610 additional 
objects.

And even if the broken clone (before my patch) did pull everything from 
gcc.git, in the cloned repository those 410610 extra objects are 
considered as garbage because nothing actually reference them.  So even 
if you decide to fetch the extra branches that the initial clone didn't 
pick up, or if you do reference that repository with "garbage" objects 
for another clone to which you want to add those extra branches, git has 
no way to know that it already had access to those objects locally and 
"ungarbage" them as they aren't referenced.  Result is a useless fetch 
of 410610 objects that you already have, but that you weren't supposed 
to have in the first place.


Nicolas
