From: Richard Hansen <rhansen@bbn.com>
Subject: Re: Pull is Mostly Evil
Date: Sun, 04 May 2014 15:09:05 -0400
Message-ID: <53669051.6090204@bbn.com>
References: <5363BB9F.40102@xiplink.com> <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com> <5364A143.1060404@bbn.com> <5364b62d5fb7b_ac68dd30816@nysa.notmuch> <5365691C.1010208@bbn.com> <5365af33825c3_520db2b308bf@nysa.notmuch> <5365F10C.6020604@bbn.com> <536613bd14e24_1c89b0930cac@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sun May 04 21:09:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh1ml-0001LL-9v
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 21:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbaEDTJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 15:09:11 -0400
Received: from smtp.bbn.com ([128.33.1.81]:62158 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbaEDTJK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 15:09:10 -0400
Received: from socket.bbn.com ([192.1.120.102]:43062)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Wh1mm-000Hs4-DF; Sun, 04 May 2014 15:09:16 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id B848F401DC
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <536613bd14e24_1c89b0930cac@nysa.notmuch>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248108>

On 2014-05-04 06:17, Felipe Contreras wrote:
> Richard Hansen wrote:
>> On 2014-05-03 23:08, Felipe Contreras wrote:
>>> It is the only solution that has been proposed.
>>
>> It's not the only proposal -- I proposed a few alternatives in my
>> earlier email (though not in the form of code), and others have too.  In
>> particular:
>>
>>   * create a new 'git integrate' command/alias that behaves like 'git
>>     pull --no-ff'
> 
> Yeah but that's for a different issue altogheter. I doesn't solve the
> problems in 1. nor 2. nor 3.

'git integrate' would handle usage cases #2 (update a published branch
to its "parent" branch) and #3 (integrate a completed task into the main
line of development), making it feasible to change 'git pull' and 'git
pull $remote [$refspec]' to default to --ff-only to handle usage case #1
(update local branch to @{u}).

> 
>>   * change 'git pull' and 'git pull $remote [$refspec]' to do --ff-only
>>     by default
>>
>> Another option that I just thought of:  Instead of your proposed
>> pull.mode and branch.<name>.pullmode, add the following two sets of configs:
>>
>>   * pull.updateMode, branch.<name>.pullUpdateMode:
>>
>>     The default mode to use when running 'git pull' without naming a
>>     remote repository or when the named remote branch is @{u}.  Valid
>>     options: ff-only (default), merge-ff, merge-ff-there, merge-no-ff,
>>     merge-no-ff-there, rebase, rebase-here, rebase-here-then-merge-no-ff
> 
> Those are way too many options to be able to sensibly explain them.

Certainly this is too many options for a first patch series, but I don't
think they're unexplainable.  (I listed a bunch of options because I was
trying to envision where this might take us in the long run.)

For the first patch series, I'd expect:  merge (which uses the merge.ff
option to determine whether to ff, ff-only, or no-ff), rebase, and ff-only.

Later ff-only would be made the default.

Later some or all of the other options would be added depending on user
interest.

> 
>>   * pull.integrateMode, branch.<name>.pullIntegrateMode:
>>
>>     The default mode to use when running 'git pull $remote [$refspec]'
>>     when '$remote [$refspec]' is not @{u}.  Valid options are the same
>>     as those for pull.updateMode.  Default is merge-ff.
>>
>> This gives the default split behavior as you propose, but the user can
>> reconfigure to suit personal preference (and we can easily change the
>> default for one or the other if there's too much outcry).
> 
> If we reduce the number of options to begin with (more can be added
> later),

yup

> then it might make sense to have these two options.
> 
> However, that doesn't change the proposal you described above (1. 2.
> 3.).

Not sure what you mean.  I oulined three usage cases:
  #1 update local branch to @{u}
  #2 update a published branch to its "parent" branch
  #3 integrate a completed task into the main line of development

Having these two sets of options (updateMode and integrateMode) would
make it possible to configure plain 'git pull' to handle usage case #1
and 'git pull $remote [$refspec]' to handle usage cases #2 and #3.

Or the user could configure 'git pull' and 'git pull $remote [$refspec]'
to behave the same, in case they find the different behaviors to be too
confusing.

> There's something we can do, and let me clarify my proposal. What you
> described above is what I think should happen eventually, however, we
> can start by doing something like what my patch series is doing; issue a
> warning that the merge is not fast-forward and things might change in
> the future.

OK, let me rephrase to make sure I understand:

  1. leave the default behavior as-is for now (merge with local
     branch the first parent)
  2. add --merge argument
  3. add ff-only setting
  4. plan to eventually change the plain 'git pull' default to ff-only,
     but don't change the default yet
  5. add a warning if the plain 'git pull' is a non-ff
  6. wait and see how users react.  If they're OK with it, switch the
     default of the plain 'git pull' to ff-only.

Is that accurate?  If so, sounds OK to me.

> 
> If people find this behavior confusing they will complain in the mailing
> list.

true

> Although I suspect it would be for other reasons, not the 'git
> pull'/'git pull $there' division.

probably

> Either way we would see in the discussion.

sounds good to me

> 
>>>>>>  3. integrate a more-or-less complete feature/fix back into the line
>>>>>>     of development it forked off of
>>>>>>
>>>>>>     In this case the local branch is a primary line of development and
>>>>>>     the remote branch contains the derivative work.  Think Linus
>>>>>>     pulling in contributions.  Different situations will call for
>>>>>>     different ways to handle this case, but most will probably want
>>>>>>     some or all of:
>>>>>>
>>>>>>      * rebase the remote commits onto local HEAD
>>>>>
>>>>> No. Most people will merge the remote branch as it is. There's no reason
>>>>> to rebase, specially if you are creating a merge commit.
>>>>
>>>> I disagree.  I prefer to rebase a topic branch before merging (no-ff) to
>>>> the main line of development for a couple of reasons:
>>>
>>> Well that is *your* preference. Most people would prefer to preserve the
>>> history.
>>
>> Probably.  My point is that the behavior should be configurable, and I'd
>> like that particular behavior to be one of the options (but not the
>> default -- that wouldn't be appropriate).
> 
> All right. But I'm a bit overwhelmed by all the things to keep in mind.

Sure, this would be an option to add later.

> Does your proposed IntegradeMode/UpdateMode deal with this?

mode = rebase-here-then-merge-no-ff would do what I described

> Anyway, I'll try to grab what I can from previous discussions (mainly
> about switching the merge parents) and create a new thread with a
> summary.

That would be nice, thanks.

-Richard
