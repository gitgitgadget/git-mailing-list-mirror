From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] http-push: refactor request url creation
Date: Thu, 29 Jan 2009 06:19:43 +0800
Message-ID: <4980D9FF.7020307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 23:21:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSImx-00053C-2Q
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 23:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbZA1WUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 17:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZA1WUO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 17:20:14 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:52551 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZA1WUM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 17:20:12 -0500
Received: by rv-out-0506.google.com with SMTP id k40so7162380rvb.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 14:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=lB0ocA7KXeES6q5rjl3xk+7CmOkLRnsA5i2w/lY92Og=;
        b=duamATYsGIvDrbW6Qhhcr/rwutE8XlNEzg4MmNwaSG5ej7H46N0pFofsomv8zGcl/H
         YdwLHMiE0bJVb4wGEl4SmM6agydKlmiyaIBOMs2H8Jy1BP6peKzlkSOEiFprGtMAH98A
         eUfgBJiTbhkfRDLV6LrNPo9bdVgjTK4yg5HJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=HZwzUHIdJpoZRKBHkG2klHl8bLsAN3M90/uf7feaf2zTKVSfHwzEeh8+xs95KcUI+o
         xFneum2nsW3NWdW8f35pjF0JTk/LnPOuzl0Xy9Z0Mm+8jBWYkTDEugW3ZlR/xXB+ELZB
         mTFdb88UIWPXcleoQgX99qSZuMRgTDAYOff+s=
Received: by 10.140.247.11 with SMTP id u11mr200340rvh.123.1233181211428;
        Wed, 28 Jan 2009 14:20:11 -0800 (PST)
Received: from ?116.87.148.55? ([116.87.148.55])
        by mx.google.com with ESMTPS id b39sm16544038rvf.0.2009.01.28.14.20.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Jan 2009 14:20:04 -0800 (PST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107589>

Currently, functions that deal with objects on the remote repository have to allocate and do strcpys to generate the URL.

This patch saves them this trouble, by providing two functions, "append_remote_object_url" and "get_remote_object_url".

Both generate a URL, with either the object's 2-digit hex directory (eg. /objects/a1/), or the complete object location (eg. /objects/a1/b2).

However, they differ in that "append_remote_object_url" appends this URL to a strbuf, while "get_remote_object_url" wraps around the former and returns the URL directly in char*. Users usually would use "get_remote_object_url", but may find "append_remote_object_url" useful if they require further string operations on the URL.

PS. In "start_fetch_loose", the variable "url" which is passed to "curl_easy_setopt" is removed, and in its place "request->url" is used. This is safe, since curl strdup's it.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Acked-by: Junio C Hamano <gitster@pobox.com>
---

* renamed only_two_digit_postfix in original patch to only_two_digit_prefix
* rebased and generated on master (5dc1308)
* updated with Junio's changes (if (...) and fix memory leak)
* updated with Junio's double interface
* rebased and generated on master (297f6a5)

  http-push.c |   64 +++++++++++++++++++++++-----------------------------------
  1 files changed, 25 insertions(+), 39 deletions(-)

diff --git a/http-push.c b/http-push.c
index 59037df..6511d19 100644
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

@@ -254,8 +268,6 @@ static void start_fetch_loose(struct transfer_request *request)
  	char *hex = sha1_to_hex(request->obj->sha1);
  	char *filename;
  	char prevfile[PATH_MAX];
-	char *url;
-	char *posn;
  	int prevlocal;
  	unsigned char prev_buf[PREV_BUF_SIZE];
  	ssize_t prev_read = 0;
@@ -305,17 +317,7 @@ static void start_fetch_loose(struct transfer_request *request)

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
@@ -359,7 +361,7 @@ static void start_fetch_loose(struct transfer_request *request)
  	curl_easy_setopt(slot->curl, CURLOPT_FILE, request);
  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
  	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);

  	/* If we have successfully processed data from a previous fetch
@@ -388,16 +390,8 @@ static void start_mkcol(struct transfer_request *request)
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
@@ -512,7 +506,7 @@ static void start_put(struct transfer_request *request)
  {
  	char *hex = sha1_to_hex(request->obj->sha1);
  	struct active_request_slot *slot;
-	char *posn;
+	struct strbuf buf = STRBUF_INIT;
  	enum object_type type;
  	char hdr[50];
  	void *unpacked;
@@ -551,21 +545,13 @@ static void start_put(struct transfer_request *request)

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
1.6.1.1.251.g0dfa1
