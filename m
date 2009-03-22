From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Respect core.autocrlf when preparing temporary files
	for external diff
Date: Sun, 22 Mar 2009 02:10:46 -0400
Message-ID: <20090322061046.GA14765@coredump.intra.peff.net>
References: <cover.1237635609u.git.johannes.schindelin@gmx.de> <8cb424b16f21164ddc26d0be3f6f7727254b3506.1237635609u.git.johannes.schindelin@gmx.de> <7vocvuekjb.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903220053260.10279@pacific.mpi-cbg.de> <7v8wmybf06.fsf@gitster.siamese.dyndns.org> <7vzlfe9ynj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 07:14:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlGxI-0003D6-Sb
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 07:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbZCVGKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 02:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbZCVGKw
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 02:10:52 -0400
Received: from peff.net ([208.65.91.99]:36590 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbZCVGKv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 02:10:51 -0400
Received: (qmail 9685 invoked by uid 107); 22 Mar 2009 06:11:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 22 Mar 2009 02:11:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2009 02:10:46 -0400
Content-Disposition: inline
In-Reply-To: <7vzlfe9ynj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114122>

On Sat, Mar 21, 2009 at 05:41:52PM -0700, Junio C Hamano wrote:

> I have a suspicion that:
> 
>  (1) borrowing from the work tree may not be buying us very much these
>      days; the introduction of the logic predates not just "clean/smudge"
>      feature but packfiles.  Back then, the tradeoff was between opening a
>      loose object file, deflating and writing out a temporary and reusing
>      a file in the work tree.  These days, most of the time the former
>      would be to reconstruct a blob from the pack data that is already
>      mapped, and performance characteristics would be different.

I don't think this is the case. We only reuse the worktree file when we
have already read the index, which means the main user is "git diff
--cached". If a file's SHA1 is the same in the HEAD and the index, then
we don't need to run the diff at all. But if it is, then that implies
content newly added for a commit, which is probably not in a packfile,
but rather a loose object.

Try something like this with and without your patch:

  cd linux-2.6 &&
  git ls-files |
    while read f; do
      echo trivial change >>$f
    done
  git add -u
  git diff --cached

I get about 10.5s with stock git, and 13.5s with your patch (actually,
the first run with without reuse_worktree_file is doubly painful -- it
touches the disk for all of the newly written loose objects).

So I think it does make a difference now. The question, though, is:

>  (2) having to check if convert_to_working_tree() is a no-op or not may be
>      a lot more costly than any performance gain we get from borrowing
>      from the work tree.

...how expensive is the check for convert_to_working_tree? It should
just be a gitattributes lookup, shouldn't it? Which:

  a. we are doing anyway and caching

  b. which takes a fraction of a second (try "time git ls-files | git
     check-attr --stdin diff >/dev/null", which should give a
     worst-case).

To be fair, though, the diff I outlined above is pretty ridiculous.
Worktree reuse saved me three seconds, but out of 26683 files. Even if
you had 1000 files in your commit, that's still only .1s.

Where I think it _would_ make an impact is in crazy large-file
repositories. Where the I/O cost of dumping a 200MB avi into a tempfile
is actually meaningful. But for that, even the current code is not very
good; it is optimized for many small files. For a few large files, you
are probably better off reading the index from disk in order to make
that optimization for other cases (like tree to tree diff, where one of
the trees happens to have the same contents for the file as HEAD).

> You can work on top of this patch to add the convert_to_working_tree()
> call to prep_temp_blob().  Such a change would also affect the "textconv"
> codepath and the result will start feeding smudged contents to the
> "textconv" filter, and I think the argument "external tools prefer to be
> fed smudged contents, not clean ones, because that is the representation
> tailored for the platform" would hold even more stronger in that context.

In practice, I don't think it will affect textconv users much. The point
of textconv is to munge ugly binary files into something humans can
read. I'm not sure if people are actually smudging those (though I guess
people have talked about smuding openoffice files, so anything is
possible...).

Anyway, I was planning to make a patch to always feed textconv the
_clean_ version of each file. My thinking was:

  1. Then tools get a consistent view of the data across platforms.
     I.e., my textconv munger or external diff script will work no
     matter what you think the working tree should look like.

  2. The tool may want the clean version, or it may want the smudged
     version. Or it may be able to operate on either. If we give it a
     format it doesn't like, it will have to undo whatever we did.

     For most cases, we start with the clean file (i.e., from a tree or
     from the index).  If we hand out the clean file and the script
     doesn't like it, it pays the cost to smudge once. If we hand it the
     smudged file and the script doesn't like it, we pay the cost to
     smudge _and_ the script pays the cost to clean.

But I have to admit that I have never once used a clean/smudge filter in
an actual project. So I am coming at this purely from a hypothetical
position. I do think the format that any scripts get should be
consistent (i.e., always clean or always smudged), and textconv and
extdiff should use the same format.

One thing that I have considered that may make it moot is adding a
"fast" extdiff/textconv interface: instead of writing temp files, call
the script with the quick information (like sha-1 and filename), and let
it ask git for the data as appropriate.

In my case, I'm motivated by making textconv faster for my media repo;
the textconv script just displays the exif (and similar) metadata for
the files. So right now for each diffed file it writes out the entire
large file to a tempfile, reads the exif data, and prints it. If it got
just the sha-1 it could:

  - use its own caching layer (which my metadata reading tools already
    have) to avoid looking at the file at all, since it knows the
    textconv for a particular sha-1 is immutable

  - when it _does_ have to read, it can stream only as much data as it
    needs to get the metadata and never touch the disk at all. I.e., by
    piping from "git cat-file".

Given such an interface, it would also be trivial to ask cat-file for
your data with or without smudging, as appropriate. Which is not that
different from what you suggested earlier in the thread with "git
filter", except that instead of smudging the existing tempfile, we skip
the part where we write out the uninteresting bit. :)

So it's a little more work on the part of the script-writer (who now has
to know about getting the data from git instead of just opening some
files), but it can potentially be a lot faster. And of course I would
retain the original interface both for historical reasons and because it
is simpler to use; this would be diff.*.textconv-quick or similar.

>  diff.c |   69 ++-------------------------------------------------------------
>  1 files changed, 3 insertions(+), 66 deletions(-)

For some reason, with your patch the tempfiles are created with mode
0005 for me (whereas they are usually 0505), which makes open() in the
called script unhappy.  Looking over the patch text, though, I have no
idea what change could be causing that.

-Peff
