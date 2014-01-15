From: Jeff King <peff@peff.net>
Subject: Re: git-log --cherry-pick gives different results when using tag or
 tag^{}
Date: Wed, 15 Jan 2014 16:53:43 -0500
Message-ID: <20140115215343.GA16401@sigill.intra.peff.net>
References: <52CFF27C.1090108@gmail.com>
 <20140115094945.GD14335@sigill.intra.peff.net>
 <xmqq1u092f2k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Francis Moreau <francis.moro@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 22:54:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3YPT-0006VL-7I
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 22:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbaAOVxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 16:53:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:33128 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752970AbaAOVxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 16:53:46 -0500
Received: (qmail 17344 invoked by uid 102); 15 Jan 2014 21:53:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 15:53:45 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 16:53:43 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1u092f2k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240482>

On Wed, Jan 15, 2014 at 11:57:39AM -0800, Junio C Hamano wrote:

> Where do we pass down other flags from tags to commits?  For
> example, if we do this:
> 
> 	$ git log ^v1.8.5 master
> 
> we mark v1.8.5 tag as UNINTERESTING, and throw that tag (not commit
> v1.8.5^0) into revs->pending.objects[].  We do the same for 'master',
> which is a commit.
> 
> Later, in prepare_revision_walk(), we call handle_commit() on them,
> and unwrap the tag v1.8.5 to get v1.8.5^0, and then handles that
> commit object with flags obtained from the tag object.  This code
> only cares about UNINTERESTING and manually propagates it.

Thanks for picking up this line of thought. I had some notion that the
right solution would be in propagating the flags later from the pending
tags to the commits, but I didn't quite know where to look. Knowing that
we explicitly propagate UNINTERESTING but nothing else makes what I was
seeing make a lot more sense.

> Perhaps that code needs to propagate at least SYMMETRIC_LEFT down to
> the commit object as well, no?  With your patch, the topmost level
> of tag object and the eventual commit object are marked with the
> flag, but if we were dealing with a tag that points at another tag
> that in turn points at a commit, the intermediate tag will not be
> marked with SYMMETRIC_LEFT (nor UNINTERESTING for that matter),
> which may not affect the final outcome, but it somewhat feels wrong.

Agreed. I think the lack of flags on intermediate tags has always been
that way, even before 895c5ba, and I do not know of any case where it
currently matters. But it seems like the obvious right thing to mark
those intermediate tags.

> How about doing it this way instead (totally untested, though)?

Makes sense. It also means we will propagate flags down to any
pointed-to trees and blobs. I can't think of a case where that will
matter either (and they cannot be SYMMETRIC_LEFT, as that only makes
sense for commit objects).

I do notice that when we have a tree, we explicitly propagate
UNINTERESTING to the rest of the tree. Should we be propagating all
flags instead? Again, I can't think of a reason to do so (and if it is
not UNINTERESTING, it is a non-trivial amount of time to mark all paths
in the tree).


> @@ -287,7 +288,6 @@ static struct commit *handle_commit(struct rev_info *revs,
>  		if (parse_commit(commit) < 0)
>  			die("unable to parse commit %s", name);
>  		if (flags & UNINTERESTING) {
> -			commit->object.flags |= UNINTERESTING;
>  			mark_parents_uninteresting(commit);
>  			revs->limited = 1;
>  		}

We don't need to propagate the UNINTERESTING flag here, because either:

  - "object" pointed to the commit, in which case flags comes from
    object->flags, and we already have it set

or

  - "object" was a tag, and we propagated the flags as we peeled (from
    your earlier hunk)

Makes sense. I think the "mark_blob_uninteresting" call later in the
function is now irrelevant for the same reasons. The
mark_tree_uninteresting call is not, though, because it recurses.

-Peff
