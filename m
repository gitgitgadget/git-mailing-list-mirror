From: Nicolas Pitre <nico@cam.org>
Subject: Re: Continue git clone after interruption
Date: Fri, 21 Aug 2009 17:07:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908211614220.6044@xanadu.home>
References: <1250509342.2885.13.camel@cf-48>
 <200908200937.05412.jnareb@gmail.com>
 <alpine.LFD.2.00.0908201358010.6044@xanadu.home>
 <200908211207.38555.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 23:08:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MebLC-0003WK-CV
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 23:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbZHUVH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 17:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbZHUVH4
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 17:07:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32861 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932672AbZHUVH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 17:07:56 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOQ0092NW13R1C0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 21 Aug 2009 17:07:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200908211207.38555.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126755>

On Fri, 21 Aug 2009, Jakub Narebski wrote:

> On Thu, 20 Aug 2009, Nicolas Pitre wrote:
> > On Thu, 20 Aug 2009, Jakub Narebski wrote:
> >> It is however only 2.5 MB out of 37 MB that are resumable, which is 7%
> >> (well, that of course depends on repository).  Not that much that is
> >> resumable.
> > 
> > Take the Linux kernel then.  It is more like 75 MB.
> 
> Ah... good example.
> 
> On the other hand Linux is fairly large project in terms of LoC, but
> it had its history cut when moving to Git, so the ratio of git-archive
> of HEAD to the size of packfile is overemphasized here.

That doesn't matter.  You still need that amount of data up front to do 
anything.  And I doubt people with slow links will want the full history 
anyway, regardless if it goes backward 4 years or 18 years back.

> You make use here of a few facts:
> 
> 1. Objects in packfile are _usually_ sorted in recency order, with most
>    recent commits, and most recent versions of trees and tags being in
>    the front of pack file, and being base objects for a large set of 
>    objects.  Note the "usually" part; it is not set in stone as for RCS
>    (and CVS) reverse delta based repository format.

Exact.  In theory the object order could be totally random and the pack 
would still be valid.  The only restriction at the moment has to do with 
OFS_DELTA objects as the reference to the base object is encoded as a 
downward offset from the beginning of that OFS_DELTA object.  Hence the 
base object has to appear first.  In the case of REF_DELTA objects, the 
base can be located anywhere in the pack (or anywhere else outside of 
the pack in the thin pack case).

> 2. There is support in git pack format to do 'deepening' of shallow
>    clone, which means that git can generate incrementals in top-down
>    order, _similar to how objects are ordered in packfile_.

Well... the pack format was not meant for that "support".  The fact that 
the typical object order used by pack-objects when serving fetch request 
is amenable to incremental top-down updates is rather coincidental and 
not really planned.

> 3. git-archive output is stable.  _git-archive can be made resumable_
>    (with range/partial requests), and can be made so it can create
>    single-head depth 0 shallow clone.
> 
> Also, with top-down deepening order even if you don't use 
> 'git clone --continue' but 'git clone --skip' (or something), you
> would have got usable shallow clone.  In the most extreme case when
> you are able to get only the fully resumable part, i.e. git-archive
> part (with top commit), you would have single-branch depth 0
> shallow clone (not very usable, but still better than nothing).

Right.

> > A special 
> > mode to pack-object could place commit objects only after all the 
> > objects needed to create that revision.  So once you get a commit object 
> > on the receiving end, you could assume that all objects reachable from 
> > that commit are already received, or you had them locally already.
> 
> Yes, with such mode (which I think wouldn't reduce / interfere with
> ability for upload-pack to pack more tightly by reordering objects
> and choosing different deltas) it would be easy to do a salvage of
> a partially completed / transferred packfile.  Even if there is no
> extension to tell git server which objects we have ("have" is only
> about commits), if there is at least one commit object in received
> part of packfile, we can try to continue from later (from more);
> there is less left to download.

Exact.  Suffice to set the last received commit(s) (after validation) as 
one of the shallow points.

> >> Documentation/technical/shallow.txt doesn't cover "shallow", "unshallow"
> >> and "deepen" commands from 'shallow' capability extension to git pack
> >> protocol (http://git-scm.com/gitserver.txt).
> > 
> > 404 Not Found
> > 
> > Maybe that should be committed to git in Documentation/technical/  as 
> > well?
> 
> This was plain text RFC for the Git Packfile Protocol, generated from
> rfc2629 XML sources at http://github.com/schacon/gitserver-rfc

I suggest you track it down and prod/propose a version for merging in 
the git repository.

> The description in Documentation/technical/pack-protocol.txt is very
> brief, and Documentation/technical/shallow.txt doesn't cover 'shallow'
> capability of git pack protocol.

Yeah.  I finally had a look directly at the code to understand how it 
works.

> >> P.S. As you can see implementing resumable clone isn't easy...
> > 
> > I've been saying that all along for quite a while now.   ;-)
> 
> Well, on the other hand side we have example of how long it took to
> come to current implementation of git submodules.  But if finally
> got done.

In this case there is still no new line of code what so ever.  Thinking 
it through is what takes time.

> The git-archive + deepening approach you proposed can be split into
> smaller individual improvements.  You don't need to implement it all
> at once.
> 
> 1. Improve deepening of shallow clone.  This means sending only required
>    objects, and being able to use as a base objects that other side has
>    and send thin pack.

Yes.  And now that I understand how shallow clones are implemented, I 
Probably will fix that flaw soon.  Won't be hard at all.

> 2. Add support for resuming (range request) of git-archive.  It is up
>    to client to translate size of partial transfer of compressed file
>    into range request of original (uncompressed) archive.
> 
> 3. Create new git-archive pseudoformat, used to transfer single commit
>    (with commit object and original branch name in some extended header,
>    similar to how commit ID is stored in extended pax header or ZIP
>    comment).  It would imply not using export-* gitattributes.

The format I was envisioning is really simple:

First the size of the raw commit object data content in decimal, 
followed by a 0 byte, followed by the actual content of the commit 
object, followed by a 0 byte.  (Note: this could be the exact same 
content as the canonical commit object data with the "commit" prefix, 
but as all the rest are all blob content this would be redundant.)

Then, for each file:

 - The file mode in octal notation just as in tree objects
 - a space
 - the size of the file in decimal
 - a tab
 - the full path of the file
 - a 0 byte
 - the file content as found in the corresponding blob
 - a 0 byte

And finally some kind of marker to indicate the end of the stream.

Put the lot through zlib and you're done.

> 4. Implement alternate ordering of objects in packfile, so commit object
>    is put immediately after all its prerequisites.

That would require some changes in the object enumeration code which is 
an area of the code I don't know well.

> 5. Implement 'salvage' operation, which given partially transferred 
>    packfile would deepen shallow clone, or advance tracking branches,
>    ensuring that repository would pass fsck after this operation.
> 
>    Probably requires 4; might be not possible or much harder to salvage
>    anything with current ordering of objects in packfile.
> 
> 6. Implement resumable clone ("git clone --keep <URL> [<directory>]",
>    "git clone --resume" / "git clone --continue", "git clone --abort",
>    "git clone --make-shallow" / "git clone --salvage").

Right.  This is all doable fairly easily.


Nicolas
