From: alan@clueserver.org
Subject: Re: Odd problems trying to build an orphaned branch
Date: Fri, 6 Nov 2015 10:32:56 -0800
Message-ID: <929fa95cedaa2d2588753864b77380e9.squirrel@clueserver.org>
References: <1bf03e2146ceb5bb36b81f1ce64354b0.squirrel@clueserver.org>
    <20151106001832.GB9963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: alan@clueserver.org, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 19:33:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zulou-0004nn-Dx
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 19:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbbKFSc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 13:32:58 -0500
Received: from clueserver.org ([65.102.45.174]:60215 "EHLO clueserver.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbbKFSc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 13:32:57 -0500
Received: from clueserver.org (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 518A36002D5;
	Fri,  6 Nov 2015 10:32:54 -0800 (PST)
Received: from 192.55.54.43
        (SquirrelMail authenticated user alan)
        by clueserver.org with HTTP;
        Fri, 6 Nov 2015 10:32:56 -0800
In-Reply-To: <20151106001832.GB9963@sigill.intra.peff.net>
User-Agent: SquirrelMail/1.4.22-14.fc20
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280994>

> On Thu, Nov 05, 2015 at 01:16:54PM -0800, alan@clueserver.org wrote:
>
>> I created an orphan branch from 3.12-rc1. I then used git format-patch
>> to
>> generate patches from 3.12-rc1 to HEAD. (Over 7000 patches.) I use git
>> am
>> to apply them to the orphan branch. At patch 237 it fails to apply. (It
>> appears the patch is from a block of code added with a merge commit, but
>> it is somewhere in the middle of the block.)
>>
>> Are merge commits supposed to screw up git-format-patch?
>
> Yes. There is no defined format for merge patches, so git-format-patch
> cannot show them. What you're trying to do won't work.

This makes me worry about using git-format-patch. If it cannot handle
merge commits correctly, then using it to send patches to customers is
risky at best. (I work for a place that does not want to distribute the
kernel, just patches on top of the kernel. The case of having a large
number of merge commits in the tree seems to break that.)

> If your goal is to have the history at HEAD truncated at 3.12-rc1, you
> are probably better off using a graft and having "filter-branch" rewrite
> the history based on that. That will preserve merges and the general
> shape of history.

I tried using that.  The documentation on how to do it correctly is vague.
It seemed to want to take the patches before the graft point, not after.
When filter-branch hit a commit with no author, it died. (It does not
allow a rewrite of a commit that does not have an author.)

>
>> I also tried using clone with depth and --single-branch set.  It ignored
>> the depth setting and gave me the whole branch all the way back to
>> 2.6.x.
>
> Was it a local clone? Depth is ignored for those (it _should_ print a
> warning). If so, try --no-local to make it act like a "regular" clone.

I did not add any options for "local" vs "regular". What defines that?

>> I tried using graft and filter-branch. None of the descriptions are very
>> clear. None of them worked either. Filter-branch died on a commit
>> somewhere in 2.6 land that had no author. (Which is outside of the
>> commits
>> I want to keep.)
>
> I suspect you need to graft more than just the commit at v3.12-rc1. For
> example, consider this history graph:
>
>   --A--B--C--D---G--H
>            \    /
>             E--F
>
> If we imagine that H is the current HEAD, and D is our tag (v3.12-rc1),
> then making a cut between D and C will not have any effect on the side
> branch that contains E and F. Commits A and B are still reachable
> through them.
>
> You can find the complete set of boundary commits like this:
>
>   git log --boundary --format='%m %H' v3.12-rc1..HEAD
>
> and then graft them all like this:
>
>   git log --boundary --format='%m %H' v3.12-rc1..HEAD |
>     grep ^- | cut -d' ' -f2 >.git/info/grafts
>
> Then you should be able to run "git filter-branch" to rewrite the
> history based on that.
>
> I think you can probably get the same effect by running:
>
>   git filter-branch v3.12-rc1..HEAD

I will try this and see what happens.

> Of course that leaves only the problem that filter-branch is
> horrendously slow (for the kernel, most of the time goes to populating
> the index for each commit; I think filter-branch could probably learn to
> skip this step if there is no index or tree filter at work).

I have to only run this once, so I don't care. Running at all would be nice.

>> I tried creating an orphan branch and using cherry-pick
>> v3.12-rc1..linux-3.12.y. It blew up on the first merge commit it hit. I
>> tried adding in "-m 1" to try to get it to pick a parent, but then it
>> died
>> on the first commit because it was not a merge.
>
> That won't do what you want. Cherry-pick doesn't preserve merges. When
> you pick a merge and choose a mainline, it is effectively saying "treat
> that as the only interesting parent" and squashes the result down to a
> single non-merge commit.
>
> If you wanted to follow this path (starting at an orphan and moving the
> patches over), I think rebase's "--preserve-merges" would be your best
> bet. It used to have some corner cases, though, and I don't know if
> those were ever fixed. I'd say filter-branch is the most-supported way
> to do what you want.
>
>> All I want to do is take a branch from linux-stable and create a branch
>> that contains just the commits from where it was branched off of master
>> until it hits HEAD. That is it. All the scripts that I have seen that
>> claim to do just what I want break when it hits a merge or a bogus
>> author.
>> (How that got into linux-stable, I have no idea. The commit is 10 year
>> old!)
>
> As an aside, which commit caused the bogus-author problem? Filter-branch
> generally tries to preserve or fix problems rather than barfing, exactly
> because it is often used to rewrite-out crap. I wonder if there is
> something it could be doing better (though again, I think in your case
> you are hitting the commit only because of an incomplete cut with your
> grafts).

I will try and find it again. It is in the 2.6 tree from 2005.
