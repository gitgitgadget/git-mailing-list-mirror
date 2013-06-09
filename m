From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 00/36] Massive improvents to rebase and cherry-pick
Date: Sun,  9 Jun 2013 14:24:14 -0500
Message-ID: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:26:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllGM-00037A-OH
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab3FIT0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:26:45 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:38769 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab3FIT0p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:26:45 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so8847057obq.7
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=sQdBl4BoEtCa8+6iXtFe0uc8yf5Og9sucZCqi9Nt1+Q=;
        b=h4OieMZqDFj+SwIGH2K/MbqJ3XUrjDtZyIXl3sJaimmlbqJptUTMHNIuOeFw2isAYO
         +Ty9xqWslbBhc1pRxXVyvZ5KXPzxJufMoMCJd+XgJWhQDjm4/7nvNzFB8sMIDTj3v1dN
         zWROlRpCk2DZn+8Zqw3gZAESuzYt9Q2XwyuKnKqJwU703gA/Skm+BlUEdd7IP0okiGpY
         lSuDnk+SIGdrqq111fBqcOs3z4qcW/gzhvfVEw0BmX60FMmqgQ+LfPdYAwhHK62zAVzo
         fyInY6PUU0J1EshsTSZgAHMLs8woXmWmOYkRYVkdejSEqDpS3hndf3YFYuWHEWjCl48j
         GHZA==
X-Received: by 10.182.80.5 with SMTP id n5mr5469715obx.88.1370806003464;
        Sun, 09 Jun 2013 12:26:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm15931566obb.13.2013.06.09.12.26.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:26:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227109>

Same as before, but:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7fd4035..d72d2d2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1679,11 +1679,10 @@ GIT_NOTES_REF) is also implicitly added to the list of refs to be
 displayed.
 
 notes.rewrite.<command>::
-	When rewriting commits with <command> (currently `amend` or
-	`rebase`) and this variable is set to `true`, Git
-	automatically copies your notes from the original to the
-	rewritten commit.  Defaults to `true`, but see
-	"notes.rewriteRef" below.
+	When rewriting commits with <command> (currently `amend`, `rebase`, or
+	`cherry-pick`) and this variable is set to `true`, Git automatically
+	copies your notes from the original to the rewritten commit.  Defaults
+	to `true`, but see "notes.rewriteRef" below.
 
 notes.rewriteMode::
 	When copying notes during a rewrite (see the
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d48bf4d..8cfa13b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -352,10 +352,10 @@ post-rewrite
 ~~~~~~~~~~~~
 
 This hook is invoked by commands that rewrite commits (`git commit
---amend`, 'git-rebase'; currently 'git-filter-branch' does 'not' call
-it!).  Its first argument denotes the command it was invoked by:
-currently one of `amend` or `rebase`.  Further command-dependent
-arguments may be passed in the future.
+--amend`, `git rebase`, `git cherry-pick`; currently `git filter-branch` does
+'not' call it!).  Its first argument denotes the command it was invoked by
+(e.g. `rebase`).  Further command-dependent arguments may be passed in the
+future.
 
 The hook receives a list of the rewritten commits on stdin, in the
 format
diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index ddd369f..f805883 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -33,8 +33,8 @@ static void finish(struct replay_opts *opts)
 	if (!*name)
 		return;
 
-	run_rewrite_hook(&rewritten, name);
 	copy_rewrite_notes(&rewritten, name);
+	run_rewrite_hook(&rewritten, name);
 }
 
 static void remove_sequencer_state(void)

Felipe Contreras (36):
  build: generate and clean test scripts
  build: do not install git-remote-testgit
  build: trivial cleanup
  build: add builtin lib
  log-tree: remove dependency from sequencer
  Move sequencer to builtin
  unpack-trees: plug a memory leak
  read-cache: plug a few leaks
  sequencer: remove useless indentation
  sequencer: trivial fix
  cherry-pick: don't barf when there's nothing to do
  cherry-pick: add --skip-empty option
  revert/cherry-pick: add --quiet option
  revert/cherry-pick: add --skip option
  builtin: add rewrite helper
  cherry-pick: store rewritten commits
  cherry-pick: don't store skipped commit
  builtin: move run_rewrite_hook() to rewrite.c
  builtin: add copy_rewrite_notes()
  cherry-pick: copy notes and run hooks
  cherry-pick: add --action-name option
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
  rebase: use 'cherrypick' mode instead of 'am'
  rebase: cherry-pick: fix for shell prompt
  rebase: cherry-pick: add merge options
  rebase: remove merge mode
  rebase: cherry-pick: add copyright

 .gitignore                             |   1 +
 Documentation/config.txt               |   9 +-
 Documentation/git-cherry-pick.txt      |  10 +-
 Documentation/git-revert.txt           |   7 +-
 Documentation/githooks.txt             |   8 +-
 Documentation/sequencer.txt            |   3 +
 Makefile                               |  31 ++--
 builtin/commit.c                       |  46 +-----
 builtin/revert.c                       |  17 +++
 builtin/rewrite.c                      | 124 ++++++++++++++++
 builtin/rewrite.h                      |  20 +++
 sequencer.c => builtin/sequencer.c     | 263 +++++++++++++--------------------
 sequencer.h => builtin/sequencer.h     |  12 +-
 contrib/completion/git-prompt.sh       |   4 +-
 git-rebase--am.sh                      |  12 +-
 git-rebase--cherrypick.sh              |  72 +++++++++
 git-rebase--interactive.sh             |   4 +-
 git-rebase--merge.sh                   | 151 -------------------
 git-rebase.sh                          |  16 +-
 log-tree.c                             | 161 +++++++++++++++++++-
 log-tree.h                             |   3 +
 read-cache.c                           |   4 +
 t/t3406-rebase-message.sh              |  15 --
 t/t3407-rebase-abort.sh                |   2 +-
 t/t3420-rebase-autostash.sh            |   2 +-
 t/t3508-cherry-pick-many-commits.sh    |  13 ++
 t/t3510-cherry-pick-sequence.sh        |  14 +-
 t/t5520-pull.sh                        |   2 +-
 t/t9106-git-svn-commit-diff-clobber.sh |   2 +-
 t/t9903-bash-prompt.sh                 |   2 +-
 unpack-trees.c                         |   4 +-
 31 files changed, 608 insertions(+), 426 deletions(-)
 create mode 100644 builtin/rewrite.c
 create mode 100644 builtin/rewrite.h
 rename sequencer.c => builtin/sequencer.c (86%)
 rename sequencer.h => builtin/sequencer.h (86%)
 create mode 100644 git-rebase--cherrypick.sh
 delete mode 100644 git-rebase--merge.sh

-- 
1.8.3.698.g079b096
