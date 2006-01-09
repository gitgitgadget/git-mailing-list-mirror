From: Junio C Hamano <junkio@cox.net>
Subject: What's new in git.git
Date: Sun, 08 Jan 2006 17:20:56 -0800
Message-ID: <7vslrytcw7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 09 02:21:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evlj3-00083s-LB
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 02:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbWAIBVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 20:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWAIBV3
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 20:21:29 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31175 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751505AbWAIBU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2006 20:20:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060109011910.DEEA17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 Jan 2006 20:19:10 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14345>

Latest maintenance release for GIT 1.0 (1.0.8) and the new
feature release GIT 1.1.0 have been pushed out.

Waiting in the proposed updates branch are two backward
incompatible changes.

 - Require packfiles to be named pack-[0-9a-f]{40}.pack, and
   issue an warning if [0-9a-f]{40} part does not match the SHA1
   checksum of sorted object names that are contained in the
   pack.  Later I would like to promote the warning to an error,
   and there is a tool to help renaming packs created with older
   git-pack-objects.  When the warning is promoted to an error,
   this will break existing packfiles.

 - Use textual symbolic refs to represent .git/HEAD everywhere,
   not just on filesystems without symbolic link supports.  This
   was proposed by Pavel mid November 2005, but is known to
   break Porcelains that read(2) from .git/HEAD and expect to
   read an object name for the current branch head (use "git
   rev-parse --verify HEAD" instead), and write(2) into
   .git/HEAD and expect to update the current branch head (use
   "git update-ref HEAD $commit [$old]" instead).  Last time I
   checked, gitweb would break with this change.

Also there are patches floating around to update format-patch
and rebase.  I rejected the initial round, but consider what
the latter wants to achieve a worthwhile goal, and expect to
update rebase in some form.

Now the core and the barebone Porcelain are more or less stable
and changes have significantly slowed down, I think it is a good
time to start revisiting the libification effort, started by
Smurf.  I haven't taken a look at his tree for a while.

Another area that needs attention is to see how we can improve
handling of merges between branches that have renamed things
(i.e. HPA's klibc repositories).  I'd also like to teach
renaming merge to resolve strategy somehow.

Other small things I have in mind, in random order, are:

 - Give extra option to "diff-tree -m -p" to show difference
   between natural merge among parents and the actual merge
   result.  I do not think this would make sense for non patch
   format.

 - The recent "git-daemon --base=/pub/git" is a good addition
   (git://host/frotz.git is mapped to /pub/git/frotz.git
   directory), but with the current implementation whitelist
   needs to start with /pub/git/.  I initially thought it was
   not so nice, but maybe it is OK; but this needs to be
   documented.  It also forbids user relative paths, which
   should be made an independent switch.

 - Also in "git-daemon", I outlined --strict-symlink option a
   while ago, which forbids symbolic links to step outside of
   whitelisted areas.  This has not been implemented, and we may
   want to add it.

 - Although Linus has been pretty negative about improving the
   current dumb http transport, many people seem to rely on it.
   It "works" with packfiles in the sense that it does not barf,
   but the server file packing strategy to reduce duplicated
   download needs to be worked out to make it more efficient.

 - If the same cloning requests are made number of times, we
   should be able to cache the packfile we sent out and reuse,
   to reduce the load on the server side.  When used with
   git-daemon, this requires the daemon to be able to write
   somewhere (not necessarily the original repository itself),
   so there is certain security implications.
