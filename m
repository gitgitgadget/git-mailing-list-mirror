From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] add basic http clone/fetch tests
Date: Sun, 15 Feb 2009 01:12:17 -0500
Message-ID: <20090215061217.GB30414@coredump.intra.peff.net>
References: <20090215060815.GA7473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 07:13:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYaGB-0005NE-Lz
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 07:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbZBOGMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 01:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbZBOGMU
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 01:12:20 -0500
Received: from peff.net ([208.65.91.99]:39924 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbZBOGMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 01:12:20 -0500
Received: (qmail 5375 invoked by uid 107); 15 Feb 2009 06:12:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 01:12:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 01:12:17 -0500
Content-Disposition: inline
In-Reply-To: <20090215060815.GA7473@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109967>

This was mostly being tested implicitly by the "http push"
tests. But making a separate test script means that:

  - we will run fetch tests even when http pushing support
    is not built

  - when there are failures on fetching, they are easier to
    see and isolate, as they are not in the middle of push
    tests

This script defaults to running the webserver on port 5550,
and puts the original t5540 on port 5540, so that the two
can be run simultaneously without conflict (but both still
respect an externally set LIB_HTTPD_PORT).

Signed-off-by: Jeff King <peff@peff.net>
---
I started this as test infrastructure for the final patch in the series,
but I think it's nice to have a few http sanity checks in general. Of
course, one must use GIT_TEST_HTTPD to enable them. Junio, is that part
of your usual integration testing?

 Makefile              |    1 +
 t/t5540-http-push.sh  |    1 +
 t/t5550-http-fetch.sh |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100755 t/t5550-http-fetch.sh

diff --git a/Makefile b/Makefile
index ffef867..d689654 100644
--- a/Makefile
+++ b/Makefile
@@ -1368,6 +1368,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
+	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 5b93e5a..072ef1b 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -11,6 +11,7 @@ This test runs various sanity checks on http-push.'
 
 ROOT_PATH="$PWD"
 LIB_HTTPD_DAV=t
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5540'}
 
 if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
 then
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
new file mode 100755
index 0000000..b6e6ec9
--- /dev/null
+++ b/t/t5550-http-fetch.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='test fetching over http'
+. ./test-lib.sh
+
+if test -n "$NO_CURL"; then
+	say 'skipping test, git built without http support'
+	test_done
+fi
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
+start_httpd
+
+test_expect_success 'setup repository' '
+	echo content >file &&
+	git add file &&
+	git commit -m one
+'
+
+test_expect_success 'create http-accessible bare repository' '
+	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	 git --bare init &&
+	 echo "exec git update-server-info" >hooks/post-update &&
+	 chmod +x hooks/post-update
+	) &&
+	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push public master:master
+'
+
+test_expect_success 'clone http repository' '
+	git clone $HTTPD_URL/repo.git clone &&
+	test_cmp file clone/file
+'
+
+test_expect_success 'fetch changes via http' '
+	echo content >>file &&
+	git commit -a -m two &&
+	git push public
+	(cd clone && git pull) &&
+	test_cmp file clone/file
+'
+
+stop_httpd
+test_done
-- 
1.6.2.rc0.256.gf004c.dirty
