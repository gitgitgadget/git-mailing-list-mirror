From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible git-rev-list bug
Date: Sun, 29 Jan 2006 12:15:12 -0800
Message-ID: <7vmzhekcz3.fsf@assigned-by-dhcp.cox.net>
References: <43DC8DDF.6080904@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 21:15:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3IxD-0000Mc-DT
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 21:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWA2UPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 15:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWA2UPP
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 15:15:15 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:60859 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751153AbWA2UPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 15:15:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129201301.GFRK17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 Jan 2006 15:13:01 -0500
To: Marco Costalba <mcostalba@yahoo.it>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15237>

Marco Costalba <mcostalba@yahoo.it> writes:

> $ git-rev-list --max-count=1 --parents addafaf92eeb86033da91323d0d3ad7a496dae83 -- rev-list.c
> addafaf92eeb86033da91323d0d3ad7a496dae83
> d8f6b342ae200b2eb72e2f81afea7fe0d41aec0b
> 93b74bca86f59b8df410b6fd4803b88ee0f304bf
> d8f6b342ae200b2eb72e2f81afea7fe0d41aec0b
> d8f6b342ae200b2eb72e2f81afea7fe0d41aec0b
> 3815f423ae39bf774de3c268c6d3e3b72128a4e5
>
> We have the same parent (d8f6b342ae200b2eb72e2f81afea7fe0d41aec0b) multiple times.

I think it probably is a bug.  The commit really has five
parents that bundle five independent tracks of development.  Two
of them touch the specified path since they forked.  The rest do
not, and for them, the last commit that touched the specified
path is behind where they forked:

                  .---o---.
                 /         \
                .---*---o---.
               /   93b74bc   \
  ---*---o---o-----o---o------o addafaf
     d8f6b34   \             /
                .---o---o---.
                 \         /
                  .---*---.
                      3815f42

The "rev-list.c" path limiter is meant to omit "uninteresting"
commit, so in this case showing only the three parents after
filtering dups would be the right thing to do, I think.

Let me wait for a while to hear Linus contradicts me, though...
