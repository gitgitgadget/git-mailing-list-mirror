From: "George Spelvin" <linux@horizon.com>
Subject: Re: Git workflow: how to achieve?
Date: 27 Apr 2009 18:59:00 -0400
Message-ID: <20090427225900.29793.qmail@science.horizon.com>
References: <49F16BA5.9060003@op5.se>
Cc: git@vger.kernel.org, linux@horizon.com
To: ae@op5.se
X-From: git-owner@vger.kernel.org Tue Apr 28 00:59:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZn8-0001dT-AW
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 00:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188AbZD0W7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 18:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756959AbZD0W7F
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 18:59:05 -0400
Received: from science.horizon.com ([192.35.100.1]:49154 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756334AbZD0W7C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 18:59:02 -0400
Received: (qmail 29794 invoked by uid 1000); 27 Apr 2009 18:59:00 -0400
In-Reply-To: <49F16BA5.9060003@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117726>

Andreas Ericsson <ae@op5.se> wrote:
>>  I want to be able to switch feature branches easily.
> 
> Well, git makes that absolutely trivial. No other vcs has as cheap
> branching as git does.

Yes, I'm quite aware, but I mean while keeping the same merged result.
That is, I'm compiling and testing base+feature_a+feature_b+feature_c,
but I want to be able to change which feature I'm committing to.

This comes up if I arrange some merges so that the "current branch" is
one below the top merge:

o--o--o--o--o--o--o <-- HEAD
           /  /  /
    ...c--c  /  /
      ...b--b  /
        ...a--a

And then want to switch to branch c.

> Sounds like you'd benefit somewhat from using TopGit or some other
> patch-queue management tool. I haven't used them myself, but I believe
> this is the kind of problem they set out to solve.

Thanks, I didn't know about TopGit; I'm looking at it now.

>> But when I want to be testing something highly volatile like linux-next,
>> and ensuring that my work continues to merge with it cleanly, as well
>> as helping others with their branches, it becomes a daily pain.
> 
> Why? Just merge it to make sure it merges, and then throw away the result.
> There's a post made by Linus somewhere on how he would like people to do
> merges (ie, which to keep and which to throw away).

I don't want to just merge it, I want to *compile it* and *run it*.
Because the whole point of using linux-next is to test it.
And when it breaks, I want access to the relevant source code.

>> The best attempt I have so far is to rebase a lot.  But that means that
>> I can't do any merging in my development branch lest the rebasing turn
>> into a mess.
> 
> Merging other branches into your development branch and keeping the result
> is often a bad idea, since you can't later merge the development branch
> without also merging everything that *you* merged. This makes it nearly
> impossible to pick your feature into random spots in the DAG. If you ever
> work anywhere but on the bleeding edge, you'll find merging the "main dev
> branch" is a *really* bad idea.

I didn't mean merging main into my dev branch, but merging within my
dev branch.  As in, "that refactorization of the foo_* helpers is a
better base for development, so I'll merge that into my bar branch", and
then test-merge THAT into main.

>>  And forcing everything to be linear makes changing branches
>> a pain.
> 
> Everything needn't be linear, but if you can manage to keep each topic
> linear that makes your series a lot easier to review.

Yes, I know.  I generally try, but it's occasionally nice to have sub-branches
within a feature branch.

>>  And I can't share half-finished versions with co-workers.
> 
> So finish it before you push. Anyone fetching from your local repository
> should be aware that not all branches point to something sensible. If
> they don't, they'll be sure to ask you so you can bring out the LART.
> 
>> This is all vaguely quilt-like, although I'd rather not worry about the
>> order of patches.  I suppose I'd like git to let me "commit under" the
>> final merge.  When I switch branches, git should reorganize the tree of
>> merges so that the current branch is only one merge from the HEAD.
> 
> Umm... Use a separate branch to do the merge, and enable rerere caching
> so your recorded resolutions get reused when you do the merge "for real".

>> (Another thing I've wished for that might be related is for a branch
>> to have a notion of its origin.  So I can rebase it onto an arbitrary
>> place in the commit tree without having to explicitly specify an origin.)
> 
> This is a bad idea.

Can you explain why?  When I talk about a "feature branch", I mean a chain
of commits that introduces a feature.  Why would it be bad for a reference
to have an optional "origin" attribute that indicates a start position?

>> ((Another really simple feature I keep wanting is "git commit -b
>> <newbranch>".  I should probably try to write a patch...))
> 
> This is a good idea (assuming you mean "commit this state to that branch",
> and it should be fairly trivial to implement using something like this:
> 
>     git stash && git checkout -b newbranch && git stash pop && git commit

Actually, just 
git checkout -b newbranch; git commit "$@"
does the job quite nicely, but 

>> Anyway, my feature ideas might be unworkable, and in any case, they'll
>> take a long time to implement.  Is there some easier way to achieve more
>> or less this effect?
> 
> I'm not sure what effect you're after. If you can write down, with very
> *little* detail, what it is you want to achieve, it will be a lot easier
> to help you than if you ask about small steps in a pre-thought-out solution
> that may not even be right from the beginning.

We may have a language problem.  "very little detail" means almost no detail,
an absence of details.  Did you mean "every little detail"?

It actually came to mind recently during $DAY_JOB work, but let me give a
concrete example based on the Linux kernel:

I am running a customized Linux kernel.  On top of Linus's base,
I have local patches to enable 64-bit DMA on the SB600 SATA controller,
some local patches to make the RAID (md) code print out the locations
of mismatches when verifying, the EDAC quilt series, a merge of the
LinuxPPS code, a number of local patches to the LinuxPPS code (that
I'm discussing with Rodolfo Giometti), and some revisions to the serial
interrupt handler (that I'm discussing with Alan Cox).

There's also the beginning of an ethernet driver that I'm trying to
write, but it's going slow.

Every week or two, I rebase all that on top of Linus's latest.  Plain
rebase doesn't like the LinuxPPS merge, so I've been doing it manually
in two parts.  Although rebase -p is apprently working much better than
I remember.

I would also like to be able to revise each of those features
independently, based on feedback from the relevant upstream maintainer.
I also don't know in what order they'll be acecpted upstream (if ever).
Regardless of that, I want to my running kernels to have all of the
patches applied.

Currently, some patches get deeply buried in the stack and I have to
do a lot of deep rebasing.

>> Maybe the planned git-rebase improvements to handle merges better will
>> fix this, so I can just commit on top and periodically rebase the changes
>> under the head manually without too much pain?  (git rebase -i -p does
>> appear to be working better than I remember.)
> 
> What planned rebase improvements are you talking about?

I was referring to Dscho's "Heads up: major rebase -i -p rework coming up"
http://marc.info/?l=git&m=123282871626215

>> H'm... in fact, it might be as easy as replacing "git pull" with
>> git rebase -p -i <last merge>^
>> (Delete the merge in the editor)
>> git pull <remote>
>> 
>> Annoying to remember, but not TOO bad.
> 
> Use an alias, or a wrapper script.

Once I've done it manually a few times to verify there are no surprises.
