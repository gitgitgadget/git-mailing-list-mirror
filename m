From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 01/12] Introduce Git.pm (v4)
Date: Sat, 24 Jun 2006 01:33:52 -0700
Message-ID: <7vu06bymtr.fsf@assigned-by-dhcp.cox.net>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
	<7vr71f5kzs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 10:34:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu3aX-0005sH-Cy
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 10:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318AbWFXIdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 04:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933321AbWFXIdy
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 04:33:54 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36487 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S933318AbWFXIdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 04:33:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624083352.RHJX22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 04:33:52 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vr71f5kzs.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 23 Jun 2006 19:46:15 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22492>

Junio C Hamano <junkio@cox.net> writes:

> Just to let you know, I already have v3 in my tree which is
> merged in "pu".  With the two fixes I sent you earlier I think
> it is in a good shape to be cooked in "next".
>
> I do not think I'd have trouble applying this new series (I
> would probably start from "master" to apply it and perhaps merge
> or --squash merge it onto pb/gitpm topic branch that has v3 with
> the two fixes I sent you separately) but we will see soon
> enough.

EEEEEEEEEK.

git-fmt-merge-msg failed and git-pull did not notice it and went
ahead to call git-merge with an empty log message.  This screwed
up my tree rather big way.

The reason it failed?  Well, it could not find Git.pm because
the changes to fmt-merge-msg was done for distros not for people
who install under their home directories.

Now, I am quite unhappy about the situation (and it is not your
fault).  "git pull" is something almost everybody uses, and
having the series means they would need to make sure whereever
Git.pm is installed is on their PERL5LIB as things currently
stand.

In the case of git-merge-recursive.py, Fredrik does

	sys.path.append('''@@GIT_PYTHON_PATH@@''')

and while running test this invalid path is overridden by having
PYTHONPATH environment variable.  Since it is "append", the test
picks up the freshly built version, not the version from the
previous install (i.e. PYTHONPATH environment variable wins).

So you would probably want to have something like

	use lib '@@GIT_PERL_PATH@@';

inside git-fmt-merge-msg.perl, which will be turned into

	use lib '/home/junio/some/where/you/install/pm';

in git-fmt-merge-msg and things might start working.

... gitster mumbles something in his mouth, and in a puff of
smoke Merlyn appears and solves all our Perl problems ;-) ...
