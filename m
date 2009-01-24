From: Ray Chuan <rctay89@gmail.com>
Subject: PATCH] http-push: refactor request url creation
Date: Sun, 25 Jan 2009 00:16:19 +0800
Message-ID: <be6fef0d0901240816r25e6a9c9q2d437d413a524362@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 17:17:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQlCh-0006St-GR
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 17:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496AbZAXQQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 11:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755397AbZAXQQV
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 11:16:21 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:16247 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229AbZAXQQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 11:16:20 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5200453rvb.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 08:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=8B6+zfULq38E+D2AMxuS6SsVNqoALYBjIN32YrArSj8=;
        b=c3E+C/wSCyFpE+F/SQVEZHuVHHjfOjX6HmRRPj8egkZHzsv7A2xvR1GVNYsPrN2WXD
         BjCLOtFJV8pyrNWE92PJDTd9ntYkQav5wW5tBZYE4oEoeO3U354iW5li7SaSZkFhCT4V
         djaxAvl8TzD50pk1+966r+mGqPPEaiivNEnYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=BODk3qkBjvohPKW8fnPBGrQjxstjS+4kC4bT2ceExu7P6e6EqVaUnrnUsnKvle5+kO
         xNFzphWhmSzemBgtDbGymN5LgBqn+3o3pIdx3G5Njuyjd7DtgLcyrMNHLIUtddxAqhtB
         F6LyyXrql5KKgdyGw9v+I3b00ZedFX4dkJALg=
Received: by 10.114.81.1 with SMTP id e1mr186132wab.212.1232813779972; Sat, 24 
	Jan 2009 08:16:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106974>

Currently, functions that deal with objects on the remote repository
have to allocate and do strcpys to generate the URL.

This patch saves them this trouble, by providing a function that
returns a URL: either the object's 2-digit hex directory (eg.
/objects/a1/) or the complete object location (eg. /objects/a1/b2).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |   58 +++++++++++++++++++---------------------------------------
 1 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/http-push.c b/http-push.c
index cb5bf95..715954e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -177,6 +177,16 @@ struct remote_ls_ctx
 	struct remote_ls_ctx *parent;
 };

+static char *get_remote_object_url(const char *url, const char *hex,
int only_two_digit_postfix) {
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%sobjects/%.*s/", url, 2, hex);
+	if(!only_two_digit_postfix)
+		strbuf_addf(&buf, "%s", hex+2);
+
+	return strbuf_detach(&buf, NULL);
+}
+
 static void finish_request(struct transfer_request *request);
 static void release_request(struct transfer_request *request);

@@ -222,8 +232,6 @@ static void start_fetch_loose(struct
transfer_request *request)
 	char *hex = sha1_to_hex(request->obj->sha1);
 	char *filename;
 	char prevfile[PATH_MAX];
-	char *url;
-	char *posn;
 	int prevlocal;
 	unsigned char prev_buf[PREV_BUF_SIZE];
 	ssize_t prev_read = 0;
@@ -273,17 +281,7 @@ static void start_fetch_loose(struct
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
@@ -327,7 +325,7 @@ static void start_fetch_loose(struct
transfer_request *request)
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, request);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);

 	/* If we have successfully processed data from a previous fetch
@@ -356,16 +354,8 @@ static void start_mkcol(struct transfer_request *request)
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
@@ -480,7 +470,7 @@ static void start_put(struct transfer_request *request)
 {
 	char *hex = sha1_to_hex(request->obj->sha1);
 	struct active_request_slot *slot;
-	char *posn;
+	struct strbuf url_buf = STRBUF_INIT;
 	enum object_type type;
 	char hdr[50];
 	void *unpacked;
@@ -519,21 +509,11 @@ static void start_put(struct transfer_request *request)

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
