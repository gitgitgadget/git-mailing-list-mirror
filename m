From: Junio C Hamano <junkio@cox.net>
Subject: Should git-prune-script warn about dircache?
Date: Sun, 01 May 2005 03:50:44 -0700
Message-ID: <7vwtqjxlrv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 12:45:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSBwj-0006hU-L1
	for gcvg-git@gmane.org; Sun, 01 May 2005 12:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVEAKux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 06:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVEAKux
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 06:50:53 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:59056 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261585AbVEAKuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 06:50:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501105045.DXFR8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 06:50:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When the user has a change that is recorded in the dircache but
the change has not been committed, git-fsck-cache --unreachable
would report blobs and trees (if you have a subdirectory) that
are involved.

    $ git-init-db
    defaulting to local storage area
    $ date >foo
    $ git-update-cache --add foo
    $ date | git-commit-tree $(git-write-tree) >.git/HEAD
    Committing initial tree 9061076c3ec10fef339c84f4e0c9e06576d3b7db
    $ date >foo
    $ git-update-cache foo
    $ git-fsck-cache --unreachable $(cat .git/HEAD)
    unreachable blob d8c61e975a591ad5905c7defc567a77fca58f092
    $ git-ls-files --stage
    100644 d8c61e975a591ad5905c7defc567a77fca58f092 0 foo

At this point, if we run git-prune-script with the current head,
we would remove the blob, and after that, code that assumes the
objects pointed by SHA1s recorded in the dircache are locally
available start failing.

    $ git-prune-script
    $ touch foo
    $ git-diff-files -p
    .git/objects/d8/c61e975a591....: No such file or directory
    fatal: unable to read blob object for foo (d8c61e975a591....)

I have a feeling somewhere in the chain from git-prune-script we
should have a mechanism to prevent us from losing such blob and
trees.  I know it should not be in git-fsck-cache, but I have
not decided what my suggestions would be for us to do yet.

Maybe a big warning in red ugly bold blinking typeface somewhere
in the doc?

