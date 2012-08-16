From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 00/12] git p4: submit conflict handling
Date: Thu, 16 Aug 2012 19:35:02 -0400
Message-ID: <1345160114-27654-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:35:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29b4-0002H1-Ex
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab2HPXfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:35:19 -0400
Received: from honk.padd.com ([74.3.171.149]:47751 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883Ab2HPXfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:35:18 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 50F82D27;
	Thu, 16 Aug 2012 16:35:17 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id ACD18313FD; Thu, 16 Aug 2012 19:35:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc2.111.g96f7c73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches rework how git p4 deals with conflicts that
arise during a "git p4 submit".  These may arise due to
changes that happened in p4 since the last "git p4 sync".

Luke: I especially wanted to get this out as you suggested
that you had a different way of dealing with skipped commits.

The part that needs the most attention is the interaction
loop that happens when a commit failed.  Currently, three
options are offered:

    [s]kip this commit, but continue to apply others
    [a]pply the commit forcefully, generating .rej files
    [w]rite the commit to a patch.txt file
    and the implicit <ctrl-c> to stop

After this series, it offers two:

    [c]ontinue to apply others
    [q]uit to stop

This feels more natural to me, and I like the term "continue" rather
than "skip" as it matches what rebase uses.  I'd like to know what
others think of the new flow.

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

Pete Wyckoff (12):
  git p4 test: remove bash-ism of combined export/assignment
  git p4 test: use p4d -L option to suppress log messages
  git p4: gracefully fail if some commits could not be applied
  git p4: remove submit failure options [a]pply and [w]rite
  git p4: move conflict prompt into run, use [c]ontinue and [q]uit
  git p4: standardize submit cancel due to unchanged template
  git p4: test clean-up after failed submit, fix added files
  git p4: rearrange submit template construction
  git p4: revert deleted files after submit cancel
  git p4: accept -v for --verbose
  git p4: add submit --dry-run option
  git p4: add submit --prepare-p4-only option

 Documentation/git-p4.txt           |  13 +-
 git-p4.py                          | 213 +++++++++++++++------
 t/lib-git-p4.sh                    |  10 +-
 t/t9805-git-p4-skip-submit-edit.sh |   2 +-
 t/t9807-git-p4-submit.sh           |  65 +++++++
 t/t9810-git-p4-rcs.sh              |  50 +----
 t/t9815-git-p4-submit-fail.sh      | 367 +++++++++++++++++++++++++++++++++++++
 7 files changed, 612 insertions(+), 108 deletions(-)
 create mode 100755 t/t9815-git-p4-submit-fail.sh

-- 
1.7.11.4
