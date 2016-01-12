From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] lock_ref_sha1_basic: handle REF_NODEREF with
 invalid refs
Date: Tue, 12 Jan 2016 15:22:52 -0500
Message-ID: <20160112202251.GA10843@sigill.intra.peff.net>
References: <20160112095638.GA4773@sigill.intra.peff.net>
 <20160112095804.GB16501@sigill.intra.peff.net>
 <20160112132628.GA31854@sigill.intra.peff.net>
 <20160112135522.GA23255@sigill.intra.peff.net>
 <xmqqlh7utwki.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 21:23:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ5T4-0003RC-9a
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 21:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbcALUW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 15:22:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:52507 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753464AbcALUWy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 15:22:54 -0500
Received: (qmail 16221 invoked by uid 102); 12 Jan 2016 20:22:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 15:22:54 -0500
Received: (qmail 18154 invoked by uid 107); 12 Jan 2016 20:23:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 15:23:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 15:22:52 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlh7utwki.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283842>

On Tue, Jan 12, 2016 at 11:41:17AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I also notice that if we are deleting, we _do_ set
> > RESOLVE_REF_NO_RECURSE from the very beginning, which means we would
> > generally not get a valid lock->old_oid.hash for a symref. But I'm not
> > sure what it would mean to delete a symref while asking for its current
> > value (it cannot have one!). So I don't think it is a bug.
> 
> I started scratching my head after noticing that the NO_RECURSE bit
> set in the DELETING codepath before reading the above, and I am
> still doing so.
> 
> A transaction that attempts to delete an existing symref presumably
> wants to make sure that the "old" value it read hasn't changed, but
> ensuring the object name (obtained by reading the ref that is
> pointed by the symref by dereferencing) are the same is not the
> right way to ensure nobody raced with us in the meantime anyway (we
> should rather be making sure that the symref is still pointing at
> the same ref), so in that sense, in the context of acquiring the
> lock, old oid value is meaningless for symrefs.

Right, that's the point I was trying to make. Though I think there is
something even more subtle going in (see the end of this message).

In theory you might want the old sha1 for logging purposes, but since we
delete the reflog along with the symref, I don't think it matters there,
either.

I'm not sure we actually delete symrefs very often, though. Grepping for
delete_ref and REF_NODEREF shows the callers expecting symrefs to mostly
be "git remote", which never passes in an old_sha1.

The only caller which does so is "branch -d", but I think it doesn't
affect symrefs. It gets the "old" sha1 by calling resolve_ref_unsafe()
itself with RESOLVE_REF_NO_RECURSE, so it will unconditionally remove a
symref you ask it to, even if somebody else raced and put something in
it.

You can also call "update-ref --no-ref -d" with an "old" sha1, but I
doubt anyone ever does so.

> This patch is a strict improvement as the behaviour for REF_DELETING
> case is unchanged by it (an idempotent resolve-ref-unsafe may be
> called one more time in some cases), and other cases are better, I
> think.

Yeah. My gut feeling is that the REF_DELETING special-handling of
REF_NODEREF could just be folded into what I've added in this series.
But absent a case that is demonstrably broken, I'm inclined not to muck
with it too much.

I had thought that this:

  git init
  git commit --allow-empty -m foo
  git symbolic-ref refs/foo refs/heads/master
  old=$(git rev-parse foo)
  git update-ref --no-deref -d refs/foo $old

might trigger a problem (because reading refs/foo with NODEREF will give
us a blank sha1 to compare against). But of course that is nonsense. The
actual lock verification is not done by this initial resolve_ref. It
happens _after_ we take the lock (as it must to avoid races), when
verify_lock() calls read_ref_full().

But now I'm doubly confused. When we call read_ref_full(), it is _also_
into lock->old_oid.hash. Which should be overwriting what the earlier
resolve_ref_unsafe() wrote into it. Which would mean my whole commit is
wrong; we can just unconditionally do a non-recursive resolution in the
first place. But when I did so, I ended up with funny reflog values
(which is why I wrote the patch as I did).

Let me try to dig a little further into that case and see what is going
on.

-Peff
