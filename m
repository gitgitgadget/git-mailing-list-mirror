From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/2] fix http auth with multiple curl handles
Date: Tue, 10 Apr 2012 11:53:40 +0200
Message-ID: <1334051620-18044-3-git-send-email-drizzd@aon.at>
References: <20120402083115.GA2235@sigill.intra.peff.net>
 <1334051620-18044-1-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 12:02:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHXtm-0004pj-Gh
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 12:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284Ab2DJKBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 06:01:48 -0400
Received: from nat-warsl417-01.aon.at ([195.3.96.119]:8220 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753562Ab2DJKBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 06:01:47 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Apr 2012 06:01:46 EDT
Received: (qmail 18932 invoked from network); 10 Apr 2012 09:55:06 -0000
Received: from smarthub77.res.a1.net (HELO email.aon.at) ([172.18.1.205])
          (envelope-sender <drizzd@aon.at>)
          by fallback43.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 10 Apr 2012 09:55:06 -0000
Received: (qmail 28674 invoked from network); 10 Apr 2012 09:55:03 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL604.highway.telekom.at
X-Spam-Level: *******
Received: from unknown (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[80.123.242.182])
          (envelope-sender <drizzd@aon.at>)
          by smarthub77.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <git@vger.kernel.org>; 10 Apr 2012 09:55:03 -0000
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1334051620-18044-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195079>

From: Jeff King <peff@peff.net>

HTTP authentication is currently handled by get_refs and fetch_ref, but
not by fetch_object, fetch_pack or fetch_alternates. In the
single-threaded case, this is not an issue, since get_refs is always
called first. It recognigzes the 401 and prompts the user for
credentials, which will then be used subsequently.

If the curl multi interface is used, however, only the multi handle used
by get_refs will have credentials configured. Requests made by other
handles fail with an authentication error.

Fix this by setting CURLOPT_USERPWD whenever a slot is requested.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 http.c                |    2 ++
 t/t5550-http-fetch.sh |   10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index f3f83d7..c6dc9b7 100644
--- a/http.c
+++ b/http.c
@@ -494,6 +494,8 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+	if (http_auth.password)
+		init_curl_http_auth(slot->curl);
 
 	return slot;
 }
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 1d9ff1e..b06f817 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -92,21 +92,21 @@ test_expect_success 'http auth can use user/pass in URL' '
 	expect_askpass none
 '
 
-test_expect_failure 'http auth can use just user in URL' '
+test_expect_success 'http auth can use just user in URL' '
 	>askpass-query &&
 	echo user@host >askpass-response &&
 	git clone "$HTTPD_URL_USER/auth/repo.git" clone-auth-pass &&
 	expect_askpass pass user@host
 '
 
-test_expect_failure 'http auth can request both user and pass' '
+test_expect_success 'http auth can request both user and pass' '
 	>askpass-query &&
 	echo user@host >askpass-response &&
 	git clone "$HTTPD_URL/auth/repo.git" clone-auth-both &&
 	expect_askpass both user@host
 '
 
-test_expect_failure 'http auth respects credential helper config' '
+test_expect_success 'http auth respects credential helper config' '
 	test_config_global credential.helper "!f() {
 		cat >/dev/null
 		echo username=user@host
@@ -118,7 +118,7 @@ test_expect_failure 'http auth respects credential helper config' '
 	expect_askpass none
 '
 
-test_expect_failure 'http auth can get username from config' '
+test_expect_success 'http auth can get username from config' '
 	test_config_global "credential.$HTTPD_URL.username" user@host &&
 	>askpass-query &&
 	echo user@host >askpass-response &&
@@ -126,7 +126,7 @@ test_expect_failure 'http auth can get username from config' '
 	expect_askpass pass user@host
 '
 
-test_expect_failure 'configured username does not override URL' '
+test_expect_success 'configured username does not override URL' '
 	test_config_global "credential.$HTTPD_URL.username" wrong &&
 	>askpass-query &&
 	echo user@host >askpass-response &&
-- 
1.7.9.6
