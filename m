From: Jeff King <peff@peff.net>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 16:04:03 -0400
Message-ID: <20110609200403.GA3955@sigill.intra.peff.net>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <4DF10ADA.5070206@alum.mit.edu>
 <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 22:04:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUlSf-0007BC-JI
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 22:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab1FIUEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 16:04:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46981
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683Ab1FIUEH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 16:04:07 -0400
Received: (qmail 18846 invoked by uid 107); 9 Jun 2011 20:04:14 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 16:04:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 16:04:03 -0400
Content-Disposition: inline
In-Reply-To: <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175570>

On Thu, Jun 09, 2011 at 11:38:21AM -0700, Junio C Hamano wrote:

> I think this mega-thread served its purpose. It started to explore "will
> it make it easier to understand and explain if we use these tokens to name
> trees that do not exist in reality?" which is a worthy thing to do.  The
> conclusion appears to be "well we do not even know what exactly these
> tokens mean in certain situations." but at least people tried, and along
> the way a few new people seem to have become more aware of the index, so
> overall we didn't lose that much.

I think there are actually two questions here:

  1. Will it be easier for people to understand "git diff" if we use
     tokens to describe non-treeish sources and destinations?

  2. Are there better tokens to use to break down parts of the index?

I don't have a big problem with (1). Allowing things like:

  git diff INDEX WTREE

allows one to explain what is going on with the diff syntax in a very
clear and verbose manner. I wouldn't want to type that every day, but
that's OK; "git diff" will always mean the same thing as it always has,
but can now be explained to people who have trouble seeing it in terms
of "git diff INDEX WTREE".

There's still a bit of magic in that INDEX is _not_ a tree, but I think
that's a good thing. When there are no merge conflicts, it will behave
identically to the proposed NEXT tree. And when there are conflicts, it
will show you something even more useful.

It does have the potential to confuse in that "INDEX" is not actually a
tree, and so we can't expect to use it as a tree-ish everywhere. So now
diff feels a little inconsistent with other parts of git. One idea,
which I think is probably too crazy, would be to let INDEX be used as a
tree-ish everywhere, but only if all entries are at stage 0. Otherwise,
it will die with an error. That would make it more or less a more
verbose version of ":" (e.g., I can do "git show :Makefile", but it will
die with an error if Makefile exists only at higher stages).


I'm less sure about these new tokens, for a few reasons:

  1. You get less useful answers in some situations by treating each
     stage as a separate tree (e.g., lack of combined diff). So why
     would I want to use them?

  2. Their answers are different than what diffing against the INDEX
     could give. So in theory they could be more useful in different
     situations than a diff against the index. But I haven't seen a good
     example of what such a situation would be.

  3. They're supposed to introduce consistency in explaining diff
     behavior. But we're not going to change what "git diff" does to not
     use the whole index. So "git diff" isn't actually expressible using
     these tokens.

  4. They're supposed to be simpler to understand than index stages. But
     are they? The latest definitions seem to be:

       OURS is a tree of each path in the index, either from stage 2 if
       it exists, or from NEXT otherwise.

       NEXT is a tree of each path in the index, either from stage 0 if
       it exists, or from HEAD otherwise.

     But that doesn't seem any simpler to me than just saying "the index
     has numbered stages, and they correspond to resolved, base, ours,
     and theirs".

I agree that ":2:Makefile" is not exactly an intuitive way to ask for
"ours". Didn't we have a patch at one point a year or two ago to allow
using names instead of numbered stages? If we allowed "INDEX" as a
verbose noise-word in front of ":", then you could say:

  git show INDEX:OURS:Makefile

which is identical to what I wrote above, but is perhaps easier to
explain.

-Peff
