From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Re: git-svn: make git-svn commit-diff able to work without explicit arguments
Date: Tue, 02 Jan 2007 14:01:11 -0800
Message-ID: <7vwt45rsuw.fsf@assigned-by-dhcp.cox.net>
References: <459AA31E.5070705@gmail.com>
	<7vr6udtbmv.fsf@assigned-by-dhcp.cox.net>
	<20070102211339.GF17898@hades.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 23:01:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1rh8-0003xU-Lr
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 23:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbXABWBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 17:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbXABWBP
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 17:01:15 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:36240 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964946AbXABWBO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 17:01:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102220113.FDQV16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 17:01:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6N0R1W00l1kojtg0000000; Tue, 02 Jan 2007 17:00:26 -0500
To: Steve =?iso-8859-1?Q?Fr=E9cinaux?= <nudrema@gmail.com>
In-Reply-To: <20070102211339.GF17898@hades.madism.org> (Pierre Habouzit's
	message of "Tue, 2 Jan 2007 22:13:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35827>

Pierre Habouzit <madcoder@debian.org> writes:

> ... and
> sometimes think that in a A--B--C--D and in fact, I'd prefer to have:
>
>   {A,C}--B--D. how is it possible to do that in a not too cumbersome
> way? because that would make sens to work in some scratch branch, and
> then reorganize patches in a saner better way in the master branch.
>
>   But I fail to see how to achieve that without using cumbersome
> export-to-patch then git apply patch and edit logs which is painful and
> not really using git.

First of all, "format-patch and then edit" is a perfectly sane
way to use git.  Any workflow that takes advantage of cheap
branch creatin and cheap resetting of the tip of a branch _is_
"really using git".  It depends on the size of the series you
are redoing, but I do that all the time.

Also cherry-pick, rebase, squash merge are your friends.

If you are on $original branch (which may be your 'master') with
commits A--B--C--D:

	git checkout -b temp HEAD~3 ;# that's A
        git cherry-pick $original~1 ;# that's C
	git checkout $original
        git rebase temp

would make the $original A--C'-B'-D'.  Then:

	git checkout temp ; git reset --hard $original~4 ;# parent of A
	git merge -s squash $original~2 ;# squash A and C'

would prepare you to make a squashed commit out of the two to
the temp branch.  Then:

	git checkout $original
        git rebase --onto temp HEAD~2 ;# that's C'
	git branch -d temp

would give you (A+C)--B'-D' on $original branch.

StGIT would make life even easier for you.  It is designed to
make things like the above simpler.
