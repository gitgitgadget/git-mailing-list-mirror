From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Thu, 17 Dec 2009 00:38:47 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912161841210.23173@xanadu.home>
References: <1260822484.9379.53.camel@localhost>
 <20091214211142.GC9364@coredump.intra.peff.net>
 <1260825629.9379.56.camel@localhost>
 <20091215023918.GA14689@coredump.intra.peff.net>
 <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
 <1260851180.9379.88.camel@localhost>
 <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
 <1260970885.2788.87.camel@localhost>
 <alpine.LFD.2.00.0912161526080.23173@xanadu.home>
 <1261003041.2788.142.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 06:38:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL94j-0000Fn-1K
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 06:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbZLQFiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 00:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbZLQFiv
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 00:38:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33189 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbZLQFiu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 00:38:50 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KUS00A2Z7ONYLH0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Dec 2009 00:38:48 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1261003041.2788.142.camel@localhost>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135358>

On Wed, 16 Dec 2009, Eric Paris wrote:

> On Wed, 2009-12-16 at 16:06 -0500, Nicolas Pitre wrote:
> > On Wed, 16 Dec 2009, Eric Paris wrote:
> > 
> > > On Tue, 2009-12-15 at 22:03 -0500, Nicolas Pitre wrote:
> > > > On Mon, 14 Dec 2009, Eric Paris wrote:
> > > > 
> > > > > The alternative repo is slowing pushing up to that same location.  That
> > > > > tar is 855838982, so just a tad bit smaller.
> > > > 
> > > > It doesn't appear to be complete yet, and not progressing either.
> > > 
> > > The alternative repo is now available (but the original is down)
> > > 
> > > I tried to run git gc --aggressive last night while I slept and got this
> > > as output, maybe it helps point to a solution/problem?  The git reflog
> > > portion ran for 5 hours and 36 minutes and appears to have finished.
> > 
> > Yes.  I was able to reproduce your issue.  And because of the *horrible* 
> > repository packing, the reflog expiration process is taking ages when 
> > determining object reachability at a rate of one reflog entry every 2 
> > seconds or so.  With 4214 entries for the fsnotify-syscall branch, and 
> > 1352 entries for the fsnotify branch, this already takes up asignificant 
> > portion of the actual run time.  I'm sure if your repository was 
> > properly packed this would take less than a minute.
> 
> I'm guessing this is a result of stgit.?  These branches really should
> be just a branch from a tag (which exists in kernel-1) and about 30-50
> patches linearly applied on top.  I don't know how I get that many
> objects.  I'm guessing many/most of them are crap that should be able to
> be cleaned/deleted entirely as the rebasing/pushing/poping/updating that
> stgit does under the covers should have rendered them pointless.  Not
> really sure when/how that should/could have happened.

Possible.  Commit operations (including patch applications) always 
create loose objects because this is fast, with the expectation that 
they get collected in a pack later.

> Should I be running git-gc every night?

This is certainly a good thing to do given your heavy stgit usage.

> > Now, repacking doesn't work because...
> > 
> > > $ git gc --aggressive
> > > error: Could not read d936ff8a7b0841b51ddf96afa24a30b016824cb2
> > > error: Could not read 29b6c2fb1390b4fd350a5ecc78f1156fc5d91e9f
> 
> /me is pretty git dumb, but is there some way to figure out the parents
> or children of these?  I just trolled through all of my directories
> doing git show and didn't get any hits.  I guess I'll just clean up and
> start over....

Moving the reflog data aside (i.e. mv .git/logs .git/logs.bak) it seems 
that d936ff8 is not referenced anymore.

I found the other one as follows:

First I tried

$ git rev-list --all --objects

This resulted in:

[...]
4f7911b0b0dbd187131a109cf00161a0c6a9d727 arch/x86
ea868257c1eabc31e0ea7941efa42b543978b3fa arch/x86/kvm
a0c11ead723956c667172a9f3fb6787684fe7ff5 arch/x86/kvm/paging_tmpl.h
b556b6aad8b1aacfecb1dd4a56dbd389674687b5 arch/x86/kvm/x86.c
68a9733ae3315d7e2bfec2037dfeee4db8a6f6a1 drivers
error: Could not read 29b6c2fb1390b4fd350a5ecc78f1156fc5d91e9f
fatal: bad tree object 29b6c2fb1390b4fd350a5ecc78f1156fc5d91e9f

Because of the way objects are enumerated, we can be pretty sure that 
the bad tree object is referenced by the tree object 68a9733a 
corresponding to drivers/.  Let's verify that:

$ git ls-tree 68a9733a
100644 blob 00cf9553f74065291612b0971337f79995933a06    Kconfig
100644 blob c1bf41737936ab00be4a87563a0bb0638074785d    Makefile
040000 tree d4e847de9bf2450842936582ea7cc6778413825b    accessibility
040000 tree 29b6c2fb1390b4fd350a5ecc78f1156fc5d91e9f    acpi
[...]

