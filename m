From: Jeff King <peff@peff.net>
Subject: Re: Linear time/space rename logic for *inexact* case
Date: Mon, 22 Oct 2007 06:34:40 -0400
Message-ID: <20071022103439.GA16648@coredump.intra.peff.net>
References: <596909b30710220240g665054d8hc40bc5d2234ba9e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy C <andychup@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 12:34:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjucY-0007hl-Lh
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 12:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbXJVKen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 06:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbXJVKen
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 06:34:43 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3880 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbXJVKem (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 06:34:42 -0400
Received: (qmail 23544 invoked by uid 111); 22 Oct 2007 10:34:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 22 Oct 2007 06:34:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2007 06:34:40 -0400
Content-Disposition: inline
In-Reply-To: <596909b30710220240g665054d8hc40bc5d2234ba9e1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61982>

On Mon, Oct 22, 2007 at 02:40:08AM -0700, Andy C wrote:

> I just subscribed to this list, so sorry I can't respond to the
> threads already started here.  I'm the guy that was mailing Linus
> about this algorithm to do similarity detection in linear time,
> mentioned here:

Great, welcome aboard. :)

> To avoid the m*n memory usage of step 2, I use a hash table which maps
> 2-tuples to counts to represent the sparse similarity matrix, instead
> of representing it directly.  The 2-tuple is a pair of filenames,
> corresponding to the row/column of the matrix, and the counts/values
> are the entries in the matrix.

OK, makes sense (that's what I was trying to propose near the end of my
mail).

> You can also prune entries which have a long "postings list" (using
> the term in the IR sense here:
> http://www.xapian.org/docs/intro_ir.html).  This has the nice side
> effect of getting rid of quadratic behavior, *and* making the
> algorithm more accurate because it stops considering common lines like
> "#endif" as contributing to similarity.

Ah, very clever. I think that should have nice behavior most of the
time, though I wonder about a pathological case where we have many
files, all very similar to each other, and then have a commit where they
all start to diverge, but just by a small amount, while getting moved.
We would end up with an artificially low score between renamed files
(because we've thrown out all of the commonality) which may lead us to
believe there was no rename at all.

But it might be worth ignoring that case.

> This pruning of common lines from the index makes step 3 linear.  In
> fact, I prune the index to only include lines which occur just *once*.
>  Nearly every line of code in real data sets is unique, so this works
> well in practice.

Makes sense.

> http://marc.info/?l=git&m=118975452330644&w=2
> "Of course, 2 minutes for a git-status is still way too slow, so there we
> might still need a limiter. It also looks like 57% of my time is spent
> in spanhash_find, and another 29% in diffcore_count_changes."
> 
> I know there have been a couple fixes since you posted that, but if it
> was the O(m*n) behavior that was causing your problem, it should still
> be reproducible.  Linus suggested that this is a good data set to try
> things out with.  Is there there a repository I can clone with git
> commands to run to repro this?

Yes, I still have the problem (the 2 minutes was _after_ we did fixes,
down from 20 minutes; the latest patch from Linus just covers the "exact
match" case where two files have identical SHA1s).

It's a 1.2G repo at the end of a slow DSL line, so rather than cloning
it, here's a way to reproduce a repo with similar properties:

-- >8 --
#!/bin/sh
rm -rf repo
mkdir repo && cd repo

# seq and openssl aren't portable, but the
# point is to generate 200 random 1M files
for i in `seq -f %03g 1 600`; do
  openssl rand 100000 >$i.rand
done

# make repo, fully packed
# we don't bother trying to delta in the pack
# since the files are all random
git-init
git-add .
git-commit -q -m one
git-repack -a -d --window=0

# move every file
mkdir new
git-mv *.rand new

# modify every file
for i in new/*.rand; do
  echo foo >>$i
done
git-add new

# this is the operation of interest
time git-diff --cached --raw -M -l0 >/dev/null

-- >8 --

The idea is to have a large number of files that are slightly changed
and moved, and to try to find the pairs.  The diff takes about 20
seconds to run for me (the real repo has 1M files rather than 100K
files, but it's nice to have the tests take a lot less time). If you
want a bigger test, bump up the file size (or increase the number of
files, which will emphasize the quadratic behavior).

> 3) Compute the similarity metric, which I've defined here as
> max(c/|left file|, c/|right file|), where c the entry in the matrix
> for the file pair.  Note that the files are treated as *sets* of lines
> (unordered, unique).  The similarity score is a number between 0.0 and
> 1.0.  Other similarity metrics are certainly possible.

We have to handle binary files, too. In the current implementation, we
consider either lines or "chunks", and similarity is increased by the
size of the chunk.

> * Some people might be concerned that it treats files as unordered
> sets of lines.  The first thought might be to do this as a
> preprocessing step to cull the list of candidates, and then do a real
> delta.  But in my experience, I haven't encountered a case where
> there's all that much to gain by doing that.

I think we are already treating the files as unordered sets of lines.
And really, I think there is some value in that, anyway. If I reverse
the order of all lines in a file, it might be useful for git to say
"this file came from that file".

> * This can be run on all files, not just adds/deletes.  If I have a

Great. git has a "look for copies also" flag, but it is usually disabled
because of the computational cost. If we can get it low enough, it might
actually become a lot more useful.

> If anything about the explanation is unclear, let me know and I will
> try to clarify it.  Playing around with the demo should illuminate
> what it does.  You can run it on data sets of your own.  All you need
> is 2 source trees and the "find" command to produce input to the
> script (see setup_demo.sh).

I'll try it on my test data, but it sounds like it doesn't really handle
binary files.

> As mentioned, I will try to do some tests on this, perhaps with Jeff's
> hard data set, and show that the results are good and that the
> algorithm is faster because the quadratic behavior is gone (if Linus
> doesn't beat me to it!).

Trying to fit it into the C git code would be useful, but I doubt I'll
have time to work on it tonight, since it's getting onto dawn here.

-Peff
