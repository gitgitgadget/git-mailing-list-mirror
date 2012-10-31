From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] remote-curl: retry failed requests for auth even with
 gzip
Date: Wed, 31 Oct 2012 08:01:12 -0400
Message-ID: <20121031120112.GB21011@sigill.intra.peff.net>
References: <20121031115346.GC30879@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 13:01:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTWzB-0004V2-AB
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 13:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935419Ab2JaMBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 08:01:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45009 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932738Ab2JaMBP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 08:01:15 -0400
Received: (qmail 13288 invoked by uid 107); 31 Oct 2012 12:01:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Oct 2012 08:01:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2012 08:01:12 -0400
Content-Disposition: inline
In-Reply-To: <20121031115346.GC30879@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208810>

Commit b81401c taught the post_rpc function to retry the
http request after prompting for credentials. However, it
did not handle two cases:

  1. If we have a large request, we do not retry. That's OK,
     since we would have sent a probe (with retry) already.

  2. If we are gzipping the request, we do not retry. That
     was considered OK, because the intended use was for
     push (e.g., listing refs is OK, but actually pushing
     objects is not), and we never gzip on push.

This patch teaches post_rpc to retry even a gzipped request.
This has two advantages:

  1. It is possible to configure a "half-auth" state for
     fetching, where the set of refs and their sha1s are
     advertised, but one cannot actually fetch objects.

     This is not a recommended configuration, as it leaks
     some information about what is in the repository (e.g.,
     an attacker can try brute-forcing possible content in
     your repository and checking whether it matches your
     branch sha1). However, it can be slightly more
     convenient, since a no-op fetch will not require a
     password at all.

  2. It future-proofs us should we decide to ever gzip more
     requests.

Signed-off-by: Jeff King <peff@peff.net>
---
I doubt we would ever want to gzip push requests. The bulk of the data
is objects, which are already compressed. In theory we could gzip the
non-pack parts, but that would first mean splitting them into a separate
request. The tiny bit of savings are almost certainly not worth the
complexity.

But the future-proofing might still be valuable if we ever modify the
protocol to have a new phase.

 remote-curl.c           | 11 ++++++++++-
 t/lib-httpd/apache.conf |  7 +++++++
 t/t5551-http-fetch.sh   | 15 +++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 10cd47d..fac2bef 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -474,6 +474,15 @@ retry:
 			fflush(stderr);
 		}
 
+	} else if (gzip_body) {
+		/*
+		 * If we are looping to retry authentication, then the previous
+		 * run will have set up the headers and gzip buffer already,
+		 * and we just need to send it.
+		 */
+		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, gzip_body);
+		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, gzip_size);
+
 	} else if (use_gzip && 1024 < rpc->len) {
 		/* The client backend isn't giving us compressed data so
 		 * we can try to deflate it ourselves, this may save on.
@@ -530,7 +539,7 @@ retry:
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
 
 	err = run_slot(slot);
-	if (err == HTTP_REAUTH && !large_request && !use_gzip)
+	if (err == HTTP_REAUTH && !large_request)
 		goto retry;
 	if (err != HTTP_OK)
 		err = -1;
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index ec8618d..15a3c71 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -96,6 +96,13 @@ SSLEngine On
 	Require valid-user
 </LocationMatch>
 
+<LocationMatch "^/auth-fetch/.*/git-upload-pack$">
+	AuthType Basic
+	AuthName "git-auth"
+	AuthUserFile passwd
+	Require valid-user
+</LocationMatch>
+
 <IfDefine DAV>
 	LoadModule dav_module modules/mod_dav.so
 	LoadModule dav_fs_module modules/mod_dav_fs.so
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 7380f2a..5f174da 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -129,6 +129,21 @@ test_expect_success 'clone from auth-only-for-push repository' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone from auth-only-for-objects repository' '
+	echo two >expect &&
+	set_askpass user@host &&
+	git clone --bare "$HTTPD_URL/auth-fetch/smart/repo.git" half-auth &&
+	expect_askpass both user@host &&
+	git --git-dir=half-auth log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'no-op half-auth fetch does not require a password' '
+	set_askpass wrong &&
+	git --git-dir=half-auth fetch &&
+	expect_askpass none
+'
+
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
-- 
1.8.0.207.gdf2154c
