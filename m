From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 00/31] Refactor rebase
Date: Tue, 28 Dec 2010 10:30:17 +0100
Message-ID: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:31:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbVv-0004OY-F9
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab0L1Pam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:30:42 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55923 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab0L1Pal (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:30:41 -0500
Received: by qwa26 with SMTP id 26so9390191qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=IzQ3erFXvsk+Z5Ef5pSJpquVu0hkK/8Dy8PBneFm1/o=;
        b=Oh0ohP2zkCxAFL1eefnGOsdY/Es2Z1JISjFlZTLKeMHkvePKBsq6ZnQcrbJb55kb9A
         Qc0kTby+r99Q5nDp7r68o9y7gkoqoycCLSWiAMtT3ASoobUPedOC9eSlzX/LNb2sCciH
         FJ5AAuI+H/4ZQ4VHMhqc9VFs1CmSLESS1E1B4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pS8LoOTfyiKJ+JXScjtdUXDxDofbeK8C2iGLf0CglBFUlk7pX56V3UaiFnVWCt/JtY
         kxq/XK3eOqgYWG/D9eYoR2yWOIbYYF3PB7Lrla5R8MEbUZAzwMYl2gp98SRMjZCAAcCZ
         EF+a+X5T395Mcxe5wTEi+Y+w39ipJbEhwMY8s=
Received: by 10.224.28.134 with SMTP id m6mr5087201qac.145.1293550238701;
        Tue, 28 Dec 2010 07:30:38 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.30.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:30:35 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164241>

For the past two months, I have been working on refactoring the rebase
code. See [1] for background information. I have been trying to polish
the patch set for some time, but now I don't think I will get much
further without your help.

My goals with this series were:

 (1) Make it easier to add new features to git rebase by reducing the
 amount of duplicated code. FWIW, this series removes about 140 lines
 non-test code.

 (2) Make the behavior (towards the user) more consistent between
 interactive and non-interactive rebase. This mainly involves error
 messages and command line options.

While not being a goal from the beginning, I have also tried to make
the code more readable. This is of course very subjective, so we'll
see - maybe in your eyes I just made things worse :-).


At a high level, I tried to do what was suggested by Johannes Sixt in
the second entry on [1], namely

"... to write a command line processor, git-rebase.sh, that sets shell
variables from options that it collects from various sources, then
dispatches to one of git-rebase--interactive.sh, git-rebase--merge.sh,
or git-rebase--am.sh (the latter two would be stripped-down copies of
the current git-rebase.sh)."


Patches 01-04 try to make git-rebase.sh more readable and extensible
by factoring out the code that reads the saved state from
.git/rebase-apply or .git/rebase-merge.

Patches 05-09 set the stage for further refactoring by aligning
git-rebase.sh and git-rebase--interactive.sh.

Patches 10-16 factor out parts from git-rebase--interactive.sh and let
it rely on the corresponding code in git-rebase.sh.

Patch 17 just removes a duplicated variable.

Patches 18 and 19 extract the am-specific and merge-specifc rebase
code into two new source files (as suggested by Hannes).

Patch 20 makes interactive rebase print the same message as
non-interactive rebase in case of conflict.

Patches 21 and 22 prepare for further refactoring by aligning
interactive and non-interactive rebase a bit more.

Patch 23 factors out part or all of the handling of --continue, --skip
and --abort from git-rebase--interactive to git-rebase.sh.

Patches 24-27 makes rebase remember more options passed on the command
line thoughout the rebase (past any conflicts).

Patches 28-31 remove some unnecessary code.


I have tried to separate pure refactoring from changes that make
functional changes, but there are still some functional changes hiding
in the "refactoring" patches. I have tried to point this out in the
commit message where applicable, but I'm sure I have missed a lot of
places.


/Martin


[1] http://thread.gmane.org/gmane.comp.version-control.git/160517


Martin von Zweigbergk (31):
  rebase: clearer names for directory variables
  rebase: refactor reading of state
  rebase: read state outside loop
  rebase: remove unused rebase state 'prev_head'
  rebase: improve detection of rebase in progress
  rebase: act on command line outside parsing loop
  rebase: stricter check of standalone sub command
  rebase: align variable names
  rebase: align variable content
  rebase: factor out command line option processing
  rebase -i: remove now unnecessary directory checks
  rebase: reorder validation steps
  rebase: factor out reference parsing
  rebase: factor out clean work tree check
  rebase: factor out call to pre-rebase hook
  rebase -i: support --stat
  rebase: remove $branch as synonym for $orig_head
  rebase: extract merge code to new source file
  rebase: extract am code to new source file
  rebase: show consistent conflict resolution hint
  rebase -i: align variable names
  rebase: make -v a tiny bit more verbose
  rebase: factor out sub command handling
  rebase: extract code for writing basic state
  rebase: remember verbose option
  rebase: remember strategy and strategy options
  rebase -m: remember allow_rerere_autoupdate option
  rebase -m: don't print exit code 2 when merge fails
  git-rebase--am: remove unnecessary --3way option
  rebase -i: don't read unused variable preserve_merges
  rebase -i: remove unnecessary state rebase-root

 .gitignore                 |    2 +
 Makefile                   |    2 +
 git-rebase--am.sh          |   30 +++
 git-rebase--interactive.sh |  589 ++++++++++++++------------------------------
 git-rebase--merge.sh       |  151 +++++++++++
 git-rebase.sh              |  477 ++++++++++++++---------------------
 t/t3403-rebase-skip.sh     |    5 +
 t/t3407-rebase-abort.sh    |   10 +
 t/t3418-rebase-continue.sh |   55 ++++
 9 files changed, 627 insertions(+), 694 deletions(-)
 create mode 100644 git-rebase--am.sh
 create mode 100644 git-rebase--merge.sh

-- 
1.7.3.2.864.gbbb96
