From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 2/4] coverage: do not delete .gcno files before building
Date: Mon, 13 May 2013 23:27:26 +0200
Message-ID: <13bcab7694a9aa4707845769cacea2128664e407.1368479988.git.trast@inf.ethz.ch>
References: <cover.1368479988.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 23:27:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc0Hh-0004uF-SM
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 23:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347Ab3EMV1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 17:27:40 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:52715 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546Ab3EMV1d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 17:27:33 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 13 May
 2013 23:27:28 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 13 May
 2013 23:27:29 +0200
X-Mailer: git-send-email 1.8.3.rc1.400.g07d6e4a
In-Reply-To: <cover.1368479988.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224208>

The coverage-compile target depends on coverage-clean, which is
supposed to remove the earlier build products that would get in the
way of the next coverage test run.

However, removing *.gcno is actively wrong.  These are the files that
contain the compile-time coverage related data.  They are only rebuilt
if the source is compiled.  So if one ran 'make coverage' two times in
a row, the second run would remove *.gcno, but then fail to recreate
them because neither source files nor build flags have changed.  (This
remained hidden for so long most likely because any other intervening
use of 'make' will change the build flags, causing a full rebuild.)

So we make an exception for *.gcno.  The *.gcda are the coverage
results, written when the gcov-instrumented program is run.  We still
remove those, so as to get a one-test-run view of the data; you could
probably argue the other way too.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index f98296b..99e4d09 100644
--- a/Makefile
+++ b/Makefile
@@ -2443,7 +2443,7 @@ profile-clean:
 	$(RM) $(addsuffix *.gcda,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 
-clean: profile-clean
+clean: profile-clean coverage-clean
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
 		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
@@ -2525,20 +2525,23 @@ check-builtins::
 ### Test suite coverage testing
 #
 .PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
+.PHONY: coverage-clean-results
 
 coverage:
 	$(MAKE) coverage-test
 	$(MAKE) coverage-report
 
 object_dirs := $(sort $(dir $(OBJECTS)))
-coverage-clean:
+coverage-clean-results:
 	$(RM) $(addsuffix *.gcov,$(object_dirs))
 	$(RM) $(addsuffix *.gcda,$(object_dirs))
-	$(RM) $(addsuffix *.gcno,$(object_dirs))
 	$(RM) coverage-untested-functions
 	$(RM) -r cover_db/
 	$(RM) -r cover_db_html/
 
+coverage-clean: coverage-clean-results
+	$(RM) $(addsuffix *.gcno,$(object_dirs))
+
 COVERAGE_CFLAGS = $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs
 COVERAGE_LDFLAGS = $(CFLAGS)  -O0 -lgcov
 GCOVFLAGS = --preserve-paths --branch-probabilities --all-blocks
-- 
1.8.3.rc1.400.g07d6e4a
