From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve errors from 'git diff --no-index'.
Date: Mon, 23 May 2011 16:50:38 -0400
Message-ID: <20110523205038.GB6281@sigill.intra.peff.net>
References: <4dd98da1.1bf98e0a.4eb4.6fc5@mx.google.com>
 <7vlixyw4cx.fsf@alter.siamese.dyndns.org>
 <BANLkTinKpSP5oEms914TWD7Tsjab1B87QQ@mail.gmail.com>
 <7vhb8mw1e6.fsf@alter.siamese.dyndns.org>
 <BANLkTi=Uf8X+Bkd+CZ9qz0wXhHn8wwYzrA@mail.gmail.com>
 <7vpqn9usqt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Anthony Foiani <anthony.foiani@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 22:50:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOc5U-0002kO-6e
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 22:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757428Ab1EWUus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 16:50:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54493
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315Ab1EWUul (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 16:50:41 -0400
Received: (qmail 23254 invoked by uid 107); 23 May 2011 20:52:44 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 16:52:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 16:50:38 -0400
Content-Disposition: inline
In-Reply-To: <7vpqn9usqt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174273>

On Mon, May 23, 2011 at 12:22:34PM -0700, Junio C Hamano wrote:

> > $ # with my patch:
> > $ ../git/git-diff /tmp/{foo,bar}
> > warning: neither '/tmp/foo' nor '/tmp/bar' are tracked, forcing --no-index
> 
> I actually consider this a regression. We are giving an output that the
> user wanted to see, and I do not see a reason why we need to warn.

Agreed.

> One thing that I have always been unhappy about --no-index is that it does
> not really mesh well with the notion of what a "git diff" is. "git diff"
> inherently is an operation to take two collections of contents labeled
> with paths, and show series of patch output between corresponding paths in
> these collections, while rename/copy detection may affect the definition
> of "correspoinding paths".

It's not just --no-index that breaks this abstraction. How about:

  git diff HEAD:Makefile v1.7.5:Makefile

or even

  git diff :1:Makefile :2:Makefile

?

So I think even without --no-index, we have the concept that diff
compares two "things", and that only some of those things are a
collection of paths (either a tree-ish, or possibly a directory, but as
you note below, I suspect the latter is broken).

And obviously the two "things" must either both be single items, or must
both be collections, as any other comparison doesn't really make sense.
We do catch this, but it's another place where it might be nice to have
better error messages:

  $ git diff HEAD:Makefile HEAD
  usage: git diff [<options>] [<commit> [<commit>]] [--] [<path>...]

> 	$ git diff [--no-index] /tmp/foo /tmp/bar
> 
> but such a request does not compare "two collections of paths that have
> corresponding paths" at all. We could say we are comparing a collection
> that has tmp/foo with another that has tmp/bar, but then we should either
> emit a delete patch for tmp/foo and a create patch for tmp/bar, or emit a
> rename patch to create tmp/bar out of tmp/foo if we want to be consistent.
> 
> But that consistency goes totally against what the users would expect.

Right. If I give git two single items to compare, rather than
collections, I am not going to expect renames at all, which
fundamentally involve path movement. Those are a collection thing, and I
asked for a much narrower scope.

> The _only_ use of --no-index that is in line with what "git diff" does is
> to compare two directories as the "two collections of contents" above,
> i.e.
> 
> 	$ git diff --no-index old/ new/
> 
> and then support pathspecs, like this:
> 
> 	$ git diff --no-index old/ new/ -- Makefile '*.c'
> 
> But I do not think the current implementation does not even support this
> only sane usecase.

Yeah, I would expect git to support that, but knowing the builtin/diff.c
code, I am not too surprised if it doesn't. :)

On the subject of things git diff should probably do but I doubt anybody
cares enough to implement, it would be nice to be able to do:

  git diff $merge^1 $merge^2 $merge

and get the combined diff that "git show $merge" would give you, but
without the log cruft.

I also wonder if the reverse would be useful:

  git diff $ours $theirs `git merge-base $ours $theirs`

which would produce something like a reverse combined diff, or "how have
we diverged". E.g.,:

  diff --combined file
  index $base..$ours,$theirs
  --- a/file
  --- b/file
  @@@ -1,1 +1,1 +1,1 @@@
  --what was in the base
  + what is in ours
   +what is in theirs

But that is more than just a git-diff interface problem; we would
actually have to write the reverse-combined diff code (I _think_ it
should be a pretty simple reversal of the regular combined diff, but I
haven't really thought it through).

-Peff
