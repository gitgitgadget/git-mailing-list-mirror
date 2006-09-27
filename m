From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-split: Split the history of a git repository by subdirectories and ranges
Date: Wed, 27 Sep 2006 03:13:54 -0700
Message-ID: <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
References: <451A30E4.50801@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 12:14:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSWQR-0003Gg-0m
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 12:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965441AbWI0KN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 06:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965509AbWI0KN4
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 06:13:56 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37554 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965441AbWI0KNz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 06:13:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927101355.EKIW21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Sep 2006 06:13:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TNDr1V00J1kojtg0000000
	Wed, 27 Sep 2006 06:13:52 -0400
To: Josh Triplett <josh@freedesktop.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27896>

Josh Triplett <josh@freedesktop.org> writes:

> Jamey Sharp and I wrote a script called git-split to accomplish this
> repository split. git-split reconstructs the history of a sub-project
> previously stored in a subdirectory of a larger repository. It
> constructs new commit objects based on the existing tree objects for the
> subtree in each commit, and discards commits which do not affect the
> history of the sub-project, as well as merges made unnecessary due to
> these discarded commits.

Very nicely done.

> We would like to acknowledge the work of the gobby team in creating a
> collaborative editor which greatly aided the development of git-split.

> from itertools import izip
> from subprocess import Popen, PIPE
> import os, sys

How recent a Python are we assuming here?  Is late 2.4 recent
enough?

> def walk(commits, new_commits, commit_hash, project):
>     commit = commits[commit_hash]
>     if not(commit.has_key("new_hash")):
>         tree = get_subtree(commit["tree"], project)
>         commit["new_tree"] = tree
>         if not tree:
>             raise Exception("Did not find project in tree for commit " + commit_hash)
>         new_parents = list(set([walk(commits, new_commits, parent, project)
>                                 for parent in commit["parents"]]))
>
>         new_hash = None
>         if len(new_parents) == 1:
>             new_hash = new_parents[0]
>         elif len(new_parents) == 2: # Check for unnecessary merge
>             if is_ancestor(new_commits, new_parents[0], new_parents[1]):
>                 new_hash = new_parents[0]
>             elif is_ancestor(new_commits, new_parents[1], new_parents[0]):
>                 new_hash = new_parents[1]
>         if new_hash and new_commits[new_hash]["new_tree"] != tree:
>             new_hash = None

This is a real gem.  I really like reading well-written Python
programs.

When git-rev-list (or "git-log --pretty=raw" that you use in
your main()) simplifies the merge history based on subtree, we
look at the merge and if the tree matches any of the parent we
discard other parents and make the history a single strand of
pearls.  However for this application that is not what you want,
so I can see why you run full "git-log" and prune history by
hand here like this.

I wonder if using "git-log --full-history -- $project" to let
the core side omit commits that do not change the $project (but
still give you all merged branches) would have made your job any
easier?

You are handling grafts by hand because --pretty=raw is special
in that it displays the real parents (although traversal does
use grafts).  Maybe it would have helped if we had a --pretty
format that is similar to raw but rewrites the parents?
