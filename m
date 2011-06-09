From: Jeff King <peff@peff.net>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 18:21:44 -0400
Message-ID: <20110609222144.GA7413@sigill.intra.peff.net>
References: <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <4DF10ADA.5070206@alum.mit.edu>
 <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
 <20110609200403.GA3955@sigill.intra.peff.net>
 <4DF13D00.2060000@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 10 00:22:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUnc6-0004Gf-JA
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 00:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820Ab1FIWVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 18:21:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44400
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755739Ab1FIWVv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 18:21:51 -0400
Received: (qmail 20311 invoked by uid 107); 9 Jun 2011 22:21:58 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 18:21:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 18:21:44 -0400
Content-Disposition: inline
In-Reply-To: <4DF13D00.2060000@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175580>

On Thu, Jun 09, 2011 at 11:37:04PM +0200, Michael Haggerty wrote:

> On 06/09/2011 10:04 PM, Jeff King wrote:
> > I'm less sure about these new tokens, for a few reasons:
> > 
> >   1. You get less useful answers in some situations by treating each
> >      stage as a separate tree (e.g., lack of combined diff). So why
> >      would I want to use them?
> 
> Wouldn't it be nice to be able to do a combined diff between *any* two
> trees?  Then the nonuniform merge behavior of "git diff" would be a
> special case of a general concept:
> 
>     git diff3 OURS NEXT THEIRS

You can almost already do that with "git diff". For example:

  merge=456a4c08b8d8ddefda939014c15877ace3e3f499
  git diff $merge $merge^1 $merge^2

which should show the same diff as "git show $merge".

To do that in the index case, I think you would want:

  git diff WTREE HEAD MERGE_HEAD

except that you can't say "WTREE" yet.

You might want:

  git diff NEXT HEAD MERGE_HEAD

but I'm not sure it is going to be useful. For resolved paths, it makes
sense: show the combined diff that would happen if I committed this
right now. But for unmerged paths, NEXT is going to default to HEAD, so
it's going to be the combined diff as if you threw out all of the
changes from both branches. Which is probably not helpful.

I'm not sure about OURS and THEIRS versus HEAD and MERGE_HEAD. They also
default to HEAD, so I guess that:

  git diff NEXT OURS THEIRS

would omit unresolved paths and give you only the "what would happen if
I committed this". Which is not something I have ever heard of somebody
wanting, but is at least something you can't calculate with current git.

I'd be curious to see more concrete examples of situations where these
tokens could help.

> There is no need to explain the pseudotrees in terms of the index
> stages; the pseudotrees are easier to understand and should therefore
> become the primary way to describe the index.  Let me give it a try, at
> tutorial level.  Assume that the concepts HEAD and WTREE have already
> been introduced:
> [...]

Not too bad. It's long, but I don't think any single concept in it is
hard. Of course I already understand the index, so maybe I'm not a good
judge.

I would be most worried about the following spots in terms of confusing
users:

>   The "index" is a special area that can hold one or more temporary
>   snapshots of your version-controlled content.  Each snapshot is
>   called a "tree" because it is analogous to a filesystem tree such
>   as the working tree [1].

This is giving the user a different mental model than what is actually
in the index. I haven't yet convinced myself whether that mental model
is completely isomorphic to what is actually being stored or not. If it
isn't, then what are the cases where the abstraction is going to leak,
and what problems is it going to cause?

IOW, I am worried about the moment where somebody does a diff with one
of these trees, and it _doesn't_ do what they expect, and the
explanation for what did happen involves explaining how the index is
actually stored.

>   NEXT, as usual, contains the contents that are ready to be committed.
>   Specifically, NEXT contains:
> 
>     * the original contents of the branch being merged into
>     * plus the merged versions of any files that merged cleanly
>     * plus any changes that have been staged for commit using
>       "git stage"; for example, files whose conflicts have been
>       resolved manually.
> 
>   OURS contains all of the resolved merges from NEXT, with any
>   remaining conflicts resolved by using the version from the branch
>   being merged *into*.
> 
>   THEIRS contains all of the resolved merges from NEXT, with any
>   remaining conflicts resolved by using the content from the branch
>   being merged *from*.
> 
>   BASE contains all of the resolved merges from NEXT, with any
>   remaining conflicts resolved by using the content from the most
>   recent ancestor of the two branches being merged.

So now we have primitive definitions, which is good. They're clear,
unambiguous, and easy to understand. But what worries me is whether
people will be able to extrapolate that those definitions mean to the
various diffs.

It's nice that you give examples of how to ask for some common things,
but I wonder if we are creating the same situation of "here's the magic
incantation to show you what you want" without actually creating more
understanding in the average user. That is, will "git diff NEXT OURS
THEIRS" be any less magical to most users than "git diff"? Understanding
_why_ they work seems as difficult to me as understanding the index in
the first place.

>   As before, "git diff" can be used to view the differences between
>   these various trees.  For example, the following command displays the
>   conflicts that still have to be resolved:
> 
>       git diff NEXT WTREE

I wouldn't recommend this; the 3-way diff contains more information. I
know why you introduced this one first. It fits the path of your
narrative better. But it seems like it is also being recommended as the
right way to get this information.

-Peff
