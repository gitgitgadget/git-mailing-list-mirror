From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git workflow: how to achieve?
Date: Fri, 24 Apr 2009 09:35:01 +0200
Message-ID: <49F16BA5.9060003@op5.se>
References: <20090424045843.7674.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 09:37:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxFyI-0002ng-P9
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 09:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbZDXHfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 03:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbZDXHfH
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 03:35:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:48442 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbZDXHfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 03:35:05 -0400
Received: by fg-out-1718.google.com with SMTP id 16so128801fgg.17
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 00:35:02 -0700 (PDT)
Received: by 10.86.51.10 with SMTP id y10mr711748fgy.51.1240558502630;
        Fri, 24 Apr 2009 00:35:02 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d4sm948583fga.14.2009.04.24.00.35.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 00:35:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090424045843.7674.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117418>

George Spelvin wrote:
> Here's something I and my co-workers would like to achieve, but are not
> too sure how to arrange.
> 
> I want to be committing to a feature branch, but always be compiling
> and testing a merge of that branch and several others.

At $dayjob we do a "build-on-push" thing, so every time a developer
feels his work is worthy of trying out for others, he ships it to the
mother-ship repository, where the update hook (should be post-receive,
but we haven't bothered changing it since it Just Works as is) kicks
the buildbot, triggering builds on all architectures and platforms
we support.

Assuming a static set of branches to merge, or a prefix or suffix
that marks the branches to merge, it wouldn't be difficult to let it
trigger "merge this and that" stuff as well.


>  I want to be able to switch feature branches easily.
> 

Well, git makes that absolutely trivial. No other vcs has as cheap
branching as git does.

> For example, I may have a background project that I'm working on slowly in
> between short-term fixes.  Or I want to be running the latest kernel.org
> kernel while my patches await approval.
> 
> If it's just my own projects, I can just commit in random order and
> straighten things out later.  Although even that is problematic,
> as I may not remember what line of development a cleanup patch is a
> prerequisite for.  (This is something that darcs is apparently good at.)
> 

Sounds like you'd benefit somewhat from using TopGit or some other
patch-queue management tool. I haven't used them myself, but I believe
this is the kind of problem they set out to solve.

> But when I want to be testing something highly volatile like linux-next,
> and ensuring that my work continues to merge with it cleanly, as well
> as helping others with their branches, it becomes a daily pain.
> 

Why? Just merge it to make sure it merges, and then throw away the result.
There's a post made by Linus somewhere on how he would like people to do
merges (ie, which to keep and which to throw away).

> The best attempt I have so far is to rebase a lot.  But that means that
> I can't do any merging in my development branch lest the rebasing turn
> into a mess.

Merging other branches into your development branch and keeping the result
is often a bad idea, since you can't later merge the development branch
without also merging everything that *you* merged. This makes it nearly
impossible to pick your feature into random spots in the DAG. If you ever
work anywhere but on the bleeding edge, you'll find merging the "main dev
branch" is a *really* bad idea.

>  And forcing everything to be linear makes changing branches
> a pain.

Everything needn't be linear, but if you can manage to keep each topic
linear that makes your series a lot easier to review.

>  And I can't share half-finished versions with co-workers.
> 

So finish it before you push. Anyone fetching from your local repository
should be aware that not all branches point to something sensible. If
they don't, they'll be sure to ask you so you can bring out the LART.

> This is all vaguely quilt-like, although I'd rather not worry about the
> order of patches.  I suppose I'd like git to let me "commit under" the
> final merge.  When I switch branches, git should reorganize the tree of
> merges so that the current branch is only one merge from the HEAD.
> 

Umm... Use a separate branch to do the merge, and enable rerere caching
so your recorded resolutions get reused when you do the merge "for real".

> (Another thing I've wished for that might be related is for a branch
> to have a notion of its origin.  So I can rebase it onto an arbitrary
> place in the commit tree without having to explicitly specify an origin.)
> 

This is a bad idea.

> ((Another really simple feature I keep wanting is "git commit -b
> <newbranch>".  I should probably try to write a patch...))
> 

This is a good idea (assuming you mean "commit this state to that branch",
and it should be fairly trivial to implement using something like this:

    git stash && git checkout -b newbranch && git stash pop && git commit

> 
> Anyway, my feature ideas might be unworkable, and in any case, they'll
> take a long time to implement.  Is there some easier way to achieve more
> or less this effect?
> 

I'm not sure what effect you're after. If you can write down, with very
*little* detail, what it is you want to achieve, it will be a lot easier
to help you than if you ask about small steps in a pre-thought-out solution
that may not even be right from the beginning.

> Maybe the planned git-rebase improvements to handle merges better will
> fix this, so I can just commit on top and periodically rebase the changes
> under the head manually without too much pain?  (git rebase -i -p does
> appear to be working better than I remember.)
> 

What planned rebase improvements are you talking about?

> H'm... in fact, it might be as easy as replacing "git pull" with
> git rebase -p -i <last merge>^
> (Delete the merge in the editor)
> git pull <remote>
> 
> Annoying to remember, but not TOO bad.

Use an alias, or a wrapper script.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
