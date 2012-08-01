From: Jeff King <peff@peff.net>
Subject: Re: rename detection
Date: Wed, 1 Aug 2012 16:39:41 -0400
Message-ID: <20120801203941.GA11940@sigill.intra.peff.net>
References: <501799CF.1080100@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gerlando Falauto <gerlando.falauto@keymile.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 22:40:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swfhz-0001Cp-7d
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 22:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab2HAUjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 16:39:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46724 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754963Ab2HAUjs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 16:39:48 -0400
Received: (qmail 9953 invoked by uid 107); 1 Aug 2012 20:39:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Aug 2012 16:39:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Aug 2012 16:39:41 -0400
Content-Disposition: inline
In-Reply-To: <501799CF.1080100@keymile.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202723>

On Tue, Jul 31, 2012 at 10:39:43AM +0200, Gerlando Falauto wrote:

> I have some questions about rename detection.
> The way I understand it, renames are not tracked in any way by GIT,
> at least not in the repository. Instead some detection algorithm is
> executed when data is extracted from the repository, prior to being
> presented to the user (i.e., git format-patch, git log, git show
> etc...), therefore depending on the command line and client used.

Right. Rename detection is always part of performing a diff. The
commands you mention above are internally doing a diff between a commit
and its parents. But you could also detect renames between any two
arbitrary trees.

Which is part of the reason that git does it this way. Giving each path
a unique identity and tracking the renames explicitly across history
means that when comparing two arbitrary trees (which is how some other
systems do it), you would have to know the history relationship between
the trees in order to show the renames. That's slow (for example, when
merging, git does not look at the tree state of intermediate commits; it
only looks at the branch point and the two endpoints). It's also less
flexible; git fundamentally does not care how each side reached its
state, only where it ended up.

> Some of those mechanisms are also in place when stuff gets commited.
> For instance, I get some rename indications when editing the commit
> message, and as the output of git commit itself.
> I would assume the mechanisms would be exactly the same.

Right. The template shown by "git commit" is just the output of "git
status", which is in turn just another diff. The "to be committed"
section is the diff between the HEAD and the index, and the "changes not
marked for commit" is the diff between the index and the working tree.

And after you complete the commit, the summary shown is from the diff
between what you committed and the previous commit.

> Things get a bit more complicated when you actually "merge" files
> (not in the git-tish sense, I mean physically move the content of one
> file into the other). Here is a test which includes a bigger file
> within a smaller file.
> [...]
> hexdump -C -n 5120 /dev/urandom > file2
> hexdump -C -n 2560 /dev/urandom > file1
> (head -n 40 file1; cat file2; tail -n+40 file1) > file3

So file3 has file2 stuck in the middle of file1. But since file2 is
twice as big as file1, that means the result is 1/3 file1, and 2/3
file2.

> git rm file1 file2
> git add file3
> git commit -m "including file2 within file1 as file3"
> git log --summary -M10% -C -1

Here we should see a rename from file2 to file3 (we will choose file2
because it shares more content with file3 than file1)

And we do (I'm quoting your message out of order from here out to show
output next to commands):

> [master 424edab] including file2 within file1 as file3
>  2 files changed, 162 insertions(+), 161 deletions(-)
>  delete mode 100644 file1
>  rename file2 => file3 (66%)
> commit 424edab771495fc3a1b4c172b9fcef9418501266
> Author: Gerlando Falauto <gerlando.falauto@keymile.com>
> Date:   Tue Jul 31 10:27:42 2012 +0200
> 
>     including file2 within file1 as file3
> 
>  delete mode 100644 file1
>  rename file2 => file3 (66%)

Moving on, we next put the new content in file1:

> git mv file3 file1
> git commit --amend -m "including file2 within file1 as file1"
> git log --summary -M10% -C -1

The diff shown by the commit summary and by "git log" will be the diff
between the initial state (both file1 and file2) and the new state
(file1 is now mostly file2, and file2 has gone away). But you get
inconsistent results, even though we are diffing the same trees:

> [master ca70367] including file2 within file1 as file1
>  1 file changed, 162 insertions(+)
>  rename file2 => file1 (66%)
> commit ca7036705063adbbd3c8cd0b5bccd5fbf44075bf
> Author: Gerlando Falauto <gerlando.falauto@keymile.com>
> Date:   Tue Jul 31 10:27:42 2012 +0200
> 
>     including file2 within file1 as file1
> 
>  delete mode 100644 file2

