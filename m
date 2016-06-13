From: Jeff King <peff@peff.net>
Subject: Re: Repacking a repository uses up all available disk space
Date: Mon, 13 Jun 2016 00:58:31 -0400
Message-ID: <20160613045831.GA3950@sigill.intra.peff.net>
References: <20160612212514.GA4584@gmail.com>
 <20160612213804.GA5428@sigill.intra.peff.net>
 <20160612215436.GB4584@gmail.com>
 <20160612221309.GC5428@sigill.intra.peff.net>
 <CACsJy8Awd2oCm0puh=bnKu9snOZr85+kVRe0D5DUhP6NhmiwcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 06:58:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCJxP-0004Qx-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 06:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbcFME6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 00:58:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:53613 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753232AbcFME6e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 00:58:34 -0400
Received: (qmail 24505 invoked by uid 102); 13 Jun 2016 04:58:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 00:58:33 -0400
Received: (qmail 10133 invoked by uid 107); 13 Jun 2016 04:58:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 00:58:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 00:58:31 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Awd2oCm0puh=bnKu9snOZr85+kVRe0D5DUhP6NhmiwcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297153>

On Mon, Jun 13, 2016 at 07:24:51AM +0700, Duy Nguyen wrote:

> >> - git fsck --full
> >> - git repack -Adl -b --pack-kept-objects
> >> - git pack-refs --all
> >> - git prune
> >>
> >> The reason it's split into repack + prune instead of just gc is because
> >> we use alternates to save on disk space and try not to prune repos that
> >> are used as alternates by other repos in order to avoid potential
> >> corruption.
> 
> Isn't this what extensions.preciousObjects is for? It looks like prune
> just refuses to run in precious objects mode though, and repack is
> skipped by gc, but if that repack command works, maybe we should do
> something like that in git-gc?

Sort of. preciousObjects is a fail-safe so that you do not ever
accidentally run an object-deleting operation where you shouldn't (e.g.,
in the shared repository used by others as an alternate). So the
important step there is that before running "repack", you would want to
make sure you have taken into account the reachability of anybody
sharing from you.

So you could do something like (in your shared repository):

  git config core.repositoryFormatVersion 1
  git config extension.preciousObjects true

  # this will fail, because it's dangerous!
  git gc

  # but we can do it safely if we take into account the other repos
  for repo in $(somehow_get_list_of_shared_repos); do
	git fetch $repo +refs/*:refs/shared/$repo/*
  done
  git config extension.preciousObjects false
  git gc
  git config extension.preciousObjects true

So it really is orthogonal to running the various gc commands yourself;
it's just here to prevent you shooting yourself in the foot.

It may still be useful in such a case to split up the commands in your
own script, though. In my case, you'll note that the commands above are
racy (what happens if somebody pushes a reference to a shared object
between your fetch and the gc invocation?). So we use a custom "repack
-k" to get around that (it just keeps everything).

You _could_ have gc automatically switch to "-k" in a preciousObjects
repository. That's at least safe. But note that it doesn't really solve
all of the problems (you do still want to have ref tips from the leaf
repositories, because it affects things like bitmaps, and packing
order).

> BTW Jeff, I think we need more documentation for
> extensions.preciousObjects. It's only documented in technical/ which
> is practically invisible to all users. Maybe
> include::repository-version.txt in config.txt, or somewhere close to
> alternates?

I'm a little hesitant to document it for end users because it's still
pretty experimental. In fact, even we are not using it at GitHub
currently. We don't have a big problem with "oops, I accidentally ran
something destructive in the shared repository", because nothing except
the maintenance script ever even goes into the shared repository.

The reason I introduced it in the first place is that I was
experimenting with the idea of actually symlinking "objects/" in the
leaf repos into the shared repository. That eliminates the object
writing in the "fetch" step above, which can be a bottleneck in some
cases (not just the I/O, but the shared repo ends up having a _lot_ of
refs, and fetch can be pretty slow).

But in that case, anything that deletes an object in one of the leaf
repos is very dangerous, as it has no idea that its object store is
shared with other leaf repos. So I really wanted a fail safe so that
running "git gc" wasn't catastrophic.

I still think that's a viable approach, but my experiments got
side-tracked and I never produced anything worth looking at. So until
there's something end users can actually make use of, I'm hesitant to
push that stuff into the regular-user documentation. Anybody who is
playing with it at this point probably _should_ be familiar with what's
in Documentation/technical.

-Peff
