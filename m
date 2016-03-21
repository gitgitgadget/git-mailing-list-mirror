From: Jeff King <peff@peff.net>
Subject: Re: Properties of trees referencing commit objects (mode 160000)?
Date: Mon, 21 Mar 2016 01:57:13 -0400
Message-ID: <20160321055712.GA21568@sigill.intra.peff.net>
References: <20160319221348.GA5247@x>
 <20160320041803.GC18312@sigill.intra.peff.net>
 <20160320184524.GA16064@x>
 <20160320200724.GC6288@sigill.intra.peff.net>
 <20160320232202.GB20803@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 06:57:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahsqL-00025e-F8
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 06:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbcCUF5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 01:57:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:35123 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750965AbcCUF5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 01:57:16 -0400
Received: (qmail 30539 invoked by uid 102); 21 Mar 2016 05:57:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 01:57:15 -0400
Received: (qmail 2702 invoked by uid 107); 21 Mar 2016 05:57:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 01:57:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2016 01:57:13 -0400
Content-Disposition: inline
In-Reply-To: <20160320232202.GB20803@x>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289404>

On Sun, Mar 20, 2016 at 04:22:02PM -0700, Josh Triplett wrote:

> I want to track the evolution of a patch series or other commit history,
> through non-fast-forwarding actions like rebase, rebase -i, or commit
> --amend.  Similar in spirit to reflog, but with intentional commits and
> commit messages, and most importantly with the ability to share and
> collaborate on it.  For each version of the patch series, I plan to
> track the commit at the end of the series, and optionally the commit at
> the base of the patch series (to simplify tracking of rebasing); I'll
> use the tree object associated with the commit to track the cover
> letter, and perhaps meta-changelog entries associated with v2/v3/vN of
> the series.
> 
> Patch series almost always need to evolve through non-fast-forwarding
> history.  And I've seen that done in two ways: either pull the patch
> series out of git, put it in quilt or similar, and track the quilt
> series with git; or pull the versioning of the patch series out of git
> and track it with branch names like feature-v2, feature-2016-03-20,
> feature-rebased, and feature-rebased-4.4-fixed-foo-fixed-bar.  That last
> one closely matches a real-world example I've recently seen.  And that
> starts to look a lot like the naming of files and documents in
> organizations that haven't yet discovered the wonders of version
> control.
> 
> I'd like to have the best of both worlds: handle the patch series in
> git, *and* handle the versioning of the patch series in git.

It seems like you could represent this in git by storing a merge commit
for each revision of the patch series, with one parent as the current
real tip of the series, and the other as the merge-commit for the
previous revision of the series. The tree would be the same as current
tip commit's tree. You could store metadata about the series in the
merge commits (presumably including some marker to say "I'm a special
series-revision commit, not a regular merge").

That's roughly the same as having "feature-v1", "feature-v2", etc, in a
tree, except that you have to walk down the parent pointers to discover
each entry, rather than walking the tree.

The resulting history would be viewable with naive "git log", but you
would probably want to use "--first-parent" to see just the revisions,
or some to-be-invented option to see just the most recent commits (e.g.,
something like: if the commit subject is "magic-token: my-series", then
skip this commit, show the second parent, and then walk down the first
parent chain, skipping commits until we hit a commit that doesn't have
"magic-token: my-series" in it).

And it would just work for transferring revisions. You'd probably have
one ref per patch series (pointing to the marker commit of the most
recent version), and the "real" clean history of the project would never
include any of the revision markers at all (though it could if you
really wanted to).

But I will be the first to admit that I haven't thought too hard on
this. It may even be that I just unconsciously regurgitated somebody
else's storage scheme. Once upon a time I was interesting in "topgit",
"guilt", and other tools, but I haven't looked at them in years.

So it may well be that somebody tried something like this, and already
discovered its downsides. :)

-Peff
