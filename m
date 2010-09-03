From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 20:29:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009021931340.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <20100902155810.GB14508@sigill.intra.peff.net>
 <alpine.LFD.2.00.1009021233190.19366@xanadu.home> <4C7FDA32.5050009@gmail.com>
 <alpine.LFD.2.00.1009021326290.19366@xanadu.home>
 <AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
 <20100902192910.GJ32601@spearce.org> <m3y6bjnadu.fsf@localhost.localdomain>
 <AANLkTikSHXivniUk-1KU30Ws23ebnbDhOmjKmpmVH-Y9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 02:29:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrKA6-0003Nz-90
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 02:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab0ICA33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 20:29:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51571 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab0ICA32 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 20:29:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L850054OAP0Q522@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 02 Sep 2010 20:29:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTikSHXivniUk-1KU30Ws23ebnbDhOmjKmpmVH-Y9@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155229>

On Thu, 2 Sep 2010, Luke Kenneth Casson Leighton wrote:

> On Thu, Sep 2, 2010 at 9:45 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> 
> > If I remember the discussion stalled (i.e. no working implementation),
> > and one of the latest proposals was to have some way of recovering
> > objects from partially downloaded file, and a way to request packfile
> > without objects that got already downloaded.
> 
>  oo.  ouch.  i can understand why things stalled, then.  you're
> effectively adding an extra layer in, and even if you could add a
> unique naming scheme on those objects (if one doesn't already exist?),
> those object might (or might not!) come up the second time round (for
> reasons mentioned already - threads resulting in different deltas
> being picked etc.) ... and if they weren't picked for the re-generated
> pack, you'd have to _delete_ them from the receiving end so as to
> avoid polluting the recipient's object store haaarrgh *spit*, *cough*.

Well, actually there is no need to delete anything.  Git can cope with 
duplicated objects just fine.  A subsequent gc will get rid of the 
duplicates automatically.

>  what _might_ work however iiiiIiis... to split the pack-object into
> two parts.  or, to add an "extra part", to be more precise:
> 
> a) complete list of all objects.  _just_ the list of objects.
> b) existing pack-object format/structure.
> 
> in this way, the sender having done all the hard work already of
> determining what objects are to go into a pack-object, transfers that
> *first*.  _theeen_ you begin transferring the pack-object.  theeeen,
> if the pack-object transfer is ever interrupted, you simply send back
> that list of objects, and ask "uhh, you know that list of objects we
> were talking about?  well, here it is *splat* - are you able to
> recreate the pack-object from that, for me, and if so please gimme
> again"

Well, it isn't that simple.

First, a resumable clone is useful only when there is a big transfer in 
play.  Otherwise it isn't worth the trouble.

So, if the clone is big, then this list of objects can be in the 
millions.  For example my linux kernel repo with a couple branches 
currently has:

$ git rev-list --all --objects | wc -l
2808136

So, 2808136 objects, with 20-byte SHA1 for each of them, and you have a 
54 MB object list to transfer already.  This is a significant overhead 
that we prefer to avoid, given the actual pack transfer which is:

$ git pack-objects --all --stdout --progress < /dev/null | wc -c
Counting objects: 2808136, done.
Compressing objects: 100% (384219/384219), done.
645201934
Total 2808136 (delta 2422420), reused 2788225 (delta 2402700)

The output from wc is 645201934 = 615 MB for this repository.  Hence the 
list of object alone is quite significant.

And even then, what if the transfer crashes during that object list 
transfer?  On flaky connections this might happen within 54 MB.

> and, 10^N-1 times out of 10^N, for reasons that shawn kindly
> explained, i bet you the answer would be "yes".

For the list of objects, sure.  But that isn't a big deal.  It is easy 
enough to tell the remote about the commits we already have and ask for 
the rest.  With a commit SHA1, the remote can figure out all the objects 
we have. But all is in that determination of the latest commit we have.  
If we get a partial pack, it is possible to somehow salvage as many 
objects from it, and determine what top commit(s) that correspond to.  
It is possible to set your local repo just as if you had requested a 
shallow clone and then the resume would simply be a deepening of that 
shallow clone.

But usually the very first commit in a pack is huge as it typically 
isn't delta compressed (a delta chain has to start somewhere).  And this 
first commit will roughly represent the same size as a tarball for that 
commit.  And if you don't get at least that first commit then you are 
screwed.  Or if you don't get a complete second commit when deepening a 
clone you are still screwed.

Another issue is what to do with objects that are themselves huge.

Yet another issue: what to do with all those objects I've got in my 
partial pack, but that I can't connect to any commit yet.  We don't want 
them transferred again but it isn't easy to tell the remote about them.

You could tell the remote: "I have this pack for this commit from this 
commit but I got only this amount of bytes from it, please resume 
transfer here."  But as mentioned before the pack stream is not 
deterministic, and we really don't want to make it single-threaded on a 
server.  Furthermore this is a lot of work for the server as even if the 
pack stream is deterministic, then the server still has to recreate the 
first part of the pack just to throw it away until the desired offset is 
reached.  And caching pack results also has all sorts of implications 
we've prefered to avoid on a server for security reasons (better keep 
serving operations read-only).

> ... um... in fact... um... i believe i'm merely talking about the .idx
> index file, aren't i?  because... um... the index file contains the
> list of object refs in the pack, yes?

In one pack, yes.  You might have multiple packs.  And that doesn't mean 
that all the objects from a pack are all relevant to the actual branches 
you are willing to export.

> sooo.... taking a wild guess, here: if you were to parse the .idx file
> and extract the list of object-refs, and then pass that to "git
> pack-objects --window=0 --delta=0", would you end up with the exact
> same pack file, because you'd forced git pack-objects to only return
> that specific list of object-refs?

If you do this i.e. turn off delta compression, then the 615 MB 
repository above will turn itself into a multi-gigabyte pack!


Nicolas
