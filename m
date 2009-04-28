From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git workflow: how to achieve?
Date: Tue, 28 Apr 2009 09:24:02 +0200
Message-ID: <49F6AF12.70906@op5.se>
References: <20090427225900.29793.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 09:24:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyhfu-00086U-3W
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 09:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbZD1HYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 03:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbZD1HYI
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 03:24:08 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:57823 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbZD1HYG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 03:24:06 -0400
Received: by fxm2 with SMTP id 2so355201fxm.37
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 00:24:04 -0700 (PDT)
Received: by 10.86.33.10 with SMTP id g10mr4058992fgg.21.1240903444484;
        Tue, 28 Apr 2009 00:24:04 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d6sm7176682fga.2.2009.04.28.00.24.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Apr 2009 00:24:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090427225900.29793.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117749>

George Spelvin wrote:
> Andreas Ericsson <ae@op5.se> wrote:
>>>  I want to be able to switch feature branches easily.
>> Well, git makes that absolutely trivial. No other vcs has as cheap
>> branching as git does.
> 
> Yes, I'm quite aware, but I mean while keeping the same merged result.
> That is, I'm compiling and testing base+feature_a+feature_b+feature_c,
> but I want to be able to change which feature I'm committing to.
> 
> This comes up if I arrange some merges so that the "current branch" is
> one below the top merge:
> 
> o--o--o--o--o--o--o <-- HEAD
>            /  /  /
>     ...c--c  /  /
>       ...b--b  /
>         ...a--a
> 
> And then want to switch to branch c.
> 

Sorry, I still don't see a problem here. If you want to commit to C,
just checkout C and commit. What am I missing?

I know some kernel-lieutenants use a magic branch-prefix to mark which
branches to merge and compile-test, and then use a homegrown script
to actually merge all those branches.

> 
>>> But when I want to be testing something highly volatile like linux-next,
>>> and ensuring that my work continues to merge with it cleanly, as well
>>> as helping others with their branches, it becomes a daily pain.
>> Why? Just merge it to make sure it merges, and then throw away the result.
>> There's a post made by Linus somewhere on how he would like people to do
>> merges (ie, which to keep and which to throw away).
> 
> I don't want to just merge it, I want to *compile it* and *run it*.
> Because the whole point of using linux-next is to test it.
> And when it breaks, I want access to the relevant source code.
> 

Ok. Sounds like you'd need some CI tool with special smarts to try merging
all relevant branches and bailing out on conflicts or something, unless you
intend to compile it locally and run it from there.

> 
>>>  And I can't share half-finished versions with co-workers.
>> So finish it before you push. Anyone fetching from your local repository
>> should be aware that not all branches point to something sensible. If
>> they don't, they'll be sure to ask you so you can bring out the LART.
>>
>>> This is all vaguely quilt-like, although I'd rather not worry about the
>>> order of patches.  I suppose I'd like git to let me "commit under" the
>>> final merge.  When I switch branches, git should reorganize the tree of
>>> merges so that the current branch is only one merge from the HEAD.
>> Umm... Use a separate branch to do the merge, and enable rerere caching
>> so your recorded resolutions get reused when you do the merge "for real".
> 
>>> (Another thing I've wished for that might be related is for a branch
>>> to have a notion of its origin.  So I can rebase it onto an arbitrary
>>> place in the commit tree without having to explicitly specify an origin.)
>> This is a bad idea.
> 
> Can you explain why?  When I talk about a "feature branch", I mean a chain
> of commits that introduces a feature.  Why would it be bad for a reference
> to have an optional "origin" attribute that indicates a start position?
> 

Because they already have a reference to where they started. It's called
the merge-base and it differs depending on which branch you want to merge
it into. If you have 'maint', 'next' and 'master', the "point of origin"
for "next" is "maint" from the point of view of "maint", but it's "master"
from the point of view of "master". Marking it as "master" would mean you
couldn't use that mark when merging it into maint, so you'd have to either
mark it as a sub-branch of all previous branches, or do what's done today.

IOW, the mark would help one corner-case but would make all other cases
more complicated. A bad idea indeed.

>>> ((Another really simple feature I keep wanting is "git commit -b
>>> <newbranch>".  I should probably try to write a patch...))
>> This is a good idea (assuming you mean "commit this state to that branch",
>> and it should be fairly trivial to implement using something like this:
>>
>>     git stash && git checkout -b newbranch && git stash pop && git commit
> 
> Actually, just 
> git checkout -b newbranch; git commit "$@"
> does the job quite nicely, but 
> 
>>> Anyway, my feature ideas might be unworkable, and in any case, they'll
>>> take a long time to implement.  Is there some easier way to achieve more
>>> or less this effect?
>> I'm not sure what effect you're after. If you can write down, with very
>> *little* detail, what it is you want to achieve, it will be a lot easier
>> to help you than if you ask about small steps in a pre-thought-out solution
>> that may not even be right from the beginning.
> 
> We may have a language problem.  "very little detail" means almost no detail,
> an absence of details.  Did you mean "every little detail"?
> 

No, I mean with very little detail. Usually when trying to answer a question
and I can't make sense of the question itself it's because the person asking
has already started down some road and entered into a frame of mind which I
cannot share. That mindset may not be correct to solve the problem, so removing
detail usually helps.

"I'd like to automatically merge a bunch of branches and compile-test them
on every commit. How do I go about doing that?" is a much more open question
that invites to giving a lot more correct answers. Since you haven't asked
such a high-level question yet, I'm not sure what your need is, and therefore
I cannot help you find a suitable solution.

> It actually came to mind recently during $DAY_JOB work, but let me give a
> concrete example based on the Linux kernel:
> 
> I am running a customized Linux kernel.  On top of Linus's base,
> I have local patches to enable 64-bit DMA on the SB600 SATA controller,
> some local patches to make the RAID (md) code print out the locations
> of mismatches when verifying, the EDAC quilt series, a merge of the
> LinuxPPS code, a number of local patches to the LinuxPPS code (that
> I'm discussing with Rodolfo Giometti), and some revisions to the serial
> interrupt handler (that I'm discussing with Alan Cox).
> 
> There's also the beginning of an ethernet driver that I'm trying to
> write, but it's going slow.
> 
> Every week or two, I rebase all that on top of Linus's latest.  Plain
> rebase doesn't like the LinuxPPS merge, so I've been doing it manually
> in two parts.  Although rebase -p is apprently working much better than
> I remember.
> 

This step is rather unnecessary unless there are changes to API's you
depend on. Doing a single rebase once you're done with the patch-series
would be far better and would, I expect, remove quite a lot of the
complexity you're experiencing.

> I would also like to be able to revise each of those features
> independently, based on feedback from the relevant upstream maintainer.
> I also don't know in what order they'll be acecpted upstream (if ever).
> Regardless of that, I want to my running kernels to have all of the
> patches applied.
> 
> Currently, some patches get deeply buried in the stack and I have to
> do a lot of deep rebasing.
> 

I'm not sure what you mean by "deep rebasing" or "stack", unless you've
started using topgit already (which, I believe, does patch-stacks).

No patch should ever get "deeply buried" unless you do really, really
weird things with your topic-branches though. They *should* remain the
same each and every time.

But the "all patches in my running kernel" problem could pretty easily
be solved by simply merging all your features into one branch and then
periodically merge Linus' latest into that branch whenever you want to
update your kernel. When the merge conflicts, you'll have to figure out
which of your features cause it (shouldn't be a problem unless they
conflict with themselves) and then rebase *that* feature onto the new
upstream (or something).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