Why? Because the diff options used by git-commit to generate its summary
are not the same as the ones you told git-log to use. The short answer
is that you can get the same result by using "-B".

To understand why, you first need to understand how the rename detection
works. Basically, we have a set of candidate sources (files which were
removed) and a set of candidate destination (files which were added),
and we try to match them up to create rename pairs by comparing their
content. The comparison is expensive and has complexity O(src*dst), so
we want to keep those numbers low to keep the cost of the computation
down.

For basic renames (i.e., "-M") we consider only removed and added files
as candidates, since a rename must involve those. When you specify "-C",
that looks for copies: we increase the source candidate set to include
files which were modified but not deleted. In other words, a copy is
just a rename where the source did not go away. We limit it to modified
files for practical purposes; it keeps the computation low, and when you
are copying the content, you tend to make modifications to the original
file.

If you specify --find-copies-harder (or use "-C" twice), git will also
include even unmodified files in the source list. This is very expensive
to compute, but can find instances where you copied without modifying
the original at all.

But what about the destination side? There is no orthogonal option to
say "include all modified files in the destination list". Such an option
could be used for finding a copy when a file existed, but absorbed most
of another file (as in this case). But it turns out not to be needed, as
you'll see in a minute.

So at this point, you should understand why your "git log" does not show
the rename; because file1 existed both before and after, it is not a new
file, and therefore not a destination candidate. But why does "git
commit" show it?

For that, we have to understand what "-B" does: break detection. This
acts on the diff results before they get to the rename phase, and tries
to break apart file modifications that substantially rewrite the file
content into two separate entries: deleting the old file, and adding the
new file at the same path.  Those entries then become eligible source
and destination candidates for rename detection.

In this case, file1 was substantially rewritten (2/3 of its content is
new), so we break it, letting us use it as both a source and destination
candidate. And since file2 is already a source candidate (since it went
away), we do the exact same rename detection as above (modulo that the
destination candidate's path is now "file1" instead of "file3"), and
find that file2 is the best source.

In your final example, we do:

> git mv file1 file2
> git commit --amend -m "including file2 within file1 as file2"
> git log --summary -M10% -C -1

Same thing, except the content is placed in file2. And we get:

> [master d7fdea4] including file2 within file1 as file2
>  2 files changed, 162 insertions(+), 161 deletions(-)
>  delete mode 100644 file1
> commit d7fdea4855efe8401562a53ec7093c80390ee274
> Author: Gerlando Falauto <gerlando.falauto@keymile.com>
> Date:   Tue Jul 31 10:27:42 2012 +0200
> 
>     including file2 within file1 as file2
> 
>  delete mode 100644 file1

No rename detection at all, in either case. Why? In the log case, it is
for the same reason above; we don't have break detection turned on, and
file2 is not a destination candidate for renames.

For commit, it is because the break algorithm did not consider the
resulting file2 to be different enough from its original version. That's
because 2/3 of the content is the same, and only 1/3 actually changed.
If you feed the break-detector a low enough score (e.g., -B30%) then it
will consider it a rename (albeit a poor one). E.g.:

  git log --summary -B30% -M30%

> So including file2 (bigger) within file1 (smaller):
> a) gets always (commit+extraction) detected as a rename file2=>file1
> if the merged file is file3 (new file).
> b) gets detected as a rename ONLY during commit (but not while
> extracting) if the merged file is file1 (existing file)
> c) doesn't ever get detected as a rename if the merged file is file2
> (which makes sense, being file2 more similar to itself than to file1)
> 
> So now my two questions:
> 
> 1) Is the behavior in b) correct? Shouldn't it at least be made consistent?
> 2) Would it make any sense to track (or detect) such "inclusion"
> cases? Is there any recommended or standard practice for performing
> such operations as file merge/split (i.e. when refactoring code or
> something)?

Hopefully the above has answered these questions for you.

However, I hope it has also showed the limitations of pure file renames
when you are looking at content movement from one file to another. For
that, you are much better off looking at something like "git blame -C
file2", which gives you line-by-line content attribution. For example,
on the final commit you produce in your example, it will properly show
which lines came from file1 and which came from file2.

-Peff
