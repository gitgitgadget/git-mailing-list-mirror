From: Junio C Hamano <junkio@cox.net>
Subject: Re: new file leaked onto release branch
Date: Mon, 19 Dec 2005 01:16:05 -0800
Message-ID: <7vvexlh2ga.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056F9395@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@osdl.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 19 10:19:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoH8S-0006CG-SQ
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 10:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbVLSJQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 04:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVLSJQI
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 04:16:08 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64207 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932703AbVLSJQH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 04:16:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051219091608.FIQA25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Dec 2005 04:16:08 -0500
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30056F9395@hdsmsx401.amr.corp.intel.com>
	(Len Brown's message of "Sun, 18 Dec 2005 22:21:53 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13819>

"Brown, Len" <len.brown@intel.com> writes:

> 2. I agree that while #### names may be an area of a potential
>    problem, it may not be related to the observed failure.

I made it a potential problem by mistake and left it so for a
couple of weeks, but there was no reason for #### names to be a
problem.  Even when #### is a unique prefix of a valid object
name, if you have .git/refs/heads/#### branch, that should be
the one that takes precedence over a random object name, and
that is what the fixed code does.  Sorry about the earlier
breakage.

Just please keep in mind that the search order is "tags then
heads" (see sha1_name.c::get_sha1_basic()::prefix[]), so if you
happen to have #### branch *and* tag then you will be merging
the tag with this:

> git checkout test && git merge "Pull #### into test branch" test ####

If the git.merge wrapper you posted earlier is always used to
pull a topic branch, it might be safer to update it to do:

	git checkout "$2" &&
        git merge "Pull $1 into $2 branch" HEAD "refs/heads/$1"

to disambiguate.
