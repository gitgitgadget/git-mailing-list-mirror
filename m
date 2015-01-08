From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate fails
Date: Thu,  8 Jan 2015 00:29:20 +0000
Message-ID: <1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
References: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
Cc: "Dan Langille (dalangil)" <dalangil@cisco.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 01:29:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y90yh-0005OA-5X
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 01:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbbAHA30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 19:29:26 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:56900 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751997AbbAHA30 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2015 19:29:26 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C19C82808F;
	Thu,  8 Jan 2015 00:29:24 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262170>

Apache servers using mod_auth_kerb can be configured to allow the user
to authenticate either using Negotiate (using the Kerberos ticket) or
Basic authentication (using the Kerberos password).  Often, one will
want to use Negotiate authentication if it is available, but fall back
to Basic authentication if the ticket is missing or expired.

However, libcurl will try very hard to use something other than Basic
auth, even over HTTPS.  If Basic and something else are offered, libcurl
will never attempt to use Basic, even if the other option fails.
Teach the HTTP client code to stop trying authentication mechanisms that
don't use a password (currently Negotiate) after the first failure,
since if they failed the first time, they will never succeed.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Jeff King <peff@peff.net>
---
Peff's original change was to get_curl_handle; however, we retry the
second time with the same slot and we may not call get_curl_handle
again, so I had to move that change to get_active_slot.  This has been
tested pushing with both Negotiate and Basic against an HTTPS server
both when info/refs was protected and when it was not.

 http.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/http.c b/http.c
index 040f362..44b130c 100644
--- a/http.c
+++ b/http.c
@@ -62,6 +62,9 @@ static const char *user_agent;
 
 static struct credential cert_auth = CREDENTIAL_INIT;
 static int ssl_cert_password_required;
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+static unsigned long http_auth_methods = CURLAUTH_ANY;
+#endif
 
 static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
@@ -580,6 +583,9 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
+#endif
 	if (http_auth.password)
 		init_curl_http_auth(slot->curl);
 
@@ -870,6 +876,9 @@ int handle_curl_result(struct slot_results *results)
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
+#endif
 			return HTTP_REAUTH;
 		}
 	} else {
@@ -986,6 +995,7 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
 		strbuf_addstr(charset, "ISO-8859-1");
 }
 
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
-- 
2.2.1.209.g41e5f3a
