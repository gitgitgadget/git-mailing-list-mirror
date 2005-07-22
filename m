From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 22 Jul 2005 13:39:06 -0700
Message-ID: <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Jul 22 22:39:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw4If-0001rS-Ta
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 22:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVGVUjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 16:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVGVUjL
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 16:39:11 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:23733 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262152AbVGVUjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 16:39:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722203906.SSBU18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 16:39:06 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050722192424.GB8556@mars.ravnborg.org> (Sam Ravnborg's message of "Fri, 22 Jul 2005 19:24:24 +0000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

>> I would use a neutral commit template, only that it should have a
>> neutral prefix as well for the lines to be removed (neither STG nor CG
>> but GIT maybe). The $GIT_DIR/commit-template is fine as a file name.
>
> How about $GIT_DIR/commit-template-`basename $EDITOR`
> Then we could have different templates for vim, emacs, kade etc.

This brings up a point I have been wanting to see discussed,
involving the core people and the Porcelain people [*1*].

I would like to see Porcelains stay compatible when the do not
have to differ.  The commit template [*2*] is one example of
such.  Another example is the "dontdiff/ignore" file Pasky
talked about in a recent commit log in his Cogito tree [*3*].

Porcelains need to agree on what is placed where and used in
what way.

First, I will talk about the "what" part.  I can see there are
various "preference" items we may want to use:

  - commit template (to enforce a certain style)
  - standard "dontdiff/ignore" file.
  - pre-commit hook (to enforce a certain tests to pass)
  - post-commit-hook (sending commit-notification perhaps).
  - environment overrides (COMMITTER_NAME, COMMITTER_EMAIL and
    such).

There may be others.  Many of them would have different origin:

  - Per project.  A project may want to enforce pre-commit hook
    for all participants;

  - Per user.  A user may want to use different environment
    settings for different projects [*4*].

  - Per repository (or work tree).  A user may have more than
    one work tree for the same project, and want to use
    different "preference" items per tree.

Personally, given the nature of GIT being a distributed system,
I do not think something like /etc/git.conf (which suggests "per
system" configuration) makes much sense; except working around a
mailhost name configuration, perhaps.

About the "where" part, one proposal I have off the top of my
head is something like this:

  - Have a directory at the root of the tree, "_git" (I do not
    care about the name at this moment.  The point being it can
    be revision controlled as part of the project and propagate
    to other repositories), to store per-project configuration.

  - Use $GIT_DIR/conf/ as a convention to store per repository
    configuration files.  This does not propagate with
    pulls/pushes/merges across repositories.

  - Use $HOME/.gitrc (could be a directory or a file in .ini
    style like StGIT uses -- again, I do not care about the
    details at this moment) to store per-user configuration.

Which configuration is read first, what can be overridden, and
if the configuration is cumulative would be specific to each
preference item, I suspect.  Some project may not want a user to
override the pre-commit hooks, for a bad example.  But normally
the per-repository one would take precedence over per-user one
which in turn would take precedence over per-project one.


[Footnotes]

*1* Technically this does not involve the core at all, but the
core people can act as objective, Porcelain-neutral referees.
They'll need to know the outcome of the discussion anyway, since
they are the ones that end up maintaining the Porcelain-neutral
tutorial document.

*2* Unless we are talking about the kind that shows and lets you
edit the diff to be committed, which somebody else's Porcelain
may support, that is.

*3* .gitignore in the cwd is used in Cogito, if I am not
mistaken.

*4* E.g. I would commit for GIT project with junkio@cox.net
while using junio@twinsun.com for my day-job projects.
