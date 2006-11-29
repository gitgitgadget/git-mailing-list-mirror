X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Tue, 28 Nov 2006 19:06:03 -0800
Message-ID: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	<878xhwwdyj.wl%cworth@cworth.org>
	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
	<7vd5786opj.fsf@assigned-by-dhcp.cox.net>
	<871wnnwi3k.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 03:06:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32610>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpFlz-0000Mp-Hq for gcvg-git@gmane.org; Wed, 29 Nov
 2006 04:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757041AbWK2DGI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 22:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757160AbWK2DGI
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 22:06:08 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:22442 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1757041AbWK2DGF
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 22:06:05 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061129030604.KLXM27894.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Tue, 28
 Nov 2006 22:06:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id sT5X1V00t1kojtg0000000; Tue, 28 Nov 2006
 22:05:32 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

>> The problem I have with the new behaviour is that it goes
>> against the mental model when I start doing anything nontrivial
>> (I would not use words as strong as "totally breaks the mental
>> model", but it comes close).  I am not sure how well I can
>> express this, but the short of it is that "grokking index" is
>> not about understanding how the index works, but about trusting
>> that git does the right thing to the index and you do not have
>> to worry about it all the time.
>
> Frankly, I do not currently trust git to always do the right thing
> with the index.

This clearly shows that I did not express myself well.  You are
correct that there are commands that ignore the index by default
(a notable example "git apply" has been given by both of us),
and you do have to know about what the commands you use do to
the index.

What I meant by "do not have to worry about" is not about the
index operations each command invocation involves.  Of course
you need to know (unless you will do a "commit -a" at the end)
that git apply without --index will leave the index out of sync
relative to your working tree, for example.

What you do _not_ have to worry about all the time is the local
changes you do not want to go in your next commit but still want
to keep in your working tree.  Although it probably is not
kosher from the purist point of view, it is very convenient to
be able to keep truly local changes (say, my GIT-VERSION-GEN,
everybody's change to Makefile to set "prefix=/usr/local", or
"#define DEBUG 1" in one of the C files you are currently
mucking with) that you have no intention of committing, while
you want to record the changes to the paths you worked on so far
with patch application, merging and edit + update-index in your
next commit.  You record the latter in the index using git tools
to build what you want to have in your next commit in the index
in each step (again, each step you may have to be aware what you
are doing).  After you update the index, you can forget about
them -- because the index remembers them for you.  They are in
the state you tentatively decided is good for the next commit.
You do not have to worry about the local changes you still have
that you do not want to have in the commit because you do not
run update-index on them, and you can trust that git does not
automatically do so either, so they stay local.

>> Once I am done, I can ask "git diff" and expect it to show my
>> local changes I have no intention of committing for now
>> (e.g. GIT-VERSION-GEN in the working tree has v1.4.5-rc1.GIT
>> long before I plan to start the rc1 cycle to constantly remind
>> me what the next version will be, which is a trick I picked up
>> from Linus), and "git diff --cached" would show exactly what I
>> will commit.
>
> I understand the trick, and I'm not proposing anything that would
> preclude it. But I really don't find it a compelling argument for the
> default behavior of git-commit.

The above paragraph is not the important part of my message.
What was much more important is what immediately followed it,
which you did not quote:

    And at that point, I trust "git commit" to do the right thing --
    the damn thing I just checked with "git diff --cached" _is_ what
    will be committed.

Like it or not, git was designed by and for people who use the
index to work in a dirty worktree.  The "-a" option to "git
commit" is politely explained as the "--all" option, but its
true pronunciation is "screw the index -- I rightfully haven't
been paying attention to the index (my workflow did not require
me to) because I know all the changes in my worktree are what I
want in the next commit" option.

The "screw the index" attitude is not a wrong thing per-se.  It
is perfectly a good habit to always work in a worktree that
exactly matches HEAD after each commit, and the only index
manipulation you would (unfortunately) need to do between your
own two commits are "git add" (for this use pattern, "git rm" is
an unnecessary thing to do -- just saying "rm" is enough).  Then
"git diff" (without --cached but perhaps with paths) would serve
as a preview for your next commit because you are going to do
the "screw the index" commit (except that unfortunate "git add"
thing, which we _could_ fix with "intent to add" entries in the
index) and you would be happy with the similarity to CVS.

Once you use "I care about the index" workflow, however, you
will see more areas where git's index shine.  For example, "git
diff" starts to take a more useful role.  "I care about the
index" attitude means you let the index be the incremental
staging area for your next commit, and when you reach a good
"snapshot" point you update the index with various means
provided by git.  "git diff" will show "what could further be
added to the next commit" without talking about what you already
decided are good earlier and updated the index with.  As we
already discussed, "git merge" will update the index for cleanly
merged paths to let you concentrate on more interesting cases
(i.e. merge conflicts).  To people who care about the index, the
next commit preview is "git diff --cached", not "git diff HEAD".
What git promises to them is not to update-index the local
changes they have without being told and without their knowing.

This is where "git commit" that does "-a" by default goes quite
against the underlying mental model of git.  You staged what
should appear in the next commit in the index because you did
not want to worry about the local changes you still want to keep
in your working tree.  Doing the "screw the index" commit by
default to these people is slap in the face.  You do not want to
get your index suddenly screwed at the final moment of making
the commit, which happened to me when I did "commit --amend"
with the version with those two patches applied.

Don't get me wrong.  I know there are cases that it is useful to
always commit with "-a", but that really has to be opt-in.  When
I work in my alternate "trivial fixes only" repository, I use
the "screw the index" workflow myself.  When I run git apply and
the patch does not apply, I use "git apply --reject" and fix the
mess by hand, and at that point I do not care if that operation
updates the index for the paths involved or not (although I do
check if the patch tries to add new paths -- they need to be
told to git even whey you take the "screw the index" attitude),
and I do not bother running update-index on them either.  But
that is possible only because I know I am going to commit the
final result with "screw the index" option.

"grokking the index" is not about knowing how the index could be
used in your workflow.  It is about actually using the index to
stage your next commit.  Somebody a bit smarter than me once
said that if you deny the index you are denying git.  Although I
would not say it that strongly, because "screw the index" is
also a valid workflow to use (arguably part of) git, "screw the
index" at the commit time _has_ _to_ be a conscious act.

