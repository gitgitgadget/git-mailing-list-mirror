From: Jeff King <peff@peff.net>
Subject: Re: another packed-refs race
Date: Mon, 6 May 2013 14:41:23 -0400
Message-ID: <20130506184122.GA23568@sigill.intra.peff.net>
References: <20130503083847.GA16542@sigill.intra.peff.net>
 <51879C1C.5000407@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 06 20:41:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQLr-0008NT-4W
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 20:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063Ab3EFSl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 14:41:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:40495 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754511Ab3EFSlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 14:41:25 -0400
Received: (qmail 21138 invoked by uid 102); 6 May 2013 18:41:45 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 13:41:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 14:41:23 -0400
Content-Disposition: inline
In-Reply-To: <51879C1C.5000407@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223481>

On Mon, May 06, 2013 at 02:03:40PM +0200, Michael Haggerty wrote:

> > We could fix this by making sure our packed-refs file is up to date
> 
> s/file/cache/

Yeah, I meant "our view of the packed-refs file", but I think "cache"
says that more succinctly. I'll be sure to make it clear when I start
writing real commit messages.

> Let me think out loud alongside your analysis...
> 
> By this mechanism the reader can ensure that it never uses a version of
> the packed-refs file that is older than its information that the
> corresponding loose ref is absent from the filesystem.

Yes, that's a good way of saying it.

> This is all assuming that the filesystem accesses have a defined order;
> how is that guaranteed?  pack_refs() and commit_ref() both rely on
> commit_lock_file(), which calls
> 
>     close(fd) on the lockfile
>     rename(lk->filename, result_file)
> 
> prune_ref() locks the ref, verifies that its SHA-1 is unchanged, then
> calls unlink(), then rollback_lock_file().
> 
> The atomicity of rename() guarantees that a reader sees either the old
> or the new version of the file in question.  But what guarantees are
> there about accesses across two files?

I don't know offhand if any standard makes such guarantees. But there
are other parts of git that do depend on that ordering. For example, I
create a loose object representing commit X. Then I update a ref to
point to X. If the ordering of those operations is not preserved, then a
simultaneous reader would think that the repository is corrupted (the
ref points to a missing object).

I would not be surprised if there are distributed or networked
filesystems for which this property does not hold. But I suspect it does
hold for operations on a single machine with a decent kernel (I would
imagine the VFS layer takes care of this). I am just basing my suspicion
on experimental results (the patch I sent does seem to work on my ext4
system).

> The loose refs cache is only used by the for_each_ref() functions, not
> for looking up individual references.  Another approach would be to
> change the top-level for_each_ref() functions to re-stat() all of the
> loose references within the namespace that interests it, *then* verify
> that the packed-ref cache is not stale, *then* start the iteration.
> Then there would be no need to re-stat() files during the iteration.
> (This would mean that we have to prohibit a second reference iteration
> from being started while one is already in progress.)

Hmm. Thinking on this more, I'm not sure that we need to stat the loose
references at all. We do not need to care if the loose refs are up to
date or not. Well, we might care, but the point here is not to pretend
that we have an up-to-date atomic view of the loose refs; it is only to
make sure that the fallback-to-packed behavior does not lie to us about
the existence or value of a ref.

IOW, it is OK to come up with a value for ref X that was true at the
beginning of the program, even if it has been simultaneously updated.
Our program can operate as if it happened in the instant it started,
even though in real life it takes longer. But it is _not_ OK to miss the
existence of a ref, or to come up with a value that it did not hold at
some point during the program (e.g., it is not OK to return some cruft
we wrote into the packed-refs file when we packed it three weeks ago).

That is a weaker guarantee, and I think we can provide it with:

  1. Load all loose refs into cache for a particular enumeration.

  2. Make sure the packed-refs cache is up-to-date (by checking its
     stat() information and reloading if necessary).

  3. Run the usual iteration over the loose/packed ref caches.

If a loose ref is updated after or during (1), that's OK. The ref
hierarchy is not atomic, so it is possible for us to see a state that
never existed (e.g., we read X, somebody updates X to X' and Y to Y',
then we read Y'; we see X and Y', a state that never existed on disk).
But either the ref was already loose, in which case we always see its
loose value as it was when we read it, or it was previously only packed
(or non-existent), in which case we see get its value from the
packed-refs (or assume it does not exist), which is its state at the
start of our program. If the loose ref is deleted instead of updated,
it's the same thing; we may see it as existing, as it was at the start
of our program.

If the packed-refs file is updated after we have read all of the loose
refs, we may see it "ahead" of the loose refs state we have cached. And
that may mean the packed-refs file even has more up-to-date values. But
we don't have to care, as long as we return some value that was valid
during the course of our program. And we do, either because we have the
loose value cached (in which case it trumps the packed-refs version and
we use it), or it was missing (in which case we will use the updated
pack-refs value, which may not even be the most recent value, but is at
least a value that the ref had to hold at some point during the run of
our program).

I realize my reasoning is a bit hand-wavy there, but I'm not sure how to
express it more formally. But the gist of it is that we would have the
same guarantees under my proposed rule as we would if the loose refs
cache and the packed-refs file did not exist at all. That is, we cannot
read the whole refs hierarchy from the filesystem atomically _anyway_,
so we have to accept that the value we get is only going to be one of
many possible values during the run of our program.

The exception, of course, is when locking a ref for write, but we
perform that read directly from the filesystem once we have the lock.

> Of course, clearing (part of) the loose reference cache invalidates any
> pointers that other callers might have retained to refnames in the old
> version of the cache.  I've never really investigated what callers might
> hold onto such pointers under the assumption that they will live to the
> end of the process.

My proposal above gets rid of the need to invalidate the loose refs
cache, so we can ignore that complexity.

> Given all of this trouble, there is an obvious question: why do we have
> a loose reference cache in the first place?  I think there are a few
> reasons:
> 
> 1. In case one git process has to iterate through the same part of the
> reference namespace more than once.  (Does this frequently happen?)

I'm not sure how often it happens. There are a few obvious candidates if
you "git grep 'for_each[a-z_]*ref'", but I'm not sure if the actual
performance impact is measurable (the cache should be warm after the
first run-through).

> 2. Reading a bunch of loose references at the same time is more
> efficient than reading them one by one interleaved with other file
> reads.  (I think this is a significant win.)

Makes some sense, though I don't recall whether it was ever measured.

> 3. Keeping references in a cache means that their refnames have a longer
> life, which callers can take advantage of to avoid making their own
> copies.  I haven't checked which callers might make this assumption, and
> nowhere is the lifetime of such a refname documented so it is not even
> clear what callers are *allowed* to assume.  (In my changes I've tried
> to stay on the safe side by not reducing any lifetimes.)

Yeah, I'm not sure if this is used or not.

-Peff
