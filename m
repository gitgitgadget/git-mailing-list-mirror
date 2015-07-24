From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 00:21:10 -0700
Message-ID: <20150724072109.GB2111@peff.net>
References: <20150723012343.GA21000@peff.net>
 <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Josh Bleecher Snyder <josharian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 09:21:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIXIE-000452-Pe
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 09:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbbGXHVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 03:21:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:34393 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751653AbbGXHVO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 03:21:14 -0400
Received: (qmail 7449 invoked by uid 102); 24 Jul 2015 07:21:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 02:21:14 -0500
Received: (qmail 17840 invoked by uid 107); 24 Jul 2015 07:21:18 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 03:21:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2015 00:21:10 -0700
Content-Disposition: inline
In-Reply-To: <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274556>

On Thu, Jul 23, 2015 at 03:46:33PM -0700, Junio C Hamano wrote:

> While I can see the reasoning behind the above [*1*], I am not sure
> if the output with "--first-parent" would always be a good match for
> the "simple" version.  Wouldn't the people who keep these messy
> histories also those who merge project trunk into a random topic and
> push the result back as the updated project trunk?  Admittedly, that
> merely is saying that "--first-parent" is not a solution to such a
> project, and does not say much about the usefulness of the new
> configuration, so I'd queue it as-is.
> 
> [Footnote]
> 
> *1* I do not necessarily agree, though.  The history being messy is
>     a sign that "the actual thought process of the developer" was
>     not clearly expressed in the work, and it is not likely that you
>     have more insight by looking at it---you will see more mess, for
>     certain, though.

I don't think people who keep "messy" commit histories are necessarily
prone to pushing to the trunk. And ditto for the footnote, I do not
think "messy" is necessarily a bad thing. It is really about whether you
choose to rebase out follow-on fixups (e.g., those that come from
review), or whether you choose to leave them in.

And there is a very good reason to leave them in: two people
collaborating on a topic have a much easier time if the other person is
not constantly rebasing.

So a GitHub-oriented workflow can be something like (and this is what we
use to develop GitHub internally):

  1. I do the usual process of creating a branch, writing some commits,
     pushing them up, and opening a pull request. This is equivalent to
     git.git, except the final step is "send to the list". I may use
     "rebase -i" during this process to make a nice sequence of commits.

  2. During review, I may get comments. In a git.git workflow, I am
     expected to re-roll the topic myself to address the comments. If I
     am lucky, the reviewer expressed their comments as a diff, and I
     can squash them in as appropriate. But in the GitHub workflow, the
     reviewer may simply check out the branch themselves locally, commit
     the fixes, and push them up. They become part of the PR.

  3. I may go back and forth with the reviewer several times, and there
     may be intermingled commits from both of us. At the end, one of us
     decides to merge the PR, and GitHub's merge button creates a non-ff
     commit on master, merging in the topic.

So we're "messy" in the sense that we chose to record the back-and-forth
during the development of the topic. But at no point was anybody in
danger of back-merging and putting the result directly onto master. Even
if they did back-merge from master onto the topic[1], the non-ff merge
to master means that any first-parent traversal starting from master
will never stray onto a PR branch at all.

Of course not everybody does this. But I think it's a perfectly sane
workflow. The PR merges become the most interesting unit of change to
review or find in the history, with the individual commits closer to
"what really happened".

-Peff

[1] We do actually back-merge master to topics all the time, because we
    have to make sure that we whatever we test and deploy contains all
    of what is already in master, even if the topic was originally
    forked from an older point. IOW, the QA process for merging is
    basically:

      - merge back from master so we know the tree at the tip of our
	topic is what _would_ be on master if we merged

      - test that tip (with automated tests, temporarily deploying to
	the live site, etc)

      - it's OK to merge to master if it has not moved; the merge would
        be a fast-forward. Instead, we create a merge commit, but the
	tree content will be the same (so we know that we are merging
	and deploying what has just passed QA).

    Incidentally, doing "git log --first-parent" while on the topic
    branch from this workflow does the reasonable thing. Because the
    merges on the topic branch are all backwards merges from master,
    following the first parent keeps you on the topic branch (rather
    than showing you all the upstream commits you just pulled in).

    Where I'd be most worried about a default first-parent hurting you
    is when you "git log $some_random_commit", at which point you may or
    may not want first-parent behavior. I suppose we could have a config
    option that kicks in only when using the default "HEAD". That seems
    more likely to do what you want all the time, but it also sounds
    rather confusingly magical.
