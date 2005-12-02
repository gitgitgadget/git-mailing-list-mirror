From: Junio C Hamano <junkio@cox.net>
Subject: Re: More merge questions (why doesn't this work?)
Date: Fri, 02 Dec 2005 02:12:42 -0800
Message-ID: <7vacfj6c4l.fsf@assigned-by-dhcp.cox.net>
References: <7vek4xsx49.fsf@assigned-by-dhcp.cox.net>
	<20051202091946.1631.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 11:15:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei7uv-0008SU-Rj
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 11:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVLBKNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 05:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbVLBKNK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 05:13:10 -0500
Received: from fed1rmmtai09.cox.net ([68.230.241.50]:8878 "EHLO
	fed1rmmtai09.cox.net") by vger.kernel.org with ESMTP
	id S932548AbVLBKNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 05:13:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202101213.HUAH3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Dec 2005 05:12:13 -0500
To: linux@horizon.com
In-Reply-To: <20051202091946.1631.qmail@science.horizon.com>
	(linux@horizon.com's message of "2 Dec 2005 04:19:46 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13113>

linux@horizon.com writes:

> Which should be case 10 of the t/t1000-read-tree-m-3way.sh
> table and succeed.

Yes.  The reason is git-read-tree's behaviour was changed
underneath while octopus was looking elsewhere ;-).  See
Documentation/technical/trivial-merge.txt, last couple of
lines.

There are two schools of thoughts about "both sides remove"
(case #10) case.  Some people argued that "the branches might
have renamed that path to different paths and might indicate a
rename/rename conflict" (meaning read-tree should not consider
it trivial, and leave that to upper level "policy layer" to
decide).  merge-one-file policy simply says "no, they both
wanted to remove them".  If I recall correctly, read-tree itself
merged this case before multi-base rewrite happened (if you are
curious, run 'git whatchanged -p read-tree.c' and look for
"Rewrite read-tree").

> 1) The MAJOR difference between "git checkout" and "git reset --hard"

True.  "git reset --hard" should be used without <rev> by
novices and with <rev> after they understand what they are
doing (it is used for rewinding/warping heads).

> 2) Don't use "git branch" to create branches, unless you really
>    *don't* want to switch to them.  Use "git checkout -b".

Because...?  "git branch foo && git checkout foo" may be
suboptimal to type, but it is not _wrong_; it does not do
anything bad or incorrect.

> 3) Dumb question: why does "git-commit-tree" need "-p" before the
>    parent commit arguments?  Isn't just argv[2]..argv[argc-1]
>    good enough?

1. Why not?

2. I myself wondered about it long time ago.

3. It does not matter; nobody types that command by hand.

4. It allows us to later add some other flags to commit-tree
   (none planned currently).

> 4) If the "git-read-tree" docs for "--reset", does "ignored" mean
>    "not overwritten" or "overwritten"?

That sentence is very poorly written; a better paraphrasing is
appreciated.

	$ git whatchanged -S--reset \
        	read-tree.c Documentation/git-read-tree.txt 

shows logs for 438195ccedce7270cf5ba167a940c90467cb72d7 commit
(run "git-cat-file commit 438195cc" to read it).  It ignores
existing unmerged entries when reconstructing the index from the
given tree ("git-read-tree -m", given an unmerged index, refuses
to operate, but "--reset" *ignores* the unmerged ones hence it
does not refuse to operate).

> 5) The final "error" message on "git-merge --no-commit" is a bit
>    alarming for a newbie who uses it...

First of all, --no-commit is not meant to be used by newbies,
but you are right.  Patches to make the failure message
conditional are welcome.  It should switch on these three cases:

 - "--no-commit" option is given, but a merge conflict would
   have prevented autocommit anyway;

 - "--no-commit" option is given, but automerge succeeded;

 - conflict prevented autocommit.

> 6) The "pickaxe" options are being a bit confusing, and the fact they're
>    only documented in cvs-migration.txt doesn't help.

Docs of git-diff-* family have OPTIONS section, at the end of
which refers you to the diffcore documentation.  Suggestions to
a better organization and a patch is appropriate here.

> 7) The git-tag man page could use a little better description of -a.

Please.  It should have the same "OPTIONS" section as others do.
