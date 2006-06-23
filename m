From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-merge --squash
Date: Fri, 23 Jun 2006 02:45:25 -0700
Message-ID: <7vd5d09pe2.fsf@assigned-by-dhcp.cox.net>
References: <7virmscl2u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 23 11:45:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtiEE-0003po-4e
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 11:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932973AbWFWJp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 05:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbWFWJp1
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 05:45:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:45517 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932475AbWFWJp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 05:45:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060623094526.VTPW11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 05:45:26 -0400
To: git@vger.kernel.org
In-Reply-To: <7virmscl2u.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 23 Jun 2006 01:50:17 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22403>

Junio C Hamano <junkio@cox.net> writes:

>    If one's habit is to use a sequence of many commits to keep
>    too-finer-grained snapshots, and the result of a squash
>    commit out of such a sequence of commits is a coherent,
>    self-contained unit, then I do not see any reason to
>    discourage that workflow.  I however suspect that people who
>    make such a sequence of "many too-finer-grained commits"
>    would inevitably include changes that do not belong together
>    in in one sequence on a topic branch and end up squashing
>    them together into one resulting commit.  If that is the
>    case, this facility is actively encouraging a bad workflow
>    and we should instead teach them to use StGIT or something
>    saner.

This part of the commentary needs a bit of clarification, as I
realize that I was a bit too negative about this --squash
option.

Suppose you have this bright idea for the new filesystem feature
that involves some VFS layer changes.  Let's call that "frob"
feature, and create a topic branch to develop it in.

	git checkout -b frob linus

Now, when you are done, you would want the result to be
a nice, neat, logical steps.  Perhaps that would introduce
features in a sequence like this:

	[PATCH 1/n] vfs: support f_op.frob_read
	[PATCH 2/n] vfs: support f_op.frob_write
        [PATCH 3/n] ext3: add f_op.frob_read and frob_write
        [PATCH 4/n] ramfs: add f_op.frob_read and frob_write
        [PATCH 5/n] vfat: add f_op.frob_read and frob_write
	...

But would you be able to develop things in a neat sequence like
this?  Probably not.  In practice (I do not do kernel myself, so
I am just speculating), I would imagine you would pick one
filesystem (say ext3) as your initial target, and do the
codepath for frob_read operation from bottom to top (vfs to
ext3), and then do the same exercise for frob_write codepath, to
have something working first. After that, you would start
migrating another fs to your updated vfs layer, and during that
process you would find your earlier changes to the vfs are
insufficient and need further tweaks to support that other fs.
So your topic branch with many little snapshot commits might
end up looking this way (fictional show-branch output):

  ! [linus] linux-2.6.17
   * [frob] vfs: finishing touches to frob_write
  --
   * [frob] vfs: finishing touches to frob_write
   * [frob~1] vfat: final fix to frob_read to make it work
   * [frob~2] vfs: Oops, vfat is special and frob_write needs this hack
   * [frob~3] vfat: fix support frob_write for disk full condition
   * [frob~4] vfat: support f_op.frob_write
   * [frob~5] ext3, ramfs: give frob_read the extra parameter like vfat does.
   * [frob~6] vfat: give frob_read the extra parameter
   * [frob~7] vfs: frob_read needs an extra parameter for vfat.
   * [frob~8] ramfs: add frob_write, that was easy.
   * [frob~9] ramfs: add frob_read, that was easy.
   * [frob~10] ext3: more frob_write, now ext3 works!
   * [frob~11] ext3: starting to add frob_write
   * [frob~12] vfs: support frob_write
   * [frob~13] vfs: enhance frob_read for special case, now ext3 works!
   * [frob~14] ext3: yet more frob_read
   * [frob~15] ext3: more frob_read
   * [frob~16] ext3: starting to add frob_read
   * [frob~17] vfs: support frob_read
  +* [linus] linux-2.6.17

The --squash merge alone would not help sorting out something
like this.  However, you could do something like this to
separate them out and squash:

	git checkout -b temp master
        for c in 17 13 7 1; do git cherry-pick frob~$c; done
        git checkout master
        git pull --sq . temp
        git commit -a -m 'vfs: support f_op.frob_read'
        git checkout temp
        git reset --hard master
        for c in 12 2 0; do git cherry-pick frob~$c; done
        git checkout master
        git pull --sq . temp
        git commit -a -m 'vfs: support f_op.frob_write'
        git checkout temp
        git reset --hard master
        for c in 16 15 14 11 10 5; do git cherry-pick frob~$c; done
        git checkout master
        git pull --sq . temp
        edit to remove changes to ramfs portion
        git commit -a -m 'ext3: add f_op.frob_read and frob_write'
        ...

So in that sense I would imagine --squash is not really useless
in such a situation as I made it sound like, but at the same
time I suspect people might be better off to use tools like
StGIT which are specially designed to support such a workflow if
they were to do this.
