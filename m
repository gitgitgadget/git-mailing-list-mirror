From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH] Prompt for a username when an HTTP request 401s
Date: Thu, 18 Mar 2010 20:41:10 -0700
Message-ID: <d411cc4a1003182041p67a93bf6i1528a8eaaab5c805@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 04:41:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsT5K-0006b9-LD
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 04:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab0CSDlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 23:41:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43240 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab0CSDlM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 23:41:12 -0400
Received: by wyb38 with SMTP id 38so1359376wyb.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 20:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=6ZSATRrCO48OOVGtR6MoJ7wYu8Vrhd0iK8BKfDQv4U8=;
        b=V6YkxxLDzigEdU6yWeXPg+tV798jTaENuDqFzLrMi+PBfPI/m2dB9ded819oLiegB6
         HVOeYiPG8cGPqlSfn4bepCoR8DivpcJreuuTj9jbyuae5Cih0RJddYJBYAJ89bhQaH5B
         kXbxUGWQe4t+cL2flHCMD8rVFv6YVsoCUcCLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=KPhozeilrrwmRrY5vWggH1+/f1TgPN9hivvswnXCIXYg81xtY7hXNrZL159pjyVOo8
         b9FWVHSL9BVaMcBNhBYYu2jhMqekCpUk1l/5m6CIuucrlrRXp13i/Y5bf4i3tgznXWfK
         7iIhCot+GVga9BF7vG1FjOAoWq2JjS68iFzDg=
Received: by 10.216.160.213 with SMTP id u63mr1306168wek.128.1268970070306; 
	Thu, 18 Mar 2010 20:41:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142558>

When an HTTP request returns a 401, Git will currently fail with a
confusing message saying that it got a 401.  This changes
http_request to prompt for the username and password, then return
HTTP_REAUTH so http_get_strbuf can try again.  If it gets a 401 even
when a user/pass is supplied, http_request will now return HTTP_NOAUTH
which remote_curl can then use to display a more intelligent error
message that is less confusing.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---

I updated this patch to include comments on why I'm using getpass() -
we went through trying to get the info via stdin/stdout and it didn't
work very well because stdout/in are pipes, apparently.  Shawn
suggested just using the getpass().  I've inlined it, though, as per
the other suggestion.

 http.c        |   19 +++++++++++++++++--
 http.h        |    2 ++
 remote-curl.c |    2 ++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index deab595..6370da4 100644
--- a/http.c
+++ b/http.c
@@ -815,7 +815,18 @@ static int http_request(const char *url, void
*result, int target, int options)
 			ret = HTTP_OK;
 		else if (missing_target(&results))
 			ret = HTTP_MISSING_TARGET;
-		else
+		else if (results.http_code == 401) {
+			if (user_name) {
+				ret = HTTP_NOAUTH;
+			} else {
+				// it is neccesary to use getpass here because
+				// there appears to be no other clean way to
+				// read/write stdout/stdin
+				user_name = xstrdup(getpass("Username: "));
+				init_curl_http_auth(slot->curl);
+				ret = HTTP_REAUTH;
+			}
+		} else
 			ret = HTTP_ERROR;
 	} else {
 		error("Unable to start HTTP request for %s", url);
@@ -831,7 +842,11 @@ static int http_request(const char *url, void
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
