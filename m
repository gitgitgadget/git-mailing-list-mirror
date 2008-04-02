From: Sam Vilain <sam@vilain.net>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Thu, 03 Apr 2008 09:06:36 +1300
Message-ID: <47F3E74C.5010804@vilain.net>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>	 <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no>	 <47EFD253.6020105@vilain.net>	 <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no>	 <32541b130803301603u65d1b6b6ladac0f6200433e5f@mail.gmail.com>	 <834174D1-82F4-4438-9854-762F416BB5EF@orakel.ntnu.no>	 <32541b130803311436t7b5041a4pabface15aad8ce63@mail.gmail.com>	 <47F2BFCD.5070202@vilain.net>	 <32541b130804011656l2e907895i98e5260b49743bbe@mail.gmail.com>	 <7vd4p9ccw8.fsf@gitster.siamese.dyndns.org> <32541b130804011903u3b5d0794w984e26c4570c4688@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 22:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh9F4-0004LA-Mx
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 22:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253AbYDBUGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 16:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756181AbYDBUGq
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 16:06:46 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:46643 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755365AbYDBUGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 16:06:44 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 39ECAFCCD9; Thu,  3 Apr 2008 09:06:43 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [192.168.69.179] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id C8A69C7E39;
	Thu,  3 Apr 2008 09:06:37 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <32541b130804011903u3b5d0794w984e26c4570c4688@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78711>

Avery Pennarun wrote:
>>  > Instead of storing only the commitid of each submodule in the parent
>>  > tree, store the current branch name as well.
>> That goes quite against the fundamental design of git submodules in that
>>  the submodules are by themselves independent entities.
>>     
> Not sure what you mean here; the supermodule already stores the
> commitid of the submodule.  All I'm proposing is that it also store
> the default branchname (ie. the branchname that the submodule was
> using when its gitlink was checked into the supermodule) along with
> that commitid.  The submodule never knows anything about the
> supermodule.
>   

How about this.

This could be an optional disambiguator in .gitmodules in the 
superproject, to allow you to "store the branch it was made from".  Glue 
to make this automatic/easy optional.

When updating a submodule, with an option set (or configured; which 
might even later become a default if people like it enough), it will try 
to figure out a reasonable branch for that commit, using git-name-rev, 
and check out the branch with that name.  It first uses the hint above 
as an argument to git-name-rev --refs=XX, and if that doesn't provide a 
reasonable answer then look for any branch.

I think this approach would not get in the way of people who don't want 
to use it, and provide for making things automatic for those who want that.

> I agree that the submodule should have its HEAD pointing at exactly
> the superproject-specified commit.  However, I believe this commit
> should have a local branch name (in the subproject) attached to it, or
> else (as I and my co-workers have frequently experienced) people will
> accidentally check in to a nameless branch, causing 'git push' to
> silently not upload anything, and thus lose track of their commits.  I
> have lost work this way.
>   

I think this is a separate argument against git-push, the default 
behaviour of which also causes me to tell people not to use the 
argument-less form of git-push until they understand how to use the 
two-argument form.

In the context of git-submodule, adding features to it to avoid this if 
that is the way that the user wants to work would be good IMHO.

> The idea of naming the local-subproject-branch with the same name as
> it had on checking is that then "git pull" in the subproject will work
> exactly as expected:

It's not really the local branch name anyway, it's how the default push 
gets configured; perhaps it's worth distinguishing which part you are 
interested in.

> The super-summary of all that is I think I'd like to make three git
> changes here:
>
> 1) When checking out a submodule from scratch, use the local
> supermodule as a --alternate.  That way if both super and submodule
> are hosted in the same remote repo, I don't have to clone them twice.
> (And cloning my local repo to another copy doesn't stop git-submodule
> from working.)
>   

Yes - you've already seen the SoC plan for that, although I believe no 
students applied for that one, and if you think it's minor enough to do, 
great.

> 2) When checking out a submodule, give the submodule's current commit
> a useful branch name (ideally, the name it had when the gitlink was
> checked into the supermodule).  When updating a submodule with
> git-submodule-update, quietly fixup the submodule's local branch ref
> if it hasn't been changed; else produce a conflict of some sort.
>   

See above for how I think that should work.

> 3) Bonus: make "git push" operate recursively on submodules, and "git
> pull" automatically run git-submodule-update.
>   

I'd appreciate that feature - though I'm more interested in making sure 
that I don't push anything where the submodule commit is not available 
via the URL listed in .gitmodules.

Presuming such a check, would that check happen at push time, or do you 
check at a different time, such as when committing, or when adding the 
submodule to the index?

I think checking that referential integrity is something perhaps easier 
to bite off and get people to agree on.  I think it would solve the 
overall process problem, by forcing people to push the submodule before 
the commit of the superproject can succeed without forcing.

Thoughts/comments?
Sam
