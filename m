From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/2] http: add option to enable 100 Continue responses
Date: Tue,  8 Oct 2013 20:48:06 +0000
Message-ID: <1381265287-39331-2-git-send-email-sandals@crustytoothpaste.net>
References: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 08 22:48:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTeCc-0003KW-Bk
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 22:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393Ab3JHUsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 16:48:17 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60984 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755525Ab3JHUsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Oct 2013 16:48:16 -0400
Received: from vauxhall.crustytoothpaste.net (vauxhall.local [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D1D042807E;
	Tue,  8 Oct 2013 20:48:14 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.236.g382490f.dirty
In-Reply-To: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235794>

When using GSS-Negotiate authentication with libcurl, the authentication
provided will change every time, and so the probe that git uses to determine if
authentication is needed is not sufficient to guarantee that data can be sent.
If the data fits entirely in http.postBuffer bytes, the data can be rewound and
resent if authentication fails; otherwise, a 100 Continue must be requested in
this case.

By default, curl will send an Expect: 100-continue if a certain amount of data
is to be uploaded, but when using chunked data this is never triggered.  Add an
option http.continue, which defaults to enabled, to control whether this header
is sent.  The addition of an option is necessary because some proxies break
badly if sent this header.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http.c        | 6 ++++++
 http.h        | 1 +
 remote-curl.c | 7 ++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index f3e1439..941c941 100644
--- a/http.c
+++ b/http.c
@@ -11,6 +11,7 @@
 int active_requests;
 int http_is_verbose;
 size_t http_post_buffer = 16 * LARGE_PACKET_MAX;
+int http_use_100_continue = 1;
 
 #if LIBCURL_VERSION_NUM >= 0x070a06
 #define LIBCURL_CAN_HANDLE_AUTH_ANY
@@ -213,6 +214,11 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.continue", var)) {
+		http_use_100_continue = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp("http.useragent", var))
 		return git_config_string(&user_agent, var, value);
 
diff --git a/http.h b/http.h
index d77c1b5..e72786e 100644
--- a/http.h
+++ b/http.h
@@ -102,6 +102,7 @@ extern void http_cleanup(void);
 extern int active_requests;
 extern int http_is_verbose;
 extern size_t http_post_buffer;
+extern int http_use_100_continue;
 
 extern char curl_errorstr[CURL_ERROR_SIZE];
 
diff --git a/remote-curl.c b/remote-curl.c
index b5ebe01..3b5e160 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -470,7 +470,12 @@ static int post_rpc(struct rpc_state *rpc)
 
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
-	headers = curl_slist_append(headers, "Expect:");
+
+	/* Force it either on or off, since curl will try to decide based on how
+	 * much data is to be uploaded and we want consistency.
+	 */
+	headers = curl_slist_append(headers, http_use_100_continue ?
+		"Expect: 100-continue" : "Expect:");
 
 retry:
 	slot = get_active_slot();
-- 
1.8.4.rc3
