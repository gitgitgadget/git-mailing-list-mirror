From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC] git-sequencer.txt
Date: Tue, 10 Jun 2008 03:21:59 +0200
Message-ID: <20080610012159.GI8079@leksak.fem-net>
References: <20080607220101.GM31040@leksak.fem-net> <m3d4mqwnxh.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 03:23:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5sZg-0003CM-Ua
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 03:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbYFJBWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 21:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753748AbYFJBWG
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 21:22:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:41697 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753468AbYFJBWF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 21:22:05 -0400
Received: (qmail invoked by alias); 10 Jun 2008 01:22:03 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp054) with SMTP; 10 Jun 2008 03:22:03 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/rY6I1lqjrh8SBxfLl+yFNL6ps2VB/ufCDckyKCU
	GkPV6u2fGPru4s
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K5sYh-0000m8-CB; Tue, 10 Jun 2008 03:21:59 +0200
Content-Disposition: inline
In-Reply-To: <m3d4mqwnxh.fsf@localhost.localdomain>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84469>

> > SYNOPSIS
> > --------
> > [verse]
> > 'git-sequencer' [-v | --verbose] <file> [<branch>]
> 
> I think that you should think carefully if there would be no troubles
> with this way of specifying options.  Perhaps explicit file option
> (-F/--file=<file>), or optional '--' separating revisions.  But
> perhaps my fears are for nothing, and current proposal is good
> solution.

Well, I think we (my mentors and me) had around three different versions
of a synopsis.
ATM I think the synopsis is not a very important thing to discuss, as it is
relatively easy changeable even in the last minute. ;)

But what are your actual fears?  What troubles do you think of?

> > 'git-sequencer' --continue | --skip | --abort | --edit
> 
> The common '--continue | --skip | --abort' infrastructure is, I think,
> one of the most important things about this.  I'd like to have
> '--what' (or '--status') option to tell us if we are in the middle of
> sequence of oprations, and what this sequence is (rebase, rebase -i,
> am, revert, cherry-pick, sequencer <file>,...).

I've read the discussion about git-what and I wrote it down on a yellow
memo sheet *g* (no real TODO list) to have such a thing in git-sequencer.

First I didn't want to have it in the prototype so I didn't add it to
the spec.
But it leads me to an open question I've also noticed on testing:

If you currently start a rebase or am and there's a conflict and
you do
	git sequencer --continue
instead of
	git rebase --continue
or
	git am --resolved
the cleanup code of rebase/am is not executed and thus the job is not
properly finished.

How to prevent this?
My first idea is the one I don't really like: the user tools temporarily
generate some "post-sequencer scripts", that get executed after
finished sequencing. This way, it doesn't matter if you call git
sequencer --continue, git rebase --continue or git am --resolved to 
finish the job.

The second idea is that somehow the user tool should set a "CALLER"
environment variable or tell the caller otherwise (--caller=rebase?)
and git-sequencer only continues if called by the same caller.

The workflow is like this:
 $ git rebase -i
 ...
 Sequencing (3/5)
 Conflict!
 Fix and do git-rebase --continue
 $
 $ # fix
 $
 $ git sequencer --continue
 Use git-rebase --continue.
 $ git-rebase --continue
 ...
 Sequencing finished.
 Succesfully rebased foo bar blub.

The string "git-rebase --continue" (or "git-am --resolved") must also be
-- somehow (environment?) -- transferred to git...
The same for --abort and --skip.

Ideas for a clean solution?

> > TODO FILE FORMAT
> > ----------------
> > edit <commit>::
> > file [<options>] <file>::
> > mark <mark>::
> > merge [<options>] <commit-ish1> <commit-ish2> ... <commit-ishN>::
> 
> > pick [<options>] <commit>::
> > 	Pick (see linkgit:git-cherry-pick[1]) a commit.
> > 	Sequencer will pause on conflicts.
> 
> Two comments (as I don't use "git rebase -i", preferring to work with
> StGIT, Quilt-like patch management interface).

Oh, I've neither experienced stgit nor quilt, but I can imagine that it
is some stack-(or push/pop)-based patch management.

> Thus I'd like to have either "pick -R" or "revert" command.

Ok ;-)

> Second, about "pick" accepring (I guess) git-cherry-pick options: I
> would like to have documentation on '--mainline <parent-number>'
> option in git-sequencer manpage, or at lest explicitely mentioned that
> it can be used to pick merge commits.

Btw it is currently pretty stupid and doesn't accept any git-cherry-pick
options.

And I didn't know that --mainline exists. I've always thought the first
parent in the parent list is the "mainline".
Well, seems to be an easier-to-use alternative to the "merge" insn if you 
want to keep the non-mainline parents, commit message and authorship.
So I think, it's ok to support it ;)

> BTW, is "pick --no-commit"  symmetric equivalent^W alternative to "squash"?

Seems that it's yet another variant to realize squash, but less generic
than the reset --soft ; commit approach.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
