From: Jeff King <peff@peff.net>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Wed, 24 Jun 2015 05:49:20 -0400
Message-ID: <20150624094919.GC5436@peff.net>
References: <1435020656.28466.8.camel@twopensource.com>
 <20150623114716.GC12518@peff.net>
 <CAJo=hJsu2b0kmpjOhGwvgRsG3yGK56+U_2RANDi2qoEg7V_PmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 11:50:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7hJj-0000jG-V2
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 11:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbbFXJtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 05:49:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:50906 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751018AbbFXJtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 05:49:22 -0400
Received: (qmail 12545 invoked by uid 102); 24 Jun 2015 09:49:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Jun 2015 04:49:22 -0500
Received: (qmail 26353 invoked by uid 107); 24 Jun 2015 09:49:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Jun 2015 05:49:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jun 2015 05:49:20 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJsu2b0kmpjOhGwvgRsG3yGK56+U_2RANDi2qoEg7V_PmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272543>

On Tue, Jun 23, 2015 at 11:09:40PM -0700, Shawn Pearce wrote:

> Yes. $DAY_JOB's DFS implementation never expires reflogs, allowing it
> to be used as a history to inspect what happened. Its been useful a
> couple of times to investigate and recover from a few accidental
> deletions.
> 
> Once you never expire reflog records you now have to consider at what
> point do you stop paying attention to the reflog entries for graph
> reachability during repack and fsck. Users still expect to be able to
> force push or delete a branch and have a set of objects disappear from
> the repository.

Yeah, we face this problem at GitHub. We actually write every single ref
write to $GIT_DIR/audit_log, which is essentially a reflog with the
refname prepended. The key, though, is that it isn't ever _read_ by git
for reachability. So it becomes an immutable log of what happened, and
we can happily prune the reflog to drop objects.

In a log-structured ref storage world, I think I'd include a single bit
per entry for "use this for reachability". Then you could "soft-expire"
reflog entries by dropping their reachability bit, but still retain them
in your audit_log. The alternative is to just copy the entries to an
archival log.

> There are some issues with append. Before appending we would need to
> verify the last record actually ends with an LF. If there was a power
> failure and only part of the last record wrote, you can't append
> without that record separator in place.

Yeah, I think that is straightforward. You have to take a lock on the
whole log anyway, so it's OK to "fixup" the previous entry.

> If that last record was truncated, and an LF was wedged in to do a new
> append, we can't trust that intermediate record. A CRC at the end of
> the record might make it safer to know the record is intact or bogus
> due to an earlier failed write that wasn't completed.

I suspect you could get by with just realizing that the entry doesn't
parse (that's what we do now for reflogs). But the idea of per-entry
consistency checks is appealing. You could also include the CRC for the
"previous" entry (remember that we would probably have a back-pointer to
some byte offset to say "this is the current ref state that I am
building on"). Then you can walk back the whole chain to know that it
hasn't been damaged.

If you want to get very fancy, replace your CRC with a cryptographically
strong hash, and you've just reinvented a blockchain. :)

> What about the case of never expiring the reflog? This log would grow
> forever. You may eventually need to archive old sections of it (e.g. 1
> year ago?) to maintain an audit log, while keeping the "latest" entry
> for each ref to rebuild the index.

Yeah, that's certainly an option. I'd say that's somewhat outside the
scope of git. If git provides the ability to prune entries completely
(i.e., what "reflog expire" does now) and to soft-expire them, then that
is enough for anyone to build whatever sort of archival system they want
(e.g., soft-expire for reachability as desired, and then occasionally
"git reflog show >your-archive && git reflog expire").

> +1 to always storing the peeled value. This was a major improvement
> for $DAY_JOB's Git servers as peeling tags on the fly can be costly
> when your storage is something remote, such as NFS. Unfortunately the
> current wire protocol demands peeled information to serve a ref
> advertisement.

Even on good disks, it makes the initial ref advertisement from
git-upload-pack _way_ cheaper, because we don't have to actually touch
the object database at all. It's basically just blitting out the
packed-refs file.

> One thing we do is always peel all refs. We record a bit to state its
> been peeled, but there is no peeled value because the ref is pointing
> to a non-tag object (e.g. refs/heads/master points to a commit).

Yeah, since c29c46f (pack-refs: add fully-peeled trait, 2013-03-18) we
implicitly do this in packed-refs; if there's no peel line after the
entry, it cannot be peeled. We could do the same here, but I think I
favor being more implicit (I'd probably add a few bits of "flags" to
each entry, and this could be one such flag).

> Updating the index on updates to a ref would be costly, as its O(N).

It depends how you implement the index. A straight text index would be
O(N). Replacing the index with a real key/value store should be very
fast. But unless we are going to write our own, that's going to
introduce a dependency (possibly one we can ship as we do with xdiff,
but the whole JGit thing is an open question).

> You could skip some index updates. Record in the header of the index
> the length of the reflog file used to build it. When reading the
> index, scan the reflog from that position to the end and patch those
> updates in memory. Rewrites of the index could then be deferred until
> the scan delta on the log is high, or the next gc.

Yeah, basically use the log as a journal. You save (or at least
amortize) O(# of refs) work for the writers, at the cost of O(# of
recent updates) work for the readers. That might be worth doing. It's
also complicated, and I was hoping to avoid complicated things. :)

> >   - Reading a single reflog is _also_ O(U), which is not as good as
> >     today. But if each log entry contains a byte offset of the previous
> >     entry, you can follow the chain (it is still slightly worse, because
> >     you are jumping all over the file, rather than reading a compact set
> >     of lines).
> 
> But this is like saying reading `git log` is bad because we jump all
> over the pack file to parse ancestors and insert them into the
> revqueue at the correct position. Feh.

Yeah, I agree it's probably not worth caring too much about. Reading the
reflogs at all is not that common an operation, and it's a tradeoff I'd
be happy to make. I was just trying to be upfront about the tradeoffs
versus the current storage format.

> IIRC some part of Ronnie's series was about setting up a socket
> protocol between Git and the ref backend. If non-default backends are
> like this, JGit could spawn the backend binary and then speak the
> socket protocol just like git-core. This would be preferable to
> linking JNI into the JVM.

I am not excited about contacting an already-running program, which is
what I thought Ronnie's patches did. That's one more thing to go wrong
or become confusing doing basic operations.  If we have to do an
external program, I'd much rather it be something we spawn once (more
like the remote-helper, which I think is what you are proposing).

I don't know how much that helps for the JGit situation. It punts the
native code out of JGit, but people using JGit still have to have the
native helper from git on their system.  I have no problems at all with
pluggable $FANCY_DB that not everybody supports.  But I think we would
want _some_ baseline that is reasonably performant, and that everybody
will support. I'm not sure putting the index into a flat file is
performant enough. Is there any basic key/value store that is has both a
C and a pure-Java version (e.g., berkeley db)?

-Peff
