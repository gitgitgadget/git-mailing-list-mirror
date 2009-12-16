From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Wed, 16 Dec 2009 16:06:32 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912161526080.23173@xanadu.home>
References: <1260822484.9379.53.camel@localhost>
 <20091214211142.GC9364@coredump.intra.peff.net>
 <1260825629.9379.56.camel@localhost>
 <20091215023918.GA14689@coredump.intra.peff.net>
 <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
 <1260851180.9379.88.camel@localhost>
 <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
 <1260970885.2788.87.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 22:06:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL14y-0005a1-Mp
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 22:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838AbZLPVGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 16:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbZLPVGe
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 16:06:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36699 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbZLPVGd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 16:06:33 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KUR00GM3JYWTSF0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 16 Dec 2009 16:06:33 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1260970885.2788.87.camel@localhost>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135340>

On Wed, 16 Dec 2009, Eric Paris wrote:

> On Tue, 2009-12-15 at 22:03 -0500, Nicolas Pitre wrote:
> > On Mon, 14 Dec 2009, Eric Paris wrote:
> > 
> > > The alternative repo is slowing pushing up to that same location.  That
> > > tar is 855838982, so just a tad bit smaller.
> > 
> > It doesn't appear to be complete yet, and not progressing either.
> 
> The alternative repo is now available (but the original is down)
> 
> I tried to run git gc --aggressive last night while I slept and got this
> as output, maybe it helps point to a solution/problem?  The git reflog
> portion ran for 5 hours and 36 minutes and appears to have finished.

Yes.  I was able to reproduce your issue.  And because of the *horrible* 
repository packing, the reflog expiration process is taking ages when 
determining object reachability at a rate of one reflog entry every 2 
seconds or so.  With 4214 entries for the fsnotify-syscall branch, and 
1352 entries for the fsnotify branch, this already takes up asignificant 
portion of the actual run time.  I'm sure if your repository was 
properly packed this would take less than a minute.

Now, repacking doesn't work because...

> $ git gc --aggressive
> error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
> error: Could not read 29b6c2fb1390b4fd350a5ecc78f1156fc5d91e9f

Those objects are indeed missing from the repository.  Without them your 
repository is "broken".  Either you can find them somewhere else and 
copy them over, or salvage as much as you can by fetching the 
interesting branches into another freshly made repository.  This is 
unfortunate because I would have liked to see by how much this 
repository would have shrunk after a successful repack.

Of course, usage of alternates is recommended _only_ with repositories 
that are stable, i.e. don't ever add repositories to 
.git/objects/info/alternates if those repositories are rewinded/rebased 
and/or branches in them are deleted/replaced.  That could be a reason 
why some objects are now missing from the repository using alternates.


Nicolas
