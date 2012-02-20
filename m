From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 0/8 v6] diff --stat: use the full terminal width
Date: Mon, 20 Feb 2012 22:57:06 +0100
Message-ID: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 20 22:57:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzbEz-0004EN-2u
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 22:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911Ab2BTV5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 16:57:44 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52828 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470Ab2BTV5n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 16:57:43 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RzbEr-0007o6-Ac; Mon, 20 Feb 2012 22:57:41 +0100
X-Mailer: git-send-email 1.7.9.1.353.g684b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191108>

Hi,

this is v6, with a new approach. The biggest change is that now the
full terminal width is used in show_stats() only when explictely
requested by the calling code. This is done by setting stat_width=-1
in diffopts in the builtin commands diff, stat, log, and merge. The
series includes to-be-squashed-eds from Junio and is also structured
differently. I followed Junio's advice and split the change to use
full terminal-width, into two patches: one which makes show_stats()
start using term_columns(), and a second one which changes the logic
to divide available columns. This proved to be a good move because it
caught a bug/deficiency in the tests: the tests I added tried to
verify that format-patch output ignores COLUMNS by setting
COLUMNS=200. Unfortunately, because the graph part was limited to 40
columns, the maximum output was less than 80 columns, the test
didn't really check anything. New tests check with both 40 and 200
columns to verify that it really works.

Since there were conflicts with 'jc/diff-stat-scaler' and
'nd/diffstat-gramnum', this re-roll is rebased on top of those two
branches.

v6:

[1/8]  make lineno_width() from blame reusable for others
  This is very close to what was in pu, but I'm sending a new version:
  - the function argument is changed from int to uintmax_t
    (max_change is uintmax_t and 9/9 does decimal_width(max_change).)
[2/8] diff --stat: tests for long filenames and big change counts
  - Tests are run for format-patch, diff, log, show, and merge.
  - Since tests are not only for format-patch, they are added in a new
    file t/t4052-stat-output.sh.
[3/8] diff --stat: use the full terminal width
  Add logic to use term_columns() when diffopts.stat_width==-1 and
  turn it on in git-diff --stat.
  - show_stats() output is adapted to full terminal width only when
    diffopts.stat_width==-1.
[4/8] show --stat: use the full terminal width
  Enable for git-show.
[5/8] log --stat: use the full terminal width
  Enable for log-show.
[6/8] merge --stat: use the full terminal width
  Enable for git-merge.
[7/8] diff --stat: limit graph part to 40 columns
  Change the logic to divide columns. This part is the unchanged from 
  v5, just separated from 3/9.
[8/8] diff --stat: use less columns for change counts
  This one is optional, to be applied or not, "when the dust settles".

Open questions:
JC:
> Perhaps the maximum for garph_width should be raised to something like
> "min(80, stat_width) - name_width"?
I think that a graph like
a | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
b |    1 -
is not very readable. I like the consistency forced by the 40-column limit.
But I guess that this is very subjective.

NTC:
> If the required number of columns is less than 80 (or even lower), can
> we maintain current spacing strategy? I just want to avoid mass
> updates in the test suite. More or less space does not make much
> different for narrow diffstats anyway.
Patch 9/9 does this "massive" change. It touches many files but is
completely trivial. I hope it'll not be a problem.

Zbyszek


v5:
- tests are moved to an earlier patch
  - seq is replaced with a while loop for windows compatibility
  - grep -m 1 is replaced with grep " | "
  - redirects are made portable
  - piped output is split into two commands to verify that the first command
    sucessfully runs to completion
- using decimal_width(change count) is moved to a later patch
- "histogram" is really not used


v4:
- comments are updated and the word "histogram" is banished
- "mopping up" is removed (but the minimum width are guaranteed)

v3:
- use decimal_width(max_change) to calculate number of columns
  required for change counts
- rework the logic to divide columns
- document the logic in comments, update docs
- add more tests

