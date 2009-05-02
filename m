From: Nicolas Pitre <nico@cam.org>
Subject: Re: Compatibility between git.git and jgit
Date: Fri, 01 May 2009 21:39:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905012032590.6741@xanadu.home>
References: <20090415182754.GF23644@curie-int>
 <alpine.LFD.2.00.0904151443030.6741@xanadu.home>
 <7vy6tj109a.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0905011616130.6741@xanadu.home>
 <7v4ow4v0xl.fsf@gitster.siamese.dyndns.org>
 <20090502000123.GF23604@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 02 03:40:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M04DM-0005A7-Ft
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 03:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbZEBBj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 21:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbZEBBjz
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 21:39:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40961 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbZEBBjy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 21:39:54 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIZ00FK5TWIAK31@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 01 May 2009 21:38:43 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090502000123.GF23604@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118115>

On Fri, 1 May 2009, Shawn O. Pearce wrote:

> On an unrelated note, someone asked me recently, how do we ensure
> compatibility in implementations between git.git and jgit?
> 
> There isn't exactly a great notion of "a Git implementation can do
> X, Y, Z, and never does Q".  So its not like we have a compability
> test suite to run between the two systems.
> 
> JGit is really starting to gain some traction in the open source
> world.

Well... this is not exactly easy.  As I said in the past 
(http://marc.info/?l=git&m=121035043412788&w=2), I think that the C 
version must remain the reference with regards to protocols and on-disk 
data structures.  If people go wild with JGit and start making changes 
to data structures then it simply won't be Git compatible anymore and 
the user base will get fragmented.  A good way to prevent this is for 
people interested in making git compatible tools to monitor and interact 
on the git mailing list, however if we look at the results from some 
past GSOC projects we must conclude that not everyone is giving enough 
consideration to that.

A formal compatibility test suite would imply that every Git 
reimplementation should be compatible with the reference C version.  
You could add some tests in your test suite which are performed in 
parallel using JGit and the C git, and make sure that the produced 
results are identical, etc.

But to which extent should the C version remain backward compatible with 
other implementations?  Let's suppose a future protocol extension is 
made and old unsuspecting C clients work just fine but some other 
implementation crashes with it?  The more you have reimplementations of 
Git, the greater is the possibility for one of them to be flawed and 
buggier in one way or another but happened to just work with older C git 
versions.  And the reference implementation cannot be held back because 
of bugs in all alternative implementations.

> A lot of folks at Eclipse are really excited about being able to
> ship a BSD licensed VCS.  Some of the Maven folks are really excited
> about being able to link JGit up to Apache MINA SSHD and have a 100%
> pure Java server solution for Git, that doesn't require native OS
> authentication systems.  Gerrit Code Review relies entirely on it,
> and some folks within Google are now using Gerrit Code Review and
> its embedded MINA SSHD/JGit server as their only Git daemon.

As long as they're futzing^Wdeveloping on top of Jgit then 
interoperability shouldn't be at risk.  If people would start adding new 
object types and pack formats and the like without obtaining a consensus 
with people around the C version then I might get extremely worried (and 
pissed) though.

> Thus far, our compatibility story with git.git has been, "it should
> work, uh, we think, because Shawn understands git reasonably well,
> and wrote some of JGit, so uh, yea....".  :-)

If that works, and as I know you I'm sure that works great, then maybe 
this should just continue that way for as long as it is workable.

> But I think in another 12 months we'll be seeing people running
> only JGit in many contexts, making compatibility between the two
> implementations somewhat more important than it has been in the past.

One defensive approach we could adopt is to use a capability slot to 
identify the software version of each peer involved in the network 
communication.  The advantage would be for a later Git version to avoid 
doing some things that are known to break with client X or Y.  Of course 
even such a scheme can be abused and misused, like on some web sites if 
you don't have the "right" browser, leading some of them to allow faking 
the User-Agent string, etc.  But maybe the upsides are more important 
than the downsides.  This doesn't help with on-disk interoperability, 
but this is probably less important than communication interoperability.


Nicolas
