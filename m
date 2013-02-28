From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v8 0/5] git log -L
Date: Thu, 28 Feb 2013 17:38:18 +0100
Message-ID: <cover.1362069310.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 17:38:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB6VT-0001uK-Qu
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 17:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405Ab3B1Qi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 11:38:29 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:16844 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753948Ab3B1Qi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 11:38:28 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Feb
 2013 17:38:23 +0100
Received: from pctrast.inf.ethz.ch (213.55.184.243) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Feb
 2013 17:38:25 +0100
X-Mailer: git-send-email 1.8.2.rc1.388.g1bd82c8
X-Originating-IP: [213.55.184.243]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217236>

Here's another shot :-)

For an instructive example, apply it and run

  git log -L:archiver:archive.h

in your git.git.

Last time around, apart from some minor issues, there was one main
point discussed[1]: it should be possible to do the line-log in two
separate steps, one for filtering and one for the diffing.

That would have some really nice advantages, in particular it would
let us generate the diff within the usual diff chain.  That way it
would work together with e.g. --word-diff automatically.

However, with the whole diff chain IMHO already being in some
disarray, that's such a far-off goal (and a good example of gsoc scope
creep!) that I can't see myself working on it in the near future
unless someone decides to pay me for working on Git.  Meanwhile, this
seems to be the only blocker for the inclusion of a feature for which
all feedback has been "WANT!" since it worked for the first time.

So I'd rather settle for including this slightly hacky version, and
then improving on it incrementally.

There are more things that need to be done: my rewrite for readability
(see [1] again) lost the support for -C and -C -C, so it no longer is
any use with big code moves.  The only thing that currently works is
-M, which will track the ranges across a file rename that can be
detected by the diff engine (i.e., it works by letting the diff engine
form a rename filepair).

Changes since v7 include:

- An all-new patch that allows for funcname matching: -L:pattern:file.
  I find it makes calling line-log (or blame, for that matter) much
  more natural.  I'm not exactly married to the syntax; in particular
  it feels weird in blame where you have to say 'git blame -L:foo file'.
  If you have better ideas, please shout.

- Tests!  Yay.  Also fixes for bugs found by the tests ;-)

- Dropped the unnecessary patch "Export three functions from diff.c".


Bo Yang (2):
  Refactor parse_loc
  Export rewrite_parents() for 'log -L'

Thomas Rast (3):
  blame: introduce $ as "end of file" in -L syntax
  Implement line-history search (git log -L)
  log -L: :pattern:file syntax to find by funcname

 Documentation/blame-options.txt     |   19 +-
 Documentation/git-log.txt           |   22 +
 Documentation/line-range-format.txt |   31 +
 Makefile                            |    2 +
 builtin/blame.c                     |   99 +--
 builtin/log.c                       |   31 +
 line-log.c                          | 1433 +++++++++++++++++++++++++++++++++++
 line-log.h                          |   80 ++
 log-tree.c                          |    4 +
 revision.c                          |   22 +-
 revision.h                          |   16 +-
 t/t4211-line-log.sh                 |   42 +
 t/t4211/expect.beginning-of-file    |   43 ++
 t/t4211/expect.end-of-file          |   62 ++
 t/t4211/expect.move-support-f       |   40 +
 t/t4211/expect.simple-f             |   59 ++
 t/t4211/expect.simple-f-to-main     |  100 +++
 t/t4211/expect.simple-main          |   68 ++
 t/t4211/expect.simple-main-to-end   |   70 ++
 t/t4211/expect.two-ranges           |  102 +++
 t/t4211/expect.vanishes-early       |   39 +
 t/t4211/history.export              |  330 ++++++++
 t/t8003-blame-corner-cases.sh       |    6 +
 23 files changed, 2601 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/line-range-format.txt
 create mode 100644 line-log.c
 create mode 100644 line-log.h
 create mode 100755 t/t4211-line-log.sh
 create mode 100644 t/t4211/expect.beginning-of-file
 create mode 100644 t/t4211/expect.end-of-file
 create mode 100644 t/t4211/expect.move-support-f
 create mode 100644 t/t4211/expect.simple-f
 create mode 100644 t/t4211/expect.simple-f-to-main
 create mode 100644 t/t4211/expect.simple-main
 create mode 100644 t/t4211/expect.simple-main-to-end
 create mode 100644 t/t4211/expect.two-ranges
 create mode 100644 t/t4211/expect.vanishes-early
 create mode 100644 t/t4211/history.export

-- 
1.8.2.rc1.388.g1bd82c8
