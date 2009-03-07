From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch and pull
Date: Sat, 07 Mar 2009 12:15:31 -0800
Message-ID: <7vfxhpnl7g.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com>
 <m3iqmmidlf.fsf@localhost.localdomain>
 <7vd4cus7ez.fsf@gitster.siamese.dyndns.org>
 <450196A1AAAE4B42A00A8B27A59278E70A115F5D@EXCHANGE.trad.tradestation.com>
 <3e8340490903070000t2780764cocfbf28d538037df5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Dlugosz <JDlugosz@tradestation.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 21:18:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg2yp-0000oJ-7S
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 21:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981AbZCGUPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 15:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799AbZCGUPo
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 15:15:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZCGUPn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 15:15:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D0D4A0EB7;
	Sat,  7 Mar 2009 15:15:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AE761A0EB6; Sat,
  7 Mar 2009 15:15:34 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA9B08A8-0B54-11DE-8BD8-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112575>

Bryan Donlan <bdonlan@gmail.com> writes:

> If the local "dev" is meant to just track the remote, you really ought
> to avoid doing anything very involved in it (unless you're planning on
> merging something into it and pushing the result, that is!). If
> there's no local changes, then you can just pull with impunity, and
> let it fast-forward - or use git merge or git rebase if you've already
> fetched and don't want to spend the few seconds it takes to ask the
> server if there's anything new :)

With git that is not ancient (i.e. v1.5.0 or newer), there is no reason to
have local "dev" that purely track the remote anymore.  If you only want
to go-look-and-see, you can check out the remote tracking branch directly
on a detached HEAD with "git checkout origin/dev".

Which means that the only cases we need to make it convenient for users
are to handle these local branches that "track" remote ones when you do
have local changes, or when you plan to have some.

If you do have local changes on "dev" that is marked to track the remove
"dev", and if you are on a branch different from "dev", then we should not
do anything after "git feftch" updates the remote tracking "dev".  It
won't fast forward anyway, and we do not need to talk about this case in
this thread.

That leaves only one case.  Your "dev" forked from the remote "dev"
sometime in the past, is marked to "track" the latter, but you haven't
done anything on the branch.  Should we have a convenient way to
fast-forward it after a "git fetch" that updates the remote "dev"?

I'd actually say we should give users a convenient way to remove the local
branches that are marked to track remote tracking branches but do not have
anything interesting on their own (iow when they can fast-forward to their
corresponding remote tracking branches), if the true motive behind this
thread is "'git push' will notice 'dev' that is left behind and gives
clutter".

Yes, you may earlier thought about building on top of the remote branch,
but you haven't done anything other than creating a branch, you left it
without doing anything interesting and kept it behind.

If you later decide to revisit whatever you wanted to work on by forking
from that branch, you can "git checkout -t -b dev origin/dev" at that time
to recreate the branch just as easily as you would do "git checkout dev",
and between the time you notice that you have a stale "dev" that does not
have anything interesting and the time you decide to really work on the
topic again, you may be better off not cluttering "git branch" output with
such useless local branches.

So how about "git branch --prune --remote=<upstream>" that iterates over
local branches, and if

 (1) it is not the current branch; and
 (2) it is marked to track some branch taken from the <upstream>; and
 (3) it does not have any commits on its own;

then remove that branch?  "git remote --prune-local-forks <upstream>" is
also fine; I do not care about which command implements the feature that
much.

The only case I think would be useful to keep a local branch that does not
yet have a commit on its own happens in this workflow:

 (1) You notice a bug sometime in the past (or at the tip) of the "dev"
     branch you see in the remote;

 (2) You bisect, find a faulty commit, and fork your "dev" from that
     commit, so that you can work on fixing that single bug, later to be
     merged back (because you anticipate the fix would be an involved
     series);

 (3) But you haven't had a chance to work on the fix yet.

Your fork point in this workflow has a meaning: this is the broken commit
I fix with my commits immediately after it.  It should not be rebased nor
fast-forwarded.

But in that case, you shouldn't mark "dev" as tracking the remote's "dev"
to begin with, so the hypothetical "branch --prune --remote=<upstream>"
would not touch such a "fork to address old issues", and we'd be safe.
