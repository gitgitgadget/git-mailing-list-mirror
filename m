From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] t/Makefile: fix result handling with TEST_OUTPUT_DIRECTORY
Date: Fri, 26 Apr 2013 19:55:52 +0100
Message-ID: <7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 20:56:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVnoh-00020R-Fu
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 20:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549Ab3DZS4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 14:56:15 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:60341 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754Ab3DZS4O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 14:56:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 5DD7260657F;
	Fri, 26 Apr 2013 19:56:14 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QyVJTMsAMiBS; Fri, 26 Apr 2013 19:56:14 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 9012D606518;
	Fri, 26 Apr 2013 19:56:06 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.715.gb260f47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222555>

When TEST_OUTPUT_DIRECTORY is set, the test results will be generated in
"$TEST_OUTPUT_DIRECTORY/test-results", which may not be the same as
"test-results" in t/Makefile.  This causes the aggregate-results target
to fail as it finds no count files.

Fix this by introducing TEST_RESULTS_DIRECTORY and using it wherever
test-results is referenced.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/Makefile | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 44ca7d3..0e1408d 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -15,9 +15,16 @@ PROVE ?= prove
 DEFAULT_TEST_TARGET ?= test
 TEST_LINT ?= test-lint-duplicates test-lint-executable
 
+ifdef TEST_OUTPUT_DIRECTORY
+TEST_RESULTS_DIRECTORY = $(TEST_RESULTS_DIRECTORY)/test-results
+else
+TEST_RESULTS_DIRECTORY = test-results
+endif
+
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
 
 T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
 TSVN = $(sort $(wildcard t91[0-9][0-9]-*.sh))
@@ -36,10 +43,10 @@ $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
 pre-clean:
-	$(RM) -r test-results
+	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
 clean-except-prove-cache:
-	$(RM) -r 'trash directory'.* test-results
+	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
@@ -65,7 +72,7 @@ aggregate-results-and-cleanup: $(T)
 	$(MAKE) clean
 
 aggregate-results:
-	for f in test-results/t*-*.counts; do \
+	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
 		echo "$$f"; \
 	done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh
 
-- 
1.8.2.1.715.gb260f47
