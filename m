From: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
Subject: [PATCHv2 2/2] Fix username and password extraction from HTTP URLs
Date: Sun, 14 Nov 2010 02:51:15 +0100
Message-ID: <1289699475-11364-3-git-send-email-gabriel.corona@enst-bretagne.fr>
References: <1289699475-11364-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Cc: srabbelier@gmail.com,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 03:02:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHRvV-0003Pg-4I
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 03:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823Ab0KNCC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 21:02:29 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:50187 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754395Ab0KNCC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 21:02:29 -0500
Received: from localhost.localdomain (unknown [88.180.106.44])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EA79DA61DE;
	Sun, 14 Nov 2010 03:02:22 +0100 (CET)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1289699475-11364-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161401>

Change the authentification initialisation to percent-decode username
and password for HTTP URLs.

Signed-off-by: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
---
 http.c                |   12 +++++++++++-
 t/t5550-http-fetch.sh |    2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 0a5011f..c9393a8 100644
--- a/http.c
+++ b/http.c
@@ -2,6 +2,7 @@
 #include "pack.h"
 #include "sideband.h"
 #include "run-command.h"
+#include "url.h"
 
 int data_received;
 int active_requests;
@@ -297,7 +298,7 @@ static CURL *get_curl_handle(void)
 
 static void http_auth_init(const char *url)
 {
-	char *at, *colon, *cp, *slash;
+	char *at, *colon, *cp, *slash, *decoded;
 	int len;
 
 	cp = strstr(url, "://");
@@ -322,16 +323,25 @@ static void http_auth_init(const char *url)
 		user_name = xmalloc(len + 1);
 		memcpy(user_name, cp, len);
 		user_name[len] = '\0';
+		decoded = url_decode(user_name);
+		free(user_name);
+		user_name = decoded;
 		user_pass = NULL;
 	} else {
 		len = colon - cp;
 		user_name = xmalloc(len + 1);
 		memcpy(user_name, cp, len);
 		user_name[len] = '\0';
+		decoded = url_decode(user_name);
+		free(user_name);
+		user_name = decoded;
 		len = at - (colon + 1);
 		user_pass = xmalloc(len + 1);
 		memcpy(user_pass, colon + 1, len);
 		user_pass[len] = '\0';
+		decoded = url_decode(user_pass);
+		free(user_pass);
+		user_pass = decoded;
 	}
 }
 
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index a0564de..8c2ac35 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -34,7 +34,7 @@ test_expect_success 'clone http repository' '
 	test_cmp file clone/file
 '
 
-test_expect_failure 'clone http repository with authentication' '
+test_expect_success 'clone http repository with authentication' '
 	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/auth/" &&
 	cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" "$HTTPD_DOCUMENT_ROOT_PATH/auth/repo.git" &&
 	git clone $AUTH_HTTPD_URL/auth/repo.git clone-auth &&
-- 
1.7.2.3
