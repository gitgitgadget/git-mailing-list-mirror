From: Jeff King <peff@peff.net>
Subject: [PATCH 4/9] http: hoist credential request out of handle_curl_result
Date: Sat, 28 Sep 2013 04:31:45 -0400
Message-ID: <20130928083145.GD2131@sigill.intra.peff.net>
References: <20130928082956.GA22610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 10:31:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPpwP-0002Rx-52
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 10:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab3I1Ibt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 04:31:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:35142 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754910Ab3I1Ibs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 04:31:48 -0400
Received: (qmail 8665 invoked by uid 102); 28 Sep 2013 08:31:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Sep 2013 03:31:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Sep 2013 04:31:45 -0400
Content-Disposition: inline
In-Reply-To: <20130928082956.GA22610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235493>

When we are handling a curl response code in http_request or
in the remote-curl RPC code, we use the handle_curl_result
helper to translate curl's response into an easy-to-use
code. When we see an HTTP 401, we do one of two things:

  1. If we already had a filled-in credential, we mark it as
     rejected, and then return HTTP_NOAUTH to indicate to
     the caller that we failed.

  2. If we didn't, then we ask for a new credential and tell
     the caller HTTP_REAUTH to indicate that they may want
     to try again.

Rejecting in the first case makes sense; it is the natural
result of the request we just made. However, prompting for
more credentials in the second step does not always make
sense. We do not know for sure that the caller is going to
make a second request, and nor are we sure that it will be
to the same URL. Logically, the prompt belongs not to the
request we just finished, but to the request we are (maybe)
about to make.

In practice, it is very hard to trigger any bad behavior.
Currently, if we make a second request, it will always be to
the same URL (even in the face of redirects, because curl
handles the redirects internally). And we almost always
retry on HTTP_REAUTH these days. The one exception is if we
are streaming a large RPC request to the server (e.g., a
pushed packfile), in which case we cannot restart. It's
extremely unlikely to see a 401 response at this stage,
though, as we would typically have seen it when we sent a
probe request, before streaming the data.

This patch drops the automatic prompt out of case 2, and
instead requires the caller to do it. This is a few extra
lines of code, and the bug it fixes is unlikely to come up
in practice. But it is conceptually cleaner, and paves the
way for better handling of credentials across redirects.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c        | 6 ++++--
 http.h        | 1 +
 remote-curl.c | 7 ++++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 41ee7aa..5504b2c 100644
--- a/http.c
+++ b/http.c
@@ -47,7 +47,7 @@ static int curl_save_cookies;
 static const char *curl_http_proxy;
 static const char *curl_cookie_file;
 static int curl_save_cookies;
-static struct credential http_auth = CREDENTIAL_INIT;
+struct credential http_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
 
@@ -823,7 +823,6 @@ int handle_curl_result(struct slot_results *results)
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
-			credential_fill(&http_auth);
 			return HTTP_REAUTH;
 		}
 	} else {
@@ -941,6 +940,9 @@ static int http_request_reauth(const char *url,
 			die("BUG: HTTP_KEEP_ERROR is only supported with strbufs");
 		}
 	}
+
+	credential_fill(&http_auth);
+
 	return http_request(url, result, target, options);
 }
 
diff --git a/http.h b/http.h
index 40404b4..17116ab 100644
--- a/http.h
+++ b/http.h
@@ -102,6 +102,7 @@ extern size_t http_post_buffer;
 extern int active_requests;
 extern int http_is_verbose;
 extern size_t http_post_buffer;
+extern struct credential http_auth;
 
 extern char curl_errorstr[CURL_ERROR_SIZE];
 
diff --git a/remote-curl.c b/remote-curl.c
index 66705bb..d524462 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -9,6 +9,7 @@
 #include "string-list.h"
 #include "sideband.h"
 #include "argv-array.h"
+#include "credential.h"
 
 static struct remote *remote;
 static const char *url; /* always ends with a trailing slash */
@@ -468,6 +469,8 @@ static int post_rpc(struct rpc_state *rpc)
 	if (large_request) {
 		do {
 			err = probe_rpc(rpc);
+			if (err == HTTP_REAUTH)
+				credential_fill(&http_auth);
 		} while (err == HTTP_REAUTH);
 		if (err != HTTP_OK)
 			return -1;
@@ -567,8 +570,10 @@ retry:
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
 
 	err = run_slot(slot);
-	if (err == HTTP_REAUTH && !large_request)
+	if (err == HTTP_REAUTH && !large_request) {
+		credential_fill(&http_auth);
 		goto retry;
+	}
 	if (err != HTTP_OK)
 		err = -1;
 
-- 
1.8.4.rc3.19.g9da5bf6
