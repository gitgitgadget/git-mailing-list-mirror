From: carbonated beverage <ramune@net-ronin.org>
Subject: t9106 failure, bisect weirdness
Date: Mon, 19 Nov 2007 15:06:01 -0800
Message-ID: <20071119230601.GA15624@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 20 00:07:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuFiW-0003qh-J2
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 00:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbXKSXHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 18:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbXKSXHK
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 18:07:10 -0500
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:59649 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbXKSXHH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 18:07:07 -0500
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JRS00439064NY20@l-daemon> for git@vger.kernel.org; Mon,
 19 Nov 2007 16:06:04 -0700 (MST)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
 by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JRS009HF06349A0@pd2mr5so.prod.shaw.ca> for
 git@vger.kernel.org; Mon, 19 Nov 2007 16:06:05 -0700 (MST)
Received: from prophet.net-ronin.org ([70.67.106.153])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JRS0081F062JJ30@l-daemon> for git@vger.kernel.org; Mon,
 19 Nov 2007 16:06:03 -0700 (MST)
Received: from ramune by prophet.net-ronin.org with local (Exim 4.50)
	id 1IuFgn-0004Af-TI	for git@vger.kernel.org; Mon, 19 Nov 2007 15:06:01 -0800
Content-disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65516>

Hi all,

Just checked out v1.5.3.6 from git, built it on a Debian/stable i386 box,
and got a failure in one of the test suites:

*** t9106-git-svn-dcommit-clobber-series.sh ***
*   ok 1: initialize repo
*   ok 2: (supposedly) non-conflicting change from SVN
*   ok 3: some unrelated changes to git
* FAIL 4: change file but in unrelated area

                test x"`sed -n -e 4p < file`" = x4 &&
                test x"`sed -n -e 7p < file`" = x7 &&
                perl -i -p -e 's/^4$/4444/' file &&
                perl -i -p -e 's/^7$/7777/' file &&
                test x"`sed -n -e 4p < file`" = x4444 &&
                test x"`sed -n -e 7p < file`" = x7777 &&
                git commit -m '4 => 4444, 7 => 7777' file &&
                git svn dcommit &&
                svn up tmp &&
                cd tmp &&
                        test x"`sed -n -e 4p < file`" = x4444 &&
                        test x"`sed -n -e 7p < file`" = x7777 &&
                        test x"`sed -n -e 58p < file`" = x5588 &&
                        test x"`sed -n -e 61p < file`" = x6611

*   ok 5: attempt to dcommit with a dirty index
* failed 1 among 5 test(s)
make[1]: *** [t9106-git-svn-dcommit-clobber-series.sh] Error 1
make[1]: Leaving directory `/home/ramune/src/git/git/t'
make: *** [test] Error 2
ramune/lycaeum:git:

Bisecting gives me:

fb159580a1628947f0a088e24cfe6fe4c81d99d0 is first bad commit
commit fb159580a1628947f0a088e24cfe6fe4c81d99d0
Author: Eric Wong <normalperson@yhbt.net>
Date:   Mon Nov 5 03:21:48 2007 -0800

    git-svn: t9114: verify merge commit message in test

    It's possible that we end up with an incorrect commit message
    in this test after making changes to fix the clobber bug
    in dcommit.

    Signed-off-by: Eric Wong <normalperson@yhbt.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:040000 040000 1c4f3776c031f9531869e736b661a0559fab5ff6 4f4c5ecd6c79f7e9732b554e2f8dd536a8a8f2a6 M      t

Which seems odd -- the previous commit (marked good, because make test didn't
fail) was the one that modified t9106-git-svn-dcommit-clobber-series.sh.

I tried running the test manually and noticed something weird as well:

ramune/lycaeum:t: sh t9106-git-svn-dcommit-clobber-series.sh
*   ok 1: initialize repo
*   ok 2: (supposedly) non-conflicting change from SVN
*   ok 3: some unrelated changes to git
*   ok 4: change file but in unrelated area
* passed all 4 test(s)
ramune/lycaeum:t:
ramune/lycaeum:t: pwd
/home/ramune/src/git/git/t
ramune/lycaeum:t:
ramune/lycaeum:t: sh t9106-git-svn-dcommit-clobber-series.sh
*   ok 1: initialize repo
*   ok 2: (supposedly) non-conflicting change from SVN
*   ok 3: some unrelated changes to git
* FAIL 4: change file but in unrelated area

                test x"`sed -n -e 4p < file`" = x4 &&
                test x"`sed -n -e 7p < file`" = x7 &&
                perl -i -p -e 's/^4$/4444/' file &&
                perl -i -p -e 's/^7$/7777/' file &&
                test x"`sed -n -e 4p < file`" = x4444 &&
                test x"`sed -n -e 7p < file`" = x7777 &&
                git commit -m '4 => 4444, 7 => 7777' file &&
                git svn dcommit &&
                svn up tmp &&
                cd tmp &&
                        test x"`sed -n -e 4p < file`" = x4444 &&
                        test x"`sed -n -e 7p < file`" = x7777 &&
                        test x"`sed -n -e 58p < file`" = x5588 &&
                        test x"`sed -n -e 61p < file`" = x6611

* failed 1 among 4 test(s)

So it succeeds once, then fails.

/bin/sh is dash 0.5.3-7 from Debian.

Any additional information needed?

-- DN
Daniel
