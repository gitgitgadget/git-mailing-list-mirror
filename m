From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH] Prompt for a username when an HTTP request 401s
Date: Thu, 1 Apr 2010 13:29:04 -0700
Message-ID: <o2xd411cc4a1004011329wcbe34a45he7f3d7ce5d4eae59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 01 22:29:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxR0s-0007yz-59
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 22:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758909Ab0DAU3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 16:29:08 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:55386 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758883Ab0DAU3H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 16:29:07 -0400
Received: by wwb17 with SMTP id 17so1052524wwb.19
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:cc:content-type;
        bh=M2Q9YLZXxz9gzk/AYky8N9vLIa8Wbsya8xPaxtGobxk=;
        b=nDz7hAUHXVLVKtsjwvztPYdTDqjgzmB2IBR4XrX82lsFFaywoIDVDQtsleObbzNLF7
         frl3HtpgyAtjSYdOOPc5HRecW936UWIx4VZyNoydKTMkT2Ua4z31vGV7rF9FU7tD50kY
         mkYBxrM2+coql6JxJ9EtSFaBJb6EAGe4Bc1hM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=W+vDn+qldAEe8RLVWcJxtXIglXIsg8SRCIacn12GEShuTFf7y4fLclTIZfo88rBNIU
         LY/ef5utDE6IGsxdniKAPF1FfRa1njdseb36TGcnrS9vcA5OIXsDkWZxcLWOHXrGa0uz
         2mBoWhnQyyDl9oIdhkR0zPUb1CyuOoQYLBf9M=
Received: by 10.216.52.2 with HTTP; Thu, 1 Apr 2010 13:29:04 -0700 (PDT)
Received: by 10.216.86.200 with SMTP id w50mr664442wee.173.1270153744227; Thu, 
	01 Apr 2010 13:29:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143747>

When an HTTP request returns a 401, Git will currently fail with a
confusing message saying that it got a 401.  This changes
http_request to prompt for the username and password, then return
HTTP_REAUTH so http_get_strbuf can try again.  If it gets a 401 even
when a user/pass is supplied, http_request will now return HTTP_NOAUTH
which remote_curl can then use to display a more intelligent error
message that is less confusing.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---

Here is the fourth version of this patch - now incorporating the
GIT_ASKPASS stuff.

 http.c        |   20 ++++++++++++++++++--
 http.h        |    2 ++
 remote-curl.c |    2 ++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 4814217..6027546 100644
--- a/http.c
+++ b/http.c
@@ -815,7 +815,19 @@ static int http_request(const char *url, void
*result, int target, int options)
 			ret = HTTP_OK;
 		else if (missing_target(&results))
 			ret = HTTP_MISSING_TARGET;
-		else
+		else if (results.http_code == 401) {
+			if (user_name) {
+				ret = HTTP_NOAUTH;
+			} else {
+				// git_getpass is needed here because its very likely stdin/stdout are
+				// pipes to our parent process.  So we instead need to use /dev/tty,
+				// but that is non-portable.  Using git_getpass() can at least be stubbed
+				// on other platforms with a different implementation if/when necessary.
+				user_name = xstrdup(git_getpass("Username: "));
+				init_curl_http_auth(slot->curl);
+				ret = HTTP_REAUTH;
+			}
+		} else
 			ret = HTTP_ERROR;
 	} else {
 		error("Unable to start HTTP request for %s", url);
@@ -831,7 +843,11 @@ static int http_request(const char *url, void
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
