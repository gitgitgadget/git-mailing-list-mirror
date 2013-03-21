From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v9 0/5] git log -L
Date: Thu, 21 Mar 2013 13:52:35 +0100
Message-ID: <cover.1363865444.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 21 13:53:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIeza-0004tz-Sp
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 13:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758206Ab3CUMwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 08:52:47 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:22138 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756438Ab3CUMwo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 08:52:44 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 21 Mar
 2013 13:52:38 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 21 Mar
 2013 13:52:41 +0100
X-Mailer: git-send-email 1.8.2.241.gee8bb87
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218720>

Compared to the previous round at

  http://thread.gmane.org/gmane.comp.version-control.git/217236

I made the following changes (numbers from v8):

[1/5] Refactor parse_loc

  Based on Junio's suggestions, the refactoring is now to a new file
  line-range.c that line-log.c will later use.  (It still irks me too
  much to call straight into builtin/blame.c.)

  I also re-copied the existing functions, to make sure that they are
  the same.  Junio correctly spotted some differences, and since we
  claim to only refactor those are bad.

[2/5] Export rewrite_parents() for 'log -L'

  Unchanged.

[2.5/5] blame: introduce $ as "end of file" in -L syntax

  Dropped.  As Junio remarked, omitting the end is already a valid way
  of saying the same.

[3/5] Implement line-history search (git log -L)

  Integrated Ramsay's fixes and Junio's remarks.  Also made some minor
  cleanups.  Added a perf test.

[4/5] log -L: :pattern:file syntax to find by funcname

  Adjusted for changes in the earlier patches; otherwise the same.

[5/5] Speed up log -L... -M

  Added to this series, I posted the same patch earlier in the side
  thread about the bad performance.  The perf test from 4/5 neatly
  shows the difference.

Bo Yang (2):
  Refactor parse_loc
  Export rewrite_parents() for 'log -L'

Thomas Rast (3):
  Implement line-history search (git log -L)
  log -L: :pattern:file syntax to find by funcname
  Speed up log -L... -M

 Documentation/blame-options.txt     |   21 +-
 Documentation/git-blame.txt         |    6 +-
 Documentation/git-log.txt           |   23 +
 Documentation/line-range-format.txt |   25 +
 Makefile                            |    4 +
 builtin/blame.c                     |   99 +--
 builtin/log.c                       |   31 +
 line-log.c                          | 1228 +++++++++++++++++++++++++++++++++++
 line-log.h                          |   49 ++
 line-range.c                        |  237 +++++++
 line-range.h                        |   36 +
 log-tree.c                          |    4 +
 revision.c                          |   22 +-
 revision.h                          |   16 +-
 t/perf/p4211-line-log.sh            |   34 +
 t/t4211-line-log.sh                 |   40 ++
 t/t4211/expect.beginning-of-file    |   43 ++
 t/t4211/expect.end-of-file          |   62 ++
 t/t4211/expect.move-support-f       |   40 ++
 t/t4211/expect.simple-f             |   59 ++
 t/t4211/expect.simple-main          |   68 ++
 t/t4211/expect.two-ranges           |  102 +++
 t/t4211/expect.vanishes-early       |   39 ++
 t/t4211/history.export              |  330 ++++++++++
 t/t8003-blame-corner-cases.sh       |    6 +
 25 files changed, 2501 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/line-range-format.txt
 create mode 100644 line-log.c
 create mode 100644 line-log.h
 create mode 100644 line-range.c
 create mode 100644 line-range.h
 create mode 100755 t/perf/p4211-line-log.sh
 create mode 100755 t/t4211-line-log.sh
 create mode 100644 t/t4211/expect.beginning-of-file
 create mode 100644 t/t4211/expect.end-of-file
 create mode 100644 t/t4211/expect.move-support-f
 create mode 100644 t/t4211/expect.simple-f
 create mode 100644 t/t4211/expect.simple-main
 create mode 100644 t/t4211/expect.two-ranges
 create mode 100644 t/t4211/expect.vanishes-early
 create mode 100644 t/t4211/history.export

-- 
1.8.2.241.gee8bb87