v2:
- style fixes
- some tests for git-format-patch added
- patches 3 and 4 squashed together, since they touch the same lines
- graph width is limited to 40 columns, even if there's more space
- patch descriptions extended and cleared up

 Documentation/diff-options.txt                     |  14 +-
 Documentation/gitcore-tutorial.txt                 |   4 +-
 builtin/blame.c                                    |  18 +-
 builtin/diff.c                                     |   3 +
 builtin/log.c                                      |   3 +
 builtin/merge.c                                    |   1 +
 builtin/reset.c                                    |   2 +
 cache.h                                            |   1 +
 diff.c                                             | 129 ++++++++++----
 pager.c                                            |  13 ++
 t/t0023-crlf-am.sh                                 |   2 +-
 t/t1200-tutorial.sh                                |   4 +-
 t/t3404-rebase-interactive.sh                      |   2 +-
 t/t3903-stash.sh                                   |   4 +-
 t/t4012-diff-binary.sh                             |  19 +++
 ...ff-tree_--cc_--patch-with-stat_--summary_master |   4 +-
 ...diff-tree_--cc_--patch-with-stat_--summary_side |   6 +-
 .../diff.diff-tree_--cc_--patch-with-stat_master   |   4 +-
 .../diff.diff-tree_--cc_--stat_--summary_master    |   4 +-
 t/t4013/diff.diff-tree_--cc_--stat_--summary_side  |   6 +-
 t/t4013/diff.diff-tree_--cc_--stat_master          |   4 +-
 ...pretty=oneline_--root_--patch-with-stat_initial |   6 +-
 .../diff.diff-tree_--pretty_--patch-with-stat_side |   6 +-
 ...-tree_--pretty_--root_--patch-with-stat_initial |   6 +-
 ...f-tree_--pretty_--root_--stat_--summary_initial |   6 +-
 .../diff.diff-tree_--pretty_--root_--stat_initial  |   6 +-
 ...diff.diff-tree_--root_--patch-with-stat_initial |   6 +-
 t/t4013/diff.diff-tree_-c_--stat_--summary_master  |   4 +-
 t/t4013/diff.diff-tree_-c_--stat_--summary_side    |   6 +-
 t/t4013/diff.diff-tree_-c_--stat_master            |   4 +-
 .../diff.diff_--patch-with-stat_-r_initial..side   |   6 +-
 t/t4013/diff.diff_--patch-with-stat_initial..side  |   6 +-
 t/t4013/diff.diff_--stat_initial..side             |   6 +-
 t/t4013/diff.diff_-r_--stat_initial..side          |   6 +-
 ..._--attach_--stdout_--suffix=.diff_initial..side |   6 +-
 ....format-patch_--attach_--stdout_initial..master |  16 +-
 ...format-patch_--attach_--stdout_initial..master^ |  10 +-
 ...ff.format-patch_--attach_--stdout_initial..side |   6 +-
 ...nline_--stdout_--numbered-files_initial..master |  16 +-
 ...tdout_--subject-prefix=TESTCASE_initial..master |  16 +-
 ....format-patch_--inline_--stdout_initial..master |  16 +-
 ...format-patch_--inline_--stdout_initial..master^ |  10 +-
 ...ormat-patch_--inline_--stdout_initial..master^^ |   6 +-
 ...ff.format-patch_--inline_--stdout_initial..side |   6 +-
 ...tch_--stdout_--cover-letter_-n_initial..master^ |  18 +-
 ...at-patch_--stdout_--no-numbered_initial..master |  16 +-
 ...ormat-patch_--stdout_--numbered_initial..master |  16 +-
 t/t4013/diff.format-patch_--stdout_initial..master |  16 +-
 .../diff.format-patch_--stdout_initial..master^    |  10 +-
 t/t4013/diff.format-patch_--stdout_initial..side   |   6 +-
 ....log_--patch-with-stat_--summary_master_--_dir_ |   6 +-
 t/t4013/diff.log_--patch-with-stat_master          |  16 +-
 t/t4013/diff.log_--patch-with-stat_master_--_dir_  |   6 +-
 ..._--root_--cc_--patch-with-stat_--summary_master |  26 +--
 ...f.log_--root_--patch-with-stat_--summary_master |  22 +--
 t/t4013/diff.log_--root_--patch-with-stat_master   |  22 +--
 ...og_--root_-c_--patch-with-stat_--summary_master |  26 +--
 t/t4013/diff.show_--patch-with-stat_--summary_side |   6 +-
 t/t4013/diff.show_--patch-with-stat_side           |   6 +-
 t/t4013/diff.show_--stat_--summary_side            |   6 +-
 t/t4013/diff.show_--stat_side                      |   6 +-
 ...nged_--patch-with-stat_--summary_master_--_dir_ |   6 +-
 t/t4013/diff.whatchanged_--patch-with-stat_master  |  16 +-
 ...ff.whatchanged_--patch-with-stat_master_--_dir_ |   6 +-
 ..._--root_--cc_--patch-with-stat_--summary_master |  26 +--
 ...anged_--root_--patch-with-stat_--summary_master |  22 +--
 ...iff.whatchanged_--root_--patch-with-stat_master |  22 +--
 ...ed_--root_-c_--patch-with-stat_--summary_master |  26 +--
 t/t4014-format-patch.sh                            |   2 +-
 t/t4016-diff-quote.sh                              |  14 +-
 t/t4030-diff-textconv.sh                           |   2 +-
 t/t4043-diff-rename-binary.sh                      |   4 +-
 t/t4045-diff-relative.sh                           |   2 +-
 t/t4047-diff-dirstat.sh                            |  54 +++---
 t/t4049-diff-stat-count.sh                         |   4 +-
 t/t4052-stat-output.sh                             | 189 +++++++++++++++++++++
 t/t5100/patch0001                                  |   2 +-
 t/t5100/patch0002                                  |   2 +-
 t/t5100/patch0003                                  |   2 +-
 t/t5100/patch0005                                  |   4 +-
 t/t5100/patch0006                                  |   2 +-
 t/t5100/patch0010                                  |   2 +-
 t/t5100/patch0011                                  |   2 +-
 t/t5100/patch0014                                  |   2 +-
 t/t5100/patch0014--scissors                        |   2 +-
 t/t5100/sample.mbox                                |  18 +-
 t/t7602-merge-octopus-many.sh                      |  12 +-
 87 files changed, 695 insertions(+), 409 deletions(-)
 create mode 100755 t/t4052-stat-output.sh

-- 
1.7.9.1.354.ge34f3
