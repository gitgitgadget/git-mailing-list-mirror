From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fixes git-cherry algorithmic flaws
Date: Sat, 23 Sep 2006 18:49:22 -0700
Message-ID: <7virjem3tp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0608071328200.22971@kivilampi-30.cs.helsinki.fi>
	<20060924000051.GI20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 03:49:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRJ7l-0005ci-4N
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 03:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbWIXBtY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 21:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbWIXBtY
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 21:49:24 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:30931 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1752053AbWIXBtX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 21:49:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060924014923.IVYG6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Sep 2006 21:49:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id S1pR1V0011kojtg0000000
	Sat, 23 Sep 2006 21:49:25 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060924000051.GI20017@pasky.or.cz> (Petr Baudis's message of
	"Sun, 24 Sep 2006 02:00:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27643>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Mon, Aug 07, 2006 at 12:30:13PM CEST, I got a letter
> where Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi> said that...
>> Old algorithm:
>>         - printed IDs of identical patches with minus (-) sign; they
>> 	  should not be printed at all
>>         - did not print anything from the changes in the upstream
>>=20
>> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>
>
> Ping? Is this patch bogus or was it just forgotten?

These are not fixes to "algorithmic flaws".  It's more like that
Ilpo is writing a different program to fill different needs, and
I did not see what workflow wanted to have the list of changes
that were in the upstream and our changes.  Maybe what Ilpo
wanted to see was something like "git log upstream...mine"
(three-dots not two to mean symmetric difference).  I dunno.
That operation certainly did not exist when we did git-cherry
originally.

The original purpose of git-cherry (which probably is different
from what Ilpo wanted to have, and that is why Ilpo modified it
into a different program) is for a developer in the contributor
role to see which ones of local patches have been accepted
upstream and which ones still remain unapplied -- the intent is
to help rebase only the latter and keep trying to convince
upstream that these remaining ones are also worth applying.

So minus (-) lines are very much needed to if you want to see
which ones have been accepted.  Plus lines are used to pick
which ones to rebase by older version of git-rebase, but I do
not think we do that anymore.  And in any case we are _not_
interested in whatever happened in the upstream that did not
come from the branch we are looking at.

I suspect we do not use it anywhere anymore.  Maybe we can
remove it?

	... goes and looks ...
	git grep -e git.cherry --and --not -e git.cherry-pick

Nah, no such luck.  One of the documentation suggests that you
drive cvsexportcommit using its output, like this:

	git cherry cvs mine | sed -n -e 's/^\+ //p' |
        xargs -L 1 git-cvsexportcommit -c -p -v

and I can see why cherry is (perhaps slightly) more desirable
than "git rev-list cvs..mine"

So unless we come up with an alternative way to do this, we
cannot change it or drop it.  Not yet.
