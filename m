From: Eric Paris <eparis@redhat.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Wed, 16 Dec 2009 17:37:21 -0500
Message-ID: <1261003041.2788.142.camel@localhost>
References: <1260822484.9379.53.camel@localhost>
	 <20091214211142.GC9364@coredump.intra.peff.net>
	 <1260825629.9379.56.camel@localhost>
	 <20091215023918.GA14689@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
	 <1260851180.9379.88.camel@localhost>
	 <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
	 <1260970885.2788.87.camel@localhost>
	 <alpine.LFD.2.00.0912161526080.23173@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 23:37:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL2V1-00080U-Fw
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 23:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935468AbZLPWhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 17:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935394AbZLPWha
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 17:37:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37109 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935421AbZLPWh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 17:37:26 -0500
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBGMbNdK028154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 16 Dec 2009 17:37:23 -0500
Received: from [10.11.8.177] (vpn-8-177.rdu.redhat.com [10.11.8.177])
	by int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nBGMbMgU012951;
	Wed, 16 Dec 2009 17:37:22 -0500
In-Reply-To: <alpine.LFD.2.00.0912161526080.23173@xanadu.home>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135342>

On Wed, 2009-12-16 at 16:06 -0500, Nicolas Pitre wrote:
> On Wed, 16 Dec 2009, Eric Paris wrote:
> 
> > On Tue, 2009-12-15 at 22:03 -0500, Nicolas Pitre wrote:
> > > On Mon, 14 Dec 2009, Eric Paris wrote:
> > > 
> > > > The alternative repo is slowing pushing up to that same location.  That
> > > > tar is 855838982, so just a tad bit smaller.
> > > 
> > > It doesn't appear to be complete yet, and not progressing either.
> > 
> > The alternative repo is now available (but the original is down)
> > 
> > I tried to run git gc --aggressive last night while I slept and got this
> > as output, maybe it helps point to a solution/problem?  The git reflog
> > portion ran for 5 hours and 36 minutes and appears to have finished.
> 
> Yes.  I was able to reproduce your issue.  And because of the *horrible* 
> repository packing, the reflog expiration process is taking ages when 
> determining object reachability at a rate of one reflog entry every 2 
> seconds or so.  With 4214 entries for the fsnotify-syscall branch, and 
> 1352 entries for the fsnotify branch, this already takes up asignificant 
> portion of the actual run time.  I'm sure if your repository was 
> properly packed this would take less than a minute.

I'm guessing this is a result of stgit.?  These branches really should
be just a branch from a tag (which exists in kernel-1) and about 30-50
patches linearly applied on top.  I don't know how I get that many
objects.  I'm guessing many/most of them are crap that should be able to
be cleaned/deleted entirely as the rebasing/pushing/poping/updating that
stgit does under the covers should have rendered them pointless.  Not
really sure when/how that should/could have happened.

Should I be running git-gc every night?

> Now, repacking doesn't work because...
> 
> > $ git gc --aggressive
> > error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
> > error: Could not read 29b6c2fb1390b4fd350a5ecc78f1156fc5d91e9f

/me is pretty git dumb, but is there some way to figure out the parents
or children of these?  I just trolled through all of my directories
doing git show and didn't get any hits.  I guess I'll just clean up and
start over....

> Those objects are indeed missing from the repository.  Without them your 
> repository is "broken".  Either you can find them somewhere else and 
> copy them over, or salvage as much as you can by fetching the 
> interesting branches into another freshly made repository.  This is 
> unfortunate because I would have liked to see by how much this 
> repository would have shrunk after a successful repack.
> 
> Of course, usage of alternates is recommended _only_ with repositories 
> that are stable, i.e. don't ever add repositories to 
> .git/objects/info/alternates if those repositories are rewinded/rebased 
> and/or branches in them are deleted/replaced.  That could be a reason 
> why some objects are now missing from the repository using alternates.

So I'm not sure how I did things wrong.  my kernel-1 has those bunch of
remotes.  The linux-next remote, like I said, basically rebases to
linus' tree, then merges 150 random branches.  It tags that tree every
day and I pull those tags.  So I would never expect any objects from
those remote trees to ever disappear.

Now I created branches in kernel-1 and I certainly have done lots of
things like so

git checkout -b testing remotes/linux-next/master
[edit]
git commit -a
git checkout -b testing1 remotes/linux-next/master
git branch -D testing

My assumption though was that this wouldn't ever affect my other
repositories.  My other repository branches always started by checking
out a branch with remotes/*/* as the base.

My understanding was that I would only run into problems if I used
something on a branch I created myself in the alternatives repo in other
repos (and I didn't remove remotes)

I guess it's not impossible to believe that at some point in time i
would have exported patches to and mbox from kernel-1 and applied them
to kernel-2 or vice versa.  I guess this would end up with the same
objects, right?  Then if I deleted the branch in kernel-1 I would have
problems in kernel-2?

I guess I'll rebuild my setup

new kernel-alt has just the remotes, and my kernel-1,2,3 all alt to it
I'll never have local branches in my kernel-alt
I'll run git-gc every night
I'll hope to never have problem again.

Sound good?
