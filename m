From: Nicolas Pitre <nico@cam.org>
Subject: Re: Continue git clone after interruption
Date: Wed, 19 Aug 2009 17:13:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908191552020.6044@xanadu.home>
References: <1250509342.2885.13.camel@cf-48>
 <200908191719.52974.jnareb@gmail.com>
 <alpine.LFD.2.00.0908191326360.6044@xanadu.home>
 <200908192142.51384.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 23:14:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdsU4-00027F-4D
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 23:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbZHSVOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 17:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbZHSVOG
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 17:14:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17687 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbZHSVOF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 17:14:05 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KON00GCC6GOQ0G0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Aug 2009 17:02:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200908192142.51384.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126583>

On Wed, 19 Aug 2009, Jakub Narebski wrote:

> Cc-ed Dscho, so he can easier participate in this subthread.
> 
> On Wed, 19 Aug 2009, Nicolas Pitre wrote:
> > On Wed, 19 Aug 2009, Jakub Narebski wrote:
> 
> > > P.S. What do you think about 'bundle' capability extension mentioned
> > >      in a side sub-thread?
> > 
> > I don't like it.  Reason is that it forces the server to be (somewhat) 
> > stateful by having to keep track of those bundles and cycle them, and it 
> > doubles the disk usage by having one copy of the repository in the form 
> > of the original pack(s) and another copy as a bundle.
> 
> I agree about problems with disk usage, but I disagree about server
> having to be stateful; server can just simply scan for bundles, and
> offer links to them if client requests 'bundles' capability, somewhere
> around initial git-ls-remote list of refs.

But that's the client that has to deal with what the server wants to 
offer, instead of the server actually serving data as the client wants.

> Well, offering daily bundle in addition to daily snapshot could be
> a good practice, at least until git acquires resumable fetch (resumable
> clone).

Outside of Git: maybe.  Through the git protocol: no.  And what would 
that bundle contain over the daily snapshot?  The whole history?  If so 
that goes against the idea that people concerned by all this have slow 
links and probably aren't interested in the time to download it all.  If 
the bundle contains only the top revision then it has no advantage over 
the snapshot.  Somewhere in the middle?  Sure, but then where to draw 
the line?  That's for the client to decide, not the server 
administrator.

And what if you start your slow transfer which breaks in the middle.  
The next morning you want to restart it in the hope that you might 
resume the transfer of the bundle that is incomplete.  But crap, the 
server has updated its bundle and your half-bundle is now useless. 
You've wasted your bandwidth for nothing.

> > If you think about git.kernel.org which has maybe hundreds of 
> > repositories where the big majority of them are actually forks of Linus' 
> > own repository, then having all those forks reference Linus' repository 
> > is a big disk space saver (and IO too as the referenced repository is 
> > likely to remain cached in memory).  Having a bundle ready for each of 
> > them will simply kill that space advantage, unless they all share the 
> > same bundle.
> 
> I am thinking about sharing the same bundle for related projects.

... meaning more administrative burden.

> > Now sharing that common bundle could be done of course, but that makes 
> > things yet more complex while still wasting IO because some requests 
> > will hit the common pack and some others will hit the bundle, making 
> > less efficient usage of the disk cache on the server.
> 
> Hmmm... true (unless bundles are on separate server).

... meaning additional but avoidable costs.

> > Yet, that bundle would probably not contain the latest revision if it is 
> > only periodically updated, even less so if it is shared between multiple 
> > repositories as outlined above.  And what people with slow/unreliable 
> > network links are probably most interested in is the latest revision and 
> > maybe a few older revisions, but probably not the whole repository as 
> > that is simply too long to wait for.  Hence having a big bundle is not 
> > flexible either with regards to the actual data transfer size.
> 
> I agree that bundle would be useful for restartable clone, and not
> useful for restartable fetch.  Well, unless you count (non-existing)
> GitTorrent / git-mirror-sync as this solution... ;-)

I don't think fetches after a clone are such an issue.  They are 
typically transfers being orders of magnitude smaller than the initial 
clone.  Same goes for fetches to deepen a shallow clone which are in 
fact fetches going back in history instead of forward.  I still stands 
by my assertion that bundles are suboptimal for a restartable clone.

As for GitTorrent / git-mirror-sync... those are still vaporwares to me 
and I therefore have doubts about their actual feasability. So no, I 
don't count on them.

