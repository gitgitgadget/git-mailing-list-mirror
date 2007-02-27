From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] commit-tree: bump MAX_PARENTS to 128
Date: Tue, 27 Feb 2007 05:52:12 -0500
Message-ID: <20070227105212.GA21757@coredump.intra.peff.net>
References: <20070226121557.GA18114@coredump.intra.peff.net> <20070226143142.GA1390@spearce.org> <Pine.LNX.4.63.0702261736570.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vr6scj9qt.fsf@assigned-by-dhcp.cox.net> <20070227081933.GA13021@coredump.intra.peff.net> <7virdnhpbt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 11:52:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLzwQ-0006iV-DN
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 11:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbXB0KwP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 05:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933017AbXB0KwP
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 05:52:15 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3139 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933004AbXB0KwO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 05:52:14 -0500
Received: (qmail 15378 invoked from network); 27 Feb 2007 05:52:27 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Feb 2007 05:52:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2007 05:52:12 -0500
Content-Disposition: inline
In-Reply-To: <7virdnhpbt.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40707>

On Tue, Feb 27, 2007 at 02:23:02AM -0800, Junio C Hamano wrote:

> I hate having to compose this message because I know I will end
> up saying negative things without offering anything constructive.

First off, thanks for a thoughtful and well-written response; it was, in
fact, constructive in getting me to think about my setup. Subproject
support is actually what I want here.

> I do not think bundling commits from unrelated multiple projects
> in one commit (some people seem to have called this Hydra in the
> past) is a good practice, regardless of size.

I'll assume by "unrelated" here you mean in the git sense; that is, not
sharing any commit history. My projects are, in fact, semantically
related. Let me describe a little further. I had a CVS repository
consisting of school work over the past several years, with one
directory per class:

  school/cs101
  school/cs201
  etc.

A year or so ago, I started using git, and imported all of my CVS repos
to git. I did each class directory separately, reasoning that each
represented a separate history. This can end up being unwieldy, because
there are dozens of repositories; I would now like to group them in the
same repo for ease of clone/fetch.

Similarly, each new class I take gets its own repo, which is quite
convenient when actively committing. However, I would like to "archive"
it in the main repo.

Thus, I believe a central "archive" repo to which I could add
"subproject" pointers to each class's commit history would be ideal.
Something like the gitlink or subproject support which has been talked
about would work fine.

OTOH, I am fortunate that this is not a "real" distributed project. I
think the most convenient thing might be to simply rewrite the history
of each class, pushing all of its files into a subdirectory from the
main history.

>  * You do not care about the ancestry of Hydra itself, so it has
>    two parents, then-current tips of A and B?

This is my case; the hydra had no history at all.

> Now, do you have some files that are maintained by Hydra itself?

Nope. It's purely a set of subprojects.

> Although pointers to component project commits are represented
> as "parent" field in commit objects, I suspect that you wish
> they were treated as if they were tree objects contained in the
> toplevel commits more often than not for the purposes of many
> git operations.

Yes, that is exactly correct. One problem I realized after doing this is
that you get unexpected results from "git-whatchanged -- subproject/".
My first expectation was to see _just_ the history of the subproject.
But of course, you see only the merge commit, since the previous commits
for that subproject didn't have that path at all (they were in the
root!).  Subproject support would fix that, as would simply rewriting
the history.

> I am not saying that the problem you are trying to solve is a
> wrong problem.  Rather, it is showing a gap between the
> structure you are trying to express and the semantics of
> ancestry chain git offers.

Agreed. I have come around to the conclusion that this is an abuse of
the parent pointers.

> Yes, I am aware that you do not even intend to build on top of
> the history of your imported-from-CVS, so in that sense, you do
> not care about the ancestry of Hydra itself (it does not even
> have a history -- just a single state).  It's such a one-shot

I thought about that, too, but I actually _might_ want to make a commit
(e.g., I'm keeping most of this around for reference code. If the
reference code has a minor bug, it would be nice to fix it).


Anyway, thanks for your comments. I think I will look at simply
rewriting the history as if it were one big repository. I think it is
simplest in this case since I have the luxury of a private repo.

-Peff
