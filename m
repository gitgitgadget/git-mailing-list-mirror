From: Junio C Hamano <junkio@cox.net>
Subject: Re: reducing line crossings in gitk
Date: Sat, 11 Jun 2005 11:26:24 -0700
Message-ID: <7v8y1gvjfz.fsf@assigned-by-dhcp.cox.net>
References: <17066.53047.660907.453399@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 20:22:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhAcN-0000nc-RM
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 20:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVFKS0c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 14:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVFKS0c
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 14:26:32 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:46057 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261773AbVFKS00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 14:26:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611182623.NQWH23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Jun 2005 14:26:23 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17066.53047.660907.453399@cargo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Sat, 11 Jun 2005 21:47:03 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PM" == Paul Mackerras <paulus@samba.org> writes:

PM> I could add a heuristic to look for this case and reverse the order of
PM> the parents, which would reduce the line crossings and make the graph
PM> look neater.  Would this be worth the slight loss of information (in
PM> that the stuff pulled in would no longer always be to the right)?

Personally I find the current "crossing lines" display makes
what happened more visually obvious than "reverse order of the
parents", so I'd be happier if you keep things as they are.

Thanks for a wonderful tool.  May I ask for more?  Some are
minor UI enhancements, some are feature ideas.

 - The first time I tried it from somewhere random without
   having GIT_DIR environment, it just gave error and exited.
   Which is correct but could have been nicer.

   Adding a "Browse Repo" in the "File" menu to let the user
   switch which repository to browse (and when chosen start
   afresh, of course) would be nicer, while keeping the default
   of showing the current ${GIT_DIR:=.git} upon start-up.

 - What support from the core GIT side would you need if you
   wanted to let users browse a remote repo?  A way to inspect
   what is under ".git/refs/" hierarchy on the remote side?
   Anything else?

 - Pasting into the SHA1 field to "Go To" was a nuisance when
   the field already had a string in it.  Clearing the SHA1
   field when focus gets in would be one way to solve it, but
   then you would lose the way to pasting out of that field, so
   I do not know what to suggest offhand.

 - How do I "Find" backwards?  Not being able to find a way to
   do this was the most annoying thing for me.

 - After typing something in "Find" and hitting <ENTER>, if the
   focus stays in it and lets me hit <ENTER> again to go to the
   next one would be nicer.  Somehow hitting <ENTER> again would
   not do this for me right now.

 - Indicaing "Find" wrapping around without annoying the user
   too much (i.e. I do _not_ want you to add "Find reached the
   beginning of time, wrapping around and continuing from the
   top" pop-up window) would be nicer.  Currently I can tell by
   looking at the scrollbar on the history pane jumping back, so
   this is not a big issue, though.

 - Can I have a way to "Find" next commit that touches a given
   pathname?

    $ git-rev-list | git-diff-tree -s -r --stdin '<that pathname>'

   which would give you a sequence of lines that look like:
       "commit-SHA1 (from parent-commit-SHA1)"

   you would pick the commit-SHA1 from the output and jump to it.

 - In addition to "Find" which looks at the commit message, can I
   have one that uses pickaxe to find changes?

   Add a new choice "In Patch" to the list of choices ("All
   fields", etc); sorry, but currently pickaxe can only do exact
   matches.  When you are operating in that mode, run

    $ git-rev-list | git-diff-tree -s -r --stdin -S'<that string>'

   which would give you a sequence of lines that look like:
       "commit-SHA1 (from parent-commit-SHA1)"

   you would pick the commit-SHA1 from the output and jump to it.

 - Can I have an option to use diffcore options to tweak the
   diff that is shown in the lower-left pane?

   Add "Diff" menu next to "File" menu, and have the following
   options: "Find Renames", "Find Copies", "Find Rewrites".

   The first two are mutually exclusive so you can have (1) both
   off, (2) Renames, or (3) Copies.  "Rewrites" is independent,
   so you end up with 6 combinations.  Give "-M", "-C", and "-B"
   option to git-diff-tree you run on the commit when these
   "Find foo" options are in effect, respectively.

   A good test case in GIT repository itself to try these are:

    418aaf847a8b3ffffb4f777a2dd5262ca5ce0ef7 (for -M)
	This renames rpull.c to ssh-pull.c etc.  Four renames in
	total.

    7ef76925d9c19ef74874e1735e2436e56d0c4897 (for -C)
	This creates git-fetch-script out of git-pull-script
        by copying.

    6af1f0192ff8740fe77db7cf02c739ccfbdf119c (for -B)
	This rewrites ls-tree.c

This list is based on gitk-1.1 (I downloaded this morning) so you
may already have unpublished solutions.

