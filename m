From: Junio C Hamano <junkio@cox.net>
Subject: Re: bisect ends with a commit marked good and bad
Date: Wed, 15 Feb 2006 00:01:01 -0800
Message-ID: <7vpslpm4oy.fsf@assigned-by-dhcp.cox.net>
References: <E1F9Gwm-0001Dy-3b@approximate.corpus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 09:01:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Hb1-00026I-95
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 09:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423026AbWBOIBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 03:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423028AbWBOIBD
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 03:01:03 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:42188 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1423026AbWBOIBC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 03:01:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060215075940.JNVO20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 02:59:40 -0500
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
In-Reply-To: <E1F9Gwm-0001Dy-3b@approximate.corpus.cam.ac.uk> (Sanjoy
	Mahajan's message of "Wed, 15 Feb 2006 02:19:32 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16219>

Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk> writes:

> How would I use gitk to show the those three good and three bad commits,
> and their spanning tree?  Neither the man entry nor the examples of its
> use in git-bisect taught me enough to use it properly.

The way bisect narrows down bug hunting is to find a single
regression.  IOW, the only question you can ask bisect is "this
older one was known to be good, but somehow this new one is bad.
If it was caused by one bug introduced somewhere during the
course of changes between the two, which one is it?"

So you always start by giving one good and one bad (or one bad
and one good, the order does not matter).  That leaves * as
suspects.

    o---o---O---*---*---*---*---X---o
         \             /
          *---*---*---*

        O (good) X (bad)

Since it is finding a single regression, o commits are
irrelevant.  commits after bad one X may have fixed the bug but
you are not interested in it.  Commits before good one O might
have been broken in some other way, but we are looking for a
single regression, so they do not really matter either.

Then bisect suggests you one of (*) commits.  Not at random, but
somewhere midway.

    o---o---O---*---*---*---*---X---o
         \             /
          *---*---*---?

        O (good) X (bad)

If ? is good, then three * suspects are good so you then have to
worry about remaining four * between the first O and X.  That's
how you narrow things down.

You say a2d823bf is bad and 0f442aa2 is good.  However, the
a2d823bf is a proper ancestor of 0f442aa2.  That is, earlier it
was good but now it is good.  As if you are trying to locate the
commit that fixed the bug.  This is an impossible situation for
the bisect.

So your initial input may be truly good and bad commits, but
there might be more than one regression involved.

To look at the graph, you could do something like this:

for r in $good; do git tag good-$r $(git-rev-parse --verify $r); done
for r in $bad; do git tag bad-$r $(git-rev-parse --verify $r); done
gitk $(git-rev-parse $good) $(git-rev-parse --not $bad)

You will notice there is only one bad-* way below all the good-*
ones.  Another possibility is maybe you have your good and bad
swapped?
