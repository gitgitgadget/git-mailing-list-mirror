From: Junio C Hamano <gitster@pobox.com>
Subject: Is this an acceptable workflow in git-svn, or a user error?
Date: Sat, 09 Jun 2007 12:10:37 -0700
Message-ID: <7vy7itdjv6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 21:10:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx6Kf-0003US-CU
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 21:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189AbXFITKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 15:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758143AbXFITKj
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 15:10:39 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:35278 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758086AbXFITKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 15:10:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609191036.XCUP12556.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 9 Jun 2007 15:10:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9XAd1X00W1kojtg0000000; Sat, 09 Jun 2007 15:10:38 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49606>

Suppose you are interacting with svn://some.where/ and you want
to have a public git://my.svn/mirror.git maintained with your
effort for others to consume.  I am wondering if the following
workflow, especially the push part, is kosher.

----------------------------------------------------------------
0. Priming the process

$ (mkdir mirror.git && cd mirror.git && git init)

$ mkdir private.git && cd private.git && git init
$ git svn init svn://some.where/
$ git push ../mirror.git/ refs/heads/master:refs/heads/master

After this step, mirror.git would be in-sync with the SVN; we
haven't done any of our own development yet.

1. Hack away

$ edit/git-add/etc.
$ git commit

2. Publish the result

git push ../mirror.git/

3. Re-sync with SVN

$ git svn dcommit
----------------------------------------------------------------

I suspect that the above sequence is a user error, in that
re-syncing with SVN using git-svn (either dcommit or rebase)
would need to redo the commits to embed SVN metadata, but the
public mirror now has commits made with git without such
rewriting.  In other words, I suspect that "git push" should
never be done if you made changes on the git side since you
sync'ed with the SVN.

The reason I am asking is that somebody on #git got in a very
confusing situation.  After the Re-sync, "git push" to the
mirror would refuse because it is not a fast forward.  "git
fetch" from the mirror reveals that what after 3. is done, we
see two identically-looking commits, one that was pushed (before
re-sync with SVN) and the other (replaced because of re-sync)
are different.

If that is the case, then I presume that the correct workflow
would be:

1. Hack away
2. Re-sync with SVN
3. Publish the result; do not do anything between 2. and 3.

Is my understanding correct?
