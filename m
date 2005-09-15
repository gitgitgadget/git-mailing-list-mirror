From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: git-merge-cache / StGIT - gitmergeonefile.py: merging one tree
 into another rather than two trees into merge base
Date: Thu, 15 Sep 2005 11:06:50 +0100
Message-ID: <tnxslw6d4qt.fsf@arm.com>
References: <200509102027.28812.blaisorblade@yahoo.it>
	<1126427087.8457.33.camel@localhost.localdomain>
	<200509142019.04667.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 12:09:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFqeY-0001Ny-GD
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 12:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVIOKHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 06:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVIOKHf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 06:07:35 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:3809 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932441AbVIOKHe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 06:07:34 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j8FA6rSV028458;
	Thu, 15 Sep 2005 11:06:54 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id LAA15249;
	Thu, 15 Sep 2005 11:06:59 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.140]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 15 Sep 2005 11:06:58 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
In-Reply-To: <200509142019.04667.blaisorblade@yahoo.it> (blaisorblade@yahoo.it's
 message of "Wed, 14 Sep 2005 20:19:04 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 15 Sep 2005 10:06:58.0031 (UTC) FILETIME=[3522C7F0:01C5B9DD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8600>

Blaisorblade <blaisorblade@yahoo.it> wrote:
> On Sunday 11 September 2005 10:24, Catalin Marinas wrote:
>> That's indeed very slow. How may files are modified in each patch?
>
> 1 files, in most cases - biggest one had 5 files changed (and is big
> 4,8K).

OK, this doesn't really matters since the diff between the new HEAD
and the old bottom of the patch is big.

>> Actually, it will three-way merge the diff between top and bottom with
>> the diff between HEAD and bottom. The time will depend on the size of
>> both diffs, not just the maximum.
>
> Yes, true, but the problem in this case was that one diff (the
> upstream one) was extremely huge. And it even involved some files
> removal - I almost never caught, with top, anything else than
> gitmergeonefile.py or git-update-cache --remove.

git-read-tree -m doesn't handle the case when a file is removed from
one branch and unmodified in the other, which is what happens in your
test. For each of these removed files, git-merge-cache will call
gitmergeonefile.py which calls 'git-update-cache --remove'.

An improvement would be to make git-read-tree smarter and only leave
out the three-way merges and the conflicts. Otherwise, implementing my
own git-merge-cache which includes gitmergeonefile.py or implementing
gitmergeonefile in C would be an improvement but I'm not sure it is
that significant.

> I guess that moves between stages don't have the big memmove()
> problem, while calling --remove shows it.
>
> And, with master being the SHA1 I pushed onto 
> (8920e8f94c44e31a73bdf923b04721e26e88cadd), 
>
> git-diff-tree -r v2.6.13 master |grep ' D'|wc -l
>
> gives 189. I guess that 2.5 seconds per each removal are enough to
> justify the time which was needed above. Actually, it even had to be
> less than a second per removal, otherwise it'd have been even
> slower.

The 2.5 figure was for trivial merges and most of the time was spent
in git-read-tree.

>> That's not a three-way diff algorithm. I could generate the diff of the
>> patch and apply it with git-apply but this might fail and you wouldn't
>> even get reject files (not sure whether git-apply supports this).
>
> Well, true, but either diff3 or merge would work fairly well. Also,
> trying to apply the patch and resorting to something more complex
> wouldn't create so many problems.

But this would slow things down for people pulling changes on a daily
(or even more often) basis. It could be added as an option to 'stg
push', i.e. when you expect something like this, just pass a
'--nothreeway' option.

>> Another problem is that it won't detect upstream merges of your patch,
>> you would need to check it by hand. If all you need is a way to apply a
>> patch using the 'patch' tool, have a look at Quilt. It has similar
>> commands (since StGIT is based on its ideas) but uses the diff/patch
>> tools and is much faster. It also generates rejects if a patch doesn't
>> apply cleanly but I find the diff3 information, together with the
>> original files left in place, much more useful.
>
> Yes, in most cases. I've had something to complain with diff3,
> however (that's a separate story). Maybe merge would be even better?

I couldn't find the difference between merge and diff3 -E. Is there
any?

>> > In the git-read-tree manpage (which is probably outdated), this is
>> > documented as follows:
>> >
>> >        o  stage 1 and stage 3 are the same and stage 2 is different:
>> >            take stage 2 (some work has been done on stage 2)
>> >
>> > But it didn't happen, which is strange.
>
>> This means that the file is not modified by an StGIT patch but it is
>> modified upstream. This case works fine for me (it's a bug if it
>> doesn't). Did you get a conflict? Are the original files left in place?
>
> No, it's not a correctness bug for me - just a performance bug. Why did 
> gitupdateonefile.py need to call git-update-cache --remove? If git-read-tree 
> had done his duty, this wouldn't be needed.

Do you mean it wasn't modified by the StGIT patch (and hence stage 3
is the same as stage 1) but it was removed in stage 2. This case is
*not* handled by git-read-tree, though I think it should deal with
this trivial case as well, it's not that different from the case
below.

If stage 2 is a simple SHA1 modification (not file removal) the case
was already handled by git-read-tree and there should only be a stage
0 entry for this file. git-merge-cache should *not* call
gitmergeonefile.py.

You can run git-read-tree manually and check the stages for this case.

>> > So, would stgit delete a file created in patch #1 when merge-applying
>> > patch #2?
>
>> Definitely not.
>
> Gonna test - but if you look at the manpage of read-tree, this would
> probably be the expected behaviour.

If patch #2 didn't explicitely removed this file and if patch #1 is
applied, it won't delete it (unless there is a bug).

-- 
Catalin
