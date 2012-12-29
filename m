From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] refs: do not use cached refs in repack_without_ref
Date: Sat, 29 Dec 2012 02:16:30 -0500
Message-ID: <20121229071630.GA15408@sigill.intra.peff.net>
References: <20121221080449.GA21741@sigill.intra.peff.net>
 <50DAB447.8000101@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Dec 29 08:17:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToqfF-0006yL-L2
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 08:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab2L2HQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 02:16:37 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38564 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab2L2HQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 02:16:36 -0500
Received: (qmail 27471 invoked by uid 107); 29 Dec 2012 07:17:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 02:17:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 02:16:30 -0500
Content-Disposition: inline
In-Reply-To: <50DAB447.8000101@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212294>

On Wed, Dec 26, 2012 at 09:24:39AM +0100, Michael Haggerty wrote:

> I'm sorry to take so long to respond to this patch.  Thank you for
> tracking down this bug and for your careful analysis.
> 
> I think your patch is correct and should fix the first race condition
> that you described.

Thanks for checking it over. I almost cc'd you, as I know you have been
working on ref caching. But I think that the problem is much older, as
we always cached the packed-refs list in memory.

> But I think the continued existence of the other race conditions is an
> indication of a fundamental problem with the reference locking
> policy--independent of the in-RAM reference cache.
> 
> The tacit assumption of the current locking policy is that changes to
> the packed-refs file are not critical for correctness, because loose
> references take precedence over it anyway.  This is true for adding and
> modifying references.  But it is not true for deleting references,
> because there is no way for a deletion to be represented as a loose
> reference in a way that takes precedence over the packed-refs file
> (i.e., there is no way for a loose reference to say "I am deleted,
> regardless of what packed-refs says").  Thus the race conditions for
> deleting references, whether via delete_ref() or via pack_refs() with
> --prune.

Yeah. It would be much nicer if we could just write the null sha1 or a
similar sentinel into the loose ref for "I am deleted". The problem
(besides backwards compatibility) is the usual D/F conflict. I cannot
delete "refs/heads/foo" and then create "refs/heads/foo/bar" if the old
ref file is in the way.

> There is a problem if two processes try to delete a reference at the
> same time, or if one process tries to delete a reference at the same
> time as another process is trying to pack the references.  The reason is
> that there is no "transaction" that spans both the rewriting of the
> packed-refs file and also the deletion of the loose-ref files, and
> therefore it is possible for conflicting changes to be made in the two
> locations.

Just to be clear, are you talking about the races I wrote about in my
other email? Or are there other races? I didn't (and still don't) see
any actual on-disk data loss races. Just ones where a reader may get an
old, packed value (which is still bad, but is less bad than one where a
write is lost).

> I think that all of the problems would be fixed if a lock would be held
> on the packed-refs file during the whole process of deleting any
> reference; i.e., change the algorithms to:

Yeah, I looked at that, too. In fact, before I had correctly analyzed
the problem, I thought that doing so would solve the problem I was
seeing (which I noticed was wrong when it did not pass my tests :) ).

>From your description, I think you realize this, but I want to point out
for other readers: just updating the pack_refs side to call prune_refs
under the lock would create a deadlock with a simultaneous delete (which
takes the individual ref lock first, then the packed-refs lock). Of
course, I do not think git is capable of deadlock, as we typically just
die() instead of blocking on a lock. So maybe it does not matter so
much. :)

> * Delete reference foo:
> 
>   1. Acquire the lock $GIT_DIR/packed-refs.lock (regardless of whether
>      "foo" is a packed ref)

This suffers from the same problem I mentioned in my earlier email: we
create lock contention on packed-refs.lock when there are two
simultaneous deletes, even when the refs aren't packed. That might be an
acceptable tradeoff, though. It's only for deletion, not for update,
which is presumably rare. And it has to happen anyway when both refs are
packed.

>   2. Write to $GIT_DIR/packed-refs.new a version of the packed-refs
>      file that omits "foo"
> [...]

All of the further steps make sense. By deleting from packed-refs first,
we eliminate the read race-condition I mentioned in my earlier email.
The only downside is the possible increased lock contention on
packed-refs.lock.  I'm very tempted to go this route. It's better to be
correct and sometimes die on lock contention than to sometimes give the
wrong answer.

> I would appreciate a critique of my analysis.  Even if you agree, I
> think it would be OK to apply Peff's patch to fix up the most pressing
> problem, then implement the more complete solution later.

I think your analysis is correct, modulo the issue I mentioned. And I
agree that my patch is a good interim, as it fixes the worst case
(losing writes).

-Peff
