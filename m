From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2] http-push: refactor request url creation
Date: Thu, 29 Jan 2009 22:59:07 +0800
Message-ID: <4981C43B.9030409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 16:01:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSYO1-0007pV-Sz
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 16:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbZA2O7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753779AbZA2O7b
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:59:31 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:5270 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbZA2O7a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:59:30 -0500
Received: by rv-out-0506.google.com with SMTP id k40so7534927rvb.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=371CDwR0PzTOGu3uLg9EpR+hKqWy3j5SoAxK/b/ux0g=;
        b=xQ1jnTP2OBTrJ2kL94G0UMQHjOg7khCiiEKEw1gyJmepqlRN9bKwWhfCrsXJSU13kL
         G3Wg5v3lc3BvWkpJPClahSjc2IjfouscI76eT5LYwRQzYoxGGVOt75xojxqGKzPPm8Eo
         gkkfH5X+bINsnWsV2qIbRiLxqmv4VvXXxH0H4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=mxhvu898i21mrnmt0loZOl88pFSfdQtIWs94SLcJtDOEF9KQOfXZSNS3jrl5yrcJXK
         JSo+aCYmUt0KSV1iHiQCDaAst7Nt2OuIejBd+Qevh2qdSNrDqgyh6IHbKyS7lqiLzzhu
         uxI0TuaLabORN5kZqFCB/x86nbBxfJJ/IQoDI=
Received: by 10.141.106.14 with SMTP id i14mr84757rvm.27.1233241169804;
        Thu, 29 Jan 2009 06:59:29 -0800 (PST)
Received: from ?116.87.148.221? ([116.87.148.221])
        by mx.google.com with ESMTPS id g14sm1316926rvb.1.2009.01.29.06.59.27
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Jan 2009 06:59:29 -0800 (PST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107691>

Currently, functions that deal with objects on the remote repository have to allocate and
do strcpys to generate the URL.

This patch saves them this trouble, by providing two functions, "append_remote_object_url"
and "get_remote_object_url".

Both generate a URL, with either the object's 2-digit hex directory (eg. /objects/a1/), or
the complete object location (eg. /objects/a1/b2).

However, they differ in that "append_remote_object_url" appends this URL to a strbuf, while
"get_remote_object_url" wraps around the former and returns the URL directly in char*.
Users usually would use "get_remote_object_url", but may find "append_remote_object_url"
useful if they require further string operations on the URL.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Acked-by: Junio C Hamano <gitster@pobox.com>
---

* renamed only_two_digit_postfix in original patch to only_two_digit_prefix
* rebased and generated on master (5dc1308)
* updated with Junio's changes (if (...) and fix memory leak)
* updated with Junio's double interface
* added back use of temporary string "url" in "start_fetch_loose"
* rebased and generated on master (a34a9db)

  http-push.c |   62 +++++++++++++++++++++++-----------------------------------
  1 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/http-push.c b/http-push.c
index 59037df..816e658 100644
--- a/http-push.c
+++ b/http-push.c
@@ -209,6 +209,20 @@ static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum d
  	return dav_headers;
  }

+static void append_remote_object_url(struct strbuf *buf, const char *url, const char *hex, int only_two_digit_prefix)
+{
+	strbuf_addf(buf, "%sobjects/%.*s/", url, 2, hex);
+	if (!only_two_digit_prefix)
+		strbuf_addf(buf, "%s", hex+2);
+}
+
+static char *get_remote_object_url(const char *url, const char *hex, int only_two_digit_prefix)
+{
+	struct strbuf buf = STRBUF_INIT;
+	append_remote_object_url(&buf, url, hex, only_two_digit_prefix);
+	return strbuf_detach(&buf, NULL);
+}
+
  static void finish_request(struct transfer_request *request);
  static void release_request(struct transfer_request *request);

@@ -255,7 +269,6 @@ static void start_fetch_loose(struct transfer_request *request)
  	char *filename;
  	char prevfile[PATH_MAX];
  	char *url;
-	char *posn;
  	int prevlocal;
  	unsigned char prev_buf[PREV_BUF_SIZE];
  	ssize_t prev_read = 0;
@@ -305,17 +318,8 @@ static void start_fetch_loose(struct transfer_request *request)

  	git_SHA1_Init(&request->c);

-	url = xmalloc(strlen(remote->url) + 50);
-	request->url = xmalloc(strlen(remote->url) + 50);
-	strcpy(url, remote->url);
-	posn = url + strlen(remote->url);
-	strcpy(posn, "objects/");
-	posn += 8;
-	memcpy(posn, hex, 2);
-	posn += 2;
-	*(posn++) = '/';
-	strcpy(posn, hex + 2);
-	strcpy(request->url, url);
+	url = get_remote_object_url(remote->url, hex, 0);
+	request->url = xstrdup(url);

  	/* If a previous temp file is present, process what was already
  	   fetched. */
@@ -388,16 +392,8 @@ static void start_mkcol(struct transfer_request *request)
  {
  	char *hex = sha1_to_hex(request->obj->sha1);
  	struct active_request_slot *slot;
-	char *posn;

-	request->url = xmalloc(strlen(remote->url) + 13);
-	strcpy(request->url, remote->url);
-	posn = request->url + strlen(remote->url);
-	strcpy(posn, "objects/");
-	posn += 8;
-	memcpy(posn, hex, 2);
-	posn += 2;
-	strcpy(posn, "/");
+	request->url = get_remote_object_url(remote->url, hex, 1);

  	slot = get_active_slot();
  	slot->callback_func = process_response;
@@ -512,7 +508,7 @@ static void start_put(struct transfer_request *request)
  {
  	char *hex = sha1_to_hex(request->obj->sha1);
  	struct active_request_slot *slot;
-	char *posn;
+	struct strbuf buf = STRBUF_INIT;
  	enum object_type type;
  	char hdr[50];
  	void *unpacked;
@@ -551,21 +547,13 @@ static void start_put(struct transfer_request *request)

  	request->buffer.buf.len = stream.total_out;

-	request->url = xmalloc(strlen(remote->url) +
-			       strlen(request->lock->token) + 51);
-	strcpy(request->url, remote->url);
-	posn = request->url + strlen(remote->url);
-	strcpy(posn, "objects/");
-	posn += 8;
-	memcpy(posn, hex, 2);
-	posn += 2;
-	*(posn++) = '/';
-	strcpy(posn, hex + 2);
-	request->dest = xmalloc(strlen(request->url) + 14);
-	sprintf(request->dest, "Destination: %s", request->url);
-	posn += 38;
-	*(posn++) = '_';
-	strcpy(posn, request->lock->token);
+	strbuf_addstr(&buf, "Destination: ");
+	append_remote_object_url(&buf, remote->url, hex, 0);
+	request->dest = strbuf_detach(&buf, NULL);
+
+	append_remote_object_url(&buf, remote->url, hex, 0);
+	strbuf_addstr(&buf, request->lock->token);
+	request->url = strbuf_detach(&buf, NULL);

  	slot = get_active_slot();
  	slot->callback_func = process_response;
-- 
1.6.1.1.241.gc53a6.dirty
