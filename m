From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] array index mixup
Date: Sun, 16 Jul 2006 01:50:00 -0700
Message-ID: <7vejwmj5mv.fsf@assigned-by-dhcp.cox.net>
References: <e9aff7$nk1$1@sea.gmane.org> <E1G1jje-0007ey-OA@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 16 10:50:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G22KL-0007sw-Br
	for gcvg-git@gmane.org; Sun, 16 Jul 2006 10:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWGPIuD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 04:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWGPIuD
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 04:50:03 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:35982 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964862AbWGPIuB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jul 2006 04:50:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060716085001.RTRH12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Jul 2006 04:50:01 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G1jje-0007ey-OA@moooo.ath.cx> (Matthias Lederhofer's message
	of "Sat, 15 Jul 2006 14:59:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23947>

Matthias Lederhofer <matled@gmx.net> writes:

> I dunno if this is really an index mixup or was intended.  If this is
> intended please add a comment what it's for.  (Without this you get
> rename information, perhaps this is the reason.)

That is exactly the reason -- it was a temporary workaround
which nobody noticed so far.

The right fix would involve updating diff_resolve_rename_copy so
that it does not rely on the comparison of path names (that
means DIFF_PAIR_RENAME() macro needs to change), and instead
mark the pairs synthesized in diffcore-rename as such, and use
that to tell if a pair is a result of rename/copy [*1*].

Your other patch (not the one to change the index of the array
used for labels, but the one that extracts the pathname out of
the syntax to name a blob by path in an arbitrary tree object)
could be safely applied when that happens.


[Footnote]

*1* If somebody wants to do this, one thing to watch out for is
matching up of broken pairs.  If a pair originally broken by
diffcore-break (because they were dissimilar enough according to
the option given to -B flag) are merged into one by
diffcore-rename (because they were similar enough according to
the option given to -M flag), we should _not_ say the resulting
pair is renamed.  In general, the threashold for breaking should
be lower than diffcore-rename to merge them for a sane use, so
this might be a non-issue in practice, though.
