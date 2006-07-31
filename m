From: Junio C Hamano <junkio@cox.net>
Subject: (unsolicited hint) resolving conflicts early
Date: Mon, 31 Jul 2006 00:19:00 -0700
Message-ID: <7vac6q9r8b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 31 09:19:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7S3P-00011S-Bq
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 09:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWGaHTD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 03:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWGaHTD
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 03:19:03 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38058 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964773AbWGaHTB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 03:19:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731071901.TIAS12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 03:19:01 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24498>

In a work flow that employs multiple topic branches, sometimes I
find that unrelated topics need to touch the same area of the
code, or they do not have textual conflicts but still have
semantic interactions.  The topic branch workflow wants you to
merge each topic at least twice (once while testing and another
time when you declare topic to be ready), which means you would
need to resolve the same conflict at least twice.

Here is a trick I've been using to deal with such a case.

A quick refresher course of "topic branch" workflow:

 - you branch off from your primary branch (typically "master")
   and create one branch per development topic.

 - your development takes place on the topic branches.

 - each topic can (and should) be tested alone, but you would
   want to test them as a whole in order to make sure your
   topics mesh together well.  Typically you use a branch other
   than your primary branch to merge them all and use the result
   for testing.  Depending on your taste, this test branch could
   be throw-away, or long lived (e.g. my "pu" is throw-away, as
   opposed to "next" which is a long-lived test branch).

 - When a topic becomes fully cooked, you merge it into your
   primary branch.

When two logically independent topics need to touch the same
area of code, or have semantic interactions that do not
necessarily involve textual merge conflicts, they need to be
resolved when the topics are merged into the test branch.

You would not know which topic becomes ready to be merged to
your primary branch first, but eventually you would want to have
both of them graduate to your mainline.  So when you merge the
second topic into your mainline, you would need to resolve the
same conflict you resolved when you merged it to the test branch.

However, it is not easy to "reuse" the merge resolution.  rerere
helps you reuse textual conflict resolution, but fixups needed
that do not involve textual conflicts are not handled by
"rerere".

For example, I have "lt/setup" that restructures calls to
setup_git_directory(), and "js/mv" that introduces a new
built-in implementation of "git mv".  They both touch the
command table in git.c which causes textual conflicts, and the
former changes the calling convention of all built-in command
implementations, so builtin-mv.c::cmd_mv() (which does not have
any textual conflict) needs to be modified when these two
branches are used together.

The way I solve this is to use the third branch ("conflict
resolution branch between the two topic branches").  You branch
this off of one of the topic branches and merge in the other,
and resolve conflicts there.  For example, I have __/setup-n-mv
branch which merges lt/setup and js/mv, and that branch is what
is merged into "next" (the test branch):

	$ git checkout -b __/setup-n-mv lt/setup
        $ git pull . js/mv
        ... fix textual merge conflicts here.
	... compile testing reveals that further fixups are needed;
	... fix them up here as well.
	... this can become an "evil merge", or a separate
        ... "fixup" commit can be made in this resolution branch.
	$ git commit -a
	$ git checkout next ; git pull . __/setup-n-mv

When one of the branches is ready to be merged to "master", I
can just do so.  After that, I merge the conflict resolution
branch into the other topic.    This way, when the other one
graduates, the merge conflict is already resolved and the
merging into "master" becomes quite easy.

A good thing here is that it is a lot easier to see what
interactions the topics have while merging them to "next" for
testing than later merging the first and then sometime later
merging the second topic to "master", because the former happens
soon after I take patches to the topic branch (or I work on the
topic myself).  Merging the second branch to "master" happens
much later, at which point I may need to do extra work to
remember the details of what interactions the topics had and
what were needed to resolve them (not just textually but
semantically).

HTH ;-).
