From: Jeff King <peff@peff.net>
Subject: [PATCH 01/14] t/lib-httpd: check for NO_CURL
Date: Thu, 10 Nov 2011 02:46:00 -0500
Message-ID: <20111110074600.GA27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:46:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPKr-0001Z4-44
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448Ab1KJHqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:46:04 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38907
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757403Ab1KJHqD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:46:03 -0500
Received: (qmail 22146 invoked by uid 107); 10 Nov 2011 07:46:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:46:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:46:00 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185198>

We already do this check individually in each of the tests
that includes lib-httpd. Let's factor it out.

There is one test (t5540) that uses lib-httpd but does not
currently do this check. But it actually has a stricter
check which is a superset (it needs all of the requirements
to have built git-http-push, one of which is not setting
NO_CURL), so adding this extra check won't hurt anything.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh          |    5 +++++
 t/t5541-http-push.sh    |    5 -----
 t/t5550-http-fetch.sh   |    5 -----
 t/t5551-http-fetch.sh   |    5 -----
 t/t5561-http-backend.sh |    5 -----
 5 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index f7dc078..8331527 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -3,6 +3,11 @@
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
 #
 
+if test -n "$NO_CURL"; then
+	skip_all='skipping test, git built without http support'
+	test_done
+fi
+
 if test -z "$GIT_TEST_HTTPD"
 then
 	skip_all="Network testing disabled (define GIT_TEST_HTTPD to enable)"
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index a73c826..a326ee0 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -6,11 +6,6 @@
 test_description='test smart pushing over http via http-backend'
 . ./test-lib.sh
 
-if test -n "$NO_CURL"; then
-	skip_all='skipping test, git built without http support'
-	test_done
-fi
-
 ROOT_PATH="$PWD"
 LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5541'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 311a33c..e9282c5 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -3,11 +3,6 @@
 test_description='test dumb fetching over http via static file'
 . ./test-lib.sh
 
-if test -n "$NO_CURL"; then
-	skip_all='skipping test, git built without http support'
-	test_done
-fi
-
 LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 26d3557..3557f2e 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -3,11 +3,6 @@
 test_description='test smart fetching over http via http-backend'
 . ./test-lib.sh
 
-if test -n "$NO_CURL"; then
-	skip_all='skipping test, git built without http support'
-	test_done
-fi
-
 LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5551'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index b5d7fbc..974be7c 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -3,11 +3,6 @@
 test_description='test git-http-backend'
 . ./test-lib.sh
 
-if test -n "$NO_CURL"; then
-	skip_all='skipping test, git built without http support'
-	test_done
-fi
-
 LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5561'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
-- 
1.7.7.2.7.g9f96f
