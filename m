From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GIT commit statistics.
Date: Sun, 13 Nov 2005 19:33:04 -0800
Message-ID: <7vlkzr6gzz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	<7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	<43758D21.3060107@michonline.com>
	<7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
	<46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
	<7vy83s95k0.fsf@assigned-by-dhcp.cox.net>
	<46a038f90511131242p4692c74fn20c015998620b9f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 04:34:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbV6Z-00057O-VB
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 04:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVKNDdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 22:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVKNDdI
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 22:33:08 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:38030 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750864AbVKNDdH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 22:33:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114033238.IGRS20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Nov 2005 22:32:38 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511131242p4692c74fn20c015998620b9f4@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 14 Nov 2005 09:42:31 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11763>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On 11/13/05, Junio C Hamano <junkio@cox.net> wrote:
>> ....  I
>> could do "git pull . origin" at this point, but that would
>> result in a useless mini-merge.  My tree is not public so I can
>> freely rebase to clean things up.
>>
>>         $ git rebase origin
>>         $ git show-branch
>
> What happens if there are conflicts during git-rebase?

Well, obviously you could resolve them ;-).  But if you are
rebasing just to reduce trivial mini-merges, it might make more
sense to honestly record the merge if the rebase involves
conflict resolution.  After all, the reason rebase got conflicts
is because the development trail by somebody else that has been
already committed to the shared "master" branch overlapped what
you were doing in your "master" branch, isn't it?

In your message you indicated that you use "format-patch" piped
to "am".  I think that is a better approach than "rebase" these
days; the conflict can be handled easier with that approach, and
if you use "--3way" flag you do not even have to worry about
patches in your branch that is already there in the shared
"master" (your "origin") branch.

So instead of running "git rebase origin" at this point, I may
do something like this [*1*]:

	$ git-reset --hard origin
        $ git-format-patch -k --stdout origin ORIG_HEAD | git am -3 -k

The first step rewinds my "master" (the original is stored in
ORIG_HEAD), and the second step extracts the commits that were
in my master but not in origin in a patch form, an replay them
on top of the "master" (which was rewound to "origin").

"git-am" would stop at the first unapplicable patch if there is
a conflict, leaving the conflicting patch in .dotest/patch.
I have to fix it up before going further.  Here is how.

1. "git am" 3-way fallback would have kicked in, because I have
   all the blobs the patch is supposed to apply to, and my
   working tree and index is in a state just like when I am
   resolving a conflicting merge after a pull.  Clean up the
   conflict in the working tree, build-test and all as usual.

2. Run "git diff HEAD >.dotest/patch" to record what the patch
   should have been if it were to apply cleanly on top of the
   previous state.  If I did a noteworthy adjustment to the
   patch, I might also edit .dotest/final-commit to update the
   commit log message.

3. Then reset the working tree and index before the failed
   application of this patch with "git reset --hard".

After that:

	$ git am -3

would let me restart from that commit that did not replay well.

> Is there a cheap way to ask from a shell script whether the merge is
> truly trivial? I thought git-diff-tree would help me here, but it
> doesn't...

This was recently added by Linus to help git-merge do that:

	git-read-tree --trivial -m -u $O $A $B

The command exits with a non-zero status, without touching index
nor working tree, when the merge is not "truly trivial".
Otherwise it does its thing -- the trivial in-index merge is
done, files in working tree updated and the only thing left for
you to do is to create a commit having parent $A and $B.

Would that help?

[Footnote]

*1* This is what the "make rebase restartable" comment in TODO
list is about, and I wanted to rewrite "rebase" to do exactly
these two commands, but I got distracted ;-).
