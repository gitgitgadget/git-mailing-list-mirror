From: Jeff King <peff@peff.net>
Subject: Re: Efficiently detecting paths that differ from each other only
 in case
Date: Sun, 10 Oct 2010 23:07:55 -0400
Message-ID: <20101011030755.GB6523@sigill.intra.peff.net>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
 <20101008135034.GC5163@sigill.intra.peff.net>
 <AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
 <20101008195120.GA10810@sigill.intra.peff.net>
 <AANLkTimAhjHm5Z4ekTOBaxwzyw2YD6MrRnB1O8E6nAtw@mail.gmail.com>
 <20101008200657.GA10954@sigill.intra.peff.net>
 <AANLkTi=YQOVYsK6Brq5pMiAdrH3Un7RgrWvYf_pymT=d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 05:07:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58jv-0002NH-4o
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 05:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab0JKDHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 23:07:45 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58872 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888Ab0JKDHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 23:07:45 -0400
Received: (qmail 12070 invoked by uid 111); 11 Oct 2010 03:07:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 11 Oct 2010 03:07:44 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Oct 2010 23:07:55 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=YQOVYsK6Brq5pMiAdrH3Un7RgrWvYf_pymT=d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158746>

On Fri, Oct 08, 2010 at 05:57:16PM -0500, Dun Peal wrote:

> On Fri, Oct 8, 2010 at 3:06 PM, Jeff King <peff@peff.net> wrote:
> > Re-reading your original message, I have a few more thoughts.
> >
> > One is that you don't need to do this per-commit. You probably want to
> > do it per-updated-ref, each of which may be pushing many commits. And
> > then you either reject the new ref value or not.
> 
> I think I do, actually, because let's say the developer pushes two
> commits, 1<-2. Suppose commit 1 violates the rule, but commit 2
> reverts the violation. One might think that we don't care, since the
> head will now be on 2, which is a correct state. But in fact we do,
> because this is Git, and anyone may branch of from 1 in the future,
> and voila we have a head in an incorrect state.

Yeah, though it is not an especially likely state to branch from, since
you have to specify it manually. However, a much more likely scenario is
checkout out a past commit for testing, especially in bisection. So yes,
if you want to be thorough, you need to check every commit.

> Yeah, that's a pretty good idea, if not for the many ls-tree calls.
> With their overhead, I strongly suspect it may be slower than the
> solution you seem to propose, which is:
> 
> git ls-tree -r <commit>
> 
> which should give the full list of all paths in a commit, upon which I
> can decide to accept or reject.

Yeah, that is what I am proposing.

One other thing you could try is to "ls-tree -r" the known-good state of
the current HEAD at the beginning of the push, and then run "git log
-diff-filter=AD --name-status $old..$new". For each commit in the log
output, look for new entries that are in case-insensitive conflict with
the existing tree, and then update your tree state appropriately with
added and removed files. You only invoke two git commands, which saves
on invocation overhead, and you only ls-tree once per push, not per
commit. Git's internal diff shouldn't look at parts of the tree that
aren't relevant.

The downside is that the tree state you are keeping internally is not
entirely accurate. For example, when receiving a merge between two
parallel lines of development, you would process them linearly, when in
fact there are two simultaneous different states. So there is a case
where branch X removes "foo.txt" and branch Y adds "FOO.TXT", and then
they merge. It looks OK because linearly, they did not both exist at the
same time. But pre-merge, the commit in branch Y is broken.

So really the straightforward approach of checking the tree state for
each commit is probably simplest. If it's really too slow, you could try
jgit or linking against git itself, which would eliminate the external
process overhead.

-Peff
