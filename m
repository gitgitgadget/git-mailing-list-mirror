From: Jeff King <peff@peff.net>
Subject: [PATCH] t/lib-httpd: handle running under --valgrind
Date: Tue, 24 Jul 2012 09:43:59 -0400
Message-ID: <20120724134358.GA14788@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 15:44:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StfPF-0000RT-FU
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 15:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab2GXNoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 09:44:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60253 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754258Ab2GXNoC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 09:44:02 -0400
Received: (qmail 17210 invoked by uid 107); 24 Jul 2012 13:44:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jul 2012 09:44:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2012 09:43:59 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202040>

Running the http tests with valgrind does not work for two
reasons:

  1. Apache complains about following the symbolic link from
     git-http-backend to valgrind.sh.

  2. Apache does not pass through the GIT_VALGRIND variable
     to the backend CGI.

This patch fixes both problems. Unfortunately, there is a
slight hack we need to handle passing environment variables
through Apache. If we just tell it:

  PassEnv GIT_VALGRIND

then Apache will complain when GIT_VALGRIND is not set. If
we try:

  SetEnv GIT_VALGRIND ${GIT_VALGRIND}

then when GIT_VALGRIND is not set, it will pass through the
literal "${GIT_VALGRIND}". Instead, we now unconditionally
pass through GIT_VALGRIND from lib-httpd.sh into apache,
even if it is empty.

Signed-off-by: Jeff King <peff@peff.net>
---
I rolled this a few weeks ago while searching for a bug that turned out
not to be in git at all. But even without hunting a specific bug, it
allows us to expand our valgrind test coverage, which is a good thing.

 t/lib-httpd.sh          | 4 ++++
 t/lib-httpd/apache.conf | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 094d490..d773542 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -43,6 +43,10 @@ TEST_PATH="$TEST_DIRECTORY"/lib-httpd
 HTTPD_ROOT_PATH="$PWD"/httpd
 HTTPD_DOCUMENT_ROOT_PATH=$HTTPD_ROOT_PATH/www
 
+# hack to suppress apache PassEnv warnings
+GIT_VALGRIND=$GIT_VALGRIND; export GIT_VALGRIND
+GIT_VALGRIND_OPTIONS=$GIT_VALGRIND_OPTIONS; export GIT_VALGRIND_OPTIONS
+
 if ! test -x "$LIB_HTTPD_PATH"
 then
 	skip_all="skipping test, no web server found at '$LIB_HTTPD_PATH'"
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index de3762e..36b1596 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -42,6 +42,9 @@ ErrorLog error.log
 </IfModule>
 </IfVersion>
 
+PassEnv GIT_VALGRIND
+PassEnv GIT_VALGRIND_OPTIONS
+
 Alias /dumb/ www/
 Alias /auth/ www/auth/
 
@@ -62,7 +65,7 @@ ScriptAlias /smart/ ${GIT_EXEC_PATH}/git-http-backend/
 ScriptAlias /smart_noexport/ ${GIT_EXEC_PATH}/git-http-backend/
 ScriptAlias /smart_custom_env/ ${GIT_EXEC_PATH}/git-http-backend/
 <Directory ${GIT_EXEC_PATH}>
-	Options None
+	Options FollowSymlinks
 </Directory>
 <Files ${GIT_EXEC_PATH}/git-http-backend>
 	Options ExecCGI
-- 
1.7.11.3.4.g9f70dbb
