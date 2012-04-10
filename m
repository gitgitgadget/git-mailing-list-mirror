From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/2] http auth fails with multiple curl handles
Date: Tue, 10 Apr 2012 11:53:39 +0200
Message-ID: <1334051620-18044-2-git-send-email-drizzd@aon.at>
References: <20120402083115.GA2235@sigill.intra.peff.net>
 <1334051620-18044-1-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 12:01:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHXtb-0004kv-C3
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 12:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285Ab2DJKBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 06:01:49 -0400
Received: from nat-warsl417-01.aon.at ([195.3.96.119]:9949 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753568Ab2DJKBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 06:01:47 -0400
Received: (qmail 14735 invoked from network); 10 Apr 2012 09:55:06 -0000
Received: from smarthub77.res.a1.net (HELO email.aon.at) ([172.18.1.205])
          (envelope-sender <drizzd@aon.at>)
          by fallback44.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 10 Apr 2012 09:55:06 -0000
Received: (qmail 28508 invoked from network); 10 Apr 2012 09:55:02 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL604.highway.telekom.at
X-Spam-Level: *******
Received: from unknown (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[80.123.242.182])
          (envelope-sender <drizzd@aon.at>)
          by smarthub77.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <git@vger.kernel.org>; 10 Apr 2012 09:55:02 -0000
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1334051620-18044-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195077>

Create a repo with multiple loose objects in order to demonstrate http
authentication breakage.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t5550-http-fetch.sh |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index e5e6b8f..1d9ff1e 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -13,17 +13,22 @@ LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
 start_httpd
 
 test_expect_success 'setup repository' '
-	echo content >file &&
+	echo content1 >file &&
 	git add file &&
 	git commit -m one
+	echo content2 >file &&
+	git add file &&
+	git commit -m two
 '
 
-test_expect_success 'create http-accessible bare repository' '
-	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+test_expect_success 'create http-accessible bare repository with loose objects' '
+	cp -a .git "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	 git --bare init &&
+	 git config core.bare true &&
+	 mkdir -p hooks &&
 	 echo "exec git update-server-info" >hooks/post-update &&
-	 chmod +x hooks/post-update
+	 chmod +x hooks/post-update &&
+	 hooks/post-update
 	) &&
 	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	git push public master:master
@@ -87,21 +92,21 @@ test_expect_success 'http auth can use user/pass in URL' '
 	expect_askpass none
 '
 
-test_expect_success 'http auth can use just user in URL' '
+test_expect_failure 'http auth can use just user in URL' '
 	>askpass-query &&
 	echo user@host >askpass-response &&
 	git clone "$HTTPD_URL_USER/auth/repo.git" clone-auth-pass &&
 	expect_askpass pass user@host
 '
 
-test_expect_success 'http auth can request both user and pass' '
+test_expect_failure 'http auth can request both user and pass' '
 	>askpass-query &&
 	echo user@host >askpass-response &&
 	git clone "$HTTPD_URL/auth/repo.git" clone-auth-both &&
 	expect_askpass both user@host
 '
 
-test_expect_success 'http auth respects credential helper config' '
+test_expect_failure 'http auth respects credential helper config' '
 	test_config_global credential.helper "!f() {
 		cat >/dev/null
 		echo username=user@host
@@ -113,7 +118,7 @@ test_expect_success 'http auth respects credential helper config' '
 	expect_askpass none
 '
 
-test_expect_success 'http auth can get username from config' '
+test_expect_failure 'http auth can get username from config' '
 	test_config_global "credential.$HTTPD_URL.username" user@host &&
 	>askpass-query &&
 	echo user@host >askpass-response &&
@@ -121,7 +126,7 @@ test_expect_success 'http auth can get username from config' '
 	expect_askpass pass user@host
 '
 
-test_expect_success 'configured username does not override URL' '
+test_expect_failure 'configured username does not override URL' '
 	test_config_global "credential.$HTTPD_URL.username" wrong &&
 	>askpass-query &&
 	echo user@host >askpass-response &&
-- 
1.7.9.6
