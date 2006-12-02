X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Sat, 02 Dec 2006 00:09:09 -0800
Message-ID: <7vbqmmzplm.fsf@assigned-by-dhcp.cox.net>
References: <200612011106.42272.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 2 Dec 2006 08:09:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33005>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqPw2-0007Xr-2T for gcvg-git@gmane.org; Sat, 02 Dec
 2006 09:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162828AbWLBIJM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 03:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162827AbWLBIJM
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 03:09:12 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:9409 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1031552AbWLBIJK
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 03:09:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061202080910.PDVK18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Sat, 2
 Dec 2006 03:09:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tk9J1V00T1kojtg0000000; Sat, 02 Dec 2006
 03:09:19 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> Raimund Bauer offered this suggestion (paraphrased):
>
> "Maybe we could do git-commit -a  _only_ if the index matches HEAD, and
> otherwise keep current behavior?  So people who don't care about the
> index won't get tripped up, and when you do have a dirty index, you get
> told about it?"
>
> Johannes Schindelin pointed out that this isn't the right thing to do for
> an --amend, so that is checked for. Additionally, it's probably not the
> right thing to do if any files are specified with "--only" or
> "--include", so they turn this behaviour off as well.
>
> Nguyen Thai Ngoc Duy asked that git-commit let you know it's done this
> by adding an extra comment to the commit message.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>

Aside from the "working tree not matching index" safety valve I
asked for, there is a more important case that "when the index
matches HEAD" is not a safe enough check for this 'cleverness'.

It's related to this code in git-commit:

        if [ "$?" != "0" -a ! -f "$GIT_DIR/MERGE_HEAD" -a -z "$amend" ]
        then
                rm -f "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
                run_status
                exit 1
        fi

This allows you to make a new commit with an identical tree as
the current HEAD, when making a merge.

We originally did not allow a commit that has identical tree
with its first parent.  It was pointed out as a bug in the real
world setting, where two bugs are independently fixed by two
people, textually and also logically differently, and the merge
results in a conflict.  In such a case, after examining the text
(git diff --cc) and motivation (git log --merge) of the changes
that conflicted from both ends, if you decide that you prefer
your own fix over the fix made by the other party, your edit of
the conflicted file would end up to be identical to what you had
originally in the HEAD.

In such a situation, it makes sense to record the fact that the
two development paths came to the same conclusion as a merge.
It would also simplify later merges from the other side, and the
merges the other side attempts by pulling from you.

So after you fix the conflicts, you would mark the conflicted
file with Nico's shiny new "git add".  The index _still_ matches
HEAD.  The 'cleverer' "git commit" would not notice this
situation and commits unrelated changes that the user does not
have any intention to commit in the working tree by mistake.

So that is _another_ exception you must handle.

But I think the problem with this 'cleverer' commit runs
deeper.

Notice that you needed to say "The main idea is this cleverness,
but foo pointed out this special case, and bar pointed out
another, and we fixed all of these known ones and now this is
good, let's apply it." in your proposed commit log message?  You
should smell fishiness in that kind of reasoning.

It's not that you cannot be sure that these suggestions covered
all cases; you should not have to cover everything under the sun
in your initial revision.  New exceptions can certainly be added
incrementally to address breakages.  However, having to have
exception from the beginning is a sign that the general rule you
started from is a broken rule.  To realize that yourself, Think
about how you would describe the behaviour to a new user.

The currently proposed rewording of "git add" and "git commit"
manual pages would define "git commit" to behave in two primary
modes:

 1. With paths, "git commit <paths>" means "forget for a moment
    the changes I staged to be committed, and make a commit that
    includes only these paths (i.e. the new commit and the
    current HEAD are different at exactly these paths and
    nowhere else, and the new commit has contents from the
    working tree for these paths)".

 2. Without paths, "git commit" means "make a commit out of
    everything I have told you to commit (aka 'staged') so far".
    The primary ways to tell git to stage contents are "git
    add/rm/mv".  But as a short-hand, you can say "git commit
    -a" to ask the command to place all the changes in the
    working tree in the changeset to be committed before making
    the new commit.

How would your version be described?

 1. (ditto)

 2. (ditto).  However, there are number of exceptions you should
    be aware of:

 2-a. The above general rule only applies if you have already
      told git to stage something for the next commit.

 2-b. However, even if you had told git to stage new contents,
      if the new contents happen to be the same as HEAD, then
      the command grabs every change in the working tree and
      makes a commit out of it.

 2-c. Contrary to the above exception, even if you staged the
      same contents as in HEAD, if you are in the middle of the
      merge, it does not include the working tree changes in the
      new commit.  This is because....

 2-d. Another exception is that if you are amending an existing
      commit, ...  This is because....

With careful reading, the users may understand it after they
read the above description, but would that understanding really
be committed to memory?  Are you confident that you will
remember your own reasoning for the exceptions and be prepared
to defend this change (and perhaps follow-up additions to the
list of exceptions), if 6 months down the road when an old timer
from the kernel circle says "I updated to recent git, and its
'commit' behaves funnily in the way I did not expect.  Why does
it do that"?

I really think the users would be much better off with
consistent behaviour that is easy and simple to describe than a
complex magic that does the right thing 99.9% of the time,
because you either understand the complex magic or constantly in
fear of the tool that can work against you 0.01% of the time.
