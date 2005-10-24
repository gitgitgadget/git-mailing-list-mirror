From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFE: git rm
Date: Mon, 24 Oct 2005 13:40:08 -0700
Message-ID: <7virvmodhz.fsf@assigned-by-dhcp.cox.net>
References: <435D2FE0.3060307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 22:41:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU97Q-0008Gk-T7
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 22:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVJXUkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 16:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVJXUkL
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 16:40:11 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:499 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751264AbVJXUkK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 16:40:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024203948.LZQL4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Oct 2005 16:39:48 -0400
To: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10557>

Jeff Garzik <jgarzik@pobox.com> writes:

> It would be nice to say "git rm files..." and have two operations occur:
>
> * list of files is passed to rm(1)
> * list of files is passed to git-update-index --remove

This is not a big problem *if* your index always matches the
HEAD tree (i.e. no intermediate git-update-index in between
commits) --- you can just say "rm -f files..." at the point of
removal, continue your work, and either pass these files from
the command line, or -a flag when running 'git commit'.

Running git-update-index in between commits is a valid thing to
do, and it helps reducing the clutter when viewing 'git diff' to
see what your changes look like since your last update-index.
The workflow would go like this:

    1$ git checkout
    ... work work work

    ... what have I done so far?
    2$ git diff
    ... the intermediate result looks OK, so record what we have
    ... done so far...
    3$ git-update-index --add --remove files...

    ... work work work
    ... go back to step 2 as many times as needed.

    ... now what is the sum of changes since the last commit?
    4$ git diff HEAD

    ... everything looks OK.  record the last bits and commit.
    5$ git-update-index --add --remove files...
    6$ git commit

Previously Linus stated that his index almost always matches the
HEAD tree, and I personally do not do intermediate update-index
ever myself, but I am curious how other people use git [*1*].
If some of you run update-index in between commits, "git rm
files..."  would make a lot of sense.


[Footnote]

*1* Cogito users do not count -- they are supposed to leave
index file manipulation to Cogito's smart.
