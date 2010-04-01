From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH] Prompt for a username when an HTTP request 401s
Date: Thu, 1 Apr 2010 15:14:35 -0700
Message-ID: <m2wd411cc4a1004011514w6d350ac7l15ab6bb1a6be8d89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 02 00:14:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxSf7-0003tt-1U
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 00:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab0DAWOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 18:14:38 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:58193 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab0DAWOg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 18:14:36 -0400
Received: by wwb17 with SMTP id 17so1104772wwb.19
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:cc:content-type;
        bh=UpZo8AVzYe5A4+kjbWclpbVgJsFsYkicBeJjuzkITB4=;
        b=iaY4JmtuzSNK+utOOlZ/Lm9i0dAEZwFVOu1yYC3eqcMPa0cOZ8XWjQB2t/edoPWG+u
         kZP8qXe86bJ459RJYikeo+JR0yMJvdzJl4RMFD848xujt4GmAwr6wsd6JqktgYSkcngD
         PO5ING2tpNFPKEQOUnKFJCi3w0Bw9ovajRMs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=FyJjAajTlRYY2bAPa/92V0kAaQO7wUCZ58BFMS84ajBTJ9Mo6MlwPsw9runwz7JsHB
         Jy72QfhvXPFVmWBZtqcObGDrHgfI9/iBhZ8zQ12DqYXC1UuFmVx350EPJ5ftv3DWvLS9
         tQE8GGdYYNpcBRSohgaF4tzs/CK3Sm+QBSWTA=
Received: by 10.216.52.2 with HTTP; Thu, 1 Apr 2010 15:14:35 -0700 (PDT)
Received: by 10.216.90.208 with SMTP id e58mr752444wef.57.1270160075554; Thu, 
	01 Apr 2010 15:14:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143756>

When an HTTP request returns a 401, Git will currently fail with a
confusing message saying that it got a 401, which is not very
descriptive.

Currently if a user wants to use Git over HTTP, they have to use one
URL with the username in the URL (e.g. "http://user@host.com/repo.git")
for write access and another without the username for unauthenticated
read access (unless they want to be prompted for the password each
time). However, since the HTTP servers will return a 401 if an action
requires authentication, we can prompt for username and password if we
see this, allowing us to use a single URL for both purposes.

This patch changes http_request to prompt for the username and password,
then return HTTP_REAUTH so http_get_strbuf can try again.  If it gets
a 401 even when a user/pass is supplied, http_request will now return
HTTP_NOAUTH which remote_curl can then use to display a more
intelligent error message that is less confusing.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---

Updated the comments style and the commit message for Junio.

 http.c        |   22 ++++++++++++++++++++--
 http.h        |    2 ++
 remote-curl.c |    2 ++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 4814217..51253e1 100644
--- a/http.c
+++ b/http.c
@@ -815,7 +815,21 @@ static int http_request(const char *url, void
*result, int target, int options)
 			ret = HTTP_OK;
 		else if (missing_target(&results))
 			ret = HTTP_MISSING_TARGET;
-		else
+		else if (results.http_code == 401) {
+			if (user_name) {
+				ret = HTTP_NOAUTH;
+			} else {
+				/*
+				 * git_getpass is needed here because its very likely stdin/stdout are
+				 * pipes to our parent process.  So we instead need to use /dev/tty,
+				 * but that is non-portable.  Using git_getpass() can at least be stubbed
+				 * on other platforms with a different implementation if/when necessary.
+				 */
+				user_name = xstrdup(git_getpass("Username: "));
+				init_curl_http_auth(slot->curl);
+				ret = HTTP_REAUTH;
+			}
+		} else
 			ret = HTTP_ERROR;
 	} else {
 		error("Unable to start HTTP request for %s", url);
@@ -831,7 +845,11 @@ static int http_request(const char *url, void
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
