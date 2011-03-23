From: Jeff King <peff@peff.net>
Subject: Re: gsoc - Better git log --follow support
Date: Wed, 23 Mar 2011 13:06:55 -0400
Message-ID: <20110323170655.GA4392@sigill.intra.peff.net>
References: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
 <20110321122407.GH16334@sigill.intra.peff.net>
 <AANLkTi=woLeveur6gKnSXTRzmS8nB0o4M9HegJ+GNUCa@mail.gmail.com>
 <20110323162023.GC30337@sigill.intra.peff.net>
 <7v8vw5g4f0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Micha=C5=82_=C5=81owicki?= <mlowicki@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 18:07:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2RWR-00056z-Nd
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 18:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab1CWRG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 13:06:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53984
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597Ab1CWRG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 13:06:57 -0400
Received: (qmail 6695 invoked by uid 107); 23 Mar 2011 17:07:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Mar 2011 13:07:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2011 13:06:55 -0400
Content-Disposition: inline
In-Reply-To: <7v8vw5g4f0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169855>

On Wed, Mar 23, 2011 at 09:58:11AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   # Now try it with --follow. Not so pretty.
> >   git log --oneline --graph --follow builtin/add.c
> 
> Is that an artifact of history simplification?

I think it's a combination of factors. The lack of history
simplification is why the graph is all choppy. The insanely wide
results, though, are probably due to the problem you mention below.

> I've always thought that it was because --follow hack used a single global
> pathspec that flipped at a rename boundary,regardless of which part of the
> history (i.e. the branch that was before the rename or after the rename)
> it is following.  So if you have two branches merged together:
> 
>         o---o---o---o---o---x---x---x
>        /                   / 
>    ...o---o---o---x---x---x
> 
> where commits marked with 'x' has it under the new path while commits
> marked with 'o' has it under the old path, and start to dig the history
> from the rightmost commit, the hack notices the rename at the transition
> between the "o---x" on the upper branch and from then on keep digging the
> history using the old path as the pathspec.  The commit history traversal
> goes reverse-chronologically, so when inspecting the next commit, which is
> the rightmost commit on the lower branch, the hack fails because it uses a
> wrong pathspec (at that point it should still be using the new path as the
> pathspec, but it already has switched to the old path).

When I prototyped the multi-file --follow last summer, I added newly
found source paths to the pathspec list instead of replacing them.
Strictly speaking, this can add unwanted commits when the names are
re-used for unrelated files (either the source name is used on a
parallel side branch, or the destination name is used in an earlier
file). But in practice it generates pretty good results, because those
corner cases don't tend to happen much. 

Obviously a solution that always provides an exact right answer is
preferable to "pretty good results", but we'd have to keep in mind the
performance difference.

-Peff
