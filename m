From: Jeff King <peff@peff.net>
Subject: Re: Inconsistent results obtained regarding how git decides what
 commits modifies a given path
Date: Fri, 7 Aug 2015 04:44:26 -0400
Message-ID: <20150807084425.GA8232@sigill.intra.peff.net>
References: <CANYPdHA6a1Jg2NUJGcg5O3KBG2AB+AK3071ckDywGL=MHghEZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: JuanLeon Lahoz <juanleon.lahoz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 10:44:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNdGY-0003bM-2z
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 10:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbbHGIoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 04:44:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:41882 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750829AbbHGIob (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 04:44:31 -0400
Received: (qmail 3828 invoked by uid 102); 7 Aug 2015 08:44:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Aug 2015 03:44:31 -0500
Received: (qmail 11892 invoked by uid 107); 7 Aug 2015 08:44:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Aug 2015 04:44:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Aug 2015 04:44:26 -0400
Content-Disposition: inline
In-Reply-To: <CANYPdHA6a1Jg2NUJGcg5O3KBG2AB+AK3071ckDywGL=MHghEZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275462>

On Fri, Aug 07, 2015 at 08:42:52AM +0200, JuanLeon Lahoz wrote:

> # This prints nothing on git < 1.8.4; prints a commit that corresponds with
> # "Merge branch 'b3' into b2_3" in git >= 1.8.4 (tested with 1.8.4 and 2.5.0)
> echo COMMITS checkpoint..b2_3: $(git rev-list checkpoint..b2_3 -- version)

I would expect the current behavior (to show the merge). The fix bisects
to d0af663 (revision.c: Make --full-history consider more merges,
2013-05-16). See that commit message, or the thread at:

  http://thread.gmane.org/gmane.comp.version-control.git/220624

for more detail. Though I'm not 100% it was intentional...

> # This prints nothing on any git version I tested.
> echo COMMITS checkpoint..b1_4: $(git rev-list checkpoint..b1_4 -- version)

This looks like a bug to me. It should be the exact same simplification
case as b2_3 (we have a merge whose outcome matches the second parent,
but not the first). One obvious difference, if you look at:

  git log --oneline --graph --decorate checkpoint b2_3 b1_4

is that in the b1_4 case, the immediate parent of the merge is marked as
UNINTERESTING|BOTTOM, because it is "checkpoint". Whereas in the b2_3
case, it is simply UNINTERESTING, as it is the _parent_ of checkpoint,
and we propagated the flag.

This difference matters in relevant_commit(). In the b2_3 case, we
consider the second parent irrelevant, because it is "just"
UNINTERESTING. But in the b1_4 case, we consider it relevant, due to the
BOTTOM flag. This code comes from 4d82660 (revision.c: discount side
branches when computing TREESAME, 2013-05-16).

And that commit claims that we exclude irrelevant parents when
determining TREESAME. Meaning the b2_3 case has only one relevant parent
(which is different, making the merge !TREESAME). Whereas b1_4 has two
relevant parents, we realize we are TREESAME to the second one, and
simplify away the merge.

At this point, I'm pretty confused (and reading the comments added by
4282660 only confused me further). I would have thought the TREESAME was
independent of the limiting of the traversal, but clearly it is not
intended to be. But this weird BOTTOM exception makes even less sense to
me.

So I'll give up for now. Maybe somebody else can pick it up from there,
or perhaps it will make more sense to me in the morning.

-Peff
