From: "Andy C" <andychup@gmail.com>
Subject: Re: Linear time/space rename logic for *inexact* case
Date: Mon, 22 Oct 2007 16:47:21 -0700
Message-ID: <596909b30710221647y6a7481c5me41c31bbe1015e3a@mail.gmail.com>
References: <596909b30710220240g665054d8hc40bc5d2234ba9e1@mail.gmail.com>
	 <20071022103439.GA16648@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 01:47:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik6zr-0007YR-78
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 01:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbXJVXrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 19:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbXJVXrY
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 19:47:24 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:42642 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbXJVXrW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 19:47:22 -0400
Received: by py-out-1112.google.com with SMTP id u77so2802544pyb
        for <git@vger.kernel.org>; Mon, 22 Oct 2007 16:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A/o6gfS0IAD6IuGr4tOU+19Dos5ghpqAJZBA4HKF+iw=;
        b=TtALHTpwVVoPHfyi9Mb+JE6vpbkTQ8gKg+JoudXcWN0WYA5kEWdMRYIOMdaiTQ7pfkE5nrqp+m7ADTTIeR6m0B180F+I0o1o59Fc3EEHJgIdOu0G3Y4uFZ3RiQy1PWSWtn3PehXbcKljb+/FRAttUhEuIP2esx5+rHtW8Ruqvek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FLyy1ix6D4oNLPzw8WxYYiuB3Ng5cy+XNuGHXwgFWpJtnXWapLm6hF0ghPCOjLetszZvp6rvn5C/w6vzitF6L/eUfM5+y23lnR+D6u4Vf/SrDHGzjCpR7flKBh0e5OAp9s8OYyPaIfSx4OVCNe/YH53PLs3npPF0TpYiELiOrOI=
Received: by 10.35.85.16 with SMTP id n16mr6804430pyl.1193096841305;
        Mon, 22 Oct 2007 16:47:21 -0700 (PDT)
Received: by 10.35.91.3 with HTTP; Mon, 22 Oct 2007 16:47:21 -0700 (PDT)
In-Reply-To: <20071022103439.GA16648@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62060>

