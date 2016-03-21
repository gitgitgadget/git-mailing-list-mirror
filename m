From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Properties of trees referencing commit objects (mode 160000)?
Date: Mon, 21 Mar 2016 08:36:27 -0700
Message-ID: <20160321153626.GA2180@jtriplet-mobl2.jf.intel.com>
References: <20160319221348.GA5247@x>
 <20160320041803.GC18312@sigill.intra.peff.net>
 <20160320184524.GA16064@x>
 <20160320200724.GC6288@sigill.intra.peff.net>
 <20160320232202.GB20803@x>
 <20160321055712.GA21568@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 16:37:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai1tP-0002uA-Lk
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 16:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756711AbcCUPhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 11:37:08 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:37510 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999AbcCUPhF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 11:37:05 -0400
Received: from mfilter35-d.gandi.net (mfilter35-d.gandi.net [217.70.178.166])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 57BBAA80F5;
	Mon, 21 Mar 2016 16:36:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter35-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter35-d.gandi.net (mfilter35-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id Wg3zVb2ah_b8; Mon, 21 Mar 2016 16:36:56 +0100 (CET)
X-Originating-IP: 50.39.163.18
Received: from jtriplet-mobl2.jf.intel.com (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 932E1A80DC;
	Mon, 21 Mar 2016 16:36:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160321055712.GA21568@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289421>

On Mon, Mar 21, 2016 at 01:57:13AM -0400, Jeff King wrote:
> On Sun, Mar 20, 2016 at 04:22:02PM -0700, Josh Triplett wrote:
> 
> > I want to track the evolution of a patch series or other commit history,
> > through non-fast-forwarding actions like rebase, rebase -i, or commit
> > --amend.  Similar in spirit to reflog, but with intentional commits and
> > commit messages, and most importantly with the ability to share and
> > collaborate on it.  For each version of the patch series, I plan to
> > track the commit at the end of the series, and optionally the commit at
> > the base of the patch series (to simplify tracking of rebasing); I'll
> > use the tree object associated with the commit to track the cover
> > letter, and perhaps meta-changelog entries associated with v2/v3/vN of
> > the series.
> > 
> > Patch series almost always need to evolve through non-fast-forwarding
> > history.  And I've seen that done in two ways: either pull the patch
> > series out of git, put it in quilt or similar, and track the quilt
> > series with git; or pull the versioning of the patch series out of git
> > and track it with branch names like feature-v2, feature-2016-03-20,
> > feature-rebased, and feature-rebased-4.4-fixed-foo-fixed-bar.  That last
> > one closely matches a real-world example I've recently seen.  And that
> > starts to look a lot like the naming of files and documents in
> > organizations that haven't yet discovered the wonders of version
> > control.
> > 
> > I'd like to have the best of both worlds: handle the patch series in
> > git, *and* handle the versioning of the patch series in git.
> 
> It seems like you could represent this in git by storing a merge commit
> for each revision of the patch series, with one parent as the current
> real tip of the series, and the other as the merge-commit for the
> previous revision of the series. The tree would be the same as current
> tip commit's tree. You could store metadata about the series in the
> merge commits (presumably including some marker to say "I'm a special
> series-revision commit, not a regular merge").

That's exactly what I'm planning to do now, ever since your initial
response said submodules wouldn't work.

> That's roughly the same as having "feature-v1", "feature-v2", etc, in a
> tree, except that you have to walk down the parent pointers to discover
> each entry, rather than walking the tree.
> 
> The resulting history would be viewable with naive "git log", but you
> would probably want to use "--first-parent" to see just the revisions,
> or some to-be-invented option to see just the most recent commits (e.g.,
> something like: if the commit subject is "magic-token: my-series", then
> skip this commit, show the second parent, and then walk down the first
> parent chain, skipping commits until we hit a commit that doesn't have
> "magic-token: my-series" in it).

Rather than relying on the numeric index of the commit parents for
semantic value, I planned to use the tree object.  I can still use
gitlinks for named references to commits from within the series, as long
as the commits linked from those trees have references via parents to
keep them alive.  For instance, /series within the commit can refer to
the commit object at the top of the series, /base (if present) can refer
to the base of the series (e.g. v4.4), and /cover (a blob) can contain
the cover letter.  Then "git series format" automatically knows the base
to start from, and "git series log" or "git series diff" will know the
difference between "reordered patches" and "rebased on a new base".

The working copy and .git/HEAD will point to the last commit in the
current version of the patch series, so that tools like "git rebase -i"
and similar can Just Work; "git series" will manage the separate ref
independently.

I'll need to provide a variety of additional tools here for showing what
has changed in a patch series; I'd eventually like to support a sensible
"git series diff" that can show things like "rebased on this base,
reordered three patches, dropped one, edited another, and changed the
cover letter".

> And it would just work for transferring revisions. You'd probably have
> one ref per patch series (pointing to the marker commit of the most
> recent version), and the "real" clean history of the project would never
> include any of the revision markers at all (though it could if you
> really wanted to).

Exactly the plan.  And you won't ever actually check out those refs into
your working copy; you'll check out the patch series commits they
reference instead.

> But I will be the first to admit that I haven't thought too hard on
> this. It may even be that I just unconsciously regurgitated somebody
> else's storage scheme. Once upon a time I was interesting in "topgit",
> "guilt", and other tools, but I haven't looked at them in years.
> 
> So it may well be that somebody tried something like this, and already
> discovered its downsides. :)

One major downside is that creating such a tool doesn't automatically
make things like a three-way merge of patch series easy.  It makes
recognizing the situation *possible* (unlike before when you couldn't
easily exchange records of non-fast-forwarding history with others), but
if your remote and you have both changed the patch series independently,
merging the two will still prove challenging.

One step at a time, though: first I want to make it possible to track
as a first-class concept, and then we can make better tooling on top
of that.

- Josh Triplett
