From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] t5551-http-fetch: Work around some libcurl versions
Date: Mon,  9 Nov 2009 10:10:36 -0800
Message-ID: <1257790237-30850-2-git-send-email-spearce@spearce.org>
References: <1257790237-30850-1-git-send-email-spearce@spearce.org>
Cc: Tarmigan <tarmigan+git@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 19:10:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7YhT-0007ma-1L
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 19:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbZKISKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 13:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbZKISKe
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 13:10:34 -0500
Received: from george.spearce.org ([209.20.77.23]:39666 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbZKISKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 13:10:33 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id D8093381FF; Mon,  9 Nov 2009 18:10:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 40289381FC
	for <git@vger.kernel.org>; Mon,  9 Nov 2009 18:10:38 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.351.g09432
In-Reply-To: <1257790237-30850-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132500>

Some versions of libcurl report their output when GIT_CURL_VERBOSE
is set differently than other versions do.  At least one variant
(version unknown but likely pre-7.18.1) reports the POST payload to
stderr, and omits the blank line after each HTTP request/response.
We clip these lines out of the stderr output now before doing the
compare, so we aren't surprised by this trivial difference.

Reported-by: Tarmigan <tarmigan+git@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t5551-http-fetch.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index eb0c039..6b0165c 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -31,23 +31,19 @@ cat >exp <<EOF
 > GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 > Accept: */*
 > Pragma: no-cache
-
 < HTTP/1.1 200 OK
 < Pragma: no-cache
 < Cache-Control: no-cache, max-age=0, must-revalidate
 < Content-Type: application/x-git-upload-pack-advertisement
-< 
 > POST /smart/repo.git/git-upload-pack HTTP/1.1
 > Accept-Encoding: deflate, gzip
 > Content-Type: application/x-git-upload-pack-request
 > Accept: application/x-git-upload-pack-response
 > Content-Length: xxx
-
 < HTTP/1.1 200 OK
 < Pragma: no-cache
 < Cache-Control: no-cache, max-age=0, must-revalidate
 < Content-Type: application/x-git-upload-pack-result
-< 
 EOF
 test_expect_success 'clone http repository' '
 	GIT_CURL_VERBOSE=1 git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
@@ -56,6 +52,8 @@ test_expect_success 'clone http repository' '
 	sed -e "
 		s/Q\$//
 		/^[*] /d
+		/^$/d
+		/^< $/d
 
 		/^[^><]/{
 			s/^/> /
@@ -64,6 +62,8 @@ test_expect_success 'clone http repository' '
 		/^> User-Agent: /d
 		/^> Host: /d
 		s/^> Content-Length: .*/> Content-Length: xxx/
+		/^00..want /d
+		/^00.*done/d
 
 		/^< Server: /d
 		/^< Expires: /d
-- 
1.6.5.2.351.g09432
