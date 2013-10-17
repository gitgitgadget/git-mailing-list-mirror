From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Thu, 17 Oct 2013 15:09:48 -0400
Message-ID: <201310171909.r9HJ9mxd007908@freeze.ariadne.com>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com> <xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 21:09:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWsxJ-0004L0-NY
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 21:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762495Ab3JQTJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 15:09:53 -0400
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:45437
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755346Ab3JQTJu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Oct 2013 15:09:50 -0400
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id eGPa1m00227AodY56K9pJN; Thu, 17 Oct 2013 19:09:49 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id eK9p1m00M1KKtkw3fK9pZx; Thu, 17 Oct 2013 19:09:49 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r9HJ9mxT007909;
	Thu, 17 Oct 2013 15:09:48 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r9HJ9mxd007908;
	Thu, 17 Oct 2013 15:09:48 -0400
In-reply-to: <xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1382036989;
	bh=8y9EjVGAJeIStgnpCGS6FQ4KqHMx2mGpWEUs/82Ohos=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=f3teCZllaii9iz+/lBhcU1b44nnfmoLOEn9zUtWblEMvl/mogdg8LTsO99nlKDtZ9
	 q2pSYIalybsjOC1Codxd89F5Vi5vStj8XUwFjvLoznnX0/BIyuqN6DbXz+G8DEZFYS
	 ifinOB0UDpKSBTZAAei61kyZ6MN3z5VnPlVnezT9bmSWO39LiPTB6E1QpKlw5rWMX1
	 +w71aUhobECkJ64I9relS8R/uyCRc0jd/vDmk7m+zwyBJnUuU7dxhBsVlf/IUGtQlu
	 3RxjHPzANcQAeYspP+T2g4LWhqbIvQff4dc9p33FKuBkrWuFfgLI2MY8ZQ0dbUY+Ts
	 FTmelNiwhPPiQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236306>

> From: Junio C Hamano <gitster@pobox.com>
> 
> worley@alum.mit.edu (Dale R. Worley) writes:
> 
> > In general, Git commands on a repository with a detached worktree can
> > be executed by cd'ing into the directory containing the .git
> > directory, ...
> 
> Eh?  News to me; it might happened to have appeared to work by
> accident, but that is not by design.

I must admit I've never seen the design (and I personally doubt that
the design has ever been written down).  But at least the following
commands work correctly on a detached worktree if the current
directory contains the .git directory, because I am using them in a
production manner:

    git add
    git cat-file
    git commit
    git commit-tree
    git config
    git gc
    git log
    git ls-tree
    git reset
    git rev-list
    git update-ref

In my situation, the worktree is not, in my mind, dependent on the
repository; the repository is intended to keep backups of the contents
of the directories that are worktree.  Indeed, one could establish
several detached repositories to back up different subsets of the same
worktree.  So it is conceptually natural to execute Git in the
repository directory.  And, after all, the current directory
identifies the repository and the repository contains a pointer to the
worktree.

> Not exporting GIT_DIR variable in sh-setup was done not by accident
> but as a very deliberate design choice, IIRC.

The intention of my change is that it appears that all of the failures
of my use pattern are when the command is implemented by a shell
script, and it appears that all shell scripts initially invoke
git-sh-setup.

The change specifically detects my use pattern and, for the remainder
of the script, changes the use pattern into a pattern closely related
to the one that Junio documents:

 - export GIT_DIR that points at the correct .git directory;

 - GIT_WORK_TREE is left unset

 - set the current directory to the top of the working tree

Perhaps the change should also set GIT_WORK_TREE.  I haven't noticed
setting GIT_WORK_TREE to be necessary for "git filter-branch", but
perhaps that is coincidental.

It seems to me that this change would uniformly support the use
pattern I use without affecting Git's behavior in any other case.

Dale
