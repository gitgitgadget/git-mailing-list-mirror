From: Jeff King <peff@peff.net>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 15:41:05 -0400
Message-ID: <20110609194104.GA4026@sigill.intra.peff.net>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <4DF10ADA.5070206@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 09 21:41:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUl6R-0005Qs-6Z
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 21:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654Ab1FITlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 15:41:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38107
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574Ab1FITlI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 15:41:08 -0400
Received: (qmail 18631 invoked by uid 107); 9 Jun 2011 19:41:15 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 15:41:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 15:41:05 -0400
Content-Disposition: inline
In-Reply-To: <4DF10ADA.5070206@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175569>

On Thu, Jun 09, 2011 at 08:03:06PM +0200, Michael Haggerty wrote:

> Thanks for the correction.  So one interesting pseudo-tree would be
> 
> OURS -- The NEXT version of any file that has been resolved; and the
> stage 2 version of any file that has not yet been resolved.  The name
> seems consistent with what is meant by, e.g., "git checkout --ours".

Yeah, that makes sense to me as a definition.

> > So the index is not quite simply a set of four trees. The presence of
> > various stages for each entry tells us the progress of resolution.
> 
> Wouldn't the four trees described above contain information equivalent
> to the contents of the index?

Taken together, yes, I think you could represent the whole index. But
each taken alone is missing some information that might be useful in a
diff.

For example, if I do "git diff THEIRS WTREE" during a merge conflict,
that is a 2-way diff that is going to show things in THEIRS going away,
and both things brought by OURS and things that are part of a resolution
being added. That's less information than "git diff INDEX WTREE" (i.e.,
what is currently spelled as "git diff") provides, because when looking
at the whole index we can do a combined diff showing which part came
from which parent.

> For example, the resolution work that remains to be done that can be
> inquired using old-fashioned "git diff" (3-way diff) could also be
> accessed via
> 
>     git diff NEXT OURS
>     git diff NEXT THEIRS

But you don't get to see it together. You have to do two separate diffs,
which means you will see conflicted regions twice. Try:

  git log --merges -p --cc

on a repo of your choice, and compare with:

  git log --merges -p -m

The former is what "git diff" would show just before marking paths as
resolved, and the latter is what your two diffs above would show.

> or even
> 
>     git diff NEXT WTREE
> 
> if you want to see the remaining conflicts in <<<<<======>>>>>> format.

As I mentioned in an earlier email, this doesn't show which parts are
part of the resolution process (including conflict markers), and which
came from either side of the merge.

-Peff
