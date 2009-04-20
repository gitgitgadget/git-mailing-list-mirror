From: Marc Weber <marco-oweber@gmx.de>
Subject: top-git, idea .topbase replacing refs/top-bases, implementation
	issues and questions..
Date: Mon, 20 Apr 2009 22:50:23 +0200
Message-ID: <20090420205023.GB2005@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 22:52:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw0TH-0000uh-Bw
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 22:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592AbZDTUub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 16:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbZDTUua
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 16:50:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:42132 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752219AbZDTUua convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 16:50:30 -0400
Received: (qmail invoked by alias); 20 Apr 2009 20:50:27 -0000
Received: from pD9E08622.dip.t-dialin.net (EHLO mail.gmx.net) [217.224.134.34]
  by mail.gmx.net (mp071) with SMTP; 20 Apr 2009 22:50:27 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX19TVTt9TolTyU67ySksEKpD9NgPzBqpCn/h4bC7Cm
	qyZP4vwv4+63JK
Received: by mail.gmx.net (sSMTP sendmail emulation); Mon, 20 Apr 2009 22:50:23 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117032>

introduction:

topgit (tg) is a tool keeping track of patches on top of branches so th=
at you
can work on those patches before comitting them upstream.

So you can do
  tg create dep1 dep2
to make your new topic branch depend on the two branches dep1, dep2.

tg first merges dep1 dep2 into a base. On top of this base you start
comitting your changes. when following upstream a new base is created b=
y
merging the old base with dep1, then dep2 again. The new base is merged
into your topic branch.

This requires keeping track of the base. That has been done by adding a=
n
extra references to .git/refs/top-bases/TG_NAME.
problems: You have to push the branch and the base to the remote
location. If you clone a top git related branch you have to get the
bases as well (tg remote --populate does this for you).

Uwe Kleine-K=C3=B6nig (current maintainer?) has proposed no longer trac=
king
the topgit branch base using a ref but adding antoher .top* file .topba=
se
containing the hash of the base. Neither pushing nor pulling causes
trouble because the base is always contained in the topic branch. So no
need to extra push/ pull contents of that branch. Another benefit of
this change is that you can easily make a top git branch out of an
ordinary branch by adding those 3 files (.topbase, .topmsg, .topdeps).

I don't see any problems implementing this except one. I'm not sure in
which way this has been adressed in the past by topgit:


Have a look at the following illustration:
http://mawercer.de/~marc/tg.svg (32kb).

Imagine two independant clones of a topgit branch (red, green).
Now users run tg update at slightly different points in time. So both
will get a different new base (B2 and B3) of the clone topgit branch.
Now red merges the topic branch (merge 1). Then a third user (blue)
merges that merge (merge 2). If a merge strategy "ours" is used the way
its done for the other .top* files the blue user's base won't know abou=
t
B3.

=46irst merge we have a conflict:

If B3 and B2 are different a merge conflict occurs:
=2Etopbase:
<<<<
hash1
=3D=3D=3D=3D
hash2
>>>>

Now the two bases should be merged to a new base (Bnew).
That new base should be written to .topbase and everything is fine
again?

Is there a way to specify such a merge action:
extract both hashes (easy)
merge them and put the resulting hash back into .topbase.
Of course this merge action must handle merge conflicts in a way which
is similar to what tg already does. tg starts a subshell and asking the
user to fix the conflicts.

Even if there is a nice way to implement this merge action this doesn't
seem to solve all trouble?
The Bnew base is neither part of the red nor the green topic branch.
Thus it can't be pushed somewhere by pushing red or green only
containing the ref in .topbase?

So in the end:
Have I missed a point ?

So are there more  advantages having a self contained top git branch
compared to beeing able to merge bases?

Maybe merging bases doesn't occur that often in practise?

So if we don't want to give up beeing able to merge bases I=20
till want to see a git push branch command also pushing the base.
Currently you can do $git push which will push *all* bases and branches=
=2E

Probably I've missed some small details while explaining this idea and
talking about its issues. So please do ask.

Sincerly
Marc Weber
