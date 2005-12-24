From: Junio C Hamano <junkio@cox.net>
Subject: GIT 1.0.4 and what is in master and proposed updates.
Date: Sat, 24 Dec 2005 01:42:11 -0800
Message-ID: <7vd5jmvnkc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 24 10:42:40 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq5v6-0002Rb-Ff
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 10:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbVLXJmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 04:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbVLXJmO
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 04:42:14 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39894 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1422640AbVLXJmN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 04:42:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051224094019.ZDZU17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Dec 2005 04:40:19 -0500
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14009>

GIT 1.0.4 contains the following updates since GIT 1.0.3:

 * check_packed_git_idx(): check integrity of the idx file itself.

   Earlier we did not use SHA1 checksum at the end of the index
   file that records the checksum of the index file itself.

 * show-branch: usability updates.

   Fixes the bug that made 'git show-branch --heads' show the
   same heads twice, among other things.

 * merge --no-commit: tweak message.

   Instead of saying "failed/prevented", say which one.

 * ls-files --full-name: usage string and documentation.

   The option was not documented.

 * mailinfo: iconv does not like "latin-1" -- should spell it "latin1"

   Noted by Marco; when a message does not identify its own
   charset, we tried to assume latin1 but misspelled it as
   latin-1, and iconv barfed.


The master branch has all of the above, and in addition contains
the following:

 * git-clone: do not special case dumb http.

   This is to remove the remnant from the days http-fetch did
   not handle packed repositories natively.

 * rev-parse: --show-cdup

   This is a low-impact shorthand for:

        git rev-parse --show-prefix | sed -e 's|[^/][^/]*|..|g'

   and will be used by "git checkout works from a subdirectory"
   patch.


The proposed updates branch has the following updates.

 * git-daemon --base-path

   Lack of the command line verification bugs me somewhat with
   this patch.  Also we might want to apply the base-path to the
   whitelist as well, which the patch currently does not do.
   Almost there, but not quite ready.

 * help with group permission in a shared repository.

   This series consists of these commits:

      Introduce core.sharedrepository
      git-init-db: initialize shared repositories with --shared
      Tutorial: mention shared repository management.

   I think this one is ready.  I just am taking things slowly.

 * make git-checkout work from a subdirectory.

   This series consists of these commits:

      checkout: sometimes work from a subdirectory.
      ls-tree: chomp leading directories when run from a subdirectory
      Adjust to ls-tree --full-name when run from a subdirectory.

   This seems to work pretty well.  I just am taking things
   slowly.

 * require packfiles to follow the naming convention more strictly.

   This rejects a packfile whose name does not begin with
   "pack-" followed by 40-byte hexadecimal digits.  The core
   never had such limitation (the only thing it required was
   that the pack and the idx are named with the same basename
   with .pack and .idx extention), but the way http-fetch
   handles packs requires this.

   An alternative strategy to handle the current mess would be
   to fix http-fetch so that it does not assume that pack names
   are always in the format "pack-[0-9a-f]{40}.pack", getting
   rid of sha1[] column from struct packed_git.  This is
   probably more work, but would be cleaner.  On the other hand,
   the cleanliness probably would not buy us much.  We do not
   need to insist on "pack-" prefix, but there is no strong
   reason to hate it, and we need to ensure packnames do not
   collide with each other anyway, so having SHA1 hash in the
   name makes sense.  However, we currently allow arbitrary 40
   hexadecimal digits there and the user is free to say 0{40}.
   Continuing to allow this defeats the initial purpose of why
   40 hexadecimal digits are there: collision avoidance.

   This series starts warning if the 40-byte hex that follows
   "pack-" is not the correct hash for contained object names
   that was given by pack-objects when the pack was created, and
   has a provision to later start rejecting such packs.

   This is probably controversial because it would eventually
   require users to rename their packs created using pre v0.99.9
   tools.  There is a small utility program that helps the
   conversion process, so it may not be that painful.

 * Disable USE_SYMLINK_HEAD by default.

   This uses symref for .git/HEAD everywhere.  Some Porcelain
   may not be ready to deal with it, so it is kept in the
   proposed updates branch for now.

   If your Porcelain "cat .git/HEAD", or "readlink .git/HEAD",
   it is already broken in repositories that use symref for
   HEAD, but it will be broken everywhere by this.  Use
   git-symbolic-ref if you want to find out the name of the
   branch HEAD points at, or git-rev-parse if you want to find
   out the commit object name HEAD points at.

   Most notably, git_read_hash(".../HEAD") in gitweb is probably
   affected (meaning, it is already broken).
