From: Jeff King <peff@peff.net>
Subject: Re: gsoc - Better git log --follow support
Date: Mon, 21 Mar 2011 08:24:07 -0400
Message-ID: <20110321122407.GH16334@sigill.intra.peff.net>
References: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82_=C5=81owicki?= <mlowicki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 13:24:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1e9g-0004kI-Rf
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 13:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab1CUMYM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 08:24:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39887
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563Ab1CUMYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 08:24:10 -0400
Received: (qmail 12793 invoked by uid 107); 21 Mar 2011 12:24:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Mar 2011 08:24:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2011 08:24:08 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169588>

On Sat, Mar 19, 2011 at 08:24:20PM +0100, Micha=C5=82 =C5=81owicki wrot=
e:

> I'm looking at idea about better git log --follow support from
> https://git.wiki.kernel.org/index.php/SoC2011Ideas .There is somethin=
g
> like this - "[.. ] it does not interact well with git's usual history
> simplification [...]". Can someone elaborate this? I've found History
> Simplification in git rev-list man but don't know yet about issues
> with --follow.

In short, history simplification is a way of looking at a subset of the
commit history graph, but in a way that makes it look like a complete
graph. Imagine I have a linear history like this:

  A--B--C

where "A" modifies "file1", "B" modifies "file2", and "C" modifies
"file1" again. If I ask for the history of "file1" with "git log file1"=
,
then git will pretend as if the graph looks like:

  A--C

including rewriting the parent of "C" to point to "A" (because the
parent pointer is basically an edge in the graph).

If you are just doing a straight "git log", the actual parentage is not
that interesting. We either show commits or we don't, and we don't show
links between them. But try "git log --graph" or "gitk", which do care
about the edges. They want to show you a whole connected graph.

Now consider --follow. It doesn't happen during the commit limiting
phase, but instead it happens while we're showing commits. And if it
decides a commit isn't interesting, we don't show it. That works OK for
"git log", but it makes the graph for other things disjointed.

You can see it in this example:

  # make the A-B-C repo we mentioned above
  git init repo && cd repo
  echo content >file1 && git add file1 && git commit -m one
  echo content >file2 && git add file2 && git commit -m two
  echo content >>file1 && git add file1 && git commit -m three

  # Now look at it in gitk; we see a nice linear graph.
  gitk

  # Now let's try it with path limiting. We see a nice subgraph that
  # pretends to be linear, because we "squished" out the uninteresting
  # nodes.
  gitk file1

  # Now let's make some more commits with a rename.
  echo content >>file2 && git commit -a -m four
  git mv file1 newfile && git commit -m five
  echo content >>newfile && git commit -a -m six

  # If we use path limiting, we'll only see the two most recent commits=
=2E
  # We get stopped at the rename because path limiting is just about th=
e
  # pathname.
  gitk newfile

  # So we can use --follow to follow the rename. First let's try simple
  # output. You should see commits 1, 3, 5, and 6, which touched either
  # newfile or its rename source, file1.=20
  git log --oneline --follow newfile

  # But now look at it in gitk. Commit 4 is included as a boundary
  # commit, but we fail to notice that it connects to three. And we
  # don't see commit 3 connecting to anything, and commit 1 is missing
  # entirely.
  gitk --follow newfile

Obviously this a pretty simplistic example. But you can imagine in a
history with a lot of branching how useful this simplification is to
understanding what happened to a subset of the tree.

Jakub mentioned another example with gitweb's subtree merge not being
found by --follow. I haven't looked into that case, but it may be
related (or it may simply be a defect in follow finding the right
source).

-Peff
