From: Jeff King <peff@peff.net>
Subject: Re: feature request - telling git bisect to skip, from inside a
 commit
Date: Mon, 28 Mar 2011 12:31:53 -0400
Message-ID: <20110328163153.GA18774@sigill.intra.peff.net>
References: <AANLkTinCiM9uqK8Yr=pKaeKytWXqpWF898AeTwvHKg4-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jim Cromie <jim.cromie@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 18:33:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4FNC-0006FQ-RG
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 18:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214Ab1C1Qb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 12:31:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47176
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932109Ab1C1Qbz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 12:31:55 -0400
Received: (qmail 12993 invoked by uid 107); 28 Mar 2011 16:32:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Mar 2011 12:32:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2011 12:31:53 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinCiM9uqK8Yr=pKaeKytWXqpWF898AeTwvHKg4-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170152>

On Sat, Mar 26, 2011 at 12:48:25PM -0600, Jim Cromie wrote:

> sometimes its feels clearer to devote a commit to changing (for example)
> the definition of a struct;  and changing all users of that struct in
> the next commit.
> This isolates and highlights the definitional change, rather than burying it in
> the middle of a huge diff.
> 
> The downside of doing this is that git bisect will trip over this 1/2 change.
> It would be nice if a committer could mark the commit as not bisectable,
> perhaps by just adding this, on a separate line, to the commit-message:
> 
>     "git bisect skip [optional range]"
> 
> the range presumably would be something like CURRENT^1
> except that it would make more sense to flag successors than ancestors,
> and of course, CURRENT would have to mean something.

That could work, though I would spell it as a pseudo-header:

  Bisect: Skip

at the end of each commit. But I'm not sure a range makes sense. Commits
can get rebased, or patches applied in a different order. So putting
something like that into the message at commit time can be fragile.

I wonder if doing this at commit time at all really makes sense, though.
It means you have to know up-front that you are breaking things. Which
yes, does happen. But it also happens frequently that you only realize
later while bisecting that your commit is bogus. Or maybe you realize
two commits down the line that your HEAD~2 is broken, but you can't use
"rebase -i" to fix it because you already pushed it.

So what if instead of marking at commit time, we kept a "skip cache".
Bisection would consult any entries marked in the skip cache and skip
them automatically. When you issued a "git bisect skip", it would not
only skip the commits now, but would also add them to the skip cache.

If we kept the skip cache in a git-notes tree, then you could share the
cache with others (though to be fair, this is slightly less convenient
than simply having it in the commit header, which survives over things
like format-patch).

And of course nothing would stop you from marking an item in the skip
cache at commit time, or any other time.

One downside to this scheme (or any skip-marking scheme) is that some
skips may depend on the bisection you are doing. Obviously if the
program doesn't build, that breaks everyone. But let's say you skip a
series of commits because they have a bug in the "foo" program, and your
bisection script must run "foo" then "bar" to get its result. But later,
you do another bisection that doesn't care about "foo" at all, but the
result of the bisection would be in the middle of the skipped series.
You won't find it exactly, because you are skipping too many commits.

> git bisect already has ability to skip a commit, this just helps an
> automated bisection script.

If you have an automated script, you could do something like this
outside of git-bisect entirely.

When you want to mark a commit as bad, do:

  git notes --ref=skip add -m "some reason it is bogus" <commit>

Then at the beginning of your test script, do something like:

  skip=`git notes --ref=skip show`
  if test -n "$skip"; then
    echo >&2 "Skipping commit: $skip"
    exit 125
  fi

Of course, for the example you gave, it may be even easier. The code in
your patch 1/2 would fail to compile. So just doing "make || exit 125"
in your bisect script would be enough, without any skip cache. But there
are certainly cases where it is nice to be able to mark something as
skippable (e.g., a kernel that builds, but is flaky on your test
hardware. You would much rather save the build and reboot just to find
out it is broken).

-Peff
