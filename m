From: Junio C Hamano <junkio@cox.net>
Subject: Re: Replay on arbitrary branches
Date: Fri, 02 Sep 2005 18:47:08 -0700
Message-ID: <7vwtlydisj.fsf@assigned-by-dhcp.cox.net>
References: <46a038f905090218113587f64f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 03:48:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBN7h-0005BF-Re
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 03:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVICBrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 21:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVICBrK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 21:47:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:62204 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751010AbVICBrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2005 21:47:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050903014709.NKEU18319.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Sep 2005 21:47:09 -0400
To: martin.langhoff@gmail.com
In-Reply-To: <46a038f905090218113587f64f@mail.gmail.com> (Martin Langhoff's
	message of "Sat, 3 Sep 2005 13:11:40 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8032>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Is there a way to replay a merge on a head that GIT considers unrelated? 
>
> I have been playing with exporting to mbox format with
> git-format-patch-script, and applying those to the destination branch.
> However, this drops binary files -- and I _do_ have binary files in
> some of the projects I work on.

I do not think your question has much to do with 'GIT considers
unrelated'.  The 'git resolve' machinery would have the same
problem with related trees, if you do keep track of binary
files, and you are changing them in both branches.  The 3-way
merge resolution step will eventually invoke 'merge' or 'diff3'
and you lose.

About 'unrelated' trees, if you know of a good tree you can use
as a reference point, you could manually emulate what 'git
resolve' does.  Let's say you have project A and project B; for
whatever historical reasons you do not have a common ancestor of
these project master branch heads.

    $ git clone projectA/.git merged
    $ cd merged
    $ git fetch ../projectB/.git master:b

Now refs/heads/master is projectA's head, and refs/heads/b is
projectB's.  They may not be related, but if you know a commit c
that was in some shared past from both projects, you probably
can:

    $ git-read-tree -m -u c master b
    $ git-merge-cache -o git-merge-one-file-script -a

If the resulting tree looks reasonable, you could now commit it
telling 'git-commit-tree' that the parents of the new commit are
master and b, and you practically merged two projects.
