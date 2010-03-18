From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH] Prompt for a username when an HTTP request 401s
Date: Thu, 18 Mar 2010 11:57:34 -0700
Message-ID: <d411cc4a1003181157o79f1a1e1qcdea05322d76b812@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 19:57:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsKub-0006Uw-L0
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 19:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253Ab0CRS5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 14:57:36 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:36959 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0CRS5f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 14:57:35 -0400
Received: by wwe15 with SMTP id 15so1321928wwe.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 11:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=iI94MOVdPwsX4Z94I4928H72a3oytTl4Vo8C/cBXKZM=;
        b=x3gHUbfw9Gfone280CvMdCb8n28U+LyXeiOMPB+8BANC113+yKYKjXde/n7bKUYcl1
         B9vA0YDBDNcNYnHJTjgw4f7h2S5ykXDAn76JWgYEcrAO47ROvOgzppwpTJ2Q6pOGq8M2
         ZBQ8Hq2/YjD7LU5D/w9PcGHmVakNKjvWUSxmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=fIdIQT8+mR5vM8udWEkBHK403XAh0JE2gZv+jEtaHg0PcDilb/6sEBI0kQuP1NV/Dn
         xdagUBzmSDWiV+SHhRNUROzE4JI/8YnIyRa7ZGE2t2BSyOKR+Ce12ZKy/aRUc1oqgwW+
         QCSMeQLSLPuE1R0GXvrqElTvk7QLWY5Sc5ekE=
Received: by 10.216.90.18 with SMTP id d18mr1668551wef.218.1268938654623; Thu, 
	18 Mar 2010 11:57:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142489>

When an HTTP request returns a 401, Git will currently fail with a
confusing message saying that it got a 401.  This changes
http_request to prompt for the username and password, then return
HTTP_REAUTH so http_get_strbuf can try again.  If it gets a 401 even
when a user/pass is supplied, http_request will now return HTTP_NOAUTH
which remote_curl can then use to display a more intelligent error
message that is less confusing.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 http.c        |   21 +++++++++++++++++++--
 http.h        |    2 ++
 remote-curl.c |    2 ++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index deab595..731783e 100644
--- a/http.c
+++ b/http.c
@@ -199,6 +199,11 @@ static int http_options(const char *var, const
char *value, void *cb)
 	return git_default_config(var, value, cb);
 }

+static void get_http_user_name()
+{
+	user_name = xstrdup(getpass("Username: "));
+}
+
 static void init_curl_http_auth(CURL *result)
 {
 	if (user_name) {
@@ -815,7 +820,15 @@ static int http_request(const char *url, void
*result, int target, int options)
 			ret = HTTP_OK;
 		else if (missing_target(&results))
 			ret = HTTP_MISSING_TARGET;
-		else
+		else if (results.http_code == 401) {
+			if (user_name) {
+				ret = HTTP_NOAUTH;
+			} else {
+				get_http_user_name();
+				init_curl_http_auth(slot->curl);
+				ret = HTTP_REAUTH;
+			}
+		} else
 			ret = HTTP_ERROR;
 	} else {
 		error("Unable to start HTTP request for %s", url);
@@ -831,7 +844,11 @@ static int http_request(const char *url, void
*result, int target, int options)

 int http_get_strbuf(const char *url, struct strbuf *result, int options)
 {
-	return http_request(url, result, HTTP_REQUEST_STRBUF, options);
+	int http_ret = http_request(url, result, HTTP_REQUEST_STRBUF, options);
+	if (http_ret == HTTP_REAUTH) {
+		http_ret = http_request(url, result, HTTP_REQUEST_STRBUF, options);
+	}
+	return http_ret;
 }

 /*
diff --git a/http.h b/http.h
index 5c9441c..2dd03e8 100644
--- a/http.h
+++ b/http.h
@@ -126,6 +126,8 @@ extern char *get_remote_object_url(const char
*url, const char *hex,
 #define HTTP_MISSING_TARGET	1
 #define HTTP_ERROR		2
 #define HTTP_START_FAILED	3
+#define HTTP_REAUTH	4
+#define HTTP_NOAUTH	5

 /*
  * Requests an url and stores the result in a strbuf.
diff --git a/remote-curl.c b/remote-curl.c
index b76bfcb..0782756 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -132,6 +132,8 @@ static struct discovery* discover_refs(const char *service)
 	case HTTP_MISSING_TARGET:
 		die("%s not found: did you run git update-server-info on the"
 		    " server?", refs_url);
+	case HTTP_NOAUTH:
+		die("Authentication failed");
 	default:
 		http_error(refs_url, http_ret);
 		die("HTTP request failed");
-- 
1.7.0.1