> > Hence having a restartable git-archive service to create the top 
> > revision with the ability to cheaply (in terms of network bandwidth) 
> > deepen the history afterwards is probably the most straight forward way 
> > to achieve that.  The server needs no be aware of separate bundles, etc.  
> > And the shared object store still works as usual with the same cached IO 
> > whether the data is needed for a traditional fetch or a "git archive" 
> > operation.
> 
> It's the "cheaply deepen history" that I doubt would be easy.  This is
> the most difficult part, I think (see also below).

Don't think so.  Try this:

	mkdir test
	cd test
	git init
	git fetch --depth=1 git://git.kernel.org/pub/scm/git/git.git

REsult:

remote: Counting objects: 1824, done.
remote: Compressing objects: 100% (1575/1575), done.
Receiving objects: 100% (1824/1824), 3.01 MiB | 975 KiB/s, done.
remote: Total 1824 (delta 299), reused 1165 (delta 180)
Resolving deltas: 100% (299/299), done.
From git://git.kernel.org/pub/scm/git/git
 * branch            HEAD       -> FETCH_HEAD

You'll get the very latest revision for HEAD, and only that.  The size 
of the transfer will be roughly the size of a daily snapshot, except it 
is fully up to date.  It is however non resumable in the event of a 
network outage.  My proposal is to replace this with a "git archive" 
call.  It won't get all branches, but for the purpose of initialising 
one's repository that should be good enough.  And the "git archive" can 
be fully resumable as I explained.

Now to deepen that history.  Let's say you want 10 more revisions going 
back then you simply perform the fetch again with a --depth=10.  Right 
now it doesn't seem to work optimally, but the pack that is then being 
sent could be made of deltas against objects found in the commits we 
already have.  Currently it seems that a pack that also includes those 
objects we already have in addition to those we want is created, which 
is IMHO a flaw in the shallow support that shouldn't be too hard to fix.  
Each level of deepening should then be as small as standard fetches 
going forward when updating the repository with new revisions.

> > Why "git archive"?  Because its content is well defined.  So if you give 
> > it a commit SHA1 you will always get the same stream of bytes (after 
> > decompression) since the way git sort files is strictly defined.  It is 
> > therefore easy to tell a remote "git archive" instance that we want the 
> > content for commit xyz but that we already got n files already, and that 
> > the last file we've got has m bytes.  There is simply no confusion about 
> > what we've got already, unlike with a partial pack which might need 
> > yet-to-be-received objects in order to make sense of what has been 
> > already received.  The server simply has to skip that many files and 
> > resume the transfer at that point, independently of the compression or 
> > even the archive format.
> 
> Let's reiterate it to check if I understand it correctly:
> 
> Any "restartable clone" / "resumable fetch" solution must begin with
> a file which is rock-solid stable wrt. reproductability given the same
> parameters.  git-archive has this feature, packfile doesn't (so I guess
> that bundle also doesn't, unless it was cached / saved on disk).

Right.

> It would be useful if it was possible to generate part of this rock-solid
> file for partial (range, resume) request, without need to generate 
> (calculate) parts that client already downloaded.  Otherwise server has
> to either waste disk space and IO for caching, or waste CPU (and IO)
> on generating part which is not needed and dropping it to /dev/null.
> git-archive you say has this feature.

"Could easily have" is more appropriate.

> Next you need to tell server that you have those objects got using
> resumable download part ("git archive HEAD" in your proposal), and
> that it can use them and do not include them in prepared file/pack.
> "have" is limited to commits, and "have <sha1>" tells server that
> you have <sha1> and all its prerequisites (dependences).  You can't 
> use "have <sha1>" with git-archive solution.  I don't know enough
> about 'shallow' capability (and what it enables) to know whether
> it can be used for that.  Can you elaborate?

See above, or Documentation/technical/shallow.txt.

> Then you have to finish clone / fetch.  All solutions so far include
> some kind of incremental improvements.  My first proposal of bisect
> fetching 1/nth or predefined size pack is buttom-up solution, where
> we build full clone from root commits up.  You propose, from what
> I understand build full clone from top commit down, using deepening
> from shallow clone.  In this step you either get full incremental
> or not; downloading incremental (from what I understand) is not
> resumable / they do not support partial fetch.

Right.  However, like I said, the incremental part should be much 
smaller and therefore less susceptible to network troubles.


Nicolas
