From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/2] http-push: refactor curl_easy_setup madness
Date: Wed, 30 Mar 2011 20:38:51 -0500
Message-ID: <1301535531-1244-2-git-send-email-dpmcgee@gmail.com>
References: <1301535531-1244-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 03:39:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56qm-0003dg-8L
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933818Ab1CaBi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 21:38:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33023 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932822Ab1CaBi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 21:38:57 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so1864765iwn.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Jejpa1xRbiBI71nGNLTq76sDS6J0/IqOe+R/YPBoUZk=;
        b=tc0+kJ6E3KPI+U4dA+Y5OQwvF6cNnPpIitjB8Vv2DlQTH6TAWGuA21Sd9/AKiUch3y
         8RQOjyrkivwiNmVeb4A4ivrWAP+Zwc2qn7f8YrbWVUYPJtyG5SSsALuZHshAu6pkJkwF
         vOiPdpma2gL4/nVMXk7YgPEkMpvSFArRN0rOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=va1fzlDezHJfTCcMWdHkr5FP+9xkM5MLgOPwmQ9QXwv0bKBR/iP5kP/lqy9afpBuIC
         zVDHQ8TlHuizfHIeApd1NFvFg85xgm+D6t3cI8svUeSffuYPBa387JtZNhpVlBdGxVpW
         CajScICT6/3y9VY/BtseUXmmVpCL//+7RyIGc=
Received: by 10.231.60.73 with SMTP id o9mr2116457ibh.33.1301535536870;
        Wed, 30 Mar 2011 18:38:56 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id i26sm382187iby.41.2011.03.30.18.38.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 18:38:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301535531-1244-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170446>

We were doing (nearly) the same thing all over the place, in slightly
different orders, different variable names, etc. Refactor most calls
into two helper functions, one for GET and one for everything else, that
do the heavy lifting leaving most callsites a lot cleaner in the
process.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 http-push.c |  152 ++++++++++++++++++++---------------------------------------
 1 files changed, 52 insertions(+), 100 deletions(-)

diff --git a/http-push.c b/http-push.c
index d18346c..28bfe76 100644
--- a/http-push.c
+++ b/http-push.c
@@ -169,7 +169,7 @@ enum dav_header_flag {
 	DAV_HEADER_TIMEOUT = (1u << 2)
 };
 
-static char *xml_entities(char *s)
+static char *xml_entities(const char *s)
 {
 	struct strbuf buf = STRBUF_INIT;
 	while (*s) {
@@ -197,6 +197,34 @@ static char *xml_entities(char *s)
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
@@ -797,7 +805,7 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 	}
 }
 
-static void one_remote_ref(char *refname);
+static void one_remote_ref(const char *refname);
 
 static void
 xml_start_tag(void *userData, const char *name, const char **atts)
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
@@ -1471,7 +1436,7 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 
 static struct ref *remote_refs;
 
-static void one_remote_ref(char *refname)
+static void one_remote_ref(const char *refname)
 {
 	struct ref *ref;
 	struct object *obj;
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
@@ -1660,7 +1615,7 @@ static int verify_merge_base(unsigned char *head_sha1, unsigned char *branch_sha
 	return (merge_bases && !merge_bases->next && merge_bases->item == branch);
 }
 
-static int delete_remote_branch(char *pattern, int force)
+static int delete_remote_branch(const char *pattern, int force)
 {
 	struct ref *refs = remote_refs;
 	struct ref *remote_ref = NULL;
@@ -1742,10 +1697,7 @@ static int delete_remote_branch(char *pattern, int force)
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
1.7.4.2
