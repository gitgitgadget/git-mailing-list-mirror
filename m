From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] test scripts: refactor start_httpd helper
Date: Sun, 15 Feb 2009 01:10:15 -0500
Message-ID: <20090215061015.GA30414@coredump.intra.peff.net>
References: <20090215060815.GA7473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 07:11:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYaEE-00057U-P8
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 07:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbZBOGKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 01:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbZBOGKS
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 01:10:18 -0500
Received: from peff.net ([208.65.91.99]:39919 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbZBOGKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 01:10:17 -0500
Received: (qmail 5351 invoked by uid 107); 15 Feb 2009 06:10:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 01:10:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 01:10:15 -0500
Content-Disposition: inline
In-Reply-To: <20090215060815.GA7473@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109966>

There are some redirects and some error checking that need
to be done by the caller; let's move both into the
start_httpd function so that all callers don't have to
repeat them (there is only one caller now, but another will
follow in this series).

This doesn't violate any assumptions that aren't already
being made by lib-httpd, which is happy to say "skipping"
and call test_done for a number of other cases.

Signed-off-by: Jeff King <peff@peff.net>
---
Cleanup for the next patch.

 t/lib-httpd.sh       |    9 +++++++--
 t/t5540-http-push.sh |    8 +-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 3824020..88cfc51 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -82,13 +82,18 @@ prepare_httpd() {
 }
 
 start_httpd() {
-	prepare_httpd
+	prepare_httpd >&3 2>&4
 
 	trap 'stop_httpd; die' EXIT
 
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
 		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
-		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start
+		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start \
+		>&3 2>&4
+	if ! test $? = 0; then
+		say "skipping test, web server setup failed"
+		test_done
+	fi
 }
 
 stop_httpd() {
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index c236b5e..5b93e5a 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -20,13 +20,7 @@ then
 fi
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
-
-if ! start_httpd >&3 2>&4
-then
-	say "skipping test, web server setup failed"
-	test_done
-	exit
-fi
+start_httpd
 
 test_expect_success 'setup remote repository' '
 	cd "$ROOT_PATH" &&
-- 
1.6.2.rc0.256.gf004c.dirty
