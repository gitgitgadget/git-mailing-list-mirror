From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 24/24] test-lib: allow setting the index format version
Date: Sun, 18 Aug 2013 21:42:13 +0200
Message-ID: <1376854933-31241-25-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:49:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8yn-0004Uv-Ox
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab3HRTtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:49:33 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43549 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124Ab3HRTtc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:49:32 -0400
Received: by mail-wg0-f44.google.com with SMTP id l18so2891708wgh.23
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZzzGuoXanh2VR1fBs7ftyUrcY7bKu0B/MdK+BUFD7Yk=;
        b=0aKa4wU0sdkOPDHzLNuN65DQV95wAlzrvXjwDGSsNinODZPnUlpU5k21Le3NOhMRyq
         7krQuuUzwkKyJ4uXE8LhzW5+oogL9DfKaufYHCmkW0OxU+9uZa3OxP8WZ9+exOumJDMb
         Fb24nLDegZxRDa60OtN9k/YHLuuLAqLLo4vtj2dFJNkxapKUQc/7JpUuogn0e9siaHUD
         psOTqvraACqO8xPDA7vjon6GYz6fXLcwRqZk0RhMBiz77vKt+69j5M6+m7wPEMuk93Q3
         SWVV84FPDOhTGWpdhpLy++eTi6S7X+52WKp7n4BwN+aV1hg0TEsP6wpD/zYVYhAMbt6H
         nr+A==
X-Received: by 10.180.91.6 with SMTP id ca6mr5571425wib.4.1376855371038;
        Sun, 18 Aug 2013 12:49:31 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id v9sm11991996wiw.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:49:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232512>

When running the test suite, it should be possible to set the default
index format for the tests.  Do that by allowing the user to add a
TEST_GIT_INDEX_VERSION variable in config.mak setting the index version.

If it isn't set, the default version given in the source code is
used (currently version 3).

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Makefile                | 7 +++++++
 t/test-lib-functions.sh | 5 +++++
 t/test-lib.sh           | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/Makefile b/Makefile
index a55206d..ecae6b8 100644
--- a/Makefile
+++ b/Makefile
@@ -345,6 +345,10 @@ all::
 # Define DEFAULT_HELP_FORMAT to "man", "info" or "html"
 # (defaults to "man") if you want to have a different default when
 # "git help" is called without a parameter specifying the format.
+#
+# Define TESTGIT_INDEX_FORMAT to 2, 3, 4 or 5 to run the test suite
+# with a different indexfile format.  If it isn't set the index file
+# format used is index-v[23].
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -2229,6 +2233,9 @@ endif
 ifdef GIT_PERF_MAKE_OPTS
 	@echo GIT_PERF_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_MAKE_OPTS)))'\' >>$@
 endif
+ifdef TEST_GIT_INDEX_VERSION
+	@echo TEST_GIT_INDEX_VERSION='$(subst ','\'',$(subst ','\'',$(TEST_GIT_INDEX_VERSION)))' >>$@
+endif
 
 ### Detect Python interpreter path changes
 ifndef NO_PYTHON
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index a7e9aac..19cdf0b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -31,6 +31,11 @@ test_set_editor () {
 	export EDITOR
 }
 
+test_set_index_version () {
+    GIT_INDEX_VERSION="$1"
+    export GIT_INDEX_VERSION
+}
+
 test_decode_color () {
 	awk '
 		function name(n) {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1aa27bd..9ca41e1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -104,6 +104,9 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
+GIT_INDEX_VERSION="$TEST_GIT_INDEX_VERSION"
+export GIT_INDEX_VERSION
+
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
-- 
1.8.3.4.1231.g9fbf354.dirty
