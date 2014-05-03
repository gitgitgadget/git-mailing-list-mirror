From: Richard Hansen <rhansen@bbn.com>
Subject: Re: Pull is Mostly Evil
Date: Sat, 03 May 2014 18:09:32 -0400
Message-ID: <5365691C.1010208@bbn.com>
References: <5363BB9F.40102@xiplink.com> <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com> <5364A143.1060404@bbn.com> <5364b62d5fb7b_ac68dd30816@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sun May 04 00:09:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgi7t-0006T5-0M
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 00:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbaECWJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 18:09:37 -0400
Received: from smtp.bbn.com ([128.33.1.81]:56828 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbaECWJg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 18:09:36 -0400
Received: from socket.bbn.com ([192.1.120.102]:42976)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Wgi7s-000FEw-2k; Sat, 03 May 2014 18:09:44 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 72D853FF32
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <5364b62d5fb7b_ac68dd30816@nysa.notmuch>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248059>

On 2014-05-03 05:26, Felipe Contreras wrote:
> Richard Hansen wrote:
> 
>> I think the fundamental difference is in the relationship between the
>> local and the remote branch (which branch derives from the other).
>> The relationship between the branches determines what the user wants
>> from 'git pull'.
>>
>> In my experience 'git pull' is mostly (only?) used for the following
>> three tasks:
> 
> I agree.
> 
>>  1. update a local branch to incorporate the latest upstream changes
>>
>>     In this case, the local branch (master) is a derivative of the
>>     upstream branch (origin/master).  The user wants all of the
>>     commits in the remote branch to be in the local branch.  And the
>>     user would like the local changes, if any, to descend from the tip
>>     of the remote branch.
> 
> My current propsal of making `git pull` by default do --ff-only would
> solve this.

It would go a long way toward improving the situation, yes.

> In addition I think by default 'master' should be merged to
> 'origin/master', if say --merge is given.

This would break cases #2 and #3.  (With cases #2 and #3 you want the
fetched branch to be the second parent, not the first.)

Or are you proposing that pull --merge should reverse the parents if and
only if the remote ref is @{u}?

> 
>>     For this case, 'git pull --ff-only' followed by 'git rebase -p'
>>     works well, as does 'git pull --rebase=preserve' if the user is
>>     comfortable rebasing without reviewing the incoming commits first.
> 
> I suppose you mean a `git rebase -p` if the `git pull --ff-only` failed.

Yes.

> This might be OK on most projects, but not all.

