From: Junio C Hamano <junkio@cox.net>
Subject: Why is it bad to rewind a branch that has already been pushed out?
Date: Fri, 02 Feb 2007 22:40:49 -0800
Message-ID: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 07:41:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDEa2-0000DO-AQ
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 07:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946361AbXBCGkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 01:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946362AbXBCGkv
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 01:40:51 -0500
Received: from fed1rmmtai20.cox.net ([68.230.241.39]:63850 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946361AbXBCGku (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 01:40:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203064049.FDKH1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 3 Feb 2007 01:40:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Jugp1W00a1kojtg0000000; Sat, 03 Feb 2007 01:40:50 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38553>

I was reading the tutorial and noticed that we say this:

    Also, don't use "git reset" on a publicly-visible branch that
    other developers pull from, as git will be confused by history
    that disappears in this way.

I do not think this is a good explanation.  For example, if we
do this:

(1) I build a series and push it out.

	---o---o---o---j

(2) Alice clones from me, and builds two commits on top of it.

	---o---o---o---j---a---a

(3) I rewind one and build a few, and push them out.

	---o---o---o...j
                    \
                     h---h---h---h

(4) Alice pulls from me again:

	---o---o---o---j---a---a---*
                    \             /
                     h---h---h---h

Contrary to the description, git will happily have Alice merge
between the two branches, and never gets confused.

Maybe I did not want to have 'j' because it was an incomplete
solution to some problem, and Alice may have fixed it up with
her changes, while I abandoned that approach I started with 'j',
and worked on something completely unrelated in the four 'h'
commits.  In such a case, the merge Alice would make would be
very sensible, and after she makes the merge if I pull from her,
the world will be perfect.  I started something with 'j' and
dropped the ball, Alice picked it up and perfected it while I
went on to work on something else with 'h'.  This would be a
perfect example of distributed parallel collaboration.  There is
nothing confused about it.

The case the rewinding becomes problematic is if the work done
in 'h' tries to solve the same problem as 'j' tried to solve in
a different way.  Then the merge forced on Alice would make her
pick between my previous attempt with her fixups (j+a) and my
second attempt (h).  If 'a' commits were to fix up what 'j'
started, presumably Alice already studied and knows enough about
the problem so she should be able to make an informed decision
to pick between what 'j+a' and 'h' do.

A lot worse case is if Alice's work is not at all related to
what 'j' wanted to do (she did not mean to pick up from where I
left off -- she just wanted to work on something different).
Then she would not be familiar enough with what 'j' and 'h'
tried to achieve, and I'd be forcing her to pick between the
two.  Of course if she can make the right decision, then again
that is a perfect example of distributed collaboration, but that
does not change the fact that I'd be forcing her to clean up my
mess.

So I am thinking about rewording the section like this.

Comments?

---

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index ea34189..5fc5be5 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -458,9 +458,9 @@ $ git reset --hard HEAD^ # reset your current branch and working
 Be careful with that last command: in addition to losing any changes
 in the working directory, it will also remove all later commits from
 this branch.  If this branch is the only branch containing those
-commits, they will be lost.  (Also, don't use "git reset" on a
-publicly-visible branch that other developers pull from, as git will
-be confused by history that disappears in this way.)
+commits, they will be lost.  Also, don't use "git reset" on a
+publicly-visible branch that other developers pull from, as it will
+force needless merges on other developers to clean up the history.
 
 The git grep command can search for strings in any version of your
 project, so
