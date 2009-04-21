From: Jeff King <peff@peff.net>
Subject: Re: How to merge from newer branch to older branches?
Date: Tue, 21 Apr 2009 15:36:15 -0400
Message-ID: <20090421193615.GB7832@coredump.intra.peff.net>
References: <2729632a0904211224x6e2621caxf6c169d90b760530@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 21 21:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwLn2-00066l-2F
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 21:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZDUTgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 15:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbZDUTgT
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 15:36:19 -0400
Received: from peff.net ([208.65.91.99]:43927 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbZDUTgS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 15:36:18 -0400
Received: (qmail 11142 invoked by uid 107); 21 Apr 2009 19:36:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 21 Apr 2009 15:36:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2009 15:36:15 -0400
Content-Disposition: inline
In-Reply-To: <2729632a0904211224x6e2621caxf6c169d90b760530@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117153>

On Tue, Apr 21, 2009 at 12:24:26PM -0700, skillzero@gmail.com wrote:

> We have a "future" branch for new development. I wanted to add a new
> feature so I branched from "future" to create a branch named
> "feature". I completed the work, but now they've decided they need
> that on two older branches. It looks like this:
> [...]
> I've read I should have started from the oldest common denominator
> branch that I might ever want, but at the time I created the branch,

Right. Junio branches all topics in git from "master", but then merges
promising ones into "next". When the topic is ready for master, he can
then just merge the topic branch, pulling in that topic but not the rest
of next.

> "future" was it because we thought 1.1 and 1.2 were locked down and
> not going to add new features. But things change and I need to roll my
> feature into 1.1 and 1.2.

Yep. Advanced planning is not always possible. :)

> What's the best way to merge changes on the "feature" branch into the
> 1.1 and 1.2 branches? If I try to checkout 1.1 then 'git merge

If it is just one or two commits, you probably just want to "git
cherry-pick" them onto your older branches.

If it is a larger series, or one which might see more development, you
might want to use "git rebase" to rewrite the branch as if it were based
on 1.1, and then merge that into 1.1, 1.2, and feature.

> feature', it (obviously) merges in a bunch of changes from "future"
> that I don't want (and has a bunch of conflicts). I also tried just
> cherry-picking commits a, b, and c from the "feature" branch. That
> mostly worked, but there were some surprising conflicts. Text that had
> been inserted into a couple files (which had been untouched in 1.1 and
> 1.2) caused a conflict when it seemed like it should have just added
> the lines without conflict. I realize it's difficult to know why it
> conflicted without seeing the changes, but I'm just asking in a more
> general way how I should be doing merges like this.

Yes, without seeing the conflicts it's hard to say. But presumably the
added lines provide context, so git was having a hard time trying to
figure out where in the old file your changes would go (you can think of
cherry-pick as the moral equivalent of "git show $COMMIT | git apply";
so you are basically applying a patch on top of something that it is
not quite the same).

If you are having trouble resolving conflicts, you might try using "git
mergetool" to fire up an external resolver that may provide a richer
interface (I use xxdiff with mergetool, myself).

> Is cherry-picking the best way? It seems pretty tedious because I have
> to do each commit in reverse order (although I could script it). I was
> hoping there was a way to say "apply all the changes from when
> "feature" branched up to its tip". I would also like to preserve the
> commit history rather than just making making one big commit of all
> the changes.

In its simplest form, rebase is basically cherry-picking a series of
commits. So that would make things a bit less tedious for you, but you
will probably still end up with the same set of conflicts.

-Peff
