From: Jeff King <peff@peff.net>
Subject: [PATCH 6/9] http: simplify http_error helper function
Date: Fri, 5 Apr 2013 18:21:34 -0400
Message-ID: <20130405222134.GF22163@sigill.intra.peff.net>
References: <20130405221331.GA21209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:51:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWQM-0001b9-W0
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162979Ab3DEWVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:21:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58249 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162853Ab3DEWVm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 18:21:42 -0400
Received: (qmail 18418 invoked by uid 107); 5 Apr 2013 22:23:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 18:23:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 18:21:34 -0400
Content-Disposition: inline
In-Reply-To: <20130405221331.GA21209@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220236>

This helper function should really be a one-liner that
prints an error message, but it has ended up unnecessarily
complicated:

  1. We call error() directly when we fail to start the curl
     request, so we must later avoid printing a duplicate
     error in http_error().

     It would be much simpler in this case to just stuff the
     error message into our usual curl_errorstr buffer
     rather than printing it ourselves. This means that
     http_error does not even have to care about curl's exit
     value (the interesting part is in the errorstr buffer
     already).

  2. We return the "ret" value passed in to us, but none of
     the callers actually cares about our return value. We
     can just drop this entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c   |  2 +-
 http.c        | 11 ++++-------
 http.h        |  5 ++---
 remote-curl.c |  2 +-
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/http-push.c b/http-push.c
index bd66f6a..439a555 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1551,7 +1551,7 @@ static int remote_exists(const char *path)
 		ret = 0;
 		break;
 	case HTTP_ERROR:
-		http_error(url, HTTP_ERROR);
+		http_error(url);
 	default:
 		ret = -1;
 	}
diff --git a/http.c b/http.c
index 45cc7c7..5e6f67d 100644
--- a/http.c
+++ b/http.c
@@ -857,7 +857,8 @@ static int http_request(const char *url, struct strbuf *type,
 		run_active_slot(slot);
 		ret = handle_curl_result(&results);
 	} else {
-		error("Unable to start HTTP request for %s", url);
+		snprintf(curl_errorstr, sizeof(curl_errorstr),
+			 "failed to start HTTP request");
 		ret = HTTP_START_FAILED;
 	}
 
@@ -940,13 +941,9 @@ int http_error(const char *url, int ret)
 	return ret;
 }
 
-int http_error(const char *url, int ret)
+void http_error(const char *url)
 {
-	/* http_request has already handled HTTP_START_FAILED. */
-	if (ret != HTTP_START_FAILED)
-		error("%s while accessing %s", curl_errorstr, url);
-
-	return ret;
+	error("%s while accessing %s", curl_errorstr, url);
 }
 
 int http_fetch_ref(const char *base, struct ref *ref)
diff --git a/http.h b/http.h
index 0fe54f4..fa65128 100644
--- a/http.h
+++ b/http.h
@@ -136,10 +136,9 @@ int http_get_strbuf(const char *url, struct strbuf *content_type, struct strbuf
 int http_get_strbuf(const char *url, struct strbuf *content_type, struct strbuf *result, int options);
 
 /*
- * Prints an error message using error() containing url and curl_errorstr,
- * and returns ret.
+ * Prints an error message using error() containing url and curl_errorstr.
  */
-int http_error(const char *url, int ret);
+void http_error(const char *url);
 
 extern int http_fetch_ref(const char *base, struct ref *ref);
 
diff --git a/remote-curl.c b/remote-curl.c
index 6c6714b..9abe4b7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -216,7 +216,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 		die("Authentication failed for '%s'", url);
 	default:
 		show_http_message(&type, &buffer);
-		http_error(url, http_ret);
+		http_error(url);
 		die("HTTP request failed");
 	}
 
-- 
1.8.2.rc0.33.gd915649
