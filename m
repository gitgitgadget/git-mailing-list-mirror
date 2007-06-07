From: linux@horizon.com
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: 7 Jun 2007 00:36:32 -0400
Message-ID: <20070607043632.31891.qmail@science.horizon.com>
To: git@vger.kernel.org, godeater@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 07 06:36:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw9jl-0004A7-4s
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 06:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbXFGEge (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 00:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbXFGEge
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 00:36:34 -0400
Received: from science.horizon.com ([192.35.100.1]:13961 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752024AbXFGEge (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 00:36:34 -0400
Received: (qmail 31893 invoked by uid 1000); 7 Jun 2007 00:36:32 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49349>

There's no reason that git can't do everything you have svn doing.
What SVN calls "commit access" is what git refers to as "push access",
but it's exactly the same thing.  I don't see how it's the tiniest bit
more difficult.

The only difference is that in git, it's a two-stage process: you commit
locally, and then push that commit (or, more commonly, a whole chain of
commits) when it's ready.  But to the receiving repository, it's just
another commit.

You can have a central server, just like you have with SVN, and when it
gets new versions, it can auto-build them and do whatever it likes with
the binaries.  (Including stick them in the same git repository, or
a different one.)

There's no need for such a central repository to be "owned" by one particular
person.  You can have a shared repository with multiple people having commit
access.  Linus likes to keep very tight security over his master repoisitory
and only pull, but git supports a shared-access repository just fine.

The only thing, and it's not a very big thing, is that if you want
fine-grained access control, you have to implement it yourself via the
pre-receive hook rather than having a canned implementation ready.


As for making a binary of every commit, git encourages a slightly
different workflow:
- Because commits are very easy, and private (until pushed), you're
  encouraged to make lots of small commits.  I used to hold of committing to
  CVS if working on a big patch.  Now, I use git freely on a private branch
  to keep track of my own hacking.
  (git-gui is nice for encouraging me to commit frequently.  As I make
  edits, I write the commit message and watch the patch grow.  When it
  gets big enough, click "commit" and keep going.  I have a perfectly good
  memory, but after three phone calls, two "just a quick question"s and
  an impromptu meeting, the notes make it quicker to get back into it.)
- If you later decide the commits aren't something you want to show the world,
  then don't.  You can cherry-pick the good ideas and kill the lousy ones.
- The simplest example of this is "git commit --amend".  Git lets you
  commit before testing, and if you find some stupid typo that prevents
  the code from even compiling, you can just fix it and re-do the commit.
  *Poof*, your embarassing mistake just disappeared.
  (When learning git merges, it took me a log time to get over my fear of
  committing a mis-merge.  With git, it doesn't matter; it's just as
  easy to undo a commit as to do one, as long as you haven't published
  the results.)

- On the other hand, if you want to enjoy the full benefits of git-bisect,
  which can let J. Random Bug-submitter find the commit that caused a
  regression while you eat chilled grapes on the beach, you want both
  small commits and commits that don't break the build.  So cleaning up
  your history before publishing can be a very worthwhile effort.
  This is a step that many people aren't used to doing, and you don't
  need to force it on your developers.  Linus has long required such
  efforts, to make code review easier, but there are different traditions.
  But it really does make tracking down bugs a lot easier.


Anyway, because of the small-commit tendency, you might want to only
build one binary per push, not one binary per version.  (Oh, I should
note that it is perfectly legal to push an old version that the receiving
repository already has.  It has no effect on the repository, but you
could have it tickle your autobuilder.  Check with someone who knows
whether git even runs the commit hooks in that case, though.)

But you can do whatever.  git-archive is a useful little tool for getting
source snapshots to compile.

Once you've built the binary, you can, if you like, put it into a git
branch by itself.  You could even put it in the same repository as the
sources, but with a totally disjoint history, but if you never intend
to merge the branches, that just complicates your life and increases
the chance that somebody will clone that branch.  It makes more sense
to use a separate repository.
