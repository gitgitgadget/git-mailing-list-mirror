From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git
Date: Wed, 11 Jan 2006 16:04:41 -0800
Message-ID: <7vhd8al3ae.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 12 01:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwpxZ-00021K-Ri
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWALAEt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWALAEt
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:04:49 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31881 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751205AbWALAEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:04:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112000239.YDQL26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 19:02:39 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14526>

I have queued the following for the maintenance branches.

For both 1.0.X and 1.1.X series:

 - update-index: work with c-quoted name
 - show-branch: handle [] globs as well.
 - name-rev: do not omit leading components of ref name.

For 1.1.X series only:

 - Add git-describe to .gitignore.
 - describe: do not silently ignore indescribable commits

I plan to do 1.0.10 [*1*] and 1.1.2 sometime this weekend, along
with some other fixes that would appear until then.

On the development front, I have these in the proposed updates
branch:

 - Exec git programs without using PATH (Michal Ostrowski).

   This has been discussed for the last couple of days on the
   list.  I think C side is ready to go in, but I'd like to
   decide what to do on the scripting side before merging it
   into the master branch.

 - Disable USE_SYMLINK_HEAD by default (Pavel Roskin).

   This has been on hold for almost two months -- forever in git
   timescale.

   One offender that could have been broken by this change was
   fixed recently (gitweb), so this can go in anytime now.  Do
   people still care about it?  The argument for the change when
   it was proposed was "then we only have to worry about one
   format of .git/HEAD, not two", and it still is a valid
   argument from Porcelain writers' point of view.  To be
   honest, since I do not do Porcelain, I am neutral about it.

 - convert-packs: futureproofing.
 - Require packfiles to follow the naming convention (preparation).

   These two I have been holding for a while.  I would
   eventually like to force people to rename the packfiles
   created by GIT older than v0.99.9 which has unverifiable
   hexadecimal string in their names and these are the first
   two baby steps toward that goal.  If people object to the
   idea of verifiable packname in general, please raise hand,
   and I may be talked into shelving the whole thing.

 - Documentation: show-branch.
 - show-branch: always include the current branch
 - show-branch: make --topo-order noop and default.
 - show-branch: make the current branch stand out.

   Here are mostly usability updates.

I'll send out some of the above patches to the list separately
for discussion and review.


[Footnote]

*1* 1.0.X series maintenance can largely be ignored by general
public, since I do not see any reason to stick to 1.0.X series.
1.1.X series does not have any backward incompatibility issues
as far as I know.  I am doing 1.0.X series primarily as a
practice for myself, and to experiment with a maintainer
workflow like this:

 - "fixo/1.0" topic branch queues fixes applicable for 1.0
   series *and* *later* maintenance series.

 - "fix" topic branch queues fixes applicable only for the
   current maintenance series.

 - "mainto/1.0" branch is used to cut releases for the 1.0.X
   maintenance series from.  This pulls from "fixo/1.0" topic
   branch.

 - "maint" branch is used to cut releases for the current
   maintenance series from.  This pulls from both "fix" topic
   branch and "mainto/*" topic branches.

With this setup, I can first merge "fixo/1.0" to "mainto/1.0",
and then merge "mainto/1.0" and "fix" branches to "maint", to
come up with something like this:

    $ git show-branch fix fixo/* maint mainto/*
    ! [fix] describe: do not silently ignore indescribable commits
     ! [fixo/1.0] name-rev: do not omit leading components of ref name.
      * [maint] GIT 1.1.2 (not really -- just a demonstration)
       ! [mainto/1.0] GIT 1.0.10 (not really -- just a demonstration)
    ----
      *  [maint] GIT 1.1.2 (not really -- just a demonstration)
    + *  [fix] describe: do not silently ignore indescribable commits
    + *  [fix^] Add git-describe to .gitignore.
      *  [maint^] Merge fixes up to GIT 1.0.10 (not really)
      *+ [mainto/1.0] GIT 1.0.10 (not really -- just a demonstration)
     +*+ [fixo/1.0] name-rev: do not omit leading components of ref name.
     +*+ [fixo/1.0^] update-index: work with c-quoted name
      *+ [mainto/1.0^] GIT 1.0.9
      *  [maint~2] GIT 1.1.1
     +*+ [fixo/1.0~2] glossary: explain "master" and "origin"
    + *  [maint~3] GIT-VERSION-GEN: detect dirty tree and mark the ver...
    + *  [maint~4] For release tarballs, include the proper version
    + *  [maint~5] GIT 1.1.0
    + *+ [mainto/1.0~2] GIT 1.0.8
    ++*+ [fixo/1.0~3] mailsplit: allow empty input from stdin
