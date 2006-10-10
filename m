From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] merge: loosen overcautious "working file will be lost" check.
Date: Mon, 09 Oct 2006 17:19:18 -0700
Message-ID: <7vd5919g55.fsf@assigned-by-dhcp.cox.net>
References: <7vy7rp9kdz.fsf@assigned-by-dhcp.cox.net>
	<20061010000127.76332.qmail@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 02:19:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX5LK-00083v-4E
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 02:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWJJATU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 20:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWJJATU
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 20:19:20 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:31686 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750763AbWJJATT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 20:19:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010001918.FXD13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 20:19:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YQKM1V00L1kojtg0000000
	Mon, 09 Oct 2006 20:19:21 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20061010000127.76332.qmail@web31801.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 9 Oct 2006 17:01:27 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28587>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Junio C Hamano <junkio@cox.net> wrote:
>> Luben Tuikov <ltuikov@yahoo.com> writes:
>> 
>> > I think this is a good thing.
>> >
>> > How about this case I've noticed in my trees:
>> >
>> > After branching out, a file is deleted, only to add
>> > a different file with the same file name.
>> >
>> > Then any time I pull in from the trunk to merge,
>> > merge fails with git-diff-files showing all 0's and the
>> > file name in question.  Picture:
>> >
>> >   Branch B       +-----------------M1---->
>> >                 /                 /
>> >                C2 <-- git-add A  /
>> >               /                 /
>> >              C1 <-- git-rm A   /
>> >             /                 /
>> > Trunk -----+-----------------+---->
>> 
>> Sorry I do not understand the picture; where is the common
>> ancestor?  If it is the left plus sign on the Trunk line, and
>
> Yes, the left plus sign is the common ancestor.
>
>> you are talking about what happens when making the merge M1,
>> then before C1 A did not exist (so Trunk tip which is the right
>
> File A exists before C1, it does not exist after C1.  C1 removes
> it.

Ah, I misunderstood.  But then I do not understand why you see
all 0 anywhere.  Merge base has the path, branch B has it, and
trunk has it too; wouldn't it result in regular 3-way merge?

I understand you do _not_ even want a regular 3-way merge in
this case, but that is a separate issue.  You could write a new
merge strategy to traverse ancestry chain between the merge base
and each heads you are merging and notice disappearance and
reappearance of the path, but that would slow things down
tremendously for normal case and I do not think it is worth it.

You would also have exactly the same issue if you do not remove
and then add the file, but if your work on the branch involves a
significant rewrite.  Depending on how good the rewrite is,
bugfixes that happened on the trunk based on an ancient code may
not even be needed (in other words, it would not apply cleanly
anyway, but it does not matter -- the branch work is much better
or has different set of problems that the trunk fix is
irrelevant).

At that point, M1 would involve significant merge conflicts (and
not all-0 which I am still puzzled about), but I suspect that
the situation is obvious enough to the human (inspect git log
branch...trunk output and the log somewhere had better indicate
that the are unrelated), and the solution very much is different
case-by-case (most likely the person who pulls branch into trunk
would say "keep ours" for the path which would mean running "git
cat-file :2:$path >$path", or say "we are not really ready to merge
yet" and abort the entire merge; somebody on the trunk pulling
from that branch might say "I want other smaller fixes but this
total rewrite is not ready yet -- keep ours", or "now we know
this is total rewrite and the small updates on the trunk does
not matter -- take theirs and from now on we will improve on the
work done on the branch").

So in short, I do not think there is a clear-cut improvement we
can do to the tools to solve this.
