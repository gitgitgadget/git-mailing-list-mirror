From: Junio C Hamano <junkio@cox.net>
Subject: Re: new file leaked onto release branch
Date: Wed, 14 Dec 2005 01:39:42 -0800
Message-ID: <7vmzj4yq3l.fsf@assigned-by-dhcp.cox.net>
References: <200512140257.03975.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 10:42:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmT6x-0000T7-Dl
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 10:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVLNJjo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 04:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVLNJjo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 04:39:44 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35768 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932254AbVLNJjo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 04:39:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051214093811.LJKH26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 04:38:11 -0500
To: Len Brown <len.brown@intel.com>
In-Reply-To: <200512140257.03975.len.brown@intel.com> (Len Brown's message of
	"Wed, 14 Dec 2005 02:57:03 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13623>

Len Brown <len.brown@intel.com> writes:

> I'm suspecting that this issue is technically a pilot error of me issuing
> git-updated-index at the wrong time, but perhaps the list
> should be aware of this type of issue.

Merging is so fundamental to git workflow, and it is not
supposed to be prone to pilot errors, so I am puzzled and
very worried, so I am still awake.

Even if you added some file to the index prior to merge, this
sequence:

        $ git checkout one-branch
        $ git add some-file
        $ git pull . another-branch

should *never* succeed.  It should always fail, saying:

        fatal: Entry 'some-file' would be overwritten by merge. Cannot merge.

and I just tried it with both recursive (default) and resolve
merge strategies.  They both do the right thing.

One exception is if you did something like this:

	$ git checkout one-branch
        $ git pull . another-branch ;# oops, merge conflicts!
        $ edit conflicted files and fix
        $ git update-index --add some-file
        $ git commit

You can introduce unrelated changes to commits like that.  Lemme
see what your release.broken looks like.

Gahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh.

Forget about what I said.  Although all of what I said above are
correct, I do not think it applies to your case at all --- these
commits do not appear to be created by git-pull nor git-merge,
and honestly, they look quite bogus.  There is something else
going on.

        $ git cat-file commit 9115a6
        tree da65904b8c0c0bc6c778b39bc25d06e07ca7c82c
        parent 927fe18397b3b1194a5b26b1d388d97e391e5fd2
        parent e4f5c82a92c2a546a16af1614114eec19120e40a
        author Len Brown <len.brown@intel.com> 1133904460 -0500
        committer Len Brown <len.brown@intel.com> 1133904460 -0500

        Auto-update from upstream

        $ git-merge-base 9115a6^1 9115a6^2; git-rev-parse 9115a6^2
        e4f5c82a92c2a546a16af1614114eec19120e40a
        e4f5c82a92c2a546a16af1614114eec19120e40a

What is this "Auto-update from upstream" merge?  It is not a
merge at all, not even a fast forward.  Your branch tip was
927fe1 and the other branch tip e4f5c8 was behind.  In fact, I
just tried it and both of my attempts correctly said "Already
up-to-date.", with or without local changes to the index.

        $ git show-branch --sha1-name --topo-order lenb/merge*
        * [lenb/mergetest] Pull 5165 into release branch
         ! [lenb/mergeother] V4L/DVB (3087) fix analog NTSC for pcHDTV 3000
        --
        +  [927fe18] Pull 5165 into release branch
        +  [1e48396] [ACPI] correct earlier SMP deep C-states on HT patch
        ++ [e4f5c82] V4L/DVB (3087) fix analog NTSC for pcHDTV 3000

        $ git pull . lenb/mergeother
        Already up-to-date.

What do you use to create these "Auto-update" commits?

I think 9115a6 commit should not *even* *exist*.  The merge
between 927fe1 and e4f5c8 should have resulted in "Oh, we are
already up-to-date and they are behind, so there is nothing for
us to do".

Or if your tool somehow records your tree as the second parent
(goes against the usual convention but is a valid thing to do),
it should have resulted in "Updating from e4f5c8... to 927fe1.
Fast forward".

In either case, 9115a6 commit should never have been created in
the first place.

What do you use to create these "Auto-update" commits, and how
can I help you to fix it?