On 10/22/07, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 22, 2007 at 02:40:08AM -0700, Andy C wrote:
> > You can also prune entries which have a long "postings list" (using
> > the term in the IR sense here:
> > http://www.xapian.org/docs/intro_ir.html).  This has the nice side
> > effect of getting rid of quadratic behavior, *and* making the
> > algorithm more accurate because it stops considering common lines like
> > "#endif" as contributing to similarity.
>
> Ah, very clever. I think that should have nice behavior most of the
> time, though I wonder about a pathological case where we have many
> files, all very similar to each other, and then have a commit where they
> all start to diverge, but just by a small amount, while getting moved.
> We would end up with an artificially low score between renamed files
> (because we've thrown out all of the commonality) which may lead us to
> believe there was no rename at all.
>
> But it might be worth ignoring that case.

Well I do adjust the file sizes when pruning.  In the .py demo code
you can see it at these lines:

      for f in filelist:
        sizes[f] -= 1

The similarity metric depends on the sizes, so that way it won't get
out of whack if there are a lot of frequently occurring lines.

I did mention that pathological case to Linus.  The worst thing is if
you have N adds and N deletes and every single file is identical.
Well the convenient thing is that the pruning handles this gracefully.
 *Every* line in both indices will be pruned, and then the similarity
matrix will be completely empty, and no renames will be recorded.
Arguably that is what you want.  You don't want N^2 renames.  I guess
you could just assign them randomly to each other too for N renames.


> > http://marc.info/?l=git&m=118975452330644&w=2
> > "Of course, 2 minutes for a git-status is still way too slow, so there we
> > might still need a limiter. It also looks like 57% of my time is spent
> > in spanhash_find, and another 29% in diffcore_count_changes."
> >
> > I know there have been a couple fixes since you posted that, but if it
> > was the O(m*n) behavior that was causing your problem, it should still
> > be reproducible.  Linus suggested that this is a good data set to try
> > things out with.  Is there there a repository I can clone with git
> > commands to run to repro this?
>
> Yes, I still have the problem (the 2 minutes was _after_ we did fixes,
> down from 20 minutes; the latest patch from Linus just covers the "exact
> match" case where two files have identical SHA1s).
>
> It's a 1.2G repo at the end of a slow DSL line, so rather than cloning
> it, here's a way to reproduce a repo with similar properties:

Ah OK thanks.   This is a good test case for binary files, and my
Linux 2.4 vs Linux 2.6 test seems reasonable for text files.

> > 3) Compute the similarity metric, which I've defined here as
> > max(c/|left file|, c/|right file|), where c the entry in the matrix
> > for the file pair.  Note that the files are treated as *sets* of lines
> > (unordered, unique).  The similarity score is a number between 0.0 and
> > 1.0.  Other similarity metrics are certainly possible.
>
> We have to handle binary files, too. In the current implementation, we
> consider either lines or "chunks", and similarity is increased by the
> size of the chunk.

Yes, my thing doesn't handle binary files, but I have a variation of
the idea for that too which I'll explain below.

Can you explain what the current implementation does for binary files
in more detail, or point me to some docs?  I'm having a hard code
figuring out what the code is doing, even though the comments insist
that it is very simple : )

from diffcore-delta.c:
"
 * Idea here is very simple.
 *
 * Almost all data we are interested in are text, but sometimes we have
 * to deal with binary data.  So we cut them into chunks delimited by
 * LF byte, or 64-byte sequence, whichever comes first, and hash them.
"

What is the similarity metric for binary files?  Is it related to the
number of 64 byte chunks they have in common?  How do you know that
the 64 byte chunks match up?  Suppose I have 10k file, and then I
insert 10 random bytes at positions, 1000, 2000, 3000, etc.   How does
that work?

> > * This can be run on all files, not just adds/deletes.  If I have a
>
> Great. git has a "look for copies also" flag, but it is usually disabled
> because of the computational cost. If we can get it low enough, it might
> actually become a lot more useful.

Yes, there seem to be quite a few flags that have to do with trading
off features for computational time/memory.  I believe this algorithm
could be made fast enough to simplify the user interface a bit.  I'm
not yet super familiar with git, but I imagine it's probably hard for
some users to intuit what these thresholds do.

> > If anything about the explanation is unclear, let me know and I will
> > try to clarify it.  Playing around with the demo should illuminate
> > what it does.  You can run it on data sets of your own.  All you need
> > is 2 source trees and the "find" command to produce input to the
> > script (see setup_demo.sh).
>
> I'll try it on my test data, but it sounds like it doesn't really handle
> binary files.

Yes, I think we should try it out for text files first, since that's
probably the more important case.  But at the risk of getting a bit
ahead of myself, I think you can do a similar thing for binary files.

This first part isn't my idea; I heard it at a talk by Udi Manber at
Google, but I think it could be combined with my pruning and sparse
similarity matrix thing.  And it looks like there are already some of
the same ideas in git, though I'm still deciphering the code (any docs
on this area would help).

Basically his idea is that you take a rolling window of say 64 bytes
and create an inverted index, just like you do for text files.  So if
you have a 10,000 byte file, then there are (10,000 - 64) hashes to be
made.

This could be a lot, so you can speed it up by sampling.  But you want
to sample in such a way that preserves commonality.  That is, you
don't want to sample a given 64-byte sequence in one doc but miss it
in the other one.  So then all you do is keep all windows where the
hash code is 0 mod k (and you can adjust k that to achieve the
sampling rate you want).  If a given sequence is sampled in *one* doc,
then it's guaranteed to be sampled in *all* docs.

The second point is that you can do this rolling window hashing very
fast with a polynomial hash.  You can use the results of the previous
hash to compute the next hash.  I think you already have this in
diff-delta.c, but I'm not quite sure.  I'm not sure exactly what that
code is used for either (I don't think it is for the rename matching,
because that is done by estimate_similarity and
diffcore_count_changes?).

Once you have these 2 inverted indices of { sampled subset of 64-byte
substrings -> [list of documents] }  then you simply do the same thing
as I suggested for text files.  The logic is more or less the same.
If 2 files have many 64-byte substrings in common compared to their
sizes, then they are similar.  If a given 64-byte sequence (say
0000000000000...000) appears in many docs, then it's not a good
differentiator or indicator of similarity -- so throw it out.

(It occurs to me that it might be useful to do this with a small
window (8 bytes?) and a larger one (>64), and somehow combine the
results.  I guess some experimentation is in order, or maybe there is
some theory about that.)

So this is a linear algorithm too.  The hashing could have a high
constant factor, but the sampling and polynomial hashing should
basically eliminate that, I believe.

But like I said, it's probably better to concentrate on the text part
before anyone tackles that (at least I will look at the text case
first).  I have less experience with this algorithm, but it seems like
it should work just as well, and is quite simple.  I think both of
these algorithms are a bit more general and should lead to a net
reduction in lines of code, which is a good thing.

Andy
