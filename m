From: Nicolas Pitre <nico@cam.org>
Subject: Re: Continue git clone after interruption
Date: Wed, 19 Aug 2009 15:04:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908191326360.6044@xanadu.home>
References: <1250509342.2885.13.camel@cf-48>
 <200908182302.10619.jnareb@gmail.com>
 <alpine.LFD.2.00.0908181711350.6044@xanadu.home>
 <200908191719.52974.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 21:05:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdqTj-0007Fi-3w
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 21:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbZHSTFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 15:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbZHSTFh
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 15:05:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47184 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbZHSTFg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 15:05:36 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KON002XG10BDB90@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Aug 2009 15:05:00 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200908191719.52974.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126573>

On Wed, 19 Aug 2009, Jakub Narebski wrote:

> There are 114937 objects in this packfile, including 56249 objects
> used as base (can be deltified or not).  git-verify-pack -v shows
> that all objects have total size-in-packfile of 33 MB (which agrees
> with packfile size of 33 MB), with 17 MB size-in-packfile taken by
> deltaified objects, and 16 MB taken by base objects.
> 
>   git verify-pack -v | 
>     grep -v "^chain" | 
>     grep -v "objects/pack/pack-" > verify-pack.out
> 
>   sum=0; bsum=0; dsum=0; 
>   while read sha1 type size packsize off depth base; do
>     echo "$sha1" >> verify-pack.sha1.out
>     sum=$(( $sum + $packsize ))
>     if [ -n "$base" ]; then 
>        echo "$sha1" >> verify-pack.delta.out
>        dsum=$(( $dsum + $packsize ))
>     else
>        echo "$sha1" >> verify-pack.base.out
>        bsum=$(( $bsum + $packsize ))
>     fi
>   done < verify-pack.out
>   echo "sum=$sum; bsum=$bsum; dsum=$dsum"

Your object classification is misleading.  Because an object has no 
base, that doesn't mean it is necessarily a base itself.  You'd have to 
store $base into a separate file and then sort it and remove duplicates 
to know the actual number of base objects.  What you have right now is 
strictly delta objects and non-delta objects. And base objects can 
themselves be delta objects already of course.

Also... my git repo after 'git gc --aggressive' contains a pack which 
size is 22 MB.  Your script tells me:

sum=22930254; bsum=14142012; dsum=8788242

and:

   29558 verify-pack.base.out
   82043 verify-pack.delta.out
  111601 verify-pack.out
  111601 verify-pack.sha1.out

meaning that I have 111601 total objects, of which 29558 are non-deltas 
occupying 14 MB and 82043 are deltas occupying 8 MB.  That certainly 
shows how deltas are space efficient.  And with a minor modification to 
your script, I know that 44985 objects are actually used as a delta 
base.  So, on average, each base is responsible for nearly 2 deltas.

> >>>> (BTW what happens if this pack is larger than file size limit for 
> >>>> given filesystem?).
> [...]
> 
> >> If I remember correctly FAT28^W FAT32 has maximum file size of 2 GB.
> >> FAT is often used on SSD, on USB drive.  Although if you have  2 GB
> >> packfile, you are doing something wrong, or UGFWIINI (Using Git For
> >> What It Is Not Intended).
> > 
> > Hopefully you're not performing a 'git clone' off of a FAT filesystem.  
> > For physical transport you may repack with the appropriate switches.
> 
> Not off a FAT filesystem, but into a FAT filesystem.

That's what I meant, sorry.  My point still stands.

> > The front of the pack is the critical point.  If you get enough to 
> > create the top commit then further transfers can be done incrementally 
> > with only the deltas between each commits.
> 
> How?  You have some objects that can be used as base; how to tell 
> git-daemon that we have them (but not theirs prerequisites), and how
> to generate incrementals?

Just the same as when you perform a fetch to update your local copy of a 
remote branch: you tell the remote about the commit you have and the one 
you want, and git-repack will create delta objects for the commit you 
want against similar objects from the commit you already have, and skip 
those objects from the commit you want that are already included in the 
commit you have.

> >> A question about pack protocol negotiation.  If clients presents some
> >> objects as "have", server can and does assume that client has all 
> >> prerequisites for such objects, e.g. for tree objects that it has
> >> all objects for files and directories inside tree; for commit it means
> >> all ancestors and all objects in snapshot (have top tree, and its 
> >> prerequisites).  Do I understand this correctly?
> > 
> > That works only for commits.
> 
> Hmmmm... how do you intent for "prefetch top objects restartable-y first"
> to work, then?

See my latest reply to dscho (you were in CC already).

> >> BTW. because of compression it might be more difficult to resume 
> >> archive creation in the middle, I think...
> > 
> > Why so?  the tar+gzip format is streamable.
> 
> gzip format uses sliding window in compression.  "cat a b | gzip"
> is different from "cat <(gzip a) <(gzip b)".
> 
> But that doesn't matter.  If we are interrupted in the middle, we can
> uncompress what we have to check how far did we get, and tell server
> to send the rest; this way server wouldn't have to even generate 
> (but not send) what we get as partial transfer.

You got it.

> P.S. What do you think about 'bundle' capability extension mentioned
>      in a side sub-thread?

I don't like it.  Reason is that it forces the server to be (somewhat) 
stateful by having to keep track of those bundles and cycle them, and it 
doubles the disk usage by having one copy of the repository in the form 
of the original pack(s) and another copy as a bundle.

Of course, the idea of having a cron job generating a bundle and 
offering it for download through HTTP or the like is fine if people are 
OK with that, and that requires zero modifications to git.  But I don't 
think that is a solution that scales.

If you think about git.kernel.org which has maybe hundreds of 
repositories where the big majority of them are actually forks of Linus' 
own repository, then having all those forks reference Linus' repository 
is a big disk space saver (and IO too as the referenced repository is 
likely to remain cached in memory).  Having a bundle ready for each of 
them will simply kill that space advantage, unless they all share the 
same bundle.

Now sharing that common bundle could be done of course, but that makes 
things yet more complex while still wasting IO because some requests 
will hit the common pack and some others will hit the bundle, making 
less efficient usage of the disk cache on the server.

Yet, that bundle would probably not contain the latest revision if it is 
only periodically updated, even less so if it is shared between multiple 
repositories as outlined above.  And what people with slow/unreliable 
network links are probably most interested in is the latest revision and 
maybe a few older revisions, but probably not the whole repository as 
that is simply too long to wait for.  Hence having a big bundle is not 
flexible either with regards to the actual data transfer size.

Hence having a restartable git-archive service to create the top 
revision with the ability to cheaply (in terms of network bandwidth) 
deepen the history afterwards is probably the most straight forward way 
to achieve that.  The server needs no be aware of separate bundles, etc.  
And the shared object store still works as usual with the same cached IO 
whether the data is needed for a traditional fetch or a "git archive" 
operation.

Why "git archive"?  Because its content is well defined.  So if you give 
it a commit SHA1 you will always get the same stream of bytes (after 
decompression) since the way git sort files is strictly defined.  It is 
therefore easy to tell a remote "git archive" instance that we want the 
content for commit xyz but that we already got n files already, and that 
the last file we've got has m bytes.  There is simply no confusion about 
what we've got already, unlike with a partial pack which might need 
yet-to-be-received objects in order to make sense of what has been 
already received.  The server simply has to skip that many files and 
resume the transfer at that point, independently of the compression or 
even the archive format.


Nicolas
