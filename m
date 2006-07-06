From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] further upload-pack/fetch-pack tweaks
Date: Thu, 06 Jul 2006 01:43:18 -0700
Message-ID: <7vejwz6s49.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jul 06 10:44:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyPSG-00030y-BG
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 10:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWGFInU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 04:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWGFInU
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 04:43:20 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:9710 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965109AbWGFInU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 04:43:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060706084319.OPSG985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Jul 2006 04:43:19 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23381>

I was reviewing this issue and have an updated attempt to solve
the issue slightly differently.  I think I have something
working but would like to borrow extra sets of eyeballs.

    From: Junio C Hamano <junkio@cox.net>
    Subject: [PATCH/RFC] upload-pack: stop "ack continue" when we know common commits for wanted refs
    To: Ralf Baechle <ralf@linux-mips.org>
    cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
    Date: Fri, 26 May 2006 19:20:54 -0700
    Message-ID: <7vfyiwi4xl.fsf@assigned-by-dhcp.cox.net>

    When the downloader's repository has more roots than the server
    side has, the "have" exchange to figure out recent common
    commits ends up traversing the whole history of branches that
    only exist on the downloader's side.  When the downloader is
    asking for newer commits on the branch that exists on both ends,
    this is totally unnecessary.

    This adds logic to the server side to see if the wanted refs can
    reach the "have" commits received so far, and stop issuing "ack
    continue" once all of them can be reached from "have" commits.

The idea in the new implementation is to notice that the
downloader sent "have" for an object we do not know about, and
when we already have some "have" from them and some "want" are
still not known if they are already reachable from these
"have"s, we traverse the commit ancestry down to oldest "have"s
so far (this is just a heuristic) to see if all of "want" have
some common ancestor with the other side.  When we know all
"want" can be reachable by some "have" we have seen so far, we
send "ACK continue" when the downloader sends a "have" that we
do not have, to cause the downloader to stop traversing that
futile branch which leads to the root we do not have.  The code
sits near the tip of "pu".

I've started from a clone of git.git repository and tried to
fetch "todo" branch from another clone that does not have
anything but the "todo" branch.  So the downloader has five
extra roots (one for git.git itself, one for gitk, one for
gitweb, and one each for htmldocs and manpages).

        # upstream is just "todo" branch and nothing else
        git clone -n git.git upstream
        cd upstream
        mv .git/refs trash
        mkdir -p .git/refs/heads .git/refs/tags
        echo 'ref: refs/heads/master' >.git/HEAD
        cat trash/heads/todo >.git/refs/heads/master
        git repack -a -d
        cd ..

        # downloader has up-to-date git.git but stale "todo"
	git clone -n git.git downloader
        cd downloader
        git checkout todo
        git reset --hard HEAD~30
        git repack -a -d

        # try downloading things from upstream
        git fetch-pack -k -v ../upstream master 2>/var/tmp/new.out
	git fetch-pack -k -v --exec=old-git-upload-pack \
        	../upstream master 2>/var/tmp/old.out


It does send smaller number of "have"s than the current code,
but I noticed that near the end of transfer, after it gets an
"ACK continue" for a common commit on "todo" branch and an "ACK
continue" for a not-common commit on "master" branch, it keeps
sending the commits that are marked on the fetch-pack side as
COMMON_REF (so the last ref sent is v0.99^0 commit), although
upload-pack has told the downloader that whatever is reachable
from "master" branch are commits both sides agreed are common,
so I suspect it should not go down that path that far to reach
v0.99^0 commit.

I have a feeling that either get_rev() or mark_common() logic is
not marking ancestors of commit that are known to be common
properly.  Does this ring a bell?
