From: Jeff King <peff@peff.net>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 19:23:52 -0500
Message-ID: <20090217002352.GA23507@coredump.intra.peff.net>
References: <alpine.LNX.1.00.0902160322530.19665@iabervon.org> <7veixybw7u.fsf@gitster.siamese.dyndns.org> <loom.20090216T101457-231@post.gmane.org> <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com> <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302> <4999BD54.8090805@gmail.com> <7vprhidpnc.fsf@gitster.siamese.dyndns.org> <20090216224330.GA23764@sigill.intra.peff.net> <7vhc2uezl7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:25:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZDm8-0000cK-H3
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbZBQAX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbZBQAX4
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:23:56 -0500
Received: from peff.net ([208.65.91.99]:37180 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbZBQAX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:23:56 -0500
Received: (qmail 24008 invoked by uid 107); 17 Feb 2009 00:24:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Feb 2009 19:24:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2009 19:23:52 -0500
Content-Disposition: inline
In-Reply-To: <7vhc2uezl7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110268>

On Mon, Feb 16, 2009 at 03:23:00PM -0800, Junio C Hamano wrote:

> >   1. How can we improve this situation?
> 
> The situation you described is all about "don't allow a push that is NOT
> CONTROLLED BY YOU and that can interfere with what you are doing into a
> live repository", and you are right, we have operations that deliberately
> detach the HEAD and expect nobody mucks with the branch.

I don't agree that it has to be a push not controlled by you. I have
many times left a rebase-in-progress sitting in a repository, either
accidentally because I meant to "--abort" it after a conflict but
forgot, or because I got interrupted during an interactive edit and
needed to come back to it.

So the problem is simply that the repository you're pushing into is not
in the state you think it is (either because you forgot what state you
left it in, didn't realize what state you left it in, or because it is
somebody else's repo).

> But is this something even worth considering about in the same context as
> the denyCurrentBranch?  The same thing can happen even if you are not
> detaching HEAD.

I don't think it's the same, but I think it is a related problem. I
don't think the solutions are related, though.

> For example, I sometimes end up with an ugly series on a branch, whose
> endpoint is a good looking tree.  And a refactoring I would want to do
> would be too cumbersome for the interactive rebase (I could do it, but the
> machinery does not help as much as it would for a simpler case).  In such
> a case, often I would just say:
> 
> 	$ git branch -f goal
>         $ git reset --hard master
>         : repeat from here until "diff HEAD goal" becomes empty
>         ... cherry-pick $a_commit_in_goal_branch, or
>         ... edit "show $a_commit_in_goal_branch" output and apply, or
>         ... edit the files in place.
>         ... make a commit, perhaps using -c $a_commit_in_goal_branch
> 	: repeat up to here
> 
> I would not push into this repository to update the branch "goal" while I
> am doing this, as it will obviously screw up the whole process.  I think

OK, that is a good example of how this is basically impossible to
protect from fully (and a good argument why pushing into a repo used for
work is probably not a good idea in general). I think the rebase example
is a little worse because:

  - It's subtle. with denyCurrentBranch, we generally protect the user
    from pushing into the current branch and messing things up. But
    during a rebase we don't, and the only way the user would realize
    that is if they understand that rebasing happens on a detached HEAD.

  - the error message is confusing, and there is no clear way out of the
    error case. You can "rebase --abort" which throws away your rebase
    work _and_ the push.  But what you probably want to do, I described
    earlier.

> It's just a common sense thing.  What denyCurrentBranch protects you from
> is a push from elsewhere *while* you are not there, and then next day,
> getting confused by what such a push did in the receiving repository.  In

See above for why I think this can happen while you are not there. It is
about repo state for long-running workflows. I'm not too concerned with
somebody pushing in the exact half second while you are making running
"git commit".

> Obviously you can tell receive-pack to refuse pushing into a non-bare
> repository, with a "I know what I am doing" configuration, but I think at
> that point the whole "you could break things this way, so let's prevent a
> new user from making such mistake" goes into the realm of absurdity.

I think that is insane, too. This is not all that likely to happen
compared to the possible benefits of pushing into a non-bare repo. And
as you say, in most cases common sense rules: don't push into something
you are actively working on.

I am really just proposing that the "ref was not what we expected"
message to better indicate what is going on, and how the user might get
out of it. Do you not agree with that?

-Peff