The rebase only affects the local repository (the commits haven't been
pushed yet or else they'd be in @{u} already), so I'd say it's more of
an individual developer decision than a project decision.

In my opinion rebase would be the best option here, but if the project
is OK with developers pushing merge or merge-there commits and the
developer isn't yet comfortable with rebasing, then merge is also an
acceptable option.

> 
> What happens after a `git pull --ff-only` fails should be totally
> up to the user.

I tend to agree, mostly because I want users to have an opportunity to
review incoming commits before action is taken.  Also, though rebasing
would yield the nicest history, some users aren't yet comfortable with
rebase.  If a project is OK with silly little merge commits from users
that aren't comfortable with rebase, then I don't want to force everyone
to rebase by default.

As an added bonus:  Defaulting to --ff-only makes it possible for 'git
pull --all' to fast-forward every local branch to their configured
upstream, not just the currently checked-out branch.  I think this would
be a huge usability win.

> 
>>  2. update a published feature branch with the latest changes from its
>>     parent branch
>>
>>     In this case, the local branch (foo) is a derivative of the
>>     upstream branch (origin/foo) which is itself a derivative of
>>     another branch (origin/master).  All commits in origin/master
>>     should be in origin/foo, and ideally all commits unique to
>>     origin/foo would descend from the tip of origin/master.
> 
> I don't understand why are you tainting the example with 'origin/foo',

Originally I didn't have this case in my list, but I added it after
thinking about Peff's comment:

  On 2014-05-02 17:48, Jeff King wrote:
  > One common workflow for GitHub users is to back-merge master into a
  > topic, because they want the final "integrated" version on the topic
  > branch.

This almost but doesn't quite fit neatly into the other two cases.  It's
not case #1 because the shared nature of origin/foo means that rebasing
origin/foo onto origin/master is usually bad instead of usually good.
It's not case #3 because rebasing origin/master commits onto origin/foo
(assuming that the user would usually want to rebase the topic branch
when integrating) would definitely be bad.

> 'foo' and 'origin/master' are enough for this example. In fact, the
> mention of 'origin/master' made it wrong: after the pull not all the
> commits of origin/master would be in origin/foo, you need a push for
> that.

The push of foo to origin/foo was meant to be implied.

> We have enough in our plate to taint this with yet another branch
> and push.
> 
> For this case `git pull origin master` already work correctly for most
> projects.

Yes, it does.

> We probably shouldn't change that.

If we change 'git pull' to default to --ff-only but let 'git pull
$remote [$refspec]' continue to default to --ff then we have two
different behaviors depending on how 'git pull' is invoked.  I'm worried
that this would trip up users.  I'm not convinced that having two
different behaviors would be bad, but I'm not convinced that it would be
good either.

> 
>>  3. integrate a more-or-less complete feature/fix back into the line
>>     of development it forked off of
>>
>>     In this case the local branch is a primary line of development and
>>     the remote branch contains the derivative work.  Think Linus
>>     pulling in contributions.  Different situations will call for
>>     different ways to handle this case, but most will probably want
>>     some or all of:
>>
>>      * rebase the remote commits onto local HEAD
> 
> No. Most people will merge the remote branch as it is. There's no reason
> to rebase, specially if you are creating a merge commit.

I disagree.  I prefer to rebase a topic branch before merging (no-ff) to
the main line of development for a couple of reasons:

  * It makes commits easier to review.  For example, assume the
    following commit history:

       * merge topic-foo
       |\
       | * merge master into topic-foo
       |/|
       * | tweak the behavior of Thing
       | |
       | * refactor Thing
       | |
       | * wrap long lines; no behavior changes
       |/
       * blah
       |
       ...

    In this case, the impact the "refactor Thing" and "wrap long lines"
    commits have on master can't be fully understood without also
    examining the presumed merge conflict resolution in the "merge
    master into topic-foo" commit.  Merge commits are very hard to
    review, even if (especially if?) there are no conflicts.
    Developers can diff 'merge topic-foo' to its first parent, but then
    they'll see lots of noise caused by the "wrap long lines" commit.

    If the integrator rebases first, then the history looks like this:

       * merge topic-foo
       |\
       | * refactor Thing
       | |
       | * wrap long lines; no behavior changes
       |/
       * tweak the behavior of Thing
       |
       * blah
       |
       ...

    Now the merge conflict resolution is integrated into the "refactor
    Thing" and "wrap long lines" commits, making them easier to review.

  * Rebasing makes the commit history pretty and easier to understand.
    Instead of this:

       * merge feature.xyz
       |\
       | * xyz part 3/3
       | |
       | * merge master into feature.xyz
       |/|
       * | merge feature.foo
       |\ \
       | | * xyz part 2/3
       | * | foo part 2/2
       | * | foo part 1/2
       | | * xyz part 1/3
       |/ /
       | /
       |/
       * merge feature.bar
       |\

    you get this:

       * merge feature.xyz
       |\
       | * xyz part 3/3
       | * xyz part 2/3
       | * xyz part 1/3
       |/
       * merge feature.foo
       |\
       | * foo part 2/2
       | * foo part 1/2
       |/
       * merge feature.bar
       |\

    When there are regularly dozens of active branches at a time, this
    improved readability can be quite valuable.

> 
>>      * merge into local HEAD so that the first parent (if a real merge
>>        and not a ff) is the previous version of the main line of
>>        development and the second parent is the derivative work
>>      * merge --no-ff so that:
>>         - the merge can serve as a cover letter (who reviewed it,
>>           which bug reports were fixed, where the changes came from,
>>           etc.)
>>         - the commits that compose the new topic are grouped together
>>         - the first-parent path represents a series of completed tasks
> 
> It is very rare that an integrator is even able to do a fast-forward
> merge anyway.

It depends on the level of project activity.  A project as active as the
Linux kernel or Git will almost never have fast-forwards.  But
occasional contributions by random users to a small, simple project will
likely be fast-forwards.

> So being explicit about --no-ff might better, but it would
> hardly make a difference. Either way, a good integrator would configure
> pull.ff = false.

Configuring pull.ff = false is OK if the integrator only integrates and
only uses one machine.  But if the integrator also wants to develop in
the same repository, or if the integrator uses multiple machines to do
the integration work (e.g., office desktop and laptop), then setting
pull.ff may be less convenient, not more.

Maybe it's OK to require integrators to get in the habit of typing 'git
pull --no-ff'.  Presumably integrators are experienced Git users, so
they can create their own 'git integrate' alias if they don't want to
have to remember to type '--no-ff' all the time.

> 
> I'd say `git pull origin master` already works fine for this case.

It does, but again preserving the current behavior would cause the
behavior of 'git pull origin master' to be inconsistent with the
proposed ff-only default for a plain 'git pull'.

-Richard
