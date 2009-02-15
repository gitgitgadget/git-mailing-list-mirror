From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/8] Support coverage testing with GCC/gcov
Date: Sun, 15 Feb 2009 23:25:38 +0100
Message-ID: <fb1e427bf56f5061634bc57fe6837f75e36c6cb2.1234736374.git.trast@student.ethz.ch>
References: <cover.1234736374.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 23:28:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpSt-0004VH-30
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 23:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbZBOWZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 17:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbZBOWZ6
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 17:25:58 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:11608 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbZBOWZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 17:25:56 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:54 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:53 +0100
X-Mailer: git-send-email 1.6.2.rc0.335.g1a2b
In-Reply-To: <cover.1234736374.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Feb 2009 22:25:53.0944 (UTC) FILETIME=[5D57F980:01C98FBC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110070>

With gcc's --coverage option, we can perform automatic coverage data
collection for the test suite.

Add a new Makefile target 'coverage' that scraps all previous coverage
results, recompiles git with the required compiler/linker flags (in
addition to any flags you specify manually), then runs the test suite
and compiles a report.

The compilation must be done with all optimizations disabled, since
inlined functions (and for line-by-line coverage, also optimized
branches/loops) break coverage tracking.

The tests are run serially (with -j1).  The coverage code should
theoretically allow concurrent access to its data files, but the
author saw random test failures.  Obviously this could be improved.

The report currently consists of a list of functions that were never
executed during the tests, which is written to
'coverage-untested-functions'.  Once this list becomes reasonably
short, we would also want to look at branches that were never taken.

Currently only toplevel *.c files are considered.  It would be nice to
at least include xdiff, but --coverage did not save data to
subdirectories on the system used to write this (gcc 4.3.2).

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Makefile |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b040a96..1c514a9 100644
--- a/Makefile
+++ b/Makefile
@@ -1640,3 +1640,26 @@ check-docs::
 check-builtins::
 	./check-builtins.sh
 
+### Test suite coverage testing
+#
+.PHONY: coverage coverage-clean coverage-build coverage-report
+
+coverage:
+	$(MAKE) coverage-build
+	$(MAKE) coverage-report
+
+coverage-clean:
+	rm -f *.gcda *.gcno
+
+COVERAGE_CFLAGS = $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs
+COVERAGE_LDFLAGS = $(CFLAGS)  -O0 -lgcov
+
+coverage-build: coverage-clean
+	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
+		-j1 all test
+
+coverage-report:
+	gcov -b *.c
+	grep '^function.*called 0 ' *.c.gcov \
+		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
+		| tee coverage-untested-functions
-- 
1.6.2.rc0.335.g1a2b
