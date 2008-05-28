From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 17:41:18 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805281649310.19665@iabervon.org>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com> <7vfxs2uytm.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0805281326520.19665@iabervon.org>
 <7vskw2tgu2.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0805281455100.19665@iabervon.org> <7v7idetb1h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 23:42:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1TPZ-0004vZ-6p
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 23:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbYE1Vl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 17:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752939AbYE1Vl3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 17:41:29 -0400
Received: from iabervon.org ([66.92.72.58]:42289 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278AbYE1Vl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 17:41:28 -0400
Received: (qmail 12323 invoked by uid 1000); 28 May 2008 21:41:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 May 2008 21:41:18 -0000
In-Reply-To: <7v7idetb1h.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83138>

On Wed, 28 May 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Ah, yes, CE_VALID. But it doesn't quite work as well as I'd like, because 
> 
> No, I do not think we should involve CE_VALID here.  It means something
> completely different.  What I meant was that through "git status" the user
> can tell there is an unexpected breakage in the work tree, _if_ we make
> checkout to finish with "best effort" (and still report an error).

I think there are two separate issues here: (1) you've gotten partway 
through a checkout, and something fails, and we want to leave things in as 
good shape as possible; (2) you're trying to check out a tree that can't 
be accurately represented on your filesystem. In case (2), there's a good 
chance that you want to leave the unrepresentable stuff alone or modify it 
in the index without going through the filesystem.

Case (2) is very much like working on a filesystem without +x bits, where 
you'd really like to ignore what the filesystem reports and only diverge 
from what was read into the index from a tree object when the user makes 
explicit modifications to the index, rather than updating the index from 
the working directory state.

> > I think the right test for this is if create_file() returns EEXIST, but 
> > readdir doesn't show anything.
> 
> I think relying on EEXIST is too specific for this particular breakage,
> even though such a test may catch it. 

It's not just EEXIST; it's EEXIST for a filename with no struct dirent.

> A checkout may fail in the middle if a filesystem refuses to create a 
> pathname that has certain characters in it (e.g. dosen't NTFS refuse a 
> path with :|<"?*> in it, or is it just the Explorer UI layer rejecting 
> them?), or perhaps one leading directory may be unwritable.  We would 
> want to catch and cope with such a brokage the same way.

I think the leading directory thing is qualitatively different; you're 
probably not going to want to create a patch to rename all of the files in 
that directory to be in a directory that's not owned by a different user 
on your machine, while you are likely to try to get a project to use less 
odd names if there's a filename with a : in it or something. I'm not sure 
what error open() will give you for that.

The other interesting case is when the filesystem is case insensative and 
the project contains files that differ only in case; again, the filesystem 
will report EEXIST on open for a path that readdir doesn't list.

> The checkout "unpack-trees" codepath does:
> 
>  - Make sure things can be checked out safely with the internal data
>    before doing anything to the filesystem, i.e. no lost local changes, no
>    lost untracked files, etc.
> 
>  - For each path:
> 
>    - make room for it, removing directory at the place as necessary where
>      a blob must sit and removing an existing blob as needed;
> 
>    - create a new file or symlink;
> 
> And currently I think we stop on any failure.  The thing is, stopping on a
> failure during the internal checking is fine --- no external damage has
> been made yet.  But once we started updating the work tree, we _are_
> committed and not aborting in the middle for a single failure would be the
> saner thing to do.  In addition, even after such a failure after we are
> committed, we probably should update the HEAD and the index.
> 
> "status" would then show the difference between what should have been
> checked out and what is.  It might be enough to improve the issue of "git
> bisect hitting a checkout failure --- the work tree is half checked-out
> state, and the index, the HEAD, and the work tree are in a very
> inconsistent state".

For case (1), things are in an inconsistant state; for case (2), the index 
and HEAD agree, and there are known gaps in the work tree.

> We would probably signal such an error from git-checkout differently from
> an early refusal that does not do anything, to tell the callers, such as
> "git-bisect", that the checkout _has been_ already done, even though there
> may be breakages in the work tree.
> 
> > ... that notes the situation where you seem to have file A instead of 
> > file B, but fstat("B") returns A's inode, and marks the index to say that 
> > entry B is listed in the filesystem as A instead.
> 
> I personally do not think such auto-substution is a way to go --- what
> makes you trust inode information from such an untrustworthy filesystem
> that does not do what it was told to do?  I suspect that stopping at the
> error site and not automatically making the damage yet larger by doing
> such magic would keep the recovery procedure simpler.

People seem to use Windows and OS X despite the filesystems being broken. 
There seems to be a space of filesystems which aren't corrupted, but do 
unexpected things with respect to filenames. If we can find appropriate 
filenames, the content is stored reliably (or the open O_EXCL is refused). 
We should be able to identify that the user isn't trying to make a change 
by way of the working directory when the difference we see is something 
that isn't clearly representable by the filesystem.

> But I wouldn't keep people from experimenting.  Perhaps the end result
> could be even readable and mergeable, although I am quite pessimistic.

I think, in any case, that it should be pretty clean to have a "filesystem 
is inadaquate" CE flag, which mean that we just ignore the filesystem. 
Finding things that are reported with the wrong name is probably harder.

	-Daniel
*This .sig left intentionally blank*
