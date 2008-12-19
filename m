From: Jeff King <peff@peff.net>
Subject: Re: Git Notes idea.
Date: Fri, 19 Dec 2008 16:25:36 -0500
Message-ID: <20081219212536.GA27168@coredump.intra.peff.net>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com> <alpine.DEB.1.00.0812170003540.14632@racer> <5d46db230812161815s1c48af9dwc96a4701fb2a669b@mail.gmail.com> <alpine.DEB.1.00.0812170420560.14632@racer> <20081217101110.GC18265@coredump.intra.peff.net> <5d46db230812190918qf22b874n8d8aeea557083df8@mail.gmail.com> <5d46db230812190938r4e8ff994gfcb616c750be0f22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Govind Salinas <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 22:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDms6-0007Hd-J8
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 22:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbYLSVZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 16:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbYLSVZk
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 16:25:40 -0500
Received: from peff.net ([208.65.91.99]:3888 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbYLSVZj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 16:25:39 -0500
Received: (qmail 19868 invoked by uid 111); 19 Dec 2008 21:25:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Dec 2008 16:25:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Dec 2008 16:25:36 -0500
Content-Disposition: inline
In-Reply-To: <5d46db230812190938r4e8ff994gfcb616c750be0f22@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103584>

On Fri, Dec 19, 2008 at 11:38:55AM -0600, Govind Salinas wrote:

> This is my concern with keeping a history of the notes pseudo-branch.  Let
> me restate what you are saying with an example
> 
> 1) on branch A commit a
> 2) add note a`
> 3) on branch B commit b
> 4) add note b`
> 5) on branch B commit c
> 6) add note c`
> 7) delete branch A
> 8) gc after a time such that a is pruned
> 
> Now either I will always have a note a` as an object forever even though
> the only commit that points to it is gone or I have to re-write the history of
> the notes branch from the point that it was added.

Yes, that's correct.

> Given this problem, is it really such a good idea to keep the history?

I think so. Otherwise how will you push and pull notes? You won't even
know which one is the more recent tree, let alone handle any merges
caused by editing notes in two places.

> On the other, other hand, pushing and pulling notes if a history is kept
> will have to involve a lot of rebasing/merging.

Depending on your workflow. It might just involve a lot of fast forwards
if the note writer is in one place.

> A possible solution is that notes are per-branch,
> 
> refs/notes/heads/master
> refs/notes/heads/foo/bar
> refs/notes/remotes/baz/bang

Sorry, I don't quite get it. You are asking for per-branch notes that
keep history, or per-branch notes that don't keep history?

If the former, then you haven't solved the cruft accumulation problem.
You can get obsolete notes in your note history by rebasing on a branch
that is long-running (which is OK as long as you haven't published
_those particular_ commits). Or are you proposing to rebase and cleanup
the notes history every time you do a destructive operation?

If the latter, then I don't see how you've solved the push-pull and
merge problem (which you need history for).

But in either case, I think the solution is non-intuitive. If I annotate
a commit, and then merge the commit from one branch to another,
shouldn't the annotation stay?


Really, I am not sure this is worth getting too concerned about. Since
we are talking about cruft in the _history_ of the notes branch, it
won't impact actual notes usage (which will always just deal with the
most recent tree). So really we are talking about some uninteresting
objects in the db, which wastes some space. In practice, I suspect this
won't be that large because notes themselves are going to be relatively
short and in many cases, repetitive (i.e., many annotations may have the
same blob hash for several commits). And if it is a space problem, then
the right solution is to periodically truncate the notes history by
rewriting.

-Peff
