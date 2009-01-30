From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH --no-flowed] http-push: refactor request url creation
Date: Fri, 30 Jan 2009 23:05:57 +0800
Message-ID: <49831755.60405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 16:08:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSuyc-0004K7-IM
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 16:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312AbZA3PGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 10:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756348AbZA3PGV
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 10:06:21 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:21150 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbZA3PGS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 10:06:18 -0500
Received: by wf-out-1314.google.com with SMTP id 27so528125wfd.4
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 07:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=98Xn6M3aEUMoO1xD8XnPpZwT1qyqQSW/Ee4Qb+VjnbU=;
        b=EhdvDLbiv+G9OxQoskO8EPm5lC4ajWihE0BaBF1uF73wWBkHrNLjR1YQvAANClnuAc
         b2Gi93wYayZ0JCg5NkTkGP+nJWrdxeg3W1MHOKG2Ehfm+6q9AyXUTASVzHDgpdMXOX8r
         1Tb9jtlVQyMNKjQ571oOf7J/WKeNJvjIoCkzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=RsOc8P3OD8J1k7awHhytcxX7ed8QON1XmZKFzqV5yRsqKxaT6l+Q6nEnhfJj1Qs6C4
         VqkINgUYNTV7nf4jCca9kaz+YCGWoi3H+RFokPwwYehjMNB9i/BklVXqymTTkvnH9/+x
         lCrdv5eTkBBZz0M7jTYp0ZVhdm2uJbnchARRo=
Received: by 10.142.193.13 with SMTP id q13mr553782wff.277.1233327977600;
        Fri, 30 Jan 2009 07:06:17 -0800 (PST)
Received: from ?116.87.148.221? ([116.87.148.221])
        by mx.google.com with ESMTPS id 24sm1154620wfc.2.2009.01.30.07.06.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 07:06:17 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107831>

Hi,

Currently, functions that deal with objects on the remote repository
have to allocate and do strcpys to generate the URL.

This patch saves them this trouble, by providing two functions,
"append_remote_object_url" and "get_remote_object_url".

Both generate a URL, with either the object's 2-digit hex directory
(eg. /objects/a1/), or the complete object location (eg.
/objects/a1/b2).

However, they differ in that "append_remote_object_url" appends this
URL to a strbuf, while "get_remote_object_url" wraps around the former
and returns the URL directly in char*. Users usually would use
"get_remote_object_url", but may find "append_remote_object_url"
useful if they require further string operations on the URL.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Acked-by: Junio C Hamano <gitster@pobox.com>
---

* renamed only_two_digit_postfix in original patch to only_two_digit_prefix
* updated with Junio's changes (if (...) and fix memory leak)
* updated with Junio's double interface
* added back use of temporary string "url" in "start_fetch_loose"
* rebased and generated on master (a34a9db)

Crossing my fingers about format=flowed and linewraps.

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
