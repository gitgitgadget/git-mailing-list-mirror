From: Junio C Hamano <junkio@cox.net>
Subject: Re: Default remote branch for local branch
Date: Fri, 31 Mar 2006 19:05:46 -0800
Message-ID: <7vodzmngfp.fsf@assigned-by-dhcp.cox.net>
References: <1143856098.3555.48.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 01 05:05:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPWQx-0003u6-Qp
	for gcvg-git@gmane.org; Sat, 01 Apr 2006 05:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWDADFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 22:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWDADFs
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 22:05:48 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62425 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751484AbWDADFr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 22:05:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060401030547.JQAA6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 31 Mar 2006 22:05:47 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1143856098.3555.48.camel@dv> (Pavel Roskin's message of "Fri, 31
	Mar 2006 20:48:18 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18240>

Pavel Roskin <proski@gnu.org> writes:

> This is not a ready-to-use proposal, but I think my message can prompt
> useful changes in GIT or in the "porcelain".
>...
> I think it would be convenient to have git remember the remote branch
> for the given local branch.  git should know that if HEAD points to
> "local-B", "git-fetch" should fetch from "remote-B", not from "origin".

I am in favor of the general direction this is going.  Something
like this was mentioned on the list in the past twice (I think
Johannes was involved in the discussion but I do not remember
the details offhand).

My understanding is that Cogito uses $GIT_DIR/branches/$name
file as a configuration file per branch - currently it only
records which remote repository's what remote branch the local
branch $name interfaces with.

The $GIT_DIR/remotes/$name file is to describe each remote
repository, and it _wants_ to be able to describe all the
branches we are interested in, primarily because uploading and
downloading multiple, related heads at once is more efficient.
How remote branches are kept track of with the local tracking
branch, and how remote branches are updated from the local
branch heads, are described by Push/Pull lines there.

As you pointed out, we do not have a convenient way to tell git
where you typically merge things from per local branch.  There
are different patterns I've seen:

 - Promiscous.  For example, "master" branch of Linus repository
   pulls from many subsystem maintainers.  Linus could have one
   "remotes" file per subsystem maintainer he often pulls from
   (and "for-linus" branch name in each remote repository tends
   to stay the same), and unlike the rest of us he does not seem
   to pull into many local branches.  The current "remotes"
   setup is really optimized for this mode of usage (you can use
   "remotes" without having local tracking branches).

 - Merging topic branches into "master" (or "release") branch
   and "next" (or "testing") branch -- inside local repository.

 - CVS-like remote tracking.  A single "primary" remote branch
   is tracked using local "origin", merged into local "master"
   and pushed back to the remote.  Both Cogito-like branches/
   setup and having a single $GIT_DIR/remotes/origin file with
   single Push/Pull line would work equally well.

 - Multiple subsystem maintainer trees tracked in the same local
   repository.  Most generally, two local branches per each
   remote head can be used (one tracking branch to fetch into,
   another to build your changes based on it).  Alternatively,
   you can use one local branch per each remote head without
   using any tracking branch.

Your proposal to give default branch to pull from per the local
branch would help only the last case.  The first one you do not
switch between local branches at all and pull from many
different places; the second is to merge from different topic
branches from time to time and does not benefit from fixed
configuration; the third does not even need configuration.

Maybe you would want something like this.

In $GIT_DIR/config:

	[pull]
	origin = linus for master
        origin = irq-pio of libata for ata-irq-pio
        origin = pata-drivers of libata for ata-pata

In $GIT_DIR/remotes/linus:

	URL: git://git.kernel.org/.../torvalds/linux-2.6.git
	Pull: refs/heads/master:refs/heads/linus

In $GIT_DIR/remotes/libata
	URL: git://git.kernel.org/.../jgarzik/libata-dev.git
	Pull: refs/heads/irq-pio:refs/remotes/libata/irq-pio
	Pull: refs/heads/pata-drivers:refs/remotes/libata/pata-drivers

This is to maintain three local branches: master, ata-irq-pio
and ata-pata.

You are obviously interested in the mainline Linus kernel, so
while you are on your "master" branch, we will look for
"pull.origin .* for master" and find out you would want
remotes/linus file to be used.  His "master" is copied to your
local "linus" branch, and merged into your "master" branch.

	$ git pull

becomes equivalent to:

        $ git pull linus

You are also interested in the libata work by Jeff, and while
you are on your ata-pata branch

	$ git pull

becomes roughly equivalent to:

	$ git pull libata pata-drivers

While we are on the topic, it _might_ be worthwhile to think
about revamping the syntax of $GIT_DIR/remotes file, maybe even
breaking backward compatibility.  The Pull: lines can be
independently specified which gives flexibility, but I suspect
local tracking branches from the same remote tend to live in the
same place; IOW, you would probably not do something like:

	URL: git://git.kernel.org/.../jgarzik/libata-dev.git
	Pull: refs/heads/irq-pio:refs/remotes/libata/irq-pio
	Pull: refs/heads/pata-drivers:refs/heads/pata-drivers

in practice.
