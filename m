From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4 4/4] http-push: refactor curl_easy_setup madness
Date: Wed,  4 May 2011 18:11:36 +0800
Message-ID: <1304503896-5988-5-git-send-email-rctay89@gmail.com>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
 <1304503896-5988-1-git-send-email-rctay89@gmail.com>
 <1304503896-5988-2-git-send-email-rctay89@gmail.com>
 <1304503896-5988-3-git-send-email-rctay89@gmail.com>
 <1304503896-5988-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 12:12:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHZ3n-0002px-M3
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 12:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab1EDKLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 06:11:54 -0400
Received: from mail-px0-f170.google.com ([209.85.212.170]:56238 "EHLO
	mail-px0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab1EDKLw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 06:11:52 -0400
Received: by mail-px0-f170.google.com with SMTP id 19so734544pxi.1
        for <git@vger.kernel.org>; Wed, 04 May 2011 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=cIwvR3TZ0zZkW8z1o1dfjAUqsEg7k+wUvGzqYttifBA=;
        b=b26F91nxEpMpIOg5gC/8bfXhNIJZt2ooUj9dToUniAeXD9VpMJkp0n9jfcQrTD5c32
         /ZR2f1/J1InXmZCxaJHUXqrv7qLmKWIeP3HdOL9qnPl4B3izahWZixv56bI6lyConoaX
         MtetpkFmvh3a+b8D5PYFTkfhS4mm+0cH7H+iU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RjZYHp63gKR8bRoYEopKNv3dVeQrasEnkSRfvUQ/wzMcX0H5GVF6NxFhWRda/ZDRpE
         kIemMHKYQT6nKBFF7lRuJOr+uk8ArhHflJN8LzsdCxUqE43Bfud0CyqPEi3XxfHoDBpV
         cV+pH5bqbd9PQ6bWCtUXMQukgNTfgGwvj+gx8=
Received: by 10.68.32.129 with SMTP id j1mr1337415pbi.484.1304503912258;
        Wed, 04 May 2011 03:11:52 -0700 (PDT)
Received: from localhost.localdomain (cm134.beta238.maxonline.com.sg [116.86.238.134])
        by mx.google.com with ESMTPS id y5sm643190pbq.57.2011.05.04.03.11.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 03:11:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.585.g74f6e
In-Reply-To: <1304503896-5988-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172737>

From: Dan McGee <dpmcgee@gmail.com>

We were doing (nearly) the same thing all over the place, in slightly
different orders, different variable names, etc. Refactor most calls
into two helper functions, one for GET and one for everything else, that
do the heavy lifting leaving most callsites a lot cleaner in the
process.

Note that the setting of CURLOPT_PUT at the callsites of
curl_setup_http() which previously didn't do it (eg.
locking_available(), remote_ls()) is safe, since that
option is deprecated in libcurl in place of, and has the same effect as,
CURLOPT_UPLOAD.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |  144 ++++++++++++++++++++---------------------------------------
 1 files changed, 48 insertions(+), 96 deletions(-)

diff --git a/http-push.c b/http-push.c
index 0fce38d..28bfe76 100644
--- a/http-push.c
+++ b/http-push.c
@@ -197,6 +197,34 @@ static char *xml_entities(const char *s)
 	return strbuf_detach(&buf, NULL);
 }
 
+static void curl_setup_http_get(CURL *curl, const char *url,
+		const char *custom_req)
+{
+	curl_easy_setopt(curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(curl, CURLOPT_URL, url);
+	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
+	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_null);
+}
+
+static void curl_setup_http(CURL *curl, const char *url,
+		const char *custom_req, struct buffer *buffer,
+		curl_write_callback write_fn)
+{
+	curl_easy_setopt(curl, CURLOPT_PUT, 1);
+	curl_easy_setopt(curl, CURLOPT_URL, url);
+	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
+	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+#ifndef NO_CURL_IOCTL
+	curl_easy_setopt(curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
+	curl_easy_setopt(curl, CURLOPT_IOCTLDATA, &buffer);
+#endif
+	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
+	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
+}
+
 static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum dav_header_flag options)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -272,11 +300,8 @@ static void start_mkcol(struct transfer_request *request)
 	slot = get_active_slot();
 	slot->callback_func = process_response;
 	slot->callback_data = request;
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1); /* undo PUT setup */
-	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
+	curl_setup_http_get(slot->curl, request->url, DAV_MKCOL);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_MKCOL);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
 
 	if (start_active_slot(slot)) {
 		request->slot = slot;
@@ -395,19 +420,8 @@ static void start_put(struct transfer_request *request)
 	slot = get_active_slot();
 	slot->callback_func = process_response;
 	slot->callback_data = request;
-	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &request->buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, request->buffer.buf.len);
-	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
-#ifndef NO_CURL_IOCTL
-	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &request->buffer);
-#endif
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
-	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_PUT, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
+	curl_setup_http(slot->curl, request->url, DAV_PUT,
+			&request->buffer, fwrite_null);
 
 	if (start_active_slot(slot)) {
 		request->slot = slot;
@@ -427,13 +441,10 @@ static void start_move(struct transfer_request *request)
 	slot = get_active_slot();
 	slot->callback_func = process_response;
 	slot->callback_data = request;
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1); /* undo PUT setup */
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_MOVE);
+	curl_setup_http_get(slot->curl, request->url, DAV_MOVE);
 	dav_headers = curl_slist_append(dav_headers, request->dest);
 	dav_headers = curl_slist_append(dav_headers, "Overwrite: T");
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
 
 	if (start_active_slot(slot)) {
 		request->slot = slot;
@@ -458,10 +469,7 @@ static int refresh_lock(struct remote_lock *lock)
 
 	slot = get_active_slot();
 	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_LOCK);
