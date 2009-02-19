From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/8] Support coverage testing with GCC/gcov
Date: Thu, 19 Feb 2009 12:13:35 +0100
Message-ID: <fe8993f99f8459f74f704a488cdffbd4cf10b0fd.1235041345.git.trast@student.ethz.ch>
References: <cover.1235041345.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:15:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La6sG-00008u-AX
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 12:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbZBSLN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 06:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbZBSLN6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 06:13:58 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16533 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316AbZBSLNz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 06:13:55 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:52 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:52 +0100
X-Mailer: git-send-email 1.6.2.rc1.266.gce6c4
In-Reply-To: <cover.1235041345.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Feb 2009 11:13:52.0165 (UTC) FILETIME=[2557C550:01C99283]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110673>

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

Let the 'all' sub-build of 'coverage' run with the caller's -j setting
so that it can parallelize.

Interdiff:

   --- a/Makefile
   +++ b/Makefile
  @@ -21,8 +21,9 @@
   +COVERAGE_LDFLAGS = $(CFLAGS)  -O0 -lgcov
   +
   +coverage-build: coverage-clean
  ++      $(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" all
   +      $(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
  -+              -j1 all test
  ++              -j1 test
   +
   +coverage-report:
   +      gcov -b *.c


 Makefile |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b040a96..c32881b 100644
--- a/Makefile
+++ b/Makefile
@@ -1640,3 +1640,27 @@ check-docs::
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
+	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" all
+	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
+		-j1 test
+
+coverage-report:
+	gcov -b *.c
+	grep '^function.*called 0 ' *.c.gcov \
+		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
+		| tee coverage-untested-functions
--
1.6.2.rc1.266.gce6c4