Yep, we found it there.  So the missing tree object corresponds to 
drivers/acpi/.  So to find the latest commit to which this particular 
tree object is referenced by, we just need to look at the same rev-list 
output above (piped into less is handy here) and scroll up until an 
object with no name is found.  This would usually be the first root tree 
object referencing the named objects that follow.  Here I get aafb68eb.  
To be sure, let's list it so to confirm it really contains a reference 
to the 68a9733a drivers tree:

$ git ls-tree aafb68eb
[...]
040000 tree 68a9733ae3315d7e2bfec2037dfeee4db8a6f6a1    drivers
[...]

So yes, we've got the right root tree object.  Now finding the 
corresponding commit should be easy:

$ git log --all --pretty=raw

Then within less, a search for aafb68eb brings us to this:

commit 2e765e9c87a337131aad3014f9a7e5e878c7d0a0
tree aafb68eb84f96c9ab5697c6e8d10d5006d1e7209
parent a2c2de42295b3ac29758f454a7072338e5555ca3
author Eric Paris <eparis@redhat.com> 1237233261 -0400
committer Eric Paris <eparis@redhat.com> 1237233261 -0400

    refresh     64d34c511b1125d9efd2926e683e019f15dec5b4

So this is referenced by a commit that you made on the 1237233261th 
second since January 1, 1970 i.e. 2009-03-16 19:54:21 +0000 which is 
quite a while ago.  Or given the nature of the commit log, this is 
probably some stgit branch.

Note that the missing tree didn't necessarily appear with that commit.  
Because of the recency ordering from rev-list, all we can say is that 
this is the last commit on that particular branch to reference that 
tree, but it might have been introduced in the repository way before 
that point in time.

Now let's try to find out what branch(es) actually link(s) to this 
commit:

$ git branch -a --contains 2e765e9c

This comes empty.  This is because 'git branch' looks only in the 
refs/heads/ and refs/remotes namespace (or only one of them without -a).  

Scripting something around 'git for-each-ref' and 'git merge-base' could 
be done, such as:

	TARGET=2e765e9c87a337131aad3014f9a7e5e878c7d0a0
	git for-each-ref refs/* |
	while read sha1 type ref; do
		if [ "$(git merge-base $sha1 $TARGET)" = "$TARGET" ]; then
			echo "referenced by $type $ref"
		fi
	done

But this is slow, for the same reason as 'git reflog expire' above.  But 
letting it run for a while should give you at least one answer.

> > Of course, usage of alternates is recommended _only_ with repositories 
> > that are stable, i.e. don't ever add repositories to 
> > .git/objects/info/alternates if those repositories are rewinded/rebased 
> > and/or branches in them are deleted/replaced.  That could be a reason 
> > why some objects are now missing from the repository using alternates.
> 
> So I'm not sure how I did things wrong.  my kernel-1 has those bunch of
> remotes.  The linux-next remote, like I said, basically rebases to
> linus' tree, then merges 150 random branches.  It tags that tree every
> day and I pull those tags.  So I would never expect any objects from
> those remote trees to ever disappear.

Right.

> Now I created branches in kernel-1 and I certainly have done lots of
> things like so
> 
> git checkout -b testing remotes/linux-next/master
> [edit]
> git commit -a
> git checkout -b testing1 remotes/linux-next/master
> git branch -D testing
> 
> My assumption though was that this wouldn't ever affect my other
> repositories.  My other repository branches always started by checking
> out a branch with remotes/*/* as the base.
> 
> My understanding was that I would only run into problems if I used
> something on a branch I created myself in the alternatives repo in other
> repos (and I didn't remove remotes)
> 
> I guess it's not impossible to believe that at some point in time i
> would have exported patches to and mbox from kernel-1 and applied them
> to kernel-2 or vice versa.  I guess this would end up with the same
> objects, right?  Then if I deleted the branch in kernel-1 I would have
> problems in kernel-2?

Eventually, yes. After a while the auto repack in kernel2 would notice 
that some objects are in kernel1 already and purge them from kernel2.  
And if those objects were part of a deleted branch then kernel1 would 
get rid of those objects too once the reflog with a reference to that 
deleted branch expires.  The unsuspecting kernel2 repo then gets broken.

> I guess I'll rebuild my setup
> 
> new kernel-alt has just the remotes, and my kernel-1,2,3 all alt to it
> I'll never have local branches in my kernel-alt
> I'll run git-gc every night
> I'll hope to never have problem again.
> 
> Sound good?

Yes.  And make sure not to fetch rebasing repositories, such as 
linux-next, into kernel-alt without keeping a tag for each fetched state 
otherwise you'll accumulate unreferenced objects which the other 
repositories might rely upon.


Nicolas
