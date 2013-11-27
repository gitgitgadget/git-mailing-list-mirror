From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 21/24] test-lib: allow setting the index format version
Date: Wed, 27 Nov 2013 13:00:56 +0100
Message-ID: <1385553659-9928-22-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldpO-0002HU-CY
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065Ab3K0MCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:02:39 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:32931 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414Ab3K0MCg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:02:36 -0500
Received: by mail-lb0-f172.google.com with SMTP id z5so5441248lbh.31
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NrWNLJHfJttFmJ9kYSNinJabc8GsT6cGEHpbA1FiEUU=;
        b=H5aP/6XMKqkkLZFudSMWBcuBa0qse2iiIZIvqDbrbunLuRAcnEDKyPf9PH/MuE1+hQ
         tk/05SFeKjcY9ZHjbSTDQZFxFHmKCUz01f44pqJ8Cx/JF6+9P0PHkteOKamepD+uPmmx
         sn99tI39CqrhSQ5uO8uWKy1iCFsPQ7AhvqrbF92wyKwKHwpxc4NsmxAg/Xqo3/7s2lbJ
         HS8HAR1pc0tMKUBgKCRp2hAb88hTBHULyslwboy1EmoqkD4O3aMHSV2xali6LSeXNgW1
         dF9dm3+zzebA2z8xA+oy+zoEyaQGafQUfaWfRIW1tnniDH2GT8ymhAkixWeNkdnkO7Z0
         cb5g==
X-Received: by 10.152.22.4 with SMTP id z4mr29488729lae.14.1385553755728;
        Wed, 27 Nov 2013 04:02:35 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id j1sm28804491lbl.10.2013.11.27.04.02.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:02:34 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238434>

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
index 6a1b054..8539548 100644
--- a/Makefile
+++ b/Makefile
@@ -342,6 +342,10 @@ all::
 # Define DEFAULT_HELP_FORMAT to "man", "info" or "html"
 # (defaults to "man") if you want to have a different default when
 # "git help" is called without a parameter specifying the format.
+#
+# Define TESTGIT_INDEX_FORMAT to 2, 3, 4 or 5 to run the test suite
+# with a different indexfile format.  If it isn't set the index file
+# format used is index-v[23].
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -2218,6 +2222,9 @@ endif
 ifdef GIT_PERF_MAKE_OPTS
 	@echo GIT_PERF_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_MAKE_OPTS)))'\' >>$@
 endif
+ifdef TEST_GIT_INDEX_VERSION
+	@echo TEST_GIT_INDEX_VERSION='$(subst ','\'',$(subst ','\'',$(TEST_GIT_INDEX_VERSION)))' >>$@
+endif
 
 ### Detect Python interpreter path changes
 ifndef NO_PYTHON
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2f79146..4034262 100644
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
index b25249e..d9e810c 100644
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
1.8.4.2
