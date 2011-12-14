From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 0/4] Performance test framework
Date: Wed, 14 Dec 2011 16:23:28 +0100
Message-ID: <cover.1323876121.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 16:23:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaqgL-0001QF-FK
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 16:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298Ab1LNPXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 10:23:36 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:27490 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757112Ab1LNPXg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 10:23:36 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 16:23:31 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 16:23:33 +0100
X-Mailer: git-send-email 1.7.8.304.ge42e4
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187127>

Hi,

This is the first shot at a usable performance test suite.  It's
another angle than the refperf work of Michael Haggerty, however he
helped shape this in #git-devel (thanks!).

There's a big README, but if you just want to dive in, here's me
comparing the grep performance of my POC "pack reading in parallel"
branch against Junio's next:

  $ cd t/perf
  $ ./run origin/next t/sha1_file-parallel p7810-grep.sh 
  [snip no-op compilation]
  === Running 1 tests in build/7a6d658aa3c9016dd04ff3515cbf15edca6562a4 ===
  perf 1 - grep worktree, cheap regex: 1 2 3 4 5 ok
  perf 2 - grep worktree, expensive regex: 1 2 3 4 5 ok
  perf 3 - grep --cached, cheap regex: 1 2 3 4 5 ok
  perf 4 - grep --cached, expensive regex: 1 2 3 4 5 ok
  # passed all 4 test(s)
  1..4
  GIT_VERSION = 1.7.8.GIT
      * new build flags or prefix
      * new link flags
      GEN common-cmds.h
      CC hex.o
      CC kwset.o
  [snip rest of compilation]
  === Running 1 tests in build/dd2bf650b382f5aca727b7d93a48598fb1a2f7d9 ===
  perf 1 - grep worktree, cheap regex: 1 2 3 4 5 ok
  perf 2 - grep worktree, expensive regex: 1 2 3 4 5 ok
  perf 3 - grep --cached, cheap regex: 1 2 3 4 5 ok
  perf 4 - grep --cached, expensive regex: 1 2 3 4 5 ok
  # passed all 4 test(s)
  1..4
  Test                                     origin/next        t/sha1_file-parallel  
  ----------------------------------------------------------------------------------
  7810.1: grep worktree, cheap regex       0.16(0.16+0.35)    0.16(0.15+0.36) +0.0% 
  7810.2: grep worktree, expensive regex   7.83(29.68+0.39)   7.95(29.98+0.39) +1.5%
  7810.3: grep --cached, cheap regex       3.12(3.11+0.24)    1.11(3.46+0.18) -64.4%
  7810.4: grep --cached, expensive regex   9.43(30.53+0.28)   8.89(32.99+0.22) -5.7%

Note in particular that neither of the two branches contains the perf
work.

Have fun!

Thomas Rast (4):
  Move the user-facing test library to test-lib-functions.sh
  test-lib: allow testing another git build tree
  Introduce a performance testing framework
  Add a performance test for git-grep

 Makefile                        |   26 ++-
 t/Makefile                      |    5 +-
 t/perf/.gitignore               |    2 +
 t/perf/Makefile                 |   15 +
 t/perf/README                   |  146 ++++++++++
 t/perf/aggregate.perl           |  166 ++++++++++++
 t/perf/min_time.perl            |   21 ++
 t/perf/p0000-perf-lib-sanity.sh |   41 +++
 t/perf/p0001-rev-list.sh        |   17 ++
 t/perf/p7810-grep.sh            |   23 ++
 t/perf/perf-lib.sh              |  199 ++++++++++++++
 t/perf/run                      |   82 ++++++
 t/test-lib-functions.sh         |  528 ++++++++++++++++++++++++++++++++++++
 t/test-lib.sh                   |  561 +++------------------------------------
 14 files changed, 1300 insertions(+), 532 deletions(-)
 create mode 100644 t/perf/.gitignore
 create mode 100644 t/perf/Makefile
 create mode 100644 t/perf/README
 create mode 100755 t/perf/aggregate.perl
 create mode 100755 t/perf/min_time.perl
 create mode 100755 t/perf/p0000-perf-lib-sanity.sh
 create mode 100755 t/perf/p0001-rev-list.sh
 create mode 100755 t/perf/p7810-grep.sh
 create mode 100644 t/perf/perf-lib.sh
 create mode 100755 t/perf/run
 create mode 100644 t/test-lib-functions.sh

-- 
1.7.8.304.ge42e4
