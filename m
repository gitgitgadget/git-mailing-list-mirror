From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Thu, 24 May 2007 03:12:36 -0400
Message-ID: <20070524071235.GL28023@spearce.org>
References: <46528A48.9050903@gmail.com> <7v7iqz19d2.fsf@assigned-by-dhcp.cox.net> <56b7f5510705231655o589de801w88adc1aa6c18162b@mail.gmail.com> <7vps4ryp02.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 09:12:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr7VA-0001S8-Qe
	for gcvg-git@gmane.org; Thu, 24 May 2007 09:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbXEXHMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 03:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755048AbXEXHMm
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 03:12:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57808 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913AbXEXHMl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 03:12:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hr7Uz-00039W-25; Thu, 24 May 2007 03:12:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5577E20FBAE; Thu, 24 May 2007 03:12:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vps4ryp02.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48227>

Junio C Hamano <junkio@cox.net> wrote:
> "Dana How" <danahow@gmail.com> writes:
> 
> > The packed X too big combination is the problem.  As the
> > commit message says,  this could happen if the packs
> > came from fast-import,...
> > We have three options in this case:
> > (1) Drop the object (do not put it in the new pack(s)).
> > (2) Pass the object into the new pack(s).
> > (3) Write out the object as a new loose object.
> >
> > Option (1) is unacceptable.  When you call git-repack -a,
> > it blindly deletes all the non-kept packs at the end.  So
> > the megablobs would be lost.
> 
> Ok, I can buy that -- (1) nor (2) are unacceptable and (3) is
> the only sane thing to do for a previously packed objects that
> exceed the size limit.

I still don't buy the idea that these megablobs shouldn't be packed.
I understand Dana's pain here (at least a little bit, my problems
aren't as bad as his are), but I also hate to see us run away from
packfiles for these really sick cases just because we have some
issues in our current packfile handling.

Packfiles give us a lot of benefits:

 1) less inode usage;
 2) transport can write directly to local disk;
 3) transport can (quickly) copy from local disk;
 4) testing for existance is *much* faster;
 5) deltafication is possible;

Now #3 is actually really important here.  Don't forget that we
*just* disabled the fancy "new loose object format".  It doesn't
exist.  We can read the packfile-like loose objects, but we cannot
write them anymore.  So lets say we explode a megablob into a loose
object, and its 800 MiB by itself.  Now we have to send that object
to a client.  Yes, that's right, we must *RECOMPRESS* 800 MiB for
no reason.  Not the best choice.  Maybe we shouldn't have deleted
that packfile formatted loose object writer...

Now one argument to work around that recompression problem would
be to NFS share out the loose objects directory, and let clients
mount that volume and add it to their .git/objects/info/alternates
list.  But this doesn't work in the very general distributed case,
such as me getting huge files from kernel.org.  Last I checked,
the kernel.org admins did not offer up NSF mounts.  Besides, the
round-trip latency between me and kernel.org is too large for it
to be useful anyway over NFS.  :)

So I think this "explode out megablobs" is a bad idea.  Its violating
other things that make us fast, like #3's being able to reuse large
parts of an existing packfile during transfer.


Dana pointed out the megablobs make access slower because their
packfile indexes must still be searched to locate a commit; but if
the megablob packfile(s) contain only blobs then there is no value
in looking at those packfiles.

We might be able to fix this by altering the sort_pack function
in sha1_file.c to not only order by mtime, but also by the ratio
of the size of the .pack to the number of objects stored in it.
Any packfile with a high size/object ratio is likely to be what
Dana has been calling a "metadata" pack, holding things like tags,
commits, trees and small blobs.  Its these packfiles that we want
to search first, as they are the most likely to be accessed.

By pushing the megablob packs to the end of our packed_git search
list we won't tend to scan their indexes, as most of our objects
will be found earlier in the search list.  Hence we will generally
avoid any costs associated with their indexes.


Huge packfiles probably should be scheduled for keeping with a .keep
automatically.  We probably should teach pack-objects to generate a
.keep file if the resulting .pack was over a certain size threshold
(say 1.5 GiB by default) and teach git-repack to rename the .keep
file as it also renames the .idx and .pack.

Better that we degrade gracefully when faced with massive inputs
than we do something stupid by default and make the poor user pay
for their mistake of not throughly reading plumbing documentation
before use.


Now I would agree that we should punt on deltification of anything
that is just too large, and let the user decide what too large means,
and default it around 500 or 1024 MiB.  But I would still stuff it
into a packfile.

Maybe it still makes sense to have a limit on the maximum size of a
loose object to pack, but I think that's only to avoid the sick case
of a very simple no-argument "git repack" taking a long while because
there's 8 loose objects and 6 of them are 900 MiB image files.

Once in a packfile, I'd keep it there, even if the user decreases
the threshold, as the advantages of it being in the packfile outweigh
the disadvantages of it being in the packfile.  And there's like no
advantage to being loose once packed.


All of that is actually a very minor set of changes to the system,
and doesn't create odd corner cases.  It should also degrade better
out of the box.

> > ... why did I implement --max-blob-size instead
> > of --max-object-size?  I take this to mean that I should use
> > the blob size if undeltified, and the delta size if previously deltified?
> 
> No, I think the only sensible way for the end user to specify
> the size is uncompressed size of the object.  For a blob, that
> is the size of checked-out file.  IOW:
> 
> 	$ git cat-file $type $sha | wc -c
> 
> Nothing else would make any sense.

I agree.  And when you combine it with what I'm saying above about
only applying this to loose objects, its really quite easy to fetch
that value from the header and perform the test.

-- 
Shawn.
