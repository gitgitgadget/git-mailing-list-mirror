From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/16] prune: keep objects reachable from recent objects
Date: Wed, 8 Oct 2014 03:19:34 -0400
Message-ID: <20141008071934.GA25250@peff.net>
References: <20141003202045.GA15205@peff.net>
 <20141003203931.GM16293@peff.net>
 <543414CC.9020104@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 08 09:19:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XblXB-00023y-SE
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 09:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbaJHHTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 03:19:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:56088 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753326AbaJHHTh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 03:19:37 -0400
Received: (qmail 32369 invoked by uid 102); 8 Oct 2014 07:19:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 02:19:37 -0500
Received: (qmail 12708 invoked by uid 107); 8 Oct 2014 07:19:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 03:19:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Oct 2014 03:19:34 -0400
Content-Disposition: inline
In-Reply-To: <543414CC.9020104@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 07, 2014 at 06:29:00PM +0200, Michael Haggerty wrote:

> I haven't read all of the old code, but if I understand correctly this
> is your new algorithm:
> 
> 1. Walk from all references etc., marking reachable objects.
> 
> 2. Iterate over *all* objects, in no particular order, skipping the
>    objects that are already known to be reachable. Use any unreachable
>    object that has a recent mtime as a tip for a second traversal that
>    marks all of its references as "to-keep".
> 
> 3. Iterate over any objects that are not marked "to-keep". (I assume
>    that this iteration is in no particular order.) For each object:
> 
>    * [Presumably] verify that its mtime is still "old"
>    * If so, prune the object

Yes, that's more or less accurate. The iteration is in readdir() order
on the filesystem.

We do verify that the mtime is still "old" in the final iteration, but
that is mostly because the existing check was left in. In theory any
recent objects would have been caught in step 2 and marked as "to-keep"
already. Anything we find in step 3 would have to have been racily
created or freshened.

> I see some problems with this.
> 
> * The one that you mentioned in your cover letter, namely that prune's
>   final mtime check is not atomic with the object deletion. I agree
>   that this race is so much shorter than the others that we can accept
>   a solution that doesn't eliminate it, so let's forget about this one.

Right, I don't see an easy way around this.

> * If the final mtime check fails, then the object is recognized as new
>   and not pruned. But does that prevent its referents from being pruned?
> 
>   * When this situation is encountered, you would have to start another
>     object traversal starting at the "renewed" object to mark its
>     referents "to-keep". I don't see that you do this. Another, much
>     less attractive alternative would be to abort the prune operation
>     if this situation arises. But even if you do one of these...
> 
>   * ...assuming the iteration in step 3 is in no defined order, a
>     referent might *already* have been pruned before you notice the
>     "renewed" object.
> 
> So although your changes are a big improvement, it seems to me that they
> still leave a race with a window approximately as long as the time it
> takes to scan and prune the unreachable objects.

Correct. There is a delay between marking objects and deleting them.
This goes for both the existing reachability checks and the new "recent
reachability" check.

As noted above, if we see a fresh object in the final check, then we
know that it was newly freshened (or created). We could then do an
additional traversal with it as the tip, to get a slightly more accurate
view of the world.

The obvious problem as you note is that we may already have deleted its
referents. But let's leave that aside for a moment.

But even if we fix that problem, I don't think traversing again can
eliminate the race. Another process may be freshening or creating
objects after we have processed them (or their containing directories).
So you can catch _some_ cases by re-traversing, but there will always be
cases where we delete an object that has just now become recent (or
reachable, for that matter, if somebody updates the refs).

The obvious solution is to have some atomic view of the object and ref
namespace (i.e., a global write lock that says "I'm pruning, nobody
write"). But that sucks for obvious reasons. I feel like there must be
some more clever solution, but it eludes me. Surely this is something
database people solved 30 years ago. :)

> I think that the only way to get rid of that race is to delete objects
> in parent-to-child order; in other words, *only prune an object after
> all objects that refer to it have been pruned*. This could be done by
> maintaining reference counts of the to-be-pruned objects and only
> deleting an object once its reference count is zero.

Yes, if you are going to traverse again, you would want to delete in
parent-child order. I'm not convinced that traversing again is worth it;
it's trying to shorten the window, but it can't eliminate it. And my
goal here was never to eliminate the race. It was to keep races to
"simultaneous reference and prune is a problem", and not "ongoing
unbounded operations and simultaneous prune are a problem". And I do not
claim to eliminate the possibility of referents going missing; only to
try to close some obvious and easy holes where it happens.

> Let's take the simpler case first. Suppose I run the following command
> between steps 1 and 3:
> 
>     git update-ref refs/heads/newbranch $COMMIT
> 
> , where $COMMIT is a previously-unreachable object. This doesn't affect
> the mtime of $COMMIT, does it? So how does prune know that it shouldn't
> delete $COMMIT?
> 
> -> So ISTM that updating a reference (or any other traversal starting
> point, like the index) must freshen the mtime of any object newly
> referred to.

_If_ the deletion of the object and the checking of its mtime were
atomic, that would be useful to do. But it's not. Before my patch, you
have one way of "saving" the object (and its referents): making it
reachable from a ref. After my patch, you have the additional option of
updating its mtime.

But why bother with the mtime? You can just make it reachable by
updating the ref. Both are racy, but we cannot help that, so one is as
good as the other.

> A more complicated case: suppose I create a new $COMMIT referring to an
> old $TREE during step 2, *after* prune has scanned the directory that
> now contains $COMMIT. (I.e., the scan in step 2 never notices $COMMIT.)
> Then I create a new reference pointing at $COMMIT. (I.e., the scan in
> step 1 never noticed that the reference exists.) None of this affects
> the mtime of $TREE, does it? So how does prune know that it mustn't
> prune $TREE?

It doesn't, and you are screwed. :)

You could freshen the referents here, but you are still racy. Just as
you might miss the creation of $COMMIT, you might miss the freshening of
$TREE and delete it.

Making the mtimes race-free requires an atomic check-timestamp-and-delete.
And without that, I'm not sure that shortening the race from 50 system
calls to 3 system calls is worth the additional complexity. If we had
such an atomic operation, even on only a subset of systems, it might
be worth it. But I do not know of any filesystem or system call that can
do so.

> I hope I understood that all correctly...

I think your analysis is all correct. The open question is whether it's
worth trying to shrink the last bits of raciness or not (or even whether
there is a clever way of eliminating them that I haven't considered).

-Peff
