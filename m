From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-checkout and SUBDIRECTORY_OK='Yes'
Date: Fri, 23 Dec 2005 09:56:16 -0800
Message-ID: <7vwthv7l4v.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512222217040.6812@gheavc.wnzcbav.cig>
	<7virtge7fb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Nelson <jnelson-git@jamponi.net>
X-From: git-owner@vger.kernel.org Fri Dec 23 18:56:37 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Epr9c-0008UV-NS
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 18:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030581AbVLWR4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 12:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbVLWR4T
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 12:56:19 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:23965 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030581AbVLWR4S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2005 12:56:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051223175532.WPRQ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Dec 2005 12:55:32 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13996>

Junio C Hamano <junkio@cox.net> writes:

> Jon Nelson <jnelson-git@jamponi.net> writes:
>
>> Is it safe to set SUBDIRECTORY_OK='Yes' in git-checkout.sh?

> This patch *might* work, or it may not...

I've done some tests and it seems to work (it is in the
proposed updates branch).

In git.git working tree, here is what happens:

	$ git checkout pu			;# start from pu
        $ cd Documentation
        $ echo >>git-daemon.txt			;# smudge
        $ git checkout -- git-daemon.txt	;# restore
	$ git diff -r --name-status		;# no change
        $ git checkout master git-daemon.txt	;# pick from tree
	$ git diff master -r --name-status	;# (1)
	$ git diff -r --name-status		;# (2)
	$ git diff pu -r --name-status          ;# (3)
        M	Documentation/git-daemon.txt

    (1) does not show any because it did take the file out of master
        branch, and git-daemon.txt is the only file different under
        Documentation/ between master and pu.

    (2) does not show any because "checkout master git-daemon.txt"
        updated the path both in index and working tree.

    (3) shows the path indeed is different between master and pu.

The change relies on ls-tree showing full paths regardless of
where it gets started (because the output is fed to --index-info
form of git-update-index).  If we are going to take the "ls-tree
prefix truncation" patch from Linus, either we also need to
update "git-update-index --index-info" to match this.
