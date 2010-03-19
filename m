From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH] Prompt for a username when an HTTP request 401s
Date: Fri, 19 Mar 2010 12:17:58 -0700
Message-ID: <d411cc4a1003191217k406e7f0fyd144d8a77e73a60c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Stenberg <daniel@haxx.se>,
	Tay Ray Chuan <rctay89@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 20:18:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nshhv-0001GX-1g
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 20:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198Ab0CSTSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 15:18:00 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:49651 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab0CSTSA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 15:18:00 -0400
Received: by wwe15 with SMTP id 15so2041389wwe.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=2whOdXQbLw7w59VInxfvHN50VQ17peqx3S/Z/3HPeb4=;
        b=M/EDgBsHCgOoovXoKLO7VzMtsNyyyQ/S3/3KeV9pfM0bu4J8vAZqM5tP3QP0KT5GKV
         2mKGXRh3d5f/AtJR7x6cndxboaVzb5hOjR6ypjFb/ULqdYeg0mmONFRSZSHuO99ZjjgY
         iSFZNKMCC0e+TCkbE7Rzl/jexxERjMi7aZa4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=EQuo/VPf1d4IZ9q1LZ0Xowh4TX1C7onKTykF/xhxoT4gRNtGVt3opJyE891iXVy7Ij
         voqH3+QL48rDoGDZlh6233VTZEycwx3CoNOrQuy9mKsAMQ7w+ht2WD8nwetdiIRW6dt9
         yJcuSkw4s6ubYE71fw0OD2gcZsd1Zj62Id0SI=
Received: by 10.216.90.7 with SMTP id d7mr16018wef.81.1269026278761; Fri, 19 
	Mar 2010 12:17:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142637>

When an HTTP request returns a 401, Git will currently fail with a
confusing message saying that it got a 401.  This changes
http_request to prompt for the username and password, then return
HTTP_REAUTH so http_get_strbuf can try again.  If it gets a 401 even
when a user/pass is supplied, http_request will now return HTTP_NOAUTH
which remote_curl can then use to display a more intelligent error
message that is less confusing.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---

Third version of this with Shawn's comments on why getpass() is needed.

 http.c        |   20 ++++++++++++++++++--
 http.h        |    2 ++
 remote-curl.c |    2 ++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index deab595..62db1f0 100644
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
+				// getpass is needed here because its very likely stdin/stdout are
+				// pipes to our parent process.  So we instead need to use /dev/tty,
+				// but that is non-portable.  Using getpass() can at least be stubbed
+				// on other platforms with a different implementation if/when necessary.
+				user_name = xstrdup(getpass("Username: "));
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
