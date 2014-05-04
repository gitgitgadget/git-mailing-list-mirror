From: Richard Hansen <rhansen@bbn.com>
Subject: Re: Pull is Mostly Evil
Date: Sun, 04 May 2014 03:49:32 -0400
Message-ID: <5365F10C.6020604@bbn.com>
References: <5363BB9F.40102@xiplink.com> <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com> <5364A143.1060404@bbn.com> <5364b62d5fb7b_ac68dd30816@nysa.notmuch> <5365691C.1010208@bbn.com> <5365af33825c3_520db2b308bf@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sun May 04 09:49:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgrB6-00055s-Q9
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 09:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbaEDHth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 03:49:37 -0400
Received: from smtp.bbn.com ([128.33.0.80]:64867 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbaEDHtg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 03:49:36 -0400
Received: from socket.bbn.com ([192.1.120.102]:41413)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WgrB0-0009NI-51; Sun, 04 May 2014 03:49:34 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 9736F401DC
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5365af33825c3_520db2b308bf@nysa.notmuch>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248082>

On 2014-05-03 23:08, Felipe Contreras wrote:
> Richard Hansen wrote:
>> Or are you proposing that pull --merge should reverse the parents if and
>> only if the remote ref is @{u}?
> 
> Only if no remote or branch are specified `git pull --merge`.

OK.  Let me summarize to make sure I understand your full proposal:

  1. if plain 'git pull', default to --ff-only
  2. if 'git pull --merge', default to --ff.  If the local branch can't
     be fast-forwarded to the upstream branch, then create a merge
     commit where the local branch is the *second* parent, not the first
  3. if 'git pull $remote [$refspec]', default to --merge --ff.  If the
     local branch can't be fast-forwarded to the remote branch, then
     create a merge commit where the remote branch is the second parent
     (the current behavior)

Is that accurate?

>> If we change 'git pull' to default to --ff-only but let 'git pull
>> $remote [$refspec]' continue to default to --ff then we have two
>> different behaviors depending on how 'git pull' is invoked.  I'm worried
>> that this would trip up users.  I'm not convinced that having two
>> different behaviors would be bad, but I'm not convinced that it would be
>> good either.
> 
> It is the only solution that has been proposed.

It's not the only proposal -- I proposed a few alternatives in my
earlier email (though not in the form of code), and others have too.  In
particular:

  * create a new 'git integrate' command/alias that behaves like 'git
    pull --no-ff'
  * change 'git pull' and 'git pull $remote [$refspec]' to do --ff-only
    by default

Another option that I just thought of:  Instead of your proposed
pull.mode and branch.<name>.pullmode, add the following two sets of configs:

  * pull.updateMode, branch.<name>.pullUpdateMode:

    The default mode to use when running 'git pull' without naming a
    remote repository or when the named remote branch is @{u}.  Valid
    options: ff-only (default), merge-ff, merge-ff-there, merge-no-ff,
    merge-no-ff-there, rebase, rebase-here, rebase-here-then-merge-no-ff

  * pull.integrateMode, branch.<name>.pullIntegrateMode:

    The default mode to use when running 'git pull $remote [$refspec]'
    when '$remote [$refspec]' is not @{u}.  Valid options are the same
    as those for pull.updateMode.  Default is merge-ff.

This gives the default split behavior as you propose, but the user can
reconfigure to suit personal preference (and we can easily change the
default for one or the other if there's too much outcry).

> 
> Moreover, while it's a bit worrisome, it wouldn't create any actual
> problems. Since `git pull $what` remains the same, there's no problems
> there. The only change would be on `git pull`.
> 
> Since most users are not going to do `git pull $what` therefore it would
> only be a small subset of users that would notice the discrepancy
> between running with $what, or not. And the only discrepancy they could
> notice is that when they run `git pull $what` they expect it to be
> --ff-only, or when the run `git pull` they don't. Only the former could
> be an issue, but even then, it's highly unlikely that `git pull $what`
> would ever be a fast-forward.
> 
> So althought conceptually it doesn't look clean, in reality there
> wouldn't be any problems.

Yes, it might not be a problem, but I'm still nervous.  I'd need more
input (e.g., user survey, broad mailing list consensus, long beta test
period, decree by a benevolent dictator) before I'd be comfortable with it.

> 
>>>>  3. integrate a more-or-less complete feature/fix back into the line
>>>>     of development it forked off of
>>>>
>>>>     In this case the local branch is a primary line of development and
>>>>     the remote branch contains the derivative work.  Think Linus
>>>>     pulling in contributions.  Different situations will call for
>>>>     different ways to handle this case, but most will probably want
>>>>     some or all of:
>>>>
>>>>      * rebase the remote commits onto local HEAD
>>>
>>> No. Most people will merge the remote branch as it is. There's no reason
>>> to rebase, specially if you are creating a merge commit.
>>
>> I disagree.  I prefer to rebase a topic branch before merging (no-ff) to
>> the main line of development for a couple of reasons:
> 
> Well that is *your* preference. Most people would prefer to preserve the
> history.

Probably.  My point is that the behavior should be configurable, and I'd
like that particular behavior to be one of the options (but not the
default -- that wouldn't be appropriate).

> 
>>   * It makes commits easier to review.
> 
> The review in the vast majority of cases happens *before* the
> integration.

True, although even when review happens before integration there is
value in making code archeology easier.

> 
> And the problem comes when the integrator makes a mistake, which they
> inevitable do (we all do), then there's no history about how the
> conflict was resolved, and what whas the original patch.

Good point, although if I was the integrator and there was a
particularly hairy conflict I'd still rebase but ask the original
contributor to review the results before merging (or ask the contributor
to rebase).

-Richard
