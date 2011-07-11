From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Mon, 11 Jul 2011 18:01:07 -0400
Message-ID: <20110711220107.GC30155@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 00:03:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgOZu-0006Ho-9d
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 00:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757608Ab1GKWBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 18:01:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35642
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165Ab1GKWBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 18:01:09 -0400
Received: (qmail 5650 invoked by uid 107); 11 Jul 2011 22:01:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jul 2011 18:01:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2011 18:01:07 -0400
Content-Disposition: inline
In-Reply-To: <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176903>

On Mon, Jul 11, 2011 at 12:17:56PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As I mentioned earlier, I wanted this to be generic and size-agnostic,
> > because I'd also like to try caching patch-ids for git-cherry.
> 
> Sounds like a good thing to aim for, but "Object Cache" sounded too much
> like giving access to the object data that is faster than either loose or
> packed objects.

Agreed. I'm open to better suggestions for the name. I would have just
called it a straight out "cache" as it can be used for caching anything,
but that term is already taken in git. :)

You could argue we are caching metadata about objects, so something like
object_metadata_cache might be OK. I dunno.

> This is a completely unrelated tangent but because you brought up
> patch-ids ;-), the other day I tried to rebase mm patches on top of
> updated linux-next while trying to help Andrew, and noticed that in real
> life, many "duplicate" patches you find in updated upstream are "slightly
> reworded better" and "rebase --skip" is often the right thing to do, but
> it is often very difficult to diagnose, as (1) the patch you are trying to
> apply from your old series may be part of a long patch series, and (2) the
> commit you are trying to re-apply the said patch to, i.e. the updated
> upstream, may already contain many of these semi-duplicate patches. The
> conflict resulting from "am -3" in such a situation is not very pleasant
> to look at (it looks mostly as if you are reverting the effect of updated
> versions of later patches in your series).

Yeah, I run into this in git.git because I aggressively rebase my topics
on what you apply upstream. Usually it's very helpful, as I either skip
patches automatically if patch-ids match (which means I throw away my
version in favor of what you marked up based on list comments), or I get
a conflict that looks like:

  <<<<<<< HEAD
  /* what you marked up */
  =======
  /* what I originally had */
  >>>>>>> jk/foobar

and I can easily confirm that what you have is better and resolve in
favor (or if not better, I can go on the list and complain :) ).

But what I sometimes run into, and what I think you are mentioning with
"looks as if you are reverting" is when you have changes that textually
build on one another. For example:

  git init repo &&
  cd repo &&

  # make one base commit
  echo base >base && git add base && git commit -m base &&

  # now make a "topic" of two commits that textually build on one another
  git checkout -b topic &&
  echo one >file && git add file && git commit -m one &&
  echo two >file && git add file && git commit -m two &&

  # now pretend that they got applied upstream, but with a
  # slight tweak only in the first patch so that patch-ids don't match
  git checkout master &&
  echo 'modified one' >file && git add file && git commit -m one &&
  echo 'two' >file && git add file && git commit -m two &&

  # and now rebase the series on top
  git rebase master topic

What you would like to see (and what you would see without the second
commit) is:

  <<<<<<< HEAD
  modified one
  =======
  one
  >>>>>>> one

which quite obviously shows that your patch was marked up, and the
resolution is clear. But with a commit no top, you get:

  <<<<<<< HEAD
  two
  =======
  one
  >>>>>>> one

which looks like you are reverting, because of course you are building
on top of the finished series.

I think the only solution would be to do a better job of heuristically
matching up commits when rebase skips already-in-upstream commits. I
know we discussed it recently and decided that the false positives are
too dangerous for it to just skip based on something like the commit
message. I.e., even though they probably _are_ the same commit, the fact
that the patches don't match is actually really important, and the user
needs to see the conflict.

But we can show them the differences in other ways besides trying to
apply the patch and coming up with a conflict. For example, for any
commit that we think we have already in upstream (by commit message or
whatever heuristic), but whose patch-id is not found, we could show the
interdiff between the possible upstream commit and the rebased commit,
and say "Do you want to skip this?".

Then instead of having to look at the merge conflict of commit one on
top of upstream's commit two, you get to see what commit one would look
like on top of the upstream's commit one. Which is a lot more readable.
So the human is still involved, and still gets to see the conflicting
text, but it's in a much more useful form.

Does that make sense? In this example, I would expect something like:

  $ git rebase master topic
  Applying: one
  Using index info to reconstruct a base tree...
  Falling back to patching base and 3-way merge...
  Auto-merging file
  CONFLICT (content): Merge conflict in file
  Failed to merge in the changes.
  Patch failed at 0001 one

  hint: this commit may already be in upstream as 1234abcd;
  hint: the differences between that commit and this one are:

  diff --git a/file b/file
  --- a/file
  +++ b/file
  @@ -1 +1 @@
  -modified one
  +one

  When you have resolved this problem run "git rebase --continue".
  If you would prefer to skip this patch, instead run "git rebase --skip".
  To restore the original branch and stop rebasing run "git rebase --abort".

And then the user can decide to look at the conflict, or skip based on
the interdiff. For that matter, we can let them run the equivalent of
the interdiff themselves if we simply give them commit sha1s for the
potential upstream and the patch we're applying.

-Peff
