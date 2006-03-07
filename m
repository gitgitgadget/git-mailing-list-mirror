From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pulling tags from git.git
Date: Tue, 07 Mar 2006 10:10:01 -0800
Message-ID: <7vr75ejfd2.fsf@assigned-by-dhcp.cox.net>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>
	<4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>
	<440D5285.3050401@op5.se> <7voe0ilf25.fsf@assigned-by-dhcp.cox.net>
	<440D7A7D.8070507@op5.se> <440D9AB0.4070305@gmail.com>
	<440DA82D.3060909@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 19:10:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGgdP-0006Tm-09
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 19:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWCGSKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 13:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWCGSKF
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 13:10:05 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57241 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751434AbWCGSKE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 13:10:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060307180809.DEBJ20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Mar 2006 13:08:09 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <440DA82D.3060909@op5.se> (Andreas Ericsson's message of "Tue, 07
	Mar 2006 16:35:09 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17344>

Andreas Ericsson <ae@op5.se> writes:

> Imagine Linus, getting his "please pull" emails and doing so only to
> find dozens of temporary tags fetched by the pull. Junio's patch (if I
> read it correctly) unconditionally fetches *ALL* tags reachable from
> the top of the commit-chain, which means there is no longer any way to
> keep temporary tags in a repo from which someone else will pull.

I thought we made fetch made by such a promiscous pull not to
follow tags, so that wouldn't be a problem.  Tag following is
only to happen when you track other's branches.  That is:

	$ git pull git://git.kernel.org/pub/scm/git/git.git master

would store my "master" branch tip only in your .git/FETCH_HEAD and
you merge it immediately, without following my tags, while:

	$ git pull git://git.kernel.org/pub/scm/git/git.git master:origin

(which is what you get by "git pull" without arguments) would
follow my tags, because you are storing the branch head into
your local branch "origin".

> I for one riddle my repos with temporary tags whenever I'm trying
> something I'm not so sure of, or find an interesting bug or a design
> decision I'm not 100% sure of. Perhaps I should rather do this with
> branches, but imo branches are for doing work, whereas tags just mark
> a spot in the development so I easily can find them with gitk or some
> such.

I also have many throwaway unannotated tags.  Whenever I have a
WIP that I want to split up or reorder, I tag the tip of that
topic branch with "git tag anchor-blah" tag, rewind the tip to
the commit before the one I want to redo, and then do this
repeatedly:

	$ git diff -R anchor-blah >P.diff
        $ ... edit P.diff to keep the part I want to apply first
        $ git apply --index P.diff
        $ ... maybe edit a bit further
        $ git commit

until there is no difference between the rewound-and-redone tip
and anchor-blah other than whatever clean-ups I do during the
above cycle.  Propagating such throw-away tags is not very
useful.  And I think it is reasonable to say that throw-away
tags tend to be unannotated.