+	curl_setup_http_get(slot->curl, lock->url, DAV_LOCK);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 
 	if (start_active_slot(slot)) {
@@ -876,10 +884,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 		ep[1] = '\0';
 		slot = get_active_slot();
 		slot->results = &results;
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-		curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-		curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_MKCOL);
-		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
+		curl_setup_http_get(slot->curl, url, DAV_MKCOL);
 		if (start_active_slot(slot)) {
 			run_active_slot(slot);
 			if (results.curl_result != CURLE_OK &&
@@ -909,19 +914,9 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 
 	slot = get_active_slot();
 	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len);
-	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
-#ifndef NO_CURL_IOCTL
-	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &out_buffer);
-#endif
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_LOCK);
+	curl_setup_http(slot->curl, url, DAV_LOCK, &out_buffer, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
 
 	lock = xcalloc(1, sizeof(*lock));
 	lock->timeout = -1;
@@ -987,9 +982,7 @@ static int unlock_remote(struct remote_lock *lock)
 
 	slot = get_active_slot();
 	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_UNLOCK);
+	curl_setup_http_get(slot->curl, lock->url, DAV_UNLOCK);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 
 	if (start_active_slot(slot)) {
@@ -1167,19 +1160,10 @@ static void remote_ls(const char *path, int flags,
 
 	slot = get_active_slot();
 	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len);
-	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
-#ifndef NO_CURL_IOCTL
-	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &out_buffer);
-#endif
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PROPFIND);
+	curl_setup_http(slot->curl, url, DAV_PROPFIND,
+			&out_buffer, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
@@ -1250,19 +1234,10 @@ static int locking_available(void)
 
 	slot = get_active_slot();
 	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len);
-	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
-#ifndef NO_CURL_IOCTL
-	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &out_buffer);
-#endif
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, repo->url);
-	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PROPFIND);
+	curl_setup_http(slot->curl, repo->url, DAV_PROPFIND,
+			&out_buffer, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
@@ -1436,19 +1411,9 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 
 	slot = get_active_slot();
 	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len);
-	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
-#ifndef NO_CURL_IOCTL
-	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &out_buffer);
-#endif
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
+	curl_setup_http(slot->curl, lock->url, DAV_PUT,
+			&out_buffer, fwrite_null);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
-	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_PUT, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
@@ -1572,19 +1537,9 @@ static void update_remote_info_refs(struct remote_lock *lock)
 
 		slot = get_active_slot();
 		slot->results = &results;
-		curl_easy_setopt(slot->curl, CURLOPT_INFILE, &buffer);
-		curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, buffer.buf.len);
-		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
-#ifndef NO_CURL_IOCTL
-		curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
-		curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &buffer);
-#endif
-		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-		curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
+		curl_setup_http(slot->curl, lock->url, DAV_PUT,
+				&buffer, fwrite_null);
 		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
-		curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
-		curl_easy_setopt(slot->curl, CURLOPT_PUT, 1);
-		curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
 
 		if (start_active_slot(slot)) {
 			run_active_slot(slot);
@@ -1742,10 +1697,7 @@ static int delete_remote_branch(const char *pattern, int force)
 	sprintf(url, "%s%s", repo->url, remote_ref->name);
 	slot = get_active_slot();
 	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_DELETE);
+	curl_setup_http_get(slot->curl, url, DAV_DELETE);
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		free(url);
-- 
1.7.3.3.585.g74f6e
