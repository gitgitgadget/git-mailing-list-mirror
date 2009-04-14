From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 14 Apr 2009 16:17:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904141542161.6741@xanadu.home>
References: <alpine.LFD.2.00.0904052315210.6741@xanadu.home>
 <20090407081019.GK20356@atjola.homenet> <m3tz5023rq.fsf@localhost.localdomain>
 <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
 <20090407142147.GA4413@atjola.homenet>
 <alpine.LFD.2.00.0904071321520.6741@xanadu.home>
 <20090407181259.GB4413@atjola.homenet>
 <alpine.LFD.2.00.0904071454250.6741@xanadu.home>
 <20090407202725.GC4413@atjola.homenet>
 <alpine.LFD.2.00.0904080041240.6741@xanadu.home>
 <20090410T203405Z@curie.orbis-terrarum.net>
 <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 22:19:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltp6Y-0000HN-Bp
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 22:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbZDNUSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 16:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbZDNUSE
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 16:18:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45970 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbZDNUSB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 16:18:01 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KI3004UQXPVR8M0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 14 Apr 2009 16:17:55 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116564>

On Tue, 14 Apr 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 10 Apr 2009, Robin H. Johnson wrote:
> 
> > On Wed, Apr 08, 2009 at 12:52:54AM -0400, Nicolas Pitre wrote:
> > > > http://git.overlays.gentoo.org/gitweb/?p=exp/gentoo-x86.git;a=summary
> > > > At least that's what I cloned ;-) I hope it's the right one, but it fits
> > > > the description...
> > > OK.  FWIW, I repacked it with --window=250 --depth=250 and obtained a 
> > > 725MB pack file.  So that's about half the originally reported size.
> > The one problem with having the single large packfile is that Git
> > doesn't have a trivial way to resume downloading it when the git://
> > protocol is used.
> > 
> > For our developers cursed with bad internet connections (a fair number
> > of firewalls that don't seem to respect keepalive properly), I suppose
> > I can probably just maintain a separate repo for their initial clones,
> > which leaves a large overall download, but more chances to resume.
> 
> IMO the best we could do under these circumstances is to use fsck 
> --lost-found to find those commits which have a complete history (i.e. no 
> "broken links") -- this probably needs to be implemented as a special mode 
> of --lost-found -- and store them in a temporary to-be-removed 
> namespace, say refs/heads/incomplete-refs/$number, which will be sent to 
> the server when fetching the next time.  (Might need some iterations to 
> get everything, though.)

Well, although this might seem a good idea, this would help only in 
those cases where there is at least one complete revision available, 
i.e. no delta needed. This is usually true for the top commit after a 
repack which objects are all stored at the front of the pack and serve 
as base objects for deltas from subsequent (older) commits.  Thing is, 
that first revision is likely to occupy a significant portion of the 
whole pack, like no less than the size of the equivalent .tar.gz for the 
content of that commit.  To see what this represents, just try a shallow 
clone with depth=1.  For the Linux kernel, this is more than 80MB while 
the whole repo is in the 200MB range.  So if your connection isn't 
reliable enough to transfer at least that amount then you're screwed 
anyway.

Independently from this, I think there is quite a lot of confusion here.  
According to Robin, the reason for splitting the large Gentoo repo into 
multiple packs is apparently to help with the resuming of a clone.  We 
know that the git:// protocol is currently not resumable, and having 
multiple packs on the remote server won't change the outcome in any way 
as the client still receives a single big pack anyway.

WRT the HTTP protocol, I was questioning git's ability to resume the 
transfer of a pack in the middle if such transfer is interrupted without 
redownloading it all. And Mike Hommey says this is actually the case.

Meaning there is simply no reason to split a big pack into multiple 
ones.  If anything, it'll only make a clone over the native git protocol 
more costly for the server which has to pack everything back together.


Nicolas
