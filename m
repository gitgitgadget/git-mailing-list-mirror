From: Jeff King <peff@peff.net>
Subject: Re: git status --porcelain is a mess that needs fixing
Date: Sat, 10 Apr 2010 00:09:59 -0400
Message-ID: <20100410040959.GA11977@coredump.intra.peff.net>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Raymond <esr@snark.thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 06:10:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0S1p-0007P0-Jd
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 06:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811Ab0DJEKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 00:10:24 -0400
Received: from peff.net ([208.65.91.99]:49248 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719Ab0DJEKY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 00:10:24 -0400
Received: (qmail 13283 invoked by uid 107); 10 Apr 2010 04:10:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 00:10:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 00:09:59 -0400
Content-Disposition: inline
In-Reply-To: <20100409184608.C7C61475FEF@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144498>

On Fri, Apr 09, 2010 at 02:46:08PM -0400, Eric Raymond wrote:

> First, the documentation issues, in roughly increasing order of severity:

Note that "status --porcelain" is brand new in v1.7.0, so you may be
among the first to be seriously reading the documentation. As Junio
said, I think patches in this area are very welcome.

My answers below are meant to help you understand. I omitted the "...and
yes, this should be documented better" from the end of each, but you can
say it in your head if you want.

> 1. What separates the XY column from the first path?
> 
> I'd assume a tab, but it's not documented. It needs to be documented.

It's a space.

> 2. What separates the '->' on either side from the path columns?
> 
> Not documented.  Needs to be documented.

It's a space. But more importantly, the path columns are actually
C-quoted. E.g.:

  $ perl -e 'open foo, ">", "foo\n"'\
  $ git add .
  $ git status --porcelain
  A  "foo\n"

If your parser supports it, it will almost certainly be easier to use
"-z":

  $ git status --porcelain -z | cat -A
  A  foo$
  ^@

Do note that for the 'R'ename status, you will get _two_ NUL-terminated
entries, and they will be in the order of "to\0from\0", whereas the
non-NUL form is "from -> to" (and no, I doubt this is adequately
documented, either).

> 3. What do the status codes M A D R C mean?
> 
> I can guess, but I should not have to guess.  They should be documented.

They are the same as in "git diff --name-status", which in turn has kind
of crappy documentation. Patches welcome for both issues.

> 5. What is 'us' versus 'them'? What are "stage #2" and "stage #3"?
> 
> It makes my brain hurt just trying to list all the things "us"
> and "them" could mean.

The terms "us / ours" and "them / theirs" are frequently used in the git
documentation.  I'm not sure if they are ever defined rigorously. They
are only meaningful in a merging context, and basically refer to the two
sides of a merge. If I am on branch "master" and do "git merge foo",
then "us" refers to the master branch and the the contents of index
stage 2 (bear with me a moment, I'll define that in a second). "Them"
refers to branch "foo" and index stage 3.

Git's "index" is where it keeps uncommitted state about files it tracks
(sort of like CVS/Entries, if that helps, except that git exposes the
concept much more). Most of the time, you use it for building a commit
incrementally. You "git add" files to the index, and then "git commit"
creates a new commit from the contents of your index.

But the index actually has several different slots for each file entry,
which are called stages, and each has a number. "Stage #0" is the
"normal" stage, which you use as described in the last paragraph. During
a merge, entries with conflicts use the other stages. The stage #1 entry
contains the common ancestor. Stage #2 contains our original version
from before the merge. Stage #3 contains the other side's original
version from before the merge.

The details of how they are used is discussed in "git help read-tree",
under "3-Way Merge". Those details are way too gory for somebody
interested in "git status" output, but you might find them interesting.
For the "git status" documentation, it probably makes sense to keep
things simple and just indicate that XY shows what each side of a 2-way
merge did to the file.

> A. The '->' separator considered harmful
> 
> The '->' was superfluous and thus a poor design choice; the
> distinction between two columns and three columns is easy enough to
> make in any scripting language.  As it is, it's meaningless and
> scripts will actually have to go to some extra effort to throw it
> away.
> 
> I think the underlying problem here is that whoever designed this
> never got past the idea that it needed to have cues for human
> eyeballs in it.  That was a mistake.  If you're serious about it
> being easily parseable, design it that way.

Short answer: use -z.

Long answer:

This is my fault, to some degree. The "short-status" form _is_ meant for
human eyeballs, and was designed by Junio. Some people wanted a
scriptable status output, too, so I slapped a "--porcelain" on the same
format that turns off configurable features like relative pathnames and
colorizing, and makes an implicit promise that we won't make further
changes to the format. The idea was to prevent people from scripting
around --short, because it was never intended to be stable.

So yeah, while --porcelain by itself _is_ stable and scriptable, it is
perhaps not the most friendly to parsers. The "-z --porcelain" format is
much more so, and I would recommend it to anyone scripting around
"git status". I think a note in the documentation to that effect would
be helpful.

> B. Does "untracked" include "ignored"?
> 
> If so, that is a problem -- front ends care about the difference, for
> example when C-x v v is trying to compute the logical next action.
> For an unregistered file, it's to register it.  For an ignored file,
> it's to throw a user-visible error.

No. Ignored files are not listed at all.

If you really want a list of ignored files, I think you are stuck
comparing the output of "git ls-files -o" and "git ls-files -o
--exclude-standard".

> C. If "untracked" does not include "ignored", how is an ignored file tagged?
>
> If ignored files are not listed, that's another problem. Even more
> serious, actually.

See above.

It wouldn't be too hard to add them in, and would look something like
the patch below. But it would still need:

  1. For me to investigate that "ugh" comment below.

  2. It should be conditional on a command-line option. Many users won't
     want to see it.

  3. For full-length status (i.e., "git status") in my patch the
     information is just ignored. If the user specified it on the
     command-line, I guess we should show it.

> D. How do I tell the conflict/no-conflict cases apart?

Junio already answered this one, and I agree with his analysis that it
is a documentation bug.

> E. Are you *really* using a space as a status character?

Yes. I agree that a "-" probably would have been nicer for parsing, but:

> It certainly appears so from the first and seventh rows of the table.
> If so, this was a major blunder. It complicates parsing code
> unnecessarily, because the easiest way to separate columns is with the
> equivalent of a Python or Perl split() operation that will eat that
> space.  Then we have to special-case depending on the field width.

Your parser is already broken if you are calling split, as the filenames
may contain spaces (and will be quoted in that case, and you need to
unmangle). You should use "-z".

You will probably then realize that the "-z" format looks like:

  XY file1\0file2\0

which still sucks. It would be more friendly as:

  XY\0file1\0file2\0

So you could split on "\0". But even with that, you can't just blindly
split, as the column and record separators are the same, and you might
have one or two filenames.

So you really are stuck parsing it as one char of X, one char of Y, a
junk space, and then depending on X/Y, either one or two filenames.

> This may sound like a nitpick, but it's actually a crash landing, or
> close to it.  Front-end writers look at things like this and think
> "Idiots.  Can't trust them an inch...".  And git already has a bad
> reputation for interface spikiness to live down.

I agree with most of your criticisms. The question is what we want to do
about it.

Documentation fixes and an optional --show-ignored are easy. Output
format problems are harder. We can:

  (1) Ignore it. The problems make parsing harder, but it isn't
      completely broken (which I would consider it to be if, for
      example, there was impossibly ambiguous output).

  (2) Quietly change it.  The --porcelain format has been released in
      one major version. I don't know if anybody is actually using it
      yet. It is tempting to just fix it and say "we botched v1.7.0,
      don't use it". It is such a new feature that script writers
      already have to check the version to see if we even support
      --porcelain at all (or accept breakage for older versions).

      But usually we have more restraint than that about backwards
      incompatible changes. And given that it _isn't_ totally broken,
      I don't think it's justified.

  (3) Introduce --porcelain=v2 with an alternate format.

Personally, I think I am in favor of (1). Option (3) is going to
introduce maintenance headaches, but more importantly, I wonder if it is
just going to confuse people more with "Which porcelain version should I
use?  Which versions of git support which porcelain versions?"
questions.

-Peff
