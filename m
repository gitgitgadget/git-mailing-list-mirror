From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/8] t/lib-httpd: use write_script to copy CGI scripts
Date: Thu, 22 May 2014 05:28:56 -0400
Message-ID: <20140522092856.GB15032@sigill.intra.peff.net>
References: <20140522092824.GA14530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 11:29:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnPJ8-0002FO-AT
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbaEVJ26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:28:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:57235 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752805AbaEVJ26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:28:58 -0400
Received: (qmail 11507 invoked by uid 102); 22 May 2014 09:28:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:28:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:28:56 -0400
Content-Disposition: inline
In-Reply-To: <20140522092824.GA14530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249887>

Using write_script will set our shebang line appropriately
with $SHELL_PATH. The script that is there now is quite
simple and likely to succeed even with a non-POSIX /bin/sh,
but it does not hurt to be defensive.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh                   | 6 +++++-
 t/lib-httpd/broken-smart-http.sh | 1 -
 2 files changed, 5 insertions(+), 2 deletions(-)
 mode change 100755 => 100644 t/lib-httpd/broken-smart-http.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 252cbf1..8e680ef 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -105,10 +105,14 @@ else
 		"Could not identify web server at '$LIB_HTTPD_PATH'"
 fi
 
+install_script () {
+	write_script "$HTTPD_ROOT_PATH/$1" <"$TEST_PATH/$1"
+}
+
 prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
-	cp "$TEST_PATH"/broken-smart-http.sh "$HTTPD_ROOT_PATH"
+	install_script broken-smart-http.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/broken-smart-http.sh b/t/lib-httpd/broken-smart-http.sh
old mode 100755
new mode 100644
index f7ebfff..82cc610
--- a/t/lib-httpd/broken-smart-http.sh
+++ b/t/lib-httpd/broken-smart-http.sh
@@ -1,4 +1,3 @@
-#!/bin/sh
 printf "Content-Type: text/%s\n" "html"
 echo
 printf "%s\n" "001e# service=git-upload-pack"
-- 
2.0.0.rc1.436.g03cb729
