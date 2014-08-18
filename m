From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 00/27] Enable options --signoff, --reset-author for pick, reword, edit
Date: Mon, 18 Aug 2014 23:22:43 +0200
Message-ID: <cover.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:23:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUOw-0000DK-BS
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbaHRVXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:23:34 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:35085 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaHRVXd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:23:33 -0400
Received: by mail-la0-f46.google.com with SMTP id b8so5039433lan.5
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SRnceaiCW/Uv5GlsFVegT6NFPkiyd2m+z+4PU6AqvMs=;
        b=tChbadkhm7MrxRn2RJ9i9A+7bRawNYOl3i3i+T5vlXAzebvgs2cW+8D3hMbBfMcaxS
         Lvg7c92j++AE8XXnVGCUVjwhgMKXM0Tj+FOKPXAEJkTxr5aJdSqWuc71khJaw17tZb3Y
         q7EQiWGVq9I6sJm3SU6ZCaWCg3OYDLfijwWmznbgQ4rR+by5A/U5UQelG2/hracdTcU2
         TNBNIPwZbBfw15/fdGTr5k+TPwPyGwxkkya9nd+QjLBsrJ5EKUFPR08nSMfvAUCwDA9j
         u02JNocg2Ms/T8zUjH5TktNd9rEGHcvUNmBpYwBtg8W9XMgHJBK1BS2eZr1iNI6OAsNY
         FBwg==
X-Received: by 10.112.93.75 with SMTP id cs11mr29576125lbb.82.1408397012038;
        Mon, 18 Aug 2014 14:23:32 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.23.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:23:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <53A258D2.7080806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255410>

Hi,

this is the third reroll of the patch series that makes the
well-known commit options `--signoff` and `--reset-author` available
to be used with the to-do list commands `pick`, `reword` and `edit`.

What follows is a short changelog since the second reroll from almost
two weeks ago. The changes were mostly made in response to Thomas'
review.

- Merely a commit message comment: The `editor.sh` wrapper script is
  still necessary to use `output` with interactive to-do list
  commands because the `--quiet` option does not force all commands
  to be totally silent.

- `git-rebase--interactive.sh` now uses the quoting functionality of
  git-rev-parse when assigning the `editor.sh` path to the
  `GIT_EDITOR` environment variable, in case the path includes double
  quotes itself.

- The tests dealing with squash commits that violate either
  commit-msg or pre-commit now test `squash` and `fixup` sequences
  with more than two commits. This is important since the final
  commit is created on a different code path than the others.

- The `fake_editor.sh` change that prints the debug output on stderr
  instead of stdout is now a separate patch so that it can be
  referred to directly. The change might be considered a hack and
  needs revision.

- Since whitespace and shell quoting are not supported by line
  options, the `opts` variable does not need to be evaluated using
  `eval` anymore.

- Malformed to-do command lines either trigger an "unknown command"
  or an "unknown option" error message but not both.

- A test case that specifies that `git rebase --continue` only
  commits staged changes if the user has not committed on top of the
  last successfully replayed commit in the meantime. The rationale
  behind this is that `git rebase --continue` commits using the
  author information of the commit it tried to replay last. While it
  perfectly makes sense to assume that this information is correct
  when HEAD has not changed, it is probable that it is incorrect when
  the user has created commits herself because the rebase process was
  interrupted for conflict resolution only and one must know
  internals to intentionally make `git rebase --continue` commit
  changes on top of user-created commits using original author
  information.

- `do_pick` did not preserve the authorship of the original commit
  when it was asked to rewrite the commit, for instance using
  `reword`. This was fixed by applying the authorship of the named
  commit using `do_with_author`. That doesn't interfere with squash
  commits because `do_with_author` is a no-op when used with `git
  commit --amend`.

- `git rebase --continue` did not apply the line options after
  conflict resolution. This was added by remembering line options the
  way `git-rebase--interactive.sh` reminds itself of amending
  commits.

- The test suite `t3427-rebase-line-options.sh` is responsible for
  the specification of to-do lists that use line options.

- The two line options available are now documented both in the
  git-rebase man page and the to-do list help text.

Thanks for your time,
   Fabian

Fabian Ruch (27):
  rebase -i: allow replaying commits with empty log messages
  rebase -i: allow squashing empty commits without complaints
  rebase -i: allow rewording empty commits without complaints
  fake_editor: leave standard output unchanged
  rebase -i: hide interactive command messages in verbose mode
  rebase -i: discard redundant message when rewording fails
  commit: allow disabling pre-commit and commit-msg separately
  rebase -i: verify squash messages using commit-msg
  rebase -i: do not verify reworded patches using pre-commit
  rebase -i: teach do_pick the option --edit
  rebase -i: implement reword in terms of do_pick
  rebase -i: log the replay of root commits
  rebase -i: do not use -C when --no-edit is sufficient
  rebase -i: commit only once when rewriting picks
  rebase -i: do not die in do_pick
  rebase -i: teach do_pick the option --amend
  rebase -i: teach do_pick the option --file
  rebase -i: remove no-op do_with_author git commit --amend
  rebase -i: prepare for squash in terms of do_pick --amend
  rebase -i: implement squash in terms of do_pick
  rebase -i: explicitly distinguish replay commands and exec tasks
  rebase -i: parse to-do list command line options
  rebase -i: teach do_pick the option --reset-author
  rebase -i: teach do_pick the option --signoff
  rebase -i: do not overwrite user author information
  rebase -i: refuse to commit when resuming with updated head
  rebase -i: enable --signoff, --reset-author for pick, reword, edit

 Documentation/git-commit.txt   |   8 +-
 Documentation/git-rebase.txt   |  13 ++
 builtin/commit.c               |  32 +++-
 git-rebase--interactive.sh     | 370 ++++++++++++++++++++++++++++++++---------
 git-rebase.sh                  |  13 +-
 t/lib-rebase.sh                |  28 +++-
 t/t3404-rebase-interactive.sh  | 290 ++++++++++++++++++++++++++++++--
 t/t3406-rebase-message.sh      |  18 ++
 t/t3412-rebase-root.sh         |  16 ++
 t/t3427-rebase-line-options.sh | 216 ++++++++++++++++++++++++
 t/t7503-pre-commit-hook.sh     |  65 +++++++-
 t/t7504-commit-msg-hook.sh     |  85 ++++++++--
 t/test-lib-functions.sh        |  23 ++-
 13 files changed, 1044 insertions(+), 133 deletions(-)
 create mode 100755 t/t3427-rebase-line-options.sh

-- 
2.0.1
