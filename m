From: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
Subject: [PATCH] Fix username and password extraction from HTTP URLs
Date: Sat, 13 Nov 2010 00:20:25 +0100
Message-ID: <1289604025-6406-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Cc: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 13 00:31:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH35m-0000P4-0K
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 00:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131Ab0KLXbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 18:31:32 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53546 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932958Ab0KLXbb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 18:31:31 -0500
Received: from localhost.localdomain (unknown [88.180.106.44])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5F386A617D;
	Sat, 13 Nov 2010 00:31:25 +0100 (CET)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161367>

Change the authentification initialisation to percent-decode username
and password for HTTP URLs.

Signed-off-by: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
---
 http.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

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
 
-- 
1.7.2.3
