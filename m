From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: unmerging feature branches
Date: Tue, 23 Oct 2007 09:50:59 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 18:51:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkMyh-00036T-H0
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 18:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbXJWQv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 12:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbXJWQv0
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 12:51:26 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39252 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751993AbXJWQv0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 12:51:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NGp0qM026141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2007 09:51:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NGox7S028974;
	Tue, 23 Oct 2007 09:51:00 -0700
In-Reply-To: <20071023152445.GA10070@piper.oerlikon.madduck.net>
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62136>



On Tue, 23 Oct 2007, martin f krafft wrote:
> 
> Are there any other methods? Is it conceivable to let git-revert
> revert a merging commit if you tell it somehow which of the two (or
> more) parents are the ones you want undone, meaning that you'd like
> to keep the others?

So let me get this straight.. You have a merge "M" that is the result of 
merging (possibly multiple) topic branches, and you now want to undo the 
part that *one* of them brought in?

First off, let me say that to some degree, what you ask for is not 
possible. Why?

Since you have pushed out the stuff, and don't want to rewrite history 
(which would result in trouble for down-streams - and I heartily approve), 
whatever you do will always have that merge in the commit history.

And that means that while you can certainly undo the *data* that the merge 
brought in, git will always know that you already merged up that branch. 
Which means that if you later decide that you *do* want to do the merge 
after all, you now really cannot - trying to merge the branch later on 
will just be a fast-forward, and you'll never get the actual changes from 
that merge (since git knows you already have them!).

So you can revert the data, but then if you want to get it back, you'll 
need to revert the revert - you cannot just merge the branch again. 

So the first thing you need to realize is that "revert" does not revert 
history, it *only* reverts data. The fact that you did the merge will 
always remain, although you could try to hack around even that by using 
the 'grafts' file and trying to hide it (I really don't think it's a good 
idea, but sure, everything is "possible" in that sense).

Now, that said, reverting the data is not that hard. There is not any 
single-command "revert this arm of a merge", but on the other hand, git 
can certainly help you.

The way to do it is:

	# go back to just before the merge, create a "fixup" branch
	#
	git branch -b fixup M^

	# merge all of it again, *except* the branch you didn't want to 
	# merge (this example assumes that you had a four-way octopus 
	# merge, and you now want to turn it into a three-way with the
	# next-to-last parent skipped):
	#
	git merge -m "fixed merge" M^2 M^4

	# You now have "fixup" containing what you *wanted* it to be
	# after the original merge. Create a temporary branch that is 
	# based on the merge and contains that state instead, and
	# apply the difference. 
	#
	git branch -b temporary M
	git diff ..fixup | git-apply
	git commit -m "fixup commit"

	# You now have the "temporary" branch that contains just the
	# diff that effectively undoes that one merge. Go back to the
	# tip of your development, and cherry-pick it to get git to
	# help you do a good job merging it with all the subsequent
	# development
	# 
	git checkout master	# or whatever branch you used
	git cherry-pick temporary
	.. do whatever you need to do to resolve it
	.. if it didn't go cleanly 

	# Now, edit the commit message to talk about what you did
	#
	git commit --amend

or something to that effect.

Complicated? Yes. The above is strictly speaking more complex than you may 
need, but if you do it like the above, you get maximum help from git (ie 
you *could* have tried to just apply the patch with "git-apply" directly 
on the top of master, but if you do it like the above, then it's 
guaranteed that the patch that undoes the commit will apply cleanly, and 
you then use "git cherry-pick" which uses the merge logic that can do a 
proper three-way merge with renames etc, so if there are conflicts or 
other things, the above will likely be the best way to do it)

So for simple cases, you can do the above more simply, but the above is 
fairly brainless and scriptable except for the *one* place where you 
actually move the changes forward (the single cherry-pick).

There are certainly other ways too. You could just "git revert -n" all the 
commits that came in through the branch you didn't want to merge. That 
doesn't work well if there were merges in that area, though, or of there 
were changes that were common to all the branches (some of which also came 
in through *other* merges).

So the above (UNTESTED! Caveat emptor!) sequence is *one* way of doing it, 
and probably in the end the one that most closely represents what you want 
to do.

			Linus
