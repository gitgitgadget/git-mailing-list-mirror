From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Mon, 26 Sep 2005 15:03:47 -0700
Message-ID: <7vr7bba3lo.fsf@assigned-by-dhcp.cox.net>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net>
	<7vaci1nfwa.fsf@assigned-by-dhcp.cox.net>
	<87psqwzs3x.fsf@ualberta.net>
	<7v7jd4n22i.fsf@assigned-by-dhcp.cox.net>
	<1127765852.5735.36.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 00:05:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK14k-00016w-UX
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 00:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVIZWDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 18:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVIZWDw
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 18:03:52 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:45556 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932342AbVIZWDv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 18:03:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926220347.CDVL29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 18:03:47 -0400
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1127765852.5735.36.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Mon, 26 Sep 2005 15:17:32 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9342>

Jon Loeliger <jdl@freescale.com> writes:

There is a small problem in that proposal.  "Merging" in git
does not work that way.  Specifically,

>     # When merging, merge origin, maint and pu into master
>     Merge: master origin maint pu
>     # Merge into master the just the origin bits
>     Merge: master origin

the problem with these is that you may be in your "test" branch
and say "git pull".  'git pull' does not let you say 'pull into
this branch which is not my current branch', and "into master"
part would not work -- merge in git always merges things into
the current branch, so writing

>     # When merging, merge origin, maint and pu into the current
>     Merge: origin maint pu
>     # Merge just the origin bits into the current
>     Merge: origin

may make sense.

Having said that I doubt Octopus is what people do regularly, so
being able to write "Merge: origin maint pu" (or "Merge: ncq
chs-support") as a short-hand makes much sense.

There is not much inherent reason to require that the merge
happens only to the current branch, if we stop using the files
in the working tree for resolving conflicts (either manually or
automatically).  We could rewrite 'git pull' like this:

 - have it take 'merge into this branch' parameter, defaulting
   to the current branch, or your "Merge: <into> <remote>..."
   proposal.

 - if the merge is not to happen in the current branch, then
   use a temporary index file and a temporary working directory
   to do the merge -- when manual conflict resolution is needed,
   ask the user to go to that temporary working directory and
   resolve conflicts there and make commits there.  The
   temporary working directory is actually cheap because we do
   not have to checkout all the paths -- only the paths involved
   in the merge.

I remember the merge Linus originally envisioned would have
worked along the above lines, until he changed his mind around
2a68a8659f7dc55fd285d235ae2d19e7a8116c30 commit, beginning of
June, for 1.0 (ewww, we were already aiming for 1.0 back then).

	http://marc.theaimsgroup.com/?l=git&m=111806925225305&w=2

declared the merge in separate directory is post 1.0 item, and I
tend to agree with that.  Most of the time you will be merging
into the current branch, and otherwise you could make it so by
switching to that branch before pulling.
