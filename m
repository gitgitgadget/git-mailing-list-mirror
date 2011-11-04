From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: [PATCH] http-push: don't always prompt for password
Date: Fri,  4 Nov 2011 08:03:08 +0100
Message-ID: <1320390188-24334-1-git-send-email-stefan.naewe@gmail.com>
References: <7vfwi6jucg.fsf@alter.siamese.dyndns.org>
Cc: Stefan Naewe <stefan.naewe@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Fri Nov 04 08:03:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMDoD-0002yu-Vy
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 08:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab1KDHDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 03:03:19 -0400
Received: from mail96.atlas.de ([194.156.172.86]:17662 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328Ab1KDHDS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 03:03:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 761E3100B3;
	Fri,  4 Nov 2011 08:03:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id kmb0-53mgsSE; Fri,  4 Nov 2011 08:03:17 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Fri,  4 Nov 2011 08:03:17 +0100 (CET)
Received: from as100897.atlas.de (as100897.atlas.de [141.200.51.220])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 03D9427190;
	Fri,  4 Nov 2011 08:03:17 +0100 (CET)
Received: by as100897.atlas.de (Postfix, from userid 1000)
	id E1EAC14088; Fri,  4 Nov 2011 08:03:16 +0100 (CET)
X-Mailer: git-send-email 1.7.8.rc0.1.gb345ae
In-Reply-To: <7vfwi6jucg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184760>

http-push prompts for a password when the URL is set as
'https://user@host/repo' even though there is one set
in ~/.netrc. Pressing ENTER at the password prompt succeeds
then, but is a annoying and makes it almost useless
in a shell script, e.g.

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---
 http.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index a4bc770..008ad72 100644
--- a/http.c
+++ b/http.c
@@ -279,8 +279,6 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
 #endif
 
-	init_curl_http_auth(result);
-
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
@@ -846,7 +844,7 @@ static int http_request(const char *url, void *result, int target, int options)
 		else if (missing_target(&results))
 			ret = HTTP_MISSING_TARGET;
 		else if (results.http_code == 401) {
-			if (user_name) {
+			if (user_name && user_pass) {
 				ret = HTTP_NOAUTH;
 			} else {
 				/*
@@ -855,7 +853,8 @@ static int http_request(const char *url, void *result, int target, int options)
 				 * but that is non-portable.  Using git_getpass() can at least be stubbed
 				 * on other platforms with a different implementation if/when necessary.
 				 */
-				user_name = xstrdup(git_getpass_with_description("Username", description));
+				if (!user_name)
+					user_name = xstrdup(git_getpass_with_description("Username", description));
 				init_curl_http_auth(slot->curl);
 				ret = HTTP_REAUTH;
 			}
-- 
1.7.8.rc0.1.gb345ae
