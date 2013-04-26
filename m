From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] test output: respect $TEST_OUTPUT_DIRECTORY
Date: Fri, 26 Apr 2013 19:55:53 +0100
Message-ID: <47c9ba4200a22e865040208628357d9bc4bcf3f4.1367002553.git.john@keeping.me.uk>
References: <7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 20:56:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVnor-0002Bo-90
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 20:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757552Ab3DZS4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 14:56:25 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:60415 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754Ab3DZS4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 14:56:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E637E198008;
	Fri, 26 Apr 2013 19:56:23 +0100 (BST)
X-Quarantine-ID: <B207BzWD6JOk>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B207BzWD6JOk; Fri, 26 Apr 2013 19:56:23 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C2586606584;
	Fri, 26 Apr 2013 19:56:14 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.715.gb260f47
In-Reply-To: <7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
In-Reply-To: <7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
References: <7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222556>

Most test results go in $TEST_OUTPUT_DIRECTORY, but the output files for
tests run with --tee or --valgrind just use bare "test-results".
Changes these so that they do respect $TEST_OUTPUT_DIRECTORY.

As a result of this, the valgrind/analyze.sh script may no longer
inspect the correct files so it is also updated to respect
$TEST_OUTPUT_DIRECTORY by adding it to GIT-BUILD-OPTIONS.  This may be a
regression for people who have TEST_OUTPUT_DIRECTORY in their config.mak
but want to override it in the environment, but this change merely
brings it into line with GIT_TEST_OPTS which already cannot be
overridden if it is specified in config.mak.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Makefile              | 3 +++
 t/test-lib.sh         | 4 ++--
 t/valgrind/analyze.sh | 8 ++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 90661a2..d4d95fa 100644
--- a/Makefile
+++ b/Makefile
@@ -2166,6 +2166,9 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
+ifdef TEST_OUTPUT_DIRECTORY
+	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@
+endif
 ifdef GIT_TEST_OPTS
 	@echo GIT_TEST_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_OPTS)))'\' >>$@
 endif
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ca6bdef..70ad085 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -54,8 +54,8 @@ done,*)
 	# do not redirect again
 	;;
 *' --tee '*|*' --va'*)
-	mkdir -p test-results
-	BASE=test-results/$(basename "$0" .sh)
+	mkdir -p "$(TEST_OUTPUT_DIRECTORY)/test-results"
+	BASE="$(TEST_OUTPUT_DIRECTORY)/test-results/$(basename "$0" .sh)"
 	(GIT_TEST_TEE_STARTED=done ${SHELL_PATH} "$0" "$@" 2>&1;
 	 echo $? > $BASE.exit) | tee $BASE.out
 	test "$(cat $BASE.exit)" = 0
diff --git a/t/valgrind/analyze.sh b/t/valgrind/analyze.sh
index d8105d9..7b58f01 100755
--- a/t/valgrind/analyze.sh
+++ b/t/valgrind/analyze.sh
@@ -1,6 +1,10 @@
 #!/bin/sh
 
-out_prefix=$(dirname "$0")/../test-results/valgrind.out
+# Get TEST_OUTPUT_DIRECTORY from GIT-BUILD-OPTIONS if it's there...
+. "$(dirname "$0")/../../GIT-BUILD-OPTIONS"
+# ... otherwise set it to the default value.
+: ${TEST_OUTPUT_DIRECTORY=$(dirname "$0")/..}
+
 output=
 count=0
 total_count=0
@@ -115,7 +119,7 @@ handle_one () {
 	finish_output
 }
 
-for test_script in "$(dirname "$0")"/../test-results/*.out
+for test_script in "$(TEST_OUTPUT_DIRECTORY)"/test-results/*.out
 do
 	handle_one $test_script
 done
-- 
1.8.2.1.715.gb260f47
