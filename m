From: Jeff King <peff@peff.net>
Subject: Re: How to tell what paths changed in a merge?
Date: Mon, 28 Mar 2011 16:20:39 -0400
Message-ID: <20110328202039.GA27755@sigill.intra.peff.net>
References: <AANLkTi=DOf0beuts8TO0c5JJtDtjNAcQ_4hcKNkZoXjM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 22:20:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Ivf-0000Q0-3A
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 22:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab1C1UUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 16:20:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50887
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab1C1UUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 16:20:41 -0400
Received: (qmail 17431 invoked by uid 107); 28 Mar 2011 20:21:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Mar 2011 16:21:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2011 16:20:39 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=DOf0beuts8TO0c5JJtDtjNAcQ_4hcKNkZoXjM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170183>

On Mon, Mar 28, 2011 at 03:48:01PM -0400, Patrick Doyle wrote:

> I have a situation where somebody got confused while trying to
> commit/push/pull from the repository and some changes to some files
> got lost.
> 
> How can I tell which files got selected in a merge?

I'm not exactly sure what you mean by "selected". A merge commit is a
tree state with two parent commits. So you can look at what's different
in the merged state versus either parent, or there are some special ways
of looking at it all together.

You might want to try:

  # show a "combined diff"; lines with +/- in the first column came from
  # the first parent of the merge (i.e., where you were when you ran
  # "git merge" or "git pull"). The ones in the second column came from
  # the second parent (the thing you merged).
  git show -c 1e5e614

  # show a condensed combined diff; this is like "-c", except that it
  # eliminates "uninteresting" hunks, where the merge took the entire
  # hunk from one parent.
  git show --cc 1e5e614

  # show the diff of the merge commit to each of its parents
  # individually
  git show -m 1e5e614

And of course you can use those options with "git log -p" to see all of
the commits and what they did. You might also want to try "git log
--graph" to show the structure (though it is pretty hard to read with
the diffs included).

> I have a log file such as shown below (produced by "git log
> --full-history --name-status --parents --dense")

Doesn't --dense cancel out --full-history?

> I know that commit 693a2 had the correct files, but 1e5e6 does not.
> (It has an older version of the file).

Sounds like somebody botched the conflict resolution. Using the show
commands above should show you what happened in that case. Though from
the commit messages below, I don't see any mention of conflicts, which
the merge should have put in the message automatically.

So it may be that the files simply didn't change in first parent branch,
but somebody reverted them to old versions (or botched a different
merge) in the merged-in branch, with the end effect of reverting during
the merge.

If you're still confused after looking around more, and there is nothing
secret in the repo, it might work to make the repo available and tell us
what you expected to see in 1e5e6, and how it differed.

-Peff
