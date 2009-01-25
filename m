From: Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] http-push: refactor request url creation
Date: Sun, 25 Jan 2009 14:08:57 +0800
Message-ID: <be6fef0d0901242208p635264e5jc1f95d784cd51450@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 07:10:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQyCS-0007un-UE
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 07:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbZAYGJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 01:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbZAYGJB
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 01:09:01 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:8875 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbZAYGJA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 01:09:00 -0500
Received: by wa-out-1112.google.com with SMTP id v33so300772wah.21
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 22:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=ToSGoQkGQHQ9TSAnjwMqv9lz3izgaqh4Y5dQzwVL2Dg=;
        b=OGAnpdhNW0mtLUYxurIwTwFJqaOonJ1+qaJocYrU7idDmF9KIcs2XsfHDnV0uzum83
         30kuRYGrt5wuppikCIO2tRVhogfy+WaWSGeesmdkpcqyCrk2//oNC1Z43TvE1A90CXAS
         jgd4j06irgev6EO03Wd1wFEpLbrLMbykIJSrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=cW16T1jIg9WTbBab+vYJdU9EbokRDcUxCZhV9qMXcsYtkflKf6fgD29jAMsmKJEyXw
         qUBpfhyQn0aIqMtdaqemtf0EA2e3BDk8uLseUIOVBtwJbFE6HIzQbLW5yl2US9Zp2bQr
         jglvi+q03b+uGNg7hTtmyRrJ2vn2XFp3DsOz4=
Received: by 10.114.81.1 with SMTP id e1mr611020wab.212.1232863737271; Sat, 24 
	Jan 2009 22:08:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107044>

Currently, functions that deal with objects on the remote repository
have to allocate and do strcpys to generate the URL.

This patch saves them this trouble, by providing a function that
returns a URL: either the object's 2-digit hex directory (eg.
/objects/a1/) or the complete object location (eg. /objects/a1/b2).

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

* renamed only_two_digit_postfix in original patch to only_two_digit_prefix
* rebased and generated on master (5dc1308)

 http-push.c |   58 +++++++++++++++++++---------------------------------------
 1 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/http-push.c b/http-push.c
index eca4a8e..27825f2 100644
--- a/http-push.c
+++ b/http-push.c
@@ -208,6 +208,16 @@ static struct curl_slist
*get_dav_token_headers(struct remote_lock *lock, enum d
 	return dav_headers;
 }

+static char *get_remote_object_url(const char *url, const char *hex,
int only_two_digit_prefix) {
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%sobjects/%.*s/", url, 2, hex);
+	if(!only_two_digit_prefix)
+		strbuf_addf(&buf, "%s", hex+2);
+
+	return strbuf_detach(&buf, NULL);
+}
+
 static void finish_request(struct transfer_request *request);
 static void release_request(struct transfer_request *request);

@@ -253,8 +263,6 @@ static void start_fetch_loose(struct
transfer_request *request)
 	char *hex = sha1_to_hex(request->obj->sha1);
 	char *filename;
 	char prevfile[PATH_MAX];
-	char *url;
-	char *posn;
 	int prevlocal;
 	unsigned char prev_buf[PREV_BUF_SIZE];
 	ssize_t prev_read = 0;
@@ -304,17 +312,7 @@ static void start_fetch_loose(struct
transfer_request *request)

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
+	request->url = get_remote_object_url(remote->url, hex, 0);

 	/* If a previous temp file is present, process what was already
 	   fetched. */
@@ -358,7 +356,7 @@ static void start_fetch_loose(struct
transfer_request *request)
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, request);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);

 	/* If we have successfully processed data from a previous fetch
@@ -387,16 +385,8 @@ static void start_mkcol(struct transfer_request *request)
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
@@ -511,7 +501,7 @@ static void start_put(struct transfer_request *request)
 {
 	char *hex = sha1_to_hex(request->obj->sha1);
 	struct active_request_slot *slot;
-	char *posn;
+	struct strbuf url_buf = STRBUF_INIT;
 	enum object_type type;
 	char hdr[50];
 	void *unpacked;
@@ -550,21 +540,11 @@ static void start_put(struct transfer_request *request)

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
+	strbuf_addf(&url_buf, "Destination: %s",
get_remote_object_url(remote->url, hex, 0));
+	request->dest = strbuf_detach(&url_buf, NULL);
+
+	strbuf_addf(&url_buf, "%s_%s", get_remote_object_url(remote->url,
hex, 0), request->lock->token);
+	request->url = strbuf_detach(&url_buf, NULL);

 	slot = get_active_slot();
 	slot->callback_func = process_response;
-- 
1.6.0.4
