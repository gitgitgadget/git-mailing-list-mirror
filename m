From: Junio C Hamano <junkio@cox.net>
Subject: Tip of the day: archaeology
Date: Tue, 13 Dec 2005 13:16:04 -0800
Message-ID: <7vpso07l63.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051209215414.14072.qmail@science.horizon.com>
	<7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512120827440.15597@g5.osdl.org>
	<20051212195319.11d41269.tihirvon@gmail.com>
	<Pine.LNX.4.64.0512121010550.15597@g5.osdl.org>
	<86y82qyrqs.fsf@blue.stonehenge.com>
	<20051213035842.GF10371@always.joy.eth.net>
	<86d5k1y7dp.fsf@blue.stonehenge.com>
	<7vzmn5bmlk.fsf@assigned-by-dhcp.cox.net>
	<7vd5k1bf40.fsf@assigned-by-dhcp.cox.net>
	<861x0hxfn2.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 22:17:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmHVM-0005WY-OF
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 22:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVLMVQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 16:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVLMVQI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 16:16:08 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:9101 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932385AbVLMVQG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 16:16:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051213211435.QRX26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Dec 2005 16:14:35 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <861x0hxfn2.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "13 Dec 2005 05:58:41 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13589>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> I see now that grepping "gitignore" shows git-add.sh and
> git-status.sh.  gitignore is indeed doc'ed in git-add.txt, but not in
> git-status.txt.  Must've snuck in recently.  I'm trying to watch
> "git-whatchanged -p Documentation/*", but I miss things sometimes.

Let me grab this opportunity to demonstrate archaeology tools.

    $ git whatchanged --pretty=oneline \
      -S'--exclude-per-directory=.gitignore' git-status.sh

shows the "Big tool rename" commit 215a7ad on Sep 7th had it as
621fa49 blob, and we can see that the revision:

    $ git cat-file blob 621fa49 | grep -B2 gitignore
            git-ls-files --others \
                --exclude-from="$GIT_DIR/info/exclude" \
                --exclude-per-directory=.gitignore |

already had .gitignore support [*1*].  Looking at the big rename
commit, we learn git-status.sh used to be called as
git-status-script:

    $ git-diff-tree -r -M --name-status 215a7ad | grep status.sh
    R093	git-status-script	git-status.sh

Digging further with the old name reveals that it is this commit:

    $ git whatchanged --pretty=oneline \
      -S'--exclude-per-directory=.gitignore' git-status-script
    diff-tree ba966b9... (from 9804b7d...)
    Teach git-status-script about git-ls-files --others
    :100755 100755 1999a66... 1696f23... M	git-status-script
    $ git cat-file blob 1696f23 | grep gitignore
	    --exclude-per-directory=.gitignore |
    $ git cat-file blob 1999a66 | grep gitignore
    $ git log --max-count=1 ba966b9 | head -n 5
    commit ba966b957908248396402acd785d10ba1da07294
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Fri Aug 26 02:12:50 2005 -0700

        Teach git-status-script about git-ls-files --others


[Footnote]

*1* Sometimes I wish we had "cvs co -p" equivalent.

	$ git cat-blob rev path

Perhaps?
