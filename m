From: Jeff King <peff@peff.net>
Subject: [PATCH 00/16] solaris portability patches
Date: Wed, 12 Mar 2008 17:29:32 -0400
Message-ID: <20080312212932.GA26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:30:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYWc-0005zp-Jz
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbYCLV3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbYCLV3f
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:29:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4631 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbYCLV3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:29:35 -0400
Received: (qmail 2570 invoked by uid 111); 12 Mar 2008 21:29:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:29:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:29:32 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76990>

I've been trying to run the testsuite under Solaris without using any of
the more fancy tools available. Maybe this is foolhardy, and we should
simply say "at least put /usr/ucb in your PATH if you're going to run
the testsuite." Even with that, though, some of the patches below still
fix problems, either because the ucb and xpg4 versions given with
Solaris also don't work, or because the problem is in a git script
itself, and I don't think we want to force users to have /usr/ucb at the
front of their PATH.

The series goes on top of the current master.  The first patch is a
repost from this morning that was embedded in a thread, but the rest are
new. The order of patches is roughly in the order that the bugs come up
if you try to run the testsuite. :)

It may be that some are less controversial than others, and I can try to
re-order if need be.

With these patches applied, running

  PATH=/usr/bin:/bin /path/to/gmake test

passes with the following exceptions:

t3701-add-interactive.sh
t7501-commit.sh (only interactive add test)
  git-add--interactive doesn't work with perl 5.005. I haven't looked
  into it any more closely.

t9001-send-email.sh
  send-email doesn't work with perl 5.005 (haven't looked closer)

t3900-i18n-commit.sh
  I think there are some iconv issues with Japanese charsets. I tried
  debugging this before but didn't get very far.

t4109-apply-multifrag.sh
t4110-apply-scan.sh
  These tests invoke the system 'patch' which doesn't like our git
  patches very much. Despite having stdout/stderr redirected, it insists
  on printing "File to patch?" to the terminal and waiting for input.

t4116-apply-reverse.sh
  system tar doesn't recognize typeflag 'g' in our git-archive
  generated tarfile. It returns an error, which prevents further setup
  from happening.

t5000-tar-tree.sh
  The system awk complains about a long awk line. I ran out of time to
  try tracking it down.

t3901-i18n-patch.sh
t4024-diff-optimize-common.sh
  I ran out of time to look more closely at these ones. Grab bag of
  portability bugs!

The patches are:

  tr portability fixes
  t0050: perl portability fix
  more tr portability test script fixes
  grep portability fix: don't use "-e" or "-q"
  remove use of "tail -n 1" and "tail -1"
  add test_cmp function for test scripts
  t4020: don't use grep -a
  t4200: use cut instead of sed
  t6000lib: tr portability fix
  add NO_EXTERNAL_GREP build option
  config: add --literal-match option
  git-submodule: avoid sed input with no newline
  filter-branch: don't use xargs -0
  filter-branch: use $SHELL_PATH instead of 'sh'
  t9112: add missing #!/bin/sh header
  t7505: use SHELL_PATH in hook

 Documentation/git-config.txt       |    7 ++++
 Makefile                           |    8 ++++
 builtin-config.c                   |   50 ++++++++++++++++++++-------
 builtin-grep.c                     |    4 +-
 builtin-remote.c                   |    2 +-
 cache.h                            |    2 +-
 config.c                           |   67 ++++++++++++++++++++++++------------
 git-am.sh                          |    2 +-
 git-bisect.sh                      |    4 +-
 git-filter-branch.sh               |    8 ++--
 git-rebase--interactive.sh         |    8 ++--
 git-submodule.sh                   |   19 +++++-----
 t/diff-lib.sh                      |    4 +-
 t/t0003-attributes.sh              |    2 +-
 t/t0020-crlf.sh                    |    2 +-
 t/t0022-crlf-rename.sh             |    2 +-
 t/t0030-stripspace.sh              |   34 +++++++++---------
 t/t0050-filesystem.sh              |    4 +-
 t/t1005-read-tree-reset.sh         |    2 +-
 t/t1300-repo-config.sh             |   17 ++++++++-
 t/t2200-add-update.sh              |    2 +-
 t/t3001-ls-files-others-exclude.sh |    2 +-
 t/t3050-subprojects-fetch.sh       |    4 +-
 t/t3060-ls-files-with-tree.sh      |    2 +-
 t/t3201-branch-contains.sh         |    6 ++--
 t/t3300-funny-names.sh             |    6 ++--
 t/t3404-rebase-interactive.sh      |   11 +++---
 t/t3405-rebase-malformed.sh        |    4 +-
 t/t3406-rebase-message.sh          |    2 +-
 t/t3701-add-interactive.sh         |    4 +-
 t/t3800-mktag.sh                   |    2 +-
 t/t3902-quoted.sh                  |   16 ++++----
 t/t3903-stash.sh                   |    2 +-
 t/t4020-diff-external.sh           |    5 ++-
 t/t4020/diff.NUL                   |  Bin 0 -> 116 bytes
 t/t4022-diff-rewrite.sh            |    5 ++-
 t/t4023-diff-rename-typechange.sh  |    6 ++--
 t/t4024-diff-optimize-common.sh    |    2 +-
 t/t4025-hunk-header.sh             |    2 +-
 t/t4027-diff-submodule.sh          |    6 ++--
 t/t4103-apply-binary.sh            |    4 +-
 t/t4105-apply-fuzz.sh              |    2 +-
 t/t4116-apply-reverse.sh           |    4 +-
 t/t4125-apply-ws-fuzz.sh           |    8 ++--
 t/t4150-am-subdir.sh               |   10 +++---
 t/t4200-rerere.sh                  |    4 +-
 t/t4201-shortlog.sh                |    2 +-
 t/t5300-pack-object.sh             |    2 +-
 t/t5302-pack-index.sh              |    4 +-
 t/t5400-send-pack.sh               |    2 +-
 t/t5505-remote.sh                  |    6 ++--
 t/t5510-fetch.sh                   |    2 +-
 t/t5512-ls-remote.sh               |    8 ++--
 t/t6000lib.sh                      |    5 ++-
 t/t6004-rev-list-path-optim.sh     |    2 +-
 t/t6009-rev-list-parent.sh         |    2 +-
 t/t6027-merge-binary.sh            |    4 +-
 t/t6029-merge-subtree.sh           |    2 +-
 t/t6030-bisect-porcelain.sh        |    6 ++--
 t/t7003-filter-branch.sh           |    2 +-
 t/t7010-setup.sh                   |   18 +++++-----
 t/t7201-co.sh                      |   18 +++++-----
 t/t7501-commit.sh                  |   14 ++++----
 t/t7502-commit.sh                  |   14 ++++----
 t/t7502-status.sh                  |    4 +-
 t/t7505-prepare-commit-msg-hook.sh |    3 +-
 t/t7600-merge.sh                   |    8 ++--
 t/t8003-blame.sh                   |    4 +-
 t/t9001-send-email.sh              |    2 +-
 t/t9112-git-svn-md5less-file.sh    |    2 +
 t/t9116-git-svn-log.sh             |   24 ++++++------
 t/t9200-git-cvsexportcommit.sh     |   14 ++++----
 t/t9400-git-cvsserver-server.sh    |   28 +++++++-------
 t/test-lib.sh                      |   18 ++++++++++
 test-sha1.sh                       |    4 +-
 75 files changed, 347 insertions(+), 246 deletions(-)
 create mode 100644 t/t4020/diff.NUL
