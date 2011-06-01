From: Jeff King <peff@peff.net>
Subject: Re: speed of git reset -- file
Date: Wed, 1 Jun 2011 17:18:47 -0400
Message-ID: <20110601211847.GA31958@sigill.intra.peff.net>
References: <20110531190015.GA12113@gnu.kitenet.net>
 <20110531212639.GA13234@sigill.intra.peff.net>
 <7v62oqignm.fsf@alter.siamese.dyndns.org>
 <20110601195831.GA30070@sigill.intra.peff.net>
 <20110601201629.GA25354@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 23:18:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRsoa-0007qx-J1
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 23:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759517Ab1FAVSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 17:18:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50684
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753648Ab1FAVSu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 17:18:50 -0400
Received: (qmail 17665 invoked by uid 107); 1 Jun 2011 21:18:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 17:18:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 17:18:47 -0400
Content-Disposition: inline
In-Reply-To: <20110601201629.GA25354@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174902>

On Wed, Jun 01, 2011 at 04:16:29PM -0400, Joey Hess wrote:

> Jeff King wrote:
> > So implementing the "optimization" to drop the refresh here doesn't seem
> > worth it. It inroduces an awful inconsistency, and it probably isn't
> > saving much in practice. Lots of other commands will end up stat'ing
> > everything, anyway. Users with giant repos or slow stat calls are
> > probably better off using assume-unchanged, which would help this and
> > many other situations.
> 
> Sounded like git-reset -q file could be optimised to not reread the
> index without any visible inconsistency?

No, there would still be a visible inconsistency. For example:

  $ git reset -q -- file
  $ git diff-files

might leave stat-dirty entries in the index, but:

  $ git reset -- file
  $ git diff-files

would not.

In practice, it doesn't matter that much, because you would probably run
the porcelain "git diff" instead of the plumbing "git diff-files"
anyway. And "git diff" refreshes the index itself, so the behavior
change is not that important. But then, as you see, we end up refreshing
the index defensively a lot, anyway, so saving the one refresh from
reset may be lost in the noise (unless you are doing some tight loop of
resets).

So what you could do with assume-unchanged (or much better, the
autorefreshindex variable that Junio recommends), would be to shut off
_all_ of the unnecessary refreshes, not just this one.

> My experience with semi-large trees[1] is that I have to remember to use
> "git status ." in a subdir; that "git commit -a" is of course slow when
> I need to use it; and that the index gets big and things that need to
> update it can become somewhat slow especially on slow disks, but that

Generally I find that the stats are very fast because everything is in
cache, and the disk doesn't come into it at all. Are you on an OS
besides Linux, or on a machine with low memory?

> otherwise git scales fairly well and has good locality, and that it's
> easy to reason about what operations are global and avoid them.
> So this git-reset behavior was surprising.

Yeah, git is generally very good about touching only the pieces of data
you need to complete the current operation. But I think the decision was
made long ago that "update-index --refresh" was not too expensive to do
it in most porcelain-ish commands, especially since the results are much
better (e.g., more accurately indicating modified files after a reset).

> assume-unchanged seems like it would add a lot of work when merging.

Yeah, Junio's autorefresh suggestion is much better.

-Peff
