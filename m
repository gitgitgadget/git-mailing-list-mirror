From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 11:47:45 -0700
Message-ID: <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 20:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhQxM-00087e-KB
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 20:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab1GNSsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 14:48:11 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41993 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932078Ab1GNSsK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 14:48:10 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6EIm761028369
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:48:08 -0700
Received: by wwe5 with SMTP id 5so622598wwe.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:48:05 -0700 (PDT)
Received: by 10.216.54.197 with SMTP id i47mr6625859wec.48.1310669285083; Thu,
 14 Jul 2011 11:48:05 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Thu, 14 Jul 2011 11:47:45 -0700 (PDT)
In-Reply-To: <20110714183710.GA26820@sigill.intra.peff.net>
X-Spam-Status: No, hits=-102.895 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177151>

On Thu, Jul 14, 2011 at 11:37 AM, Jeff King <peff@peff.net> wrote:
>
> I'd love to have in-commit generation numbers. I'm just not sure we can
> get the speeds we want without caching them for existing commits.

So my argument would be that we'd simply be much better off fixing the
fundamental data structure (which we can), and let it become the
long-term solution.

Now, if *may* turn out that we'd want to have some cache for
generation numbers in commits that don't have them, but I absolutely
think that that should be a "add-on" rather than anything fundamental.
For example, if we just merge the "add generation numbers to the
commit object" logic first, then the "cache" case never really needs
to care about us generating new commits. They simply won't need the
cache.

Also, I suspect that the cache could easily be done as a *small* and
*incomplete* cache, ie you don't need to cache all commits, it would
be sufficient to cache a few hundred spread-out commits, and just know
that "from any commit, the cached commit will be quickly reachable".

> I'm not sure that is the best plan. Calculating generation numbers
> involves going to all roots. So once you have to find any generation
> number, it's going to be expensive, no matter how many recent commits
> have generation numbers already in them (but it won't get _more_
> expensive as more commits are added; you'll always be traversing from
> the commit in question down to the roots).

It only ends up being expensive if the commit has parents that don't
have generation numbers.

That's a fairly short-term problem. For the kernel, for example,
basically no development happens on a base that is older than one or
two releases. So if I (and Greg, with the stable tree) start using my
patch, within a couple of weeks, pretty much all development would
have a generation number in its history.

Sure, sometimes I'd merge from people who based their tree on
something old, and I'd end up calculating it all. But it would get
progressively rarer.

> As we add new commits with generation numbers, we won't need to do a
> calculation to get their numbers. But if you are doing something like
> "tag --contains", you are going to want to know the generation number of
> old tags (otherwise, you can't know whether your cutoff might hit them
> or not). IOW, even if we add generation numbers _today_, every "tag
> --contains" in linux-2.6 is going to end up traversing from v3.0-rc7
> down to the roots to get its generation number (v3.0-rc8 would get an
> embedded generation, of course).

So that could easily be handled by caching. In fact, I suspect that
you could make the cache no associate with a commit ID, but be
associated with the tags and heads. But again, then the cache would be
a "secondary" issue, not something fundamental.

> So if you aren't going to cache generation numbers, then you might as
> well write your traversal algorithm to assume you don't know them for
> old commits.

But that's how our algorithms are *already* written.

So why not have that as the fallback? You get the advantage of
generation numbers only with modern things, but those are the ones you
actually tend to use.

Merge bases are *very* seldom historical, for example.

                     Linus
