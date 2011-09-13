From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated
 submodules
Date: Tue, 13 Sep 2011 18:17:45 -0400
Message-ID: <20110913221745.GB24549@sigill.intra.peff.net>
References: <20110912195652.GA27850@sigill.intra.peff.net>
 <7vr53l5u7h.fsf@alter.siamese.dyndns.org>
 <20110912224934.GA28994@sigill.intra.peff.net>
 <4E6FAB46.30508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 14 00:18:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3bJ5-0000hH-OT
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 00:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932942Ab1IMWRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 18:17:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33175
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932935Ab1IMWRr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 18:17:47 -0400
Received: (qmail 2278 invoked by uid 107); 13 Sep 2011 22:18:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 18:18:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 18:17:45 -0400
Content-Disposition: inline
In-Reply-To: <4E6FAB46.30508@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181316>

On Tue, Sep 13, 2011 at 09:13:10PM +0200, Jens Lehmann wrote:

> The real world use case I have for that is that when a bug introduced by
> a new submodule commit is detected later on, the superproject's fix
> records an older submodule commit to remove the problematic change from
> the superproject. But the submodule's branch isn't rewound (as that is
> most probably master) but a fix is applied on top of it. Then that one
> gets tested and - if it was found ok - recorded in the superproject.

OK, that makes sense. It is a "rewind" from the perspective of the
superproject, but there is never a fork; because the submodule didn't
rewind, when we do get a new submodule state in the superproject, it
will be a fast forward from the old state.

That is a reasonable use case.

It's still probably a minority case, and we have to pay for the full
traversal each time, which is annoying. But now that it's turned off by
default if you don't have any submodules, I'm less concerned about the
performance impact. And superproject repositories are probably not going
to have the same number of commits as submodule repositories, so it may
be less of an issue.

One thing that could make it slightly less expensive (but I wouldn't
worry about implementing until it becomes an issue): you do a full diff
and collect any changed GITLINK entries, and then compare the paths we
get with the submodule config. Couldn't you instead do something like
this:

  - let S = set of submodule paths that we care about, from the config
  - start the "git rev-list $new --not $old" traversal, as we do now
  - for each commit
    - diff using a pathspec of S
    - for each changed entry
      - add it to the set of changed submodules
      - remove it from S
    - if S is empty, break

That has two advantages:

  1. We limit the diff by pathspec, which means we can avoid looking at
     irrelevant parts of the tree (we don't do this yet, but hopefully
     we will in the future).

  2. You can break out of the traversal early if you already know you
     have changes in each submodule of interest.

> Changes like this could be overlooked if you only compare "before" and
> "after" instead of traversing, leading to not fetching a submodule which
> does have new commits that are used in the newly fetched superproject's
> commits. I'd like to have on-demand fetch keep the correct solution of
> traversing unless we have good reasons against it, especially as teaching
> checkout & friends to recursively update submodules too depends on all
> needed commits being present.

Out of curiosity, what happens if we don't have such a commit? I know
you said that your policy is never to rewind a submodule's commit that
has been published in a superproject, and I think that's the only sane
thing to do. But it's not enforced by git itself, and I wonder how badly
we break if it does happen (i.e., I'm hoping the answer is "you can't
diff or checkout superproject revisions that reference the missing bit"
and not "git log crashes when it gets to that point in history").

-Peff
