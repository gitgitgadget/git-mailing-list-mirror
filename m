From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Design for http-pull on repo with packs
Date: Sun, 10 Jul 2005 16:29:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507101557510.30848-100000@iabervon.org>
References: <42D17D89.9080808@innehallsbolaget.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 22:35:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DriVd-00037I-JC
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 22:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVGJUd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 16:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVGJUcS
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 16:32:18 -0400
Received: from iabervon.org ([66.92.72.58]:13573 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262025AbVGJUbF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 16:31:05 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DriQE-0000lN-00; Sun, 10 Jul 2005 16:29:06 -0400
To: Dan Holmsand <dan@innehallsbolaget.se>
In-Reply-To: <42D17D89.9080808@innehallsbolaget.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 10 Jul 2005, Dan Holmsand wrote:

> Daniel Barkalow wrote:
> > I have a design for using http-pull on a packed repository, and it only
> > requires one extra file in the repository: an append-only list of the pack
> > files (because getting the directory listing is very painful and
> > failure-prone).
> 
> A few comments (as I've been tinkering with a way to solve the problem 
> myself).
> 
> As long as the pack files are named sensibly (i.e. if they are created 
> by git-repack-script), it's not very error-prone to just get the 
> directory listing, and look for matches for pack-<sha1>.idx. It seems to 
> work quite well (see below). It isn't beautiful in any way, but it works...

I may grab your code for that; the version I just sent seems to be working
except for that.

> >  If an individual file is not available, figure out what packs are
> >   available:
> > 
> >    Get the list of pack files the repository has
> >     (currently, I just use "e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135")
> >    For any packs we don't have, get the index files.
> 
> This part might be slightly expensive, for large repositories. If one 
> assumes that packs are named as by git-repack-script, however, one might 
> cache indexes we've already seen (again, see below). Or, if you go for 
> the mandatory "pack-index-file", require that it has a reliable order, 
> so that you can get the last added index first.

Nothing bad happens if you have index files for pack files you don't have,
as it turns out; the library ignores them. So we can keep the index files
around so we can quickly check if they have the objects we want. That way,
we don't have to worry about skipping something now (because it's not
needed) and then ignoring it when the branch gets merged in.

So what I actually do is make a list of the pack files that aren't already
downloaded that are available from the server, and download the index
files for any where the index file isn't downloaded, either.

> >    Keep a list of the struct packed_gits for the packs the server has
> >     (these are not used as places to look for objects)
> > 
> >  Each time we need an object, check the list for it. If it is in there,
> >   download the corresponding pack and report success.
> 
> Here you will need some strategy to deal with packs that overlap with 
> what we've already got. Basically, small and overlapping packs should be 
> unpacked, big and non-overlapping ones saved as is (since 
> git-unpack-objects is painfully slow and memory-hungry...).

I don't think there's an issue to having overlapping packs, either with
each other or with separate objects. If the user wants, stuff can be
repacked outside of the pull operation (note, though, that the index files
should be truncated rather than removed, so that the program doesn't fetch
them again next time some object can't be found easily).

> One could also optimize the pack-download bit, by figuring out the last 
> object in the pack that we need (easy enough to do from the index file), 
>   and just get the part of the pack file leading up to that object. That 
> could be a huge win for independently packed repositories (I don't do 
> that in my code below, though).

That's only possible if you can figure out what you want to have before
you get it. My code is walking the reachability graph on the client; it
can only figure out what other objects it needs after it's mapped the pack
file.

> Anyway, here's my attempt at the same thing. It introduces 
> "git-dumb-fetch", with usage like git-fetch-pack (except that it works 
> with http and rsync). And it adds some uglyness to git-cat-file, for 
> figuring out which objects we already have.

I might use that method for listing the available packs, although I'd sort
of like to encourage a clean solution first.

	-Daniel
*This .sig left intentionally blank*
