From: Junio C Hamano <junkio@cox.net>
Subject: Re: Clone a repository with only the objects needed for a single tag
Date: Wed, 02 Nov 2005 01:20:42 -0800
Message-ID: <7voe53v21h.fsf@assigned-by-dhcp.cox.net>
References: <43681E47.4010203@ust.hk>
	<7vy847y1m2.fsf@assigned-by-dhcp.cox.net> <43687869.7060104@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 10:21:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXEnX-0001jX-20
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 10:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVKBJUo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 04:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVKBJUo
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 04:20:44 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:50425 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964864AbVKBJUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 04:20:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102092020.EEMK9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 04:20:20 -0500
To: Ben Lau <benlau@ust.hk>
In-Reply-To: <43687869.7060104@ust.hk> (Ben Lau's message of "Wed, 02 Nov 2005
	16:27:21 +0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11015>

Ben Lau <benlau@ust.hk> writes:

>  However, it has a problem when involves the gitk/git-log.

That's why I said anything that requires you to have a complete
history would not work.

The shallow repository is by definition a *broken* repository;
the refs are supposed to mean the repository has everything
reachable from them, and many tools rely on that assumption, but
the shallow setup deliberately breaks that assumption, so you
need to be aware of what operations you can and cannot do
without having the full history.  Although using grafts to
cauterize somewhat helps as you discovered, you are operating in
"do it at your own risk" territory.

Having said that, here are the things that *should* work without
having full history (not many):

        . git diff between your index, working tree, and commits
          your shallow setup happens to have.

        . git commit on top of any of the tip of branches your
          shallow copy started out with, including git am and git
          applymbox.

        . git fetch/pull over commit walker from a remote
          repository.

        . git push to send the work done in the shallow repository
          back into your mothership repository (running git pull on
          the mothership to fetch from the shallow copy probably
          would not work, unless you use commit walkers).

	. git whatchanged, git log, and gitk to view the work
	  you did in your shallow repository.

Creating packs in the mothership repository is certainly
possible.  You could instead do this:

	$ git-shallow-pack --all ;# in mothership
        $ mkdir -p /var/tmp/shallow
        $ tar cf - .git/HEAD .git/refs/ |
          (cd /var/tmp/shallow; git-init-db; tar xf -)
        $ mv pack-* /var/tmp/shallow/.git/objects/pack

If you want a bit deeper history, instead of giving '--all' to
git-shallow-pack, you could probably say something silly like
this:

	$ (git-rev-parse --all; git-rev-list --max-count=20 HEAD) |
          xargs git-shallow-pack

The shallow-pack script I sent earlier is probably not very
useful in practice.  To polish it to be somewhat more useful, it
would probably need the following enhancements, at least:

	. Instead of taking 'git-rev-parse' arguments, take the
	  names of refs;

	. Instead of packing the objects contained in the
          commits and trees the named refs reference, include
          all blobs/trees/commits between the given refs and
          their common ancestor to create a pack;

	. Create a tarball that contains:

	  (1) the pack file created by the above procedure,
              stored in .git/objects/pack/.;

          (2) .git/refs/ to be used in the shallow copy; this
              should include only the refs given to the command
              to create the above pack.

	  (3) .git/info/grafts to cauterize the common ancestor
              commit and side branches merged into the lines you
              are taking (computing the latter may be somewhat
              expensive).

Then the command can be run in the mothership repository like
this:

	$ cd linux-2.6
        $ git-shallow-pack v2.6.14 v2.6.14-rc2 master

to produce a tarball, which can be taken to another location.
When extracted, it would contain all commits between the three
named refs, and you could view the history across them.
