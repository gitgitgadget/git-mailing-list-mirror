From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 00/28] Massive improvents to rebase and cherry-pick
Date: Fri, 30 Aug 2013 00:55:54 -0500
Message-ID: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHlZ-00070W-Pw
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab3H3GBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:00 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:63883 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517Ab3H3GA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:00:59 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so1496491obc.27
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fBF6SPBBQeQRH/FwYL3EGtE5VFbCsf0kUIxCI9pO3ow=;
        b=lgQgA2WCDf0HFl41H8NUTmBnJPQYODo2Taz0S/cdHd/XsDD6crkYG4H6tUHXiAwEmu
         ql0CJyUFTGOdsRC3h7Ap8o1Pr1wg16nVfeoM/tdgucQDpDrOM1tr++MiigUCnvMnTcQy
         CmSas0mn1g+FF8+1cFqWGSQmY/oupJq+48XaHySjLH/q7dUHFb/yQrOi2QlBp3Nt3LnO
         vNKeXLPaa5GsHFVIDHx1W0H+x5gsnFeNVo7Dtv6aqVBIG2nq04hEdKAYlO7lZTKzTdZ4
         W44J4CrCwg2cU1twpDPsrUClA1/kGz3bQ0BOSa31u178RZ2DpRT7uaab/vQ6150FKZTH
         EPlQ==
X-Received: by 10.182.48.194 with SMTP id o2mr4792499obn.90.1377842459410;
        Thu, 29 Aug 2013 23:00:59 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id a18sm35714588obf.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:00:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233396>

Hi,

These are improvements to 'git rebase' by using a much improved 'git
cherry-pick'.

A new rewrite.c helper is added, and builtin/commit updated to use
that.

A new git-rebase--cherypick mode is added, and it replaces git-rebase--am and
git-rebase--merge.

Felipe Contreras (28):
  cherry-pick: don't barf when there's nothing to do
  cherry-pick: add --skip-empty option
  revert/cherry-pick: add --quiet option
  revert/cherry-pick: add --skip option
  builtin: add rewrite helper
  cherry-pick: store rewritten commits
  cherry-pick: don't store skipped commit
  builtin: move run_rewrite_hook() to rewrite.c
  builtin: rewrite: add copy_rewrite_notes()
  cherry-pick: add --action-name option
  cherry-pick: copy notes and run hooks
  cherry-pick: remember rerere-autoupdate
  rebase: split the cherry-pick stuff
  rebase: cherry-pick: fix mode storage
  rebase: cherry-pick: fix sequence continuation
  rebase: cherry-pick: fix abort of cherry mode
  rebase: cherry-pick: fix command invocations
  rebase: cherry-pick: fix status messages
  rebase: cherry-pick: automatically commit stage
  rebase: cherry-pick: set correct action-name
  rebase: trivial cleanup
  t: rebase-autostash: fix setup
  sequencer: store progress information
  prompt: parse cherry-pick rebase mode
  rebase: use 'cherrypick' mode instead of 'am'
  rebase: cherry-pick: add merge options
  rebase: remove merge mode
  rebase: cherry-pick: add copyright

 .gitignore                             |   2 +-
 Documentation/config.txt               |   9 +-
 Documentation/git-cherry-pick.txt      |  10 ++-
 Documentation/git-revert.txt           |   7 +-
 Documentation/githooks.txt             |   8 +-
 Documentation/sequencer.txt            |   3 +
 Makefile                               |   4 +-
 builtin/commit.c                       |  46 ++--------
 builtin/revert.c                       |  17 ++++
 contrib/completion/git-prompt.sh       |  16 ++--
 git-rebase--am.sh                      |  12 +--
 git-rebase--cherrypick.sh              |  66 ++++++++++++++
 git-rebase--interactive.sh             |   6 +-
 git-rebase--merge.sh                   | 151 ---------------------------------
 git-rebase.sh                          |  16 ++--
 rewrite.c                              | 122 ++++++++++++++++++++++++++
 rewrite.h                              |  20 +++++
 sequencer.c                            | 124 +++++++++++++++++++++++++--
 sequencer.h                            |   8 +-
 t/t3406-rebase-message.sh              |  14 +--
 t/t3407-rebase-abort.sh                |   2 +-
 t/t3420-rebase-autostash.sh            | 107 ++++++++++++-----------
 t/t3425-rebase-topology-merges.sh      |  15 ++--
 t/t3508-cherry-pick-many-commits.sh    |  13 +++
 t/t3510-cherry-pick-sequence.sh        |  14 ++-
 t/t5520-pull.sh                        |   2 +-
 t/t9106-git-svn-commit-diff-clobber.sh |   2 +-
 t/t9903-bash-prompt.sh                 |   2 +-
 28 files changed, 496 insertions(+), 322 deletions(-)
 create mode 100644 git-rebase--cherrypick.sh
 delete mode 100644 git-rebase--merge.sh
 create mode 100644 rewrite.c
 create mode 100644 rewrite.h

-- 
1.8.4-fc
