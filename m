From: dwitch@nan92-1-81-57-214-146.fbx.proxad.net (Yann Dirson)
Subject: Re: stgit: bunch of bugreports/wishes
Date: Mon, 14 Aug 2006 21:24:22 +0200
Message-ID: <20060814192422.GA20336@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20060622221425.GA7851@nowhere.earth> <b0943d9e0606261404s38d4e316ja1af671f2d0d6e73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 21:24:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCi2d-0003eg-Da
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 21:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWHNTX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 15:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWHNTX7
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 15:23:59 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:35244 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932381AbWHNTX5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 15:23:57 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 30CDF225B7;
	Mon, 14 Aug 2006 21:23:55 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 033A91F011; Mon, 14 Aug 2006 21:24:22 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0606261404s38d4e316ja1af671f2d0d6e73@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25378>

Hi Catalin,

I was a bit out of time lately, following the birth of my 3rd child.
Now seems like a good moment to followup on this issue.

On Mon, Jun 26, 2006 at 10:04:07PM +0100, Catalin Marinas wrote:
> On 22/06/06, Yann Dirson <ydirson@altern.org> wrote:
> >Here are a number of problems I encountered while playing with
> >uncommit with 0.10:
> 
> "uncommit" was really intended as generating some simple patches from
> a linear list of commits (maybe for undoing a "stg commit" or after a
> git-am to modify some patches before pushint upstream). History
> re-writing is somehow outside StGIT's goals.

But uncommitting commits to an stgit stack is surely rarely done without
taking advantage of stgit main features afterwards, and that is history
rewriting anyway.  It's just another way of looking at it :)


> >- uncommit ignores grafts.  This causes "uncommit -n" to through
> >"graft merges" without asking, and surely gives unexpected result
> >when a graft is used to change an ancestor rather than adding one.
> [...]
> 
> I could fix "uncommit" to fail at this point but, as I said above, I
> wouldn't add extra features to this command.

This is most probably fixed by one of the 2 patches I just posted.  The
problem is not specific to uncommit at all, it impacts all commands
needing to look at the parents of a commit.

BTW, while I'm at it - I only changed the commit constructor to stop
reading from the commit object for parent identification, there may be
similar standard ways to access the other informations.

 
> Maybe you can explain your workflow a bit as I don't see the need for
> mass uncommitting.

The team is using CVS for history, and I'm working on a git mirror of
that repository.  In this repository we're importing upstream sources on
a branch, developping our own stuff in the CVS trunk, merging new
upstream versions as they are shipped to us.

Then we ship some of our changes upstream, and this is where I'd like to
use the power of stgit, to change the cvs history into a set of
coherent, feature-sized patches, to be fed upstream.

I manually maintain a grafts file to record the merges (and occasionally
get rid of cvs artifacts in the imported history), so my tree is full
of merges and grafts.


More recently, the work I've started today is about similarly
reorganizing the history of a linux-2.4 BSP for a custom board, to make
it more easy to maintain it.  In that case, I've taken a slightly different
approach, since I knew "uncommit" would not help: I have started a new
stgit branch, and "stgit pick"'d the individual patches from various
branches - but that was only reasonable because the number of patches
was low.


> >- when a push is not committed because of a conflict, looking at the
> >previous diff for the patch would help.  Maybe something like "stg
> >show --old" ?
> 
> "stg show <patch>//top.old" should show it (well, with a bit more
> typing than --old).

Hm, that does not seem to work with 0.10:

$ stg show pick-parent//top.old
stg show: Unknown revision: pick-parent//top.old^{commit}


> >-help = 'push a patch on top of the series'
> >-usage = """%prog [options] [<patch1> [<patch2>...]]
> >+help = 'push patches on top of the series'
> >+usage = """%prog [options] [<patch1> [<patch2>...] | -n <n> <patchroot>]
> 
> Does the <patchroot> syntax work?

I mean, that when using -n, the string is not a patchname, but a root
that gets suffixed by numbers, and in that case only one name can be
given.


While I'm at it, here is another list of problems I hit today with 0.10:

- "stg fold" short usage does not tell what <file> is used for                                                                                                                       
- I did not find a clean way to fold into current patch only the part of a patch
  impacted a given file.  Whereas I can use "stg show | filterdiff | stg
  fold" for file modifications, that fails to work for permission
  changes and the like.
  
- "stg patches" only reports about currently applied patches, it would
  be very useful to report on unapplied patches as well

- "stg patches -d" is broken, but that may be fixed in HEAD already
  (missing -- when calling git-diff-tree)

- commit.get_parent() silently returns 1st parent when there are several
  ones.  I think it should raise an exception instead, and callers must
  guard against failure.

- pick badly fails when hitting conflicts.  This is especially confusing when the
  conflicts only comes from grafts being ignored.  It is especially bad when using
  "pick" to create the 1st patch in a series : then "stg delete" on the partially
  created patch cannot recover the failure (IIRC it complains there is
  no current patch)

- Looks like trying to resolve a conflict by removing the file currently require
  a precise ordering of operations, or we need manual recovering.  In
  the following example, the mach-type.h files was removed in a patch
  below, and the conflict occurs because the current patch was modifying
  it.  This may as well be fixed by the -- in diff-index call, but I'd
  rather report it in case there is another remaining issue:

$ stg status
C include/asm-arm/mach-types.h
[...]
$ stg rm include/asm-arm/mach-types.h
$ stg resolved
include/asm-arm/mach-types.h
stg resolved: ['git-diff-index', 'HEAD', 'include/asm-arm/mach-types.h']
failed (fatal: ambiguous argument 'include/asm-arm/mach-types.h':
unknown
revision or path not in the working tree.
Use '--' to separate paths from revisions)
ydirson@unx-4791:linux-git[906]$ stg status
C include/asm-arm/mach-types.h

Emergency fixup:

$ :>include/asm-arm/mach-types.h
$ cg-add include/asm-arm/mach-types.h
Adding file include/asm-arm/mach-types.h
$ stg resolved
include/asm-arm/mach-types.h
$ cg-rm include/asm-arm/mach-types.h
Removing file include/asm-arm/mach-types.h


- "pick --fold" embeds \n's in sha1's ?  (this needs to be checked, it
  could be a side-effect of my initial implementation of using rev-list
  to identify parents)

$ ~/tools/git/stgit-0.10/stg pick --fold
8d8ecef22870e6a6b063d95d9b90d69e8391a0d0
Folding commit 8d8ecef22870e6a6b063d95d9b90d69e8391a0d0...stg pick:
['git-diff-tree', '-p', 'de47893112debe4cd3871162a0d1df0b73000e94\n',
'8d8ecef22870e6a6b063d95d9b90d69e8391a0d0'] failed (fatal: ambiguous
argument 'de47893112debe4cd3871162a0d1df0b73000e94
': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions)

whereas:

$ ~/tools/git/stgit-0.10/stg pick
8d8ecef22870e6a6b063d95d9b90d69e8391a0d0 -n import-fix
Importing commit 8d8ecef22870e6a6b063d95d9b90d69e8391a0d0... done
Now at patch "import-fix"

Best regards,
-- 
Yann.
