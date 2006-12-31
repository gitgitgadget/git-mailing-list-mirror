From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH 4/4] Disallow working directory commands in a bare repository.
Date: Sun, 31 Dec 2006 01:11:22 -0500
Message-ID: <20061231061122.GB6106@spearce.org>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org> <20061231043238.GD5823@spearce.org> <7virfsk4sd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 07:11:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0tuv-0003Wg-I3
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 07:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933030AbWLaGL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 01:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933031AbWLaGL1
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 01:11:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45522 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933030AbWLaGL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 01:11:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0tuz-0004yr-Cs; Sun, 31 Dec 2006 01:11:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7ADB320FB65; Sun, 31 Dec 2006 01:11:22 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virfsk4sd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35678>

Junio C Hamano <junkio@cox.net> wrote:
> But execution has room for improvement, and it is not your
> fault.  The shell script version of require_not_bare is as
> fragile as is_bare_git_dir(), which I already do not like, and I
> think if we are going to use is_bare_git_dir() more, I think we
> would want to have something a bit more robust.

Agreed.  But as you point out...
 
> If we could outlaw $GIT_DIR/index in a bare repository, then
> lack of $GIT_DIR/index combined with nonexistence of ref that
> is pointed at by $GIT_DIR/HEAD could become a good indication
> that the repository is bare ("the current branch unborn" check
> is needed not to mistake a repository before the initial commit
> as a bare one).
> 
> Alas, many public repositories you would see (e.g. check
> kernel.org) have been primed with rsync of .git/ from
> developer's working repository and have leftover index that is
> otherwise unused.  Because of this heavy historical baggage, I
> suspect that it is rather hard to convince people to allow us to
> use this technique.

I almost coded the require_not_bare() to look for $GIT_DIR/index
but didn't for the reasons you point out above.  It is too bad that
we didn't enforce the existance of the index file better in the past.

> When you have $GIT_DIR in your environment, no working-tree
> command is expected to work unless you are at the toplevel of
> the working-tree.  In the past, people talked about their
> workflows using more than one working trees that are associated
> with a single $GIT_DIR 

What happens with $GIT_DIR/index in this case?  Or $GIT_DIR/HEAD?
Its insane because both need to be affiliated with the working
directory, yet there's only the one set.  Sure the user could also
arrange for $GIT_INDEX_FILE to be set based on the working directory,
but what about $GIT_DIR/HEAD?  There is no equivilant.

> and that is certainly supposed to work.
> But I wonder how widely such a set-up is employed in practice.
> If we outlawed working-tree commands when $GIT_DIR environment
> exists, how much hurt are we talking about, I wonder.

I wouldn't be hurt, but I don't call Porcelain-ish unless I'm
entering commands directly on the command line, and I never set
GIT_DIR except in scripts, and even then its very rare and is more
to point at a bare repository than one with a working directory.
I suspect that probably isn't true for everyone.

> Another thing to think about is if we are happy with the above
> restriction that makes environment $GIT_DIR to imply you are
> always working at the toplevel.  Maybe it could be a good idea
> to kill this bird as well by introducing $GIT_WORKTREE_TOP
> environment variable.  Presence of it obviously means we are not
> in a bare repository, but at the same time it would allow us to
> teach setup_git_directory_gentry() to cd up to that directory to
> make the commands behave as expected.

I'm not sure what value that environment variable offers here.

Users who set GIT_DIR but don't today set GIT_WORKTREE_TOP are
broken by this change because its not set and we assume its bare.
So they need to also set this environment variable.  But that
is probably going to be annoying for those users as I doubt they
are setting GIT_DIR on a per-directory basis.

Why not just tell these users to setup the working directories with
local .git directories and not use GIT_DIR?

-- 
Shawn.
