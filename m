From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add a testcase for the safety of pull-policy='pull'.
Date: Tue, 27 Feb 2007 23:38:45 +0000
Message-ID: <b0943d9e0702271538q32e6a9d5y6ac73adfc4854ab6@mail.gmail.com>
References: <20070225220853.31361.7201.stgit@gandelf.nowhere.earth>
	 <b0943d9e0702270625o5a9ef8b4xd0fa5df68e2b805a@mail.gmail.com>
	 <20070227210906.GH4045@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBuI-000420-2Z
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbXB0Xiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbXB0Xiu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:38:50 -0500
Received: from ik-out-1112.google.com ([66.249.90.183]:38605 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbXB0Xit (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:38:49 -0500
Received: by ik-out-1112.google.com with SMTP id c21so742670ika
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 15:38:47 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lPvqeQzMtKrhzpKp+zvYuD4Fz/+g2M49djtI26fP8D9e0PWKfz7+E3wC8KfeFHvuMto7N0cwLuDDEskaFKGH4sb7VaV7WIAuxi2f07jfAxKzbM+ehu2rok4VJuTlY3syaMTHxtldr3HBnkR9UAmBGzhObOfxRaDMoedBUkmW81o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gfxRBnrg+7INiPHiC6nuVjM6KrklYK9oUWGbFBYraB0otHD0bFLM28WU/4Fy8tKyZLp0naROiBOq+loy48vE2tUviTS0NrpQ5vub7NjdnhePoq8+U4R1P6FTIkOcd+nCtXTWNczxsu/2DVHS5VkoLqmn2rIIdFH6gwX3cn+QFqM=
Received: by 10.115.59.1 with SMTP id m1mr612823wak.1172619525615;
        Tue, 27 Feb 2007 15:38:45 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Tue, 27 Feb 2007 15:38:45 -0800 (PST)
In-Reply-To: <20070227210906.GH4045@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40848>

On 27/02/07, Yann Dirson <ydirson@altern.org> wrote:
> On Tue, Feb 27, 2007 at 02:25:57PM +0000, Catalin Marinas wrote:
> > This fails (with git 1.5), as expected, but probably not for the same
> > reason. See below.
>
> That would demonstrate the usefulness of a python-based testsuite as I
> suggested the other day :)

Yes, it would be useful, but probably in addition to the functional
testing we currently do (which might be simplified).

> > BTW, push --undo now requires a status --reset beforehand.
>
> Oh, I had not noticed that.  Why so ?  It's not like if "push --undo"
> would lose any valuable data...

I added it so that one cannot remove the local changes by doing a
"push --undo" in error. You would have to explicitly ask for local
changes removing with status --reset.

> What strikes me most in this case is the difference in behaviour
> between this type of conflict (conflict marked in index, so needs an
> operation outside the current scope of stgit to proceed), with a
> regular stgit conflict that occurs during a push (index clean,
> conflict info not available to tools written for regular GIT).

I think this is a valid GIT conflict as the upstream tree re-wrote the
history and git-pull will trigger a 3-way merge. If you would always
use git-fetch + stgit-rebase, there wouldn't be any problem.

> That reminds me I already wondered why stgit has to deal with conflict
> handling itself.  I've not digged much into the GIT merge mechanism,
> but I'd think it would be great if we were able to use it.

That's probably for historical reasons. A year or so ago, porcelain
tools had to handle the merging themselves (if they needed more than
what git-read-tree -m). The only merge algorithm I could easily
understand was the one in Cogito, so I implemented it in StGIT.

Things has changed since then and now GIT can handle the merging
pretty well. StGIT even uses it transparently via git-merge-recursive
called during the 'push' operation ('sync' still uses git-read-tree
because of the better performance). The gitmergeonefile.py still has
all the conflict cases but most of them are handled by
git-merge-recursive and never get here. If this fail, StGIT tries to
use a configured 3-way merge (diff3 by default) and maybe the
interactive merge if the this fails (BTW, I just added a patch for a
2-way interactive merge as well).

An advantage of using the diff3 over the git's 3-way merge is the
configurable labels attached to the in-file conflict markers but I
don't use this feature much anyway as they get overridden by the
interactive merge tool.

We can drop most of this at some point but it is currently still
needed for the 'sync' command using git-read-tree -m. StGIT also
leaves a clean index (i.e. only one-stage files) and marks the
conflict in .git/conflicts. Maybe post 1.0 we can leave the unmerged
entries in the index and re-work this part.

> What happenned is our "stg pull" could not complete, so we had to
> complete it by hand (instead of attempting to abort it, as my initial
> testcase wanted to do).  This makes it look like an "unsafe base
> change" (since post_rebase was never called to update "orig-base",
> after our manual conflict resolution was done), so any subsequent pull
> or rebase will require a --force.
>
> I don't like that either.  I'm still quite unsure how the "git-pull"
> model of pulling ought to work, that obviously does not help :)
> Any idea ?

I think StGIT behaves correctly since, as I said above, you are
pulling from a tree that has a re-written history. People using GIT
should be able to fix this themselves. For people using StGIT-only, we
should default to the fetch+rebase strategy.

-- 
Catalin
