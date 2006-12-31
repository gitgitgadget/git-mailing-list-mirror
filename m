From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH 4/4] Disallow working directory commands in a bare repository.
Date: Sat, 30 Dec 2006 21:33:54 -0800
Message-ID: <7virfsk4sd.fsf@assigned-by-dhcp.cox.net>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
	<20061231043238.GD5823@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 06:34:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0tKc-0008HL-TS
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 06:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbWLaFd7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 00:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932919AbWLaFd7
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 00:33:59 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35511 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932795AbWLaFd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 00:33:59 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231053355.VXUB16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 00:33:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5HZ91W0091kojtg0000000; Sun, 31 Dec 2006 00:33:10 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061231043238.GD5823@spearce.org> (Shawn O. Pearce's message of
	"Sat, 30 Dec 2006 23:32:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35670>

I think the intent is good.

But execution has room for improvement, and it is not your
fault.  The shell script version of require_not_bare is as
fragile as is_bare_git_dir(), which I already do not like, and I
think if we are going to use is_bare_git_dir() more, I think we
would want to have something a bit more robust.

If we could outlaw $GIT_DIR/index in a bare repository, then
lack of $GIT_DIR/index combined with nonexistence of ref that
is pointed at by $GIT_DIR/HEAD could become a good indication
that the repository is bare ("the current branch unborn" check
is needed not to mistake a repository before the initial commit
as a bare one).

Alas, many public repositories you would see (e.g. check
kernel.org) have been primed with rsync of .git/ from
developer's working repository and have leftover index that is
otherwise unused.  Because of this heavy historical baggage, I
suspect that it is rather hard to convince people to allow us to
use this technique.

When you have $GIT_DIR in your environment, no working-tree
command is expected to work unless you are at the toplevel of
the working-tree.  In the past, people talked about their
workflows using more than one working trees that are associated
with a single $GIT_DIR and that is certainly supposed to work.
But I wonder how widely such a set-up is employed in practice.
If we outlawed working-tree commands when $GIT_DIR environment
exists, how much hurt are we talking about, I wonder.

Another thing to think about is if we are happy with the above
restriction that makes environment $GIT_DIR to imply you are
always working at the toplevel.  Maybe it could be a good idea
to kill this bird as well by introducing $GIT_WORKTREE_TOP
environment variable.  Presence of it obviously means we are not
in a bare repository, but at the same time it would allow us to
teach setup_git_directory_gentry() to cd up to that directory to
make the commands behave as expected.
