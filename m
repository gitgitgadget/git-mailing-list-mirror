From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 00/12] git p4: submit conflict handling
Date: Sun,  9 Sep 2012 16:16:01 -0400
Message-ID: <1347221773-12773-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 22:16:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAnve-0003Vk-B9
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 22:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab2IIUQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 16:16:18 -0400
Received: from honk.padd.com ([74.3.171.149]:35549 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358Ab2IIUQR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 16:16:17 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id A26C65AF2;
	Sun,  9 Sep 2012 13:16:16 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B9D5432112; Sun,  9 Sep 2012 16:16:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.176.gc22bed1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205090>

Changes from v1, due to review from Luke and Hannes:

    * Drop the patch to suppress of p4d log messages, it is
      sometimes useful to watch.

    * Fix extra line before shebang in t9815.  (Thanks Hannes.)

    * Use "skip", not "continue" in the prompt about what to
      do next, just like before this series.

    * Automate the interactive prompt when a submit conflict
      is detected, with "git p4 submit --conflict=skip" or
      config variable git-p4.conflict.

    This does not try to fix the rebase path.  It adds the
    auto-skip during the submit phase, but changes are needed
    in rebase to understand that skips happened.  One approach
    is to skip the rebase, and just reset HEAD.

    Luke:  You have a patch for git-p4.skipConflictingChanges
    that I think might work with --conflict=skip or git-p4.skip.
    With this series, logging already happens in submit, so you
    might just quietly say "git rebase --skip".  Let me know
    if you think this is a good approach, so that this series
    can go in, and you can handle the rebase part.

    Version 1 of this series:

	http://thread.gmane.org/gmane.comp.version-control.git/203570

    Blurb (edited) from v1 follows.

These patches rework how git p4 deals with conflicts that
arise during a "git p4 submit".  These may arise due to
changes that happened in p4 since the last "git p4 sync".

The part that needs the most attention is the interaction
loop that happens when a commit failed.  Currently, three
options are offered:

    [s]kip this commit, but continue to apply others
    [a]pply the commit forcefully, generating .rej files
    [w]rite the commit to a patch.txt file
    and the implicit <ctrl-c> to stop

After this series, it offers two:

    [s]kip this commit but apply the rest
    [q]uit to stop

Other observable changes are new command-line options:

Alias -v for --verbose, similar to other git commands.

The --dry-run option addresses Luke's concern in

    http://thread.gmane.org/gmane.comp.version-control.git/201004/focus=201022

when I removed an unused "self.interactive" variable
that did a similar thing if you edited the code.  It prints
commits that would be applied to p4.

Option --prepare-p4-only is similar to --dry-run, in that
it does not submit anything to p4, but it does prepare the
p4 workspace, then prints long instructions about how to submit
everything properly.  It also serves, perhaps, as a replacement for
the [a]pply option in the submit-conflict loop.

Option --conflict=skip (new in v2) automates the prompt
handling when conflicts happen.


Pete Wyckoff (12):
  git p4 test: remove bash-ism of combined export/assignment
  git p4: gracefully fail if some commits could not be applied
  git p4: remove submit failure options [a]pply and [w]rite
  git p4: move conflict prompt into run, add [q]uit input
  git p4: standardize submit cancel due to unchanged template
  git p4: test clean-up after failed submit, fix added files
  git p4: rearrange submit template construction
  git p4: revert deleted files after submit cancel
  git p4: accept -v for --verbose
  git p4: add submit --dry-run option
  git p4: add submit --prepare-p4-only option
  git-p4: add submit --conflict option and config varaiable

 Documentation/git-p4.txt           |  24 ++-
 git-p4.py                          | 239 ++++++++++++++++-----
 t/lib-git-p4.sh                    |   7 +-
 t/t9805-git-p4-skip-submit-edit.sh |   2 +-
 t/t9807-git-p4-submit.sh           |  65 ++++++
 t/t9810-git-p4-rcs.sh              |  50 +----
 t/t9815-git-p4-submit-fail.sh      | 429 +++++++++++++++++++++++++++++++++++++
 7 files changed, 709 insertions(+), 107 deletions(-)
 create mode 100755 t/t9815-git-p4-submit-fail.sh

-- 
1.7.12.rc2.111.g96f7c73
