From: Nicolas Pitre <nico@cam.org>
Subject: Re: Continue git clone after interruption
Date: Thu, 20 Aug 2009 14:41:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908201358010.6044@xanadu.home>
References: <1250509342.2885.13.camel@cf-48>
 <200908192142.51384.jnareb@gmail.com>
 <alpine.LFD.2.00.0908191552020.6044@xanadu.home>
 <200908200937.05412.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 20:42:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeCaA-0005nk-Pf
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 20:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbZHTSlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 14:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbZHTSlp
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 14:41:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12622 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbZHTSlo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 14:41:44 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOO0016NUL12590@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 20 Aug 2009 14:41:26 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200908200937.05412.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126650>

On Thu, 20 Aug 2009, Jakub Narebski wrote:

> On Wed, 19 Aug 2009, Nicolas Pitre wrote:
> > You'll get the very latest revision for HEAD, and only that.  The size 
> > of the transfer will be roughly the size of a daily snapshot, except it 
> > is fully up to date.  It is however non resumable in the event of a 
> > network outage.  My proposal is to replace this with a "git archive" 
> > call.  It won't get all branches, but for the purpose of initialising 
> > one's repository that should be good enough.  And the "git archive" can 
> > be fully resumable as I explained.
> 
> It is however only 2.5 MB out of 37 MB that are resumable, which is 7%
> (well, that of course depends on repository).  Not that much that is
> resumable.

Take the Linux kernel then.  It is more like 75 MB.

> > Now to deepen that history.  Let's say you want 10 more revisions going 
> > back then you simply perform the fetch again with a --depth=10.  Right 
> > now it doesn't seem to work optimally, but the pack that is then being 
> > sent could be made of deltas against objects found in the commits we 
> > already have.  Currently it seems that a pack that also includes those 
> > objects we already have in addition to those we want is created, which 
> > is IMHO a flaw in the shallow support that shouldn't be too hard to fix.  
> > Each level of deepening should then be as small as standard fetches 
> > going forward when updating the repository with new revisions.
> 
> You would have the same (or at least quite similar) problems with 
> deepening part (the 'incrementals' transfer part) as you found with my
> first proposal of server bisection / division of rev-list, and serving
> 1/Nth of revisions (where N is selected so packfile is reasonable) to
> client as incrementals.  Yours is top-down, mine was bottom-up approach
> to sending series of smaller packs.  The problem is how to select size
> of incrementals, and that incrementals are all-or-nothing (but see also
> comment below).

Yes and no.  Combined with a slight reordering of commit objects, it 
could be possible to receive a partial pack and still be able to extract 
a bunch of full revisions.  The biggest issue is to be able to transfer 
revision x (75 MB for Linux), but revision x-1 usually requires only a 
few kilobytes, revision x-2 a few other kilobytes, etc.  Remember that 
you are likely to have only a few deltas from one revision to another, 
which is not the case for the very first revision you get.  A special 
mode to pack-object could place commit objects only after all the 
objects needed to create that revision.  So once you get a commit object 
on the receiving end, you could assume that all objects reachable from 
that commit are already received, or you had them locally already.

> In proposal using git-archive and shallow clone deepening as incrementals
> you have this small seed (how small it depends on repository: 50% - 5%)
> which is resumable.  And presumably with deepening you can somehow make
> some use from incomplete packfile, only part of which was transferred 
> before network error / disconnect.  And even tell server about objects
> which you managed to extract from *.pack.part.

yes.  And at that point resuming the transfer is just another case of 
shallow repository deepening.

> *NEW IDEA*
> 
> Another solution would be to try to come up with some sort of stable
> sorting of objects so that packfile generated for the same parameters
> (endpoints) would be always byte-for-byte the same.  But that might be
> difficult, or even impossible.

And I don't want to commit to that either.  Having some flexibility in 
object ordering makes it possible to improve on the packing heuristics.  
We certainly should avoid imposing strong restrictions like that for 
little gain.  Even the deltas are likely to be different from one 
request to another when using threads as one thread might be getting 
more CPU time than another slightly modifying the outcome.

> Well, we could send the list of objects in pack in order used later by
> pack creation to client (non-resumable but small part), and if packfile
> transport was interrupted in the middle client would compare list of 
> complete objects in part of packfile against this manifest, and sent
> request to server with *sorted* list of object it doesn't have yet.

Well... actually that's one of the item for pack V4.  Lots of SHA1s are 
duplicated in tree and commit objects, in addition to the pack index 
file.  With pack v4 all those SHA1s would be stored only once in a table 
and objects would index that table instead.

Still, that is not _that_ small though.  Just look at the size of the 
pack index file for the Linux repository to give you an idea.

> Server would probably have to check validity of objects list first (the
> object list might be needed to be more than just object list; it might
> need to specify topology of deltas, i.e. which objects are base for which
> ones).  Then it would generate rest of packfile.

I'm afraid that has the looks of something adding lots of complexity to 
a piece of git that is already quite complex already, namely 
pack-objects.  And there is already only a few individuals with their 
brain around it.

> > > It would be useful if it was possible to generate part of this rock-solid
> > > file for partial (range, resume) request, without need to generate 
> > > (calculate) parts that client already downloaded.  Otherwise server has
> > > to either waste disk space and IO for caching, or waste CPU (and IO)
> > > on generating part which is not needed and dropping it to /dev/null.
> > > git-archive you say has this feature.
> > 
> > "Could easily have" is more appropriate.
> 
> O.K.  And I can see how this can be easy done.
> 
> > > Next you need to tell server that you have those objects got using
> > > resumable download part ("git archive HEAD" in your proposal), and
> > > that it can use them and do not include them in prepared file/pack.
> > > "have" is limited to commits, and "have <sha1>" tells server that
> > > you have <sha1> and all its prerequisites (dependences).  You can't 
> > > use "have <sha1>" with git-archive solution.  I don't know enough
> > > about 'shallow' capability (and what it enables) to know whether
> > > it can be used for that.  Can you elaborate?
> > 
> > See above, or Documentation/technical/shallow.txt.
>  
> Documentation/technical/shallow.txt doesn't cover "shallow", "unshallow"
> and "deepen" commands from 'shallow' capability extension to git pack
> protocol (http://git-scm.com/gitserver.txt).

404 Not Found

Maybe that should be committed to git in Documentation/technical/  as 
well?

> > > Then you have to finish clone / fetch.  All solutions so far include
> > > some kind of incremental improvements.  My first proposal of bisect
> > > fetching 1/nth or predefined size pack is buttom-up solution, where
> > > we build full clone from root commits up.  You propose, from what
> > > I understand build full clone from top commit down, using deepening
> > > from shallow clone.  In this step you either get full incremental
> > > or not; downloading incremental (from what I understand) is not
> > > resumable / they do not support partial fetch.
> > 
> > Right.  However, like I said, the incremental part should be much 
> > smaller and therefore less susceptible to network troubles.
> 
> If you have 7% total pack size of git-archive resumable part, how small
> do you plan to have those incremental deepening?  Besides in my 1/Nth
> proposal those bottom-up packs werealso meant to be sufficiently small
> to avoid network troubles.

Two issues here: 1) people with slow links might not be interested in a 
deep history as it costs them time.  2) Extra revisions should typically 
require only a few KB each, therefore we might manage to ask for the 
full history after the initial revision is downloaded and salvage as 
much as we can if a network outage is encountered.  There is no need for 
arbitrary size, unless the user decides arbitrarily to get only 10 more 
revisions, or 100 more, etc.

> P.S. As you can see implementing resumable clone isn't easy...

I've been saying that all along for quite a while now.   ;-)


Nicolas
