From: Jeff King <peff@peff.net>
Subject: Re: Ambiguous reference weirdness
Date: Wed, 22 Feb 2012 02:00:34 -0500
Message-ID: <20120222070034.GA17015@sigill.intra.peff.net>
References: <CABURp0oAw7cvU7cwCZOtvqZ_oa0hDPsE_0Lm3kR1ctdNuxU3hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 08:00:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S06Bw-00023d-0j
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 08:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab2BVHAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 02:00:37 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45736
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab2BVHAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 02:00:37 -0500
Received: (qmail 25740 invoked by uid 107); 22 Feb 2012 07:00:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Feb 2012 02:00:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2012 02:00:34 -0500
Content-Disposition: inline
In-Reply-To: <CABURp0oAw7cvU7cwCZOtvqZ_oa0hDPsE_0Lm3kR1ctdNuxU3hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191232>

On Tue, Feb 21, 2012 at 08:46:24PM -0500, Phil Hord wrote:

> I accidentally ran into this today:
>     $ git cherry-pick 1147
>     fatal: BUG: expected exactly one commit from walk
> 
> git log shows no output:
>     $ git log 1147

What is 1147? Is it supposed to be a partial sha1, or is it a ref you
have?

Have you looked at the object that it resolves to? I suspect it is the
partial sha1 of a non-commit object. E.g.:

  $ git cat-file -t HEAD^{tree}
  tree
  $ git cherry-pick HEAD^{tree}
  fatal: BUG: expected exactly one commit from walk
  $ git log HEAD^{tree} | wc -l
  0

Both cases have a similar source: they feed the arguments to the
revision walking machinery, which of course finds no actual revisions to
walk.

In the cherry-pick case, the code is checking the right thing, but the
message is horrible. It is not a bug, but merely unexpected input, and
it should provide a usage message.

In the log case, we totally ignore any pending non-revision arguments.
So it is correct to produce no output (there is nothing to show, which
is not unusual in itself; many queries end up producing empty output).
But we should probably notice that there are pending objects left over
and produce some kind of diagnostic.

I've reordered some of your example commands below to fit the flow of my
explanation better.

> $git log 114
> fatal: ambiguous argument '114': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions

Right. I think we require at least 4 characters in a partial sha1, so we
don't treat that as a possibility. So we are left guessing whether you
mean to do:

  git log 114 --

or

  git log HEAD -- 114

since it exists as neither a revision nor a path, and the error message
reflects that (the first one is an error, as there is no such revision.
The second is a correct query, though one that does not produce any
results).

> $ git checkout 114
> error: pathspec '114' did not match any file(s) known to git.

I think checkout has the same "is this a path or a revision" ambiguity
to resolve. But rather than be explicit that you might have meant "114"
as a tree, the error message assumes you meant a path. That might be
worth improving, similar to the above example.

Again, you can disambiguate with:

  $ git checkout -- 1147
  error: pathspec '1147' did not match any file(s) known to git.

  $ git checkout 1147 --
  fatal: reference is not a tree: 1147

> $ git checkout 1147
> fatal: reference is not a tree: 1147

In this case the name does resolve to an object, so we try to use it as
such (even though we later find that it is useless for the operation).
We _could_ realize that it is not a tree and disambiguate to:

  $ git checkout -- 1147

but the current rule is at least consistent and simple.

> $ git checkout 1146
> error: short SHA1 1146 is ambiguous.
> error: pathspec '1146' did not match any file(s) known to git.

The sha1 is ambiguous, and therefore it does not resolve to anything. So
you get the same case as "git checkout 1147", but with the extra
ambiguity warning.

> $ git merge 114
> fatal: '114' does not point to a commit

It might be nice for this error message to be split into two cases:

  1. the name does not resolve _at all_ (i.e., you made a typo)

  2. the name does resolve to something, but it is not a commit

In the latter case, we actually do get an extra error message from
elsewhere in the code:

> $ git merge 1147
> error: 1147: expected commit type, but the object dereferences to blob type
> fatal: '1147' does not point to a commit

But in case 1, it's not clear which is which (maybe even rewording it as
"114 cannot be resolved as a commit" would be less confusing).

> $ git cherry-pick 114
> fatal: ambiguous argument '114': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions
> [...]
> $ git cherry-pick 1147
> fatal: BUG: expected exactly one commit from walk

This is the "does not resolve" versus "is not actually a commit". In the
first case, though, I wonder if the error message is accurate. I'm not
sure if you can do "git cherry-pick <rev> -- <paths>", so the error
message is misleading (if anything, I would expect it to limit the
revision walk, but trying "git cherry-pick HEAD -- 114" seems to still
complain about the absence of 114).

> [more examples]

These are all variants that hopefully make sense in light of the
explanations above.

> I can understand some of the inconsistent error reporting (checkout
> may expect filenames, but cherry-pick and merge do not).  But this
> seems too varied to me.
> 
> And the first two look like bugs.
> 
> Any comments or suggestions?

I think the outcomes are all working as intended, but the error messages
could stand to be improved.

-Peff
