From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/4] Use strbuf in http code
Date: Sun,  9 Dec 2007 18:04:58 +0100
Message-ID: <1197219900-19334-2-git-send-email-mh@glandium.org>
References: 20071209170250.GA18955@glandium.org
 <1197219900-19334-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 18:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1PbC-0008I0-HV
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 18:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXLIRFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 12:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbXLIRFI
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 12:05:08 -0500
Received: from smtp2b.orange.fr ([80.12.242.144]:56985 "EHLO smtp2b.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbXLIRFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 12:05:04 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2b03.orange.fr (SMTP Server) with ESMTP id 411CA7000096
	for <git@vger.kernel.org>; Sun,  9 Dec 2007 18:05:02 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2b03.orange.fr (SMTP Server) with ESMTP id 958D87000086;
	Sun,  9 Dec 2007 18:05:01 +0100 (CET)
X-ME-UUID: 20071209170501612.958D87000086@mwinf2b03.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1PaO-00052B-W0; Sun, 09 Dec 2007 18:05:01 +0100
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197219900-19334-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67631>

Also, replace whitespaces with tabs in some places

Signed-off-by: Mike Hommey <mh@glandium.org>
---

 While testing this, I noticed 3 things:
 - CURL_MULTI makes the code very racy
 - a lot of the code doesn't do anything useful without CURL_MULTI
 - the code is redundant

 So, if I have some time soon, I'll try to refactor all that.

 http-push.c   |  186 ++++++++++++++++++--------------------------------------
 http-walker.c |   59 +++++++------------
 http.c        |   34 ++++------
 http.h        |   11 ++--
 transport.c   |   18 ++----
 5 files changed, 107 insertions(+), 201 deletions(-)

diff --git a/http-push.c b/http-push.c
index 78283b4..e01b3a9 100644
--- a/http-push.c
+++ b/http-push.c
@@ -495,10 +495,10 @@ static void start_put(struct transfer_request *request)
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, zlib_compression_level);
 	size = deflateBound(&stream, len + hdrlen);
-	request->buffer.buffer = xmalloc(size);
+	strbuf_init(&request->buffer.buf, size);
 
 	/* Compress it */
-	stream.next_out = request->buffer.buffer;
+	stream.next_out = (unsigned char *)request->buffer.buf.buf;
 	stream.avail_out = size;
 
 	/* First header.. */
@@ -515,8 +515,7 @@ static void start_put(struct transfer_request *request)
 	deflateEnd(&stream);
 	free(unpacked);
 
-	request->buffer.size = stream.total_out;
-	request->buffer.posn = 0;
+	request->buffer.buf.len = stream.total_out;
 
 	request->url = xmalloc(strlen(remote->url) +
 			       strlen(request->lock->token) + 51);
@@ -538,7 +537,7 @@ static void start_put(struct transfer_request *request)
 	slot->callback_func = process_response;
 	slot->callback_data = request;
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &request->buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, request->buffer.size);
+	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, request->buffer.buf.len);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
@@ -1003,18 +1002,13 @@ static int fetch_indices(void)
 {
 	unsigned char sha1[20];
 	char *url;
-	struct buffer buffer;
+	struct strbuf buffer = STRBUF_INIT;
 	char *data;
 	int i = 0;
 
 	struct active_request_slot *slot;
 	struct slot_results results;
 
-	data = xcalloc(1, 4096);
-	buffer.size = 4096;
-	buffer.posn = 0;
-	buffer.buffer = data;
-
 	if (push_verbosely)
 		fprintf(stderr, "Getting pack list\n");
 
@@ -1030,7 +1024,7 @@ static int fetch_indices(void)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-			free(buffer.buffer);
+			strbuf_release(&buffer);
 			free(url);
 			if (results.http_code == 404)
 				return 0;
@@ -1038,18 +1032,18 @@ static int fetch_indices(void)
 				return error("%s", curl_errorstr);
 		}
 	} else {
-		free(buffer.buffer);
+		strbuf_release(&buffer);
 		free(url);
 		return error("Unable to start request");
 	}
 	free(url);
 
-	data = buffer.buffer;
-	while (i < buffer.posn) {
+	data = buffer.buf;
+	while (i < buffer.len) {
 		switch (data[i]) {
 		case 'P':
 			i++;
-			if (i + 52 < buffer.posn &&
+			if (i + 52 < buffer.len &&
 			    !prefixcmp(data + i, " pack-") &&
 			    !prefixcmp(data + i + 46, ".pack\n")) {
 				get_sha1_hex(data + i + 6, sha1);
@@ -1064,7 +1058,7 @@ static int fetch_indices(void)
 		i++;
 	}
 
-	free(buffer.buffer);
+	strbuf_release(&buffer);
 	return 0;
 }
 
@@ -1115,16 +1109,11 @@ static char *quote_ref_url(const char *base, const char *ref)
 
 int fetch_ref(char *ref, unsigned char *sha1)
 {
-        char *url;
-        char hex[42];
-        struct buffer buffer;
+	char *url;
+	struct strbuf buffer = STRBUF_INIT;
 	char *base = remote->url;
 	struct active_request_slot *slot;
 	struct slot_results results;
-        buffer.size = 41;
-        buffer.posn = 0;
-        buffer.buffer = hex;
-        hex[41] = '\0';
 
 	url = quote_ref_url(base, ref);
 	slot = get_active_slot();
@@ -1142,9 +1131,9 @@ int fetch_ref(char *ref, unsigned char *sha1)
 		return error("Unable to start request");
 	}
 
-        hex[40] = '\0';
-        get_sha1_hex(hex, sha1);
-        return 0;
+	buffer.buf[40] = '\0';
+	get_sha1_hex(buffer.buf, sha1);
+	return 0;
 }
 
 static void one_remote_object(const char *hex)
@@ -1267,10 +1256,8 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
-	struct buffer out_buffer;
-	struct buffer in_buffer;
-	char *out_data;
-	char *in_data;
+	struct buffer out_buffer = { 0, STRBUF_INIT };
+	struct strbuf in_buffer = STRBUF_INIT;
 	char *url;
 	char *ep;
 	char timeout_header[25];
@@ -1312,16 +1299,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 		ep = strchr(ep + 1, '/');
 	}
 
-	out_buffer.size = strlen(LOCK_REQUEST) + strlen(git_default_email) - 2;
-	out_data = xmalloc(out_buffer.size + 1);
-	snprintf(out_data, out_buffer.size + 1, LOCK_REQUEST, git_default_email);
-	out_buffer.posn = 0;
-	out_buffer.buffer = out_data;
-
-	in_buffer.size = 4096;
-	in_data = xmalloc(in_buffer.size);
-	in_buffer.posn = 0;
-	in_buffer.buffer = in_data;
+	strbuf_addf(&out_buffer.buf, LOCK_REQUEST, git_default_email);
 
 	sprintf(timeout_header, "Timeout: Second-%ld", timeout);
 	dav_headers = curl_slist_append(dav_headers, timeout_header);
@@ -1330,7 +1308,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
+	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
@@ -1354,8 +1332,8 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 			XML_SetElementHandler(parser, xml_start_tag,
 					      xml_end_tag);
 			XML_SetCharacterDataHandler(parser, xml_cdata);
-			result = XML_Parse(parser, in_buffer.buffer,
-					   in_buffer.posn, 1);
+			result = XML_Parse(parser, in_buffer.buf,
+					   in_buffer.len, 1);
 			free(ctx.name);
 			if (result != XML_STATUS_OK) {
 				fprintf(stderr, "XML error: %s\n",
@@ -1369,8 +1347,8 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	}
 
 	curl_slist_free_all(dav_headers);
-	free(out_data);
-	free(in_data);
+	strbuf_release(&out_buffer.buf);
+	strbuf_release(&in_buffer);
 
 	if (lock->token == NULL || lock->timeout <= 0) {
 		if (lock->token != NULL)
@@ -1521,10 +1499,8 @@ static void remote_ls(const char *path, int flags,
 	char *url = xmalloc(strlen(remote->url) + strlen(path) + 1);
 	struct active_request_slot *slot;
 	struct slot_results results;
-	struct buffer in_buffer;
-	struct buffer out_buffer;
-	char *in_data;
-	char *out_data;
+	struct strbuf in_buffer = STRBUF_INIT;
+	struct buffer out_buffer = { 0, STRBUF_INIT };
 	XML_Parser parser = XML_ParserCreate(NULL);
 	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
@@ -1540,16 +1516,7 @@ static void remote_ls(const char *path, int flags,
 
 	sprintf(url, "%s%s", remote->url, path);
 
-	out_buffer.size = strlen(PROPFIND_ALL_REQUEST);
-	out_data = xmalloc(out_buffer.size + 1);
-	snprintf(out_data, out_buffer.size + 1, PROPFIND_ALL_REQUEST);
-	out_buffer.posn = 0;
-	out_buffer.buffer = out_data;
-
-	in_buffer.size = 4096;
-	in_data = xmalloc(in_buffer.size);
-	in_buffer.posn = 0;
-	in_buffer.buffer = in_data;
+	strbuf_addf(&out_buffer.buf, PROPFIND_ALL_REQUEST);
 
 	dav_headers = curl_slist_append(dav_headers, "Depth: 1");
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
@@ -1557,7 +1524,7 @@ static void remote_ls(const char *path, int flags,
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
+	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
@@ -1578,8 +1545,8 @@ static void remote_ls(const char *path, int flags,
 			XML_SetElementHandler(parser, xml_start_tag,
 					      xml_end_tag);
 			XML_SetCharacterDataHandler(parser, xml_cdata);
-			result = XML_Parse(parser, in_buffer.buffer,
-					   in_buffer.posn, 1);
+			result = XML_Parse(parser, in_buffer.buf,
+					   in_buffer.len, 1);
 			free(ctx.name);
 
 			if (result != XML_STATUS_OK) {
@@ -1594,8 +1561,8 @@ static void remote_ls(const char *path, int flags,
 
 	free(ls.path);
 	free(url);
-	free(out_data);
-	free(in_buffer.buffer);
+	strbuf_release(&out_buffer.buf);
+	strbuf_release(&in_buffer);
 	curl_slist_free_all(dav_headers);
 }
 
@@ -1616,29 +1583,15 @@ static int locking_available(void)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
-	struct buffer in_buffer;
-	struct buffer out_buffer;
-	char *in_data;
-	char *out_data;
+	struct strbuf in_buffer = STRBUF_INIT;
+	struct buffer out_buffer = { 0, STRBUF_INIT };
 	XML_Parser parser = XML_ParserCreate(NULL);
 	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
 	struct xml_ctx ctx;
 	int lock_flags = 0;
 
-	out_buffer.size =
-		strlen(PROPFIND_SUPPORTEDLOCK_REQUEST) +
-		strlen(remote->url) - 2;
-	out_data = xmalloc(out_buffer.size + 1);
-	snprintf(out_data, out_buffer.size + 1,
-		 PROPFIND_SUPPORTEDLOCK_REQUEST, remote->url);
-	out_buffer.posn = 0;
-	out_buffer.buffer = out_data;
-
-	in_buffer.size = 4096;
-	in_data = xmalloc(in_buffer.size);
-	in_buffer.posn = 0;
-	in_buffer.buffer = in_data;
+	strbuf_addf(&out_buffer.buf, PROPFIND_SUPPORTEDLOCK_REQUEST, remote->url);
 
 	dav_headers = curl_slist_append(dav_headers, "Depth: 0");
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
@@ -1646,7 +1599,7 @@ static int locking_available(void)
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
+	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
@@ -1666,8 +1619,8 @@ static int locking_available(void)
 			XML_SetUserData(parser, &ctx);
 			XML_SetElementHandler(parser, xml_start_tag,
 					      xml_end_tag);
-			result = XML_Parse(parser, in_buffer.buffer,
-					   in_buffer.posn, 1);
+			result = XML_Parse(parser, in_buffer.buf,
+					   in_buffer.len, 1);
 			free(ctx.name);
 
 			if (result != XML_STATUS_OK) {
@@ -1681,8 +1634,8 @@ static int locking_available(void)
 		fprintf(stderr, "Unable to start PROPFIND request\n");
 	}
 
-	free(out_data);
-	free(in_buffer.buffer);
+	strbuf_release(&out_buffer.buf);
+	strbuf_release(&in_buffer);
 	curl_slist_free_all(dav_headers);
 
 	return lock_flags;
@@ -1800,30 +1753,20 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
-	char *out_data;
 	char *if_header;
-	struct buffer out_buffer;
+	struct buffer out_buffer = { 0, STRBUF_INIT };
 	struct curl_slist *dav_headers = NULL;
-	int i;
 
 	if_header = xmalloc(strlen(lock->token) + 25);
 	sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
 	dav_headers = curl_slist_append(dav_headers, if_header);
 
-	out_buffer.size = 41;
-	out_data = xmalloc(out_buffer.size + 1);
-	i = snprintf(out_data, out_buffer.size + 1, "%s\n", sha1_to_hex(sha1));
-	if (i != out_buffer.size) {
-		fprintf(stderr, "Unable to initialize PUT request body\n");
-		return 0;
-	}
-	out_buffer.posn = 0;
-	out_buffer.buffer = out_data;
+	strbuf_addf(&out_buffer.buf, "%s\n", sha1_to_hex(sha1));
 
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
+	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
@@ -1834,7 +1777,7 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		free(out_data);
+		strbuf_release(&out_buffer.buf);
 		free(if_header);
 		if (results.curl_result != CURLE_OK) {
 			fprintf(stderr,
@@ -1844,7 +1787,7 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 			return 0;
 		}
 	} else {
-		free(out_data);
+		strbuf_release(&out_buffer.buf);
 		free(if_header);
 		fprintf(stderr, "Unable to start PUT request\n");
 		return 0;
@@ -2001,7 +1944,7 @@ static void mark_edges_uninteresting(struct commit_list *list)
 
 static void add_remote_info_ref(struct remote_ls_ctx *ls)
 {
-	struct buffer *buf = (struct buffer *)ls->userData;
+	struct strbuf *buf = (struct strbuf *)ls->userData;
 	unsigned char remote_sha1[20];
 	struct object *o;
 	int len;
@@ -2046,17 +1989,14 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 
 static void update_remote_info_refs(struct remote_lock *lock)
 {
-	struct buffer buffer;
+	struct buffer buffer = { 0, STRBUF_INIT };
 	struct active_request_slot *slot;
 	struct slot_results results;
 	char *if_header;
 	struct curl_slist *dav_headers = NULL;
 
-	buffer.buffer = xcalloc(1, 4096);
-	buffer.size = 4096;
-	buffer.posn = 0;
 	remote_ls("refs/", (PROCESS_FILES | RECURSIVE),
-		  add_remote_info_ref, &buffer);
+		  add_remote_info_ref, &buffer.buf);
 	if (!aborted) {
 		if_header = xmalloc(strlen(lock->token) + 25);
 		sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
@@ -2065,7 +2005,7 @@ static void update_remote_info_refs(struct remote_lock *lock)
 		slot = get_active_slot();
 		slot->results = &results;
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, &buffer);
-		curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, buffer.posn);
+		curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, buffer.buf.len);
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
 		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
 		curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
@@ -2074,8 +2014,6 @@ static void update_remote_info_refs(struct remote_lock *lock)
 		curl_easy_setopt(slot->curl, CURLOPT_PUT, 1);
 		curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
 
-		buffer.posn = 0;
-
 		if (start_active_slot(slot)) {
 			run_active_slot(slot);
 			if (results.curl_result != CURLE_OK) {
@@ -2086,7 +2024,7 @@ static void update_remote_info_refs(struct remote_lock *lock)
 		}
 		free(if_header);
 	}
-	free(buffer.buffer);
+	strbuf_release(&buffer.buf);
 }
 
 static int remote_exists(const char *path)
@@ -2097,12 +2035,12 @@ static int remote_exists(const char *path)
 
 	sprintf(url, "%s%s", remote->url, path);
 
-        slot = get_active_slot();
+	slot = get_active_slot();
 	slot->results = &results;
-        curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-        curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
 
-        if (start_active_slot(slot)) {
+	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.http_code == 404)
 			return 0;
@@ -2120,17 +2058,13 @@ static int remote_exists(const char *path)
 static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 {
 	char *url;
-	struct buffer buffer;
+	struct strbuf buffer = STRBUF_INIT;
 	struct active_request_slot *slot;
 	struct slot_results results;
 
 	url = xmalloc(strlen(remote->url) + strlen(path) + 1);
 	sprintf(url, "%s%s", remote->url, path);
 
-	buffer.size = 4096;
-	buffer.posn = 0;
-	buffer.buffer = xmalloc(buffer.size);
-
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
@@ -2153,17 +2087,17 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 	*symref = NULL;
 	hashclr(sha1);
 
-	if (buffer.posn == 0)
+	if (buffer.len == 0)
 		return;
 
 	/* If it's a symref, set the refname; otherwise try for a sha1 */
-	if (!prefixcmp((char *)buffer.buffer, "ref: ")) {
-		*symref = xmemdupz((char *)buffer.buffer + 5, buffer.posn - 6);
+	if (!prefixcmp((char *)buffer.buf, "ref: ")) {
+		*symref = xmemdupz((char *)buffer.buf + 5, buffer.len - 6);
 	} else {
-		get_sha1_hex(buffer.buffer, sha1);
+		get_sha1_hex(buffer.buf, sha1);
 	}
 
-	free(buffer.buffer);
+	strbuf_release(&buffer);
 }
 
 static int verify_merge_base(unsigned char *head_sha1, unsigned char *branch_sha1)
diff --git a/http-walker.c b/http-walker.c
index a3fb596..d925005 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -48,7 +48,7 @@ struct alternates_request {
 	struct walker *walker;
 	const char *base;
 	char *url;
-	struct buffer *buffer;
+	struct strbuf *buffer;
 	struct active_request_slot *slot;
 	int http_specific;
 };
@@ -475,7 +475,7 @@ static void process_alternates_response(void *callback_data)
 
 	if (alt_req->http_specific) {
 		if (slot->curl_result != CURLE_OK ||
-		    !alt_req->buffer->posn) {
+		    !alt_req->buffer->len) {
 
 			/* Try reusing the slot to get non-http alternates */
 			alt_req->http_specific = 0;
@@ -503,12 +503,12 @@ static void process_alternates_response(void *callback_data)
 	}
 
 	fwrite_buffer(&null_byte, 1, 1, alt_req->buffer);
-	alt_req->buffer->posn--;
-	data = alt_req->buffer->buffer;
+	alt_req->buffer->len--;
+	data = alt_req->buffer->buf;
 
-	while (i < alt_req->buffer->posn) {
+	while (i < alt_req->buffer->len) {
 		int posn = i;
-		while (posn < alt_req->buffer->posn && data[posn] != '\n')
+		while (posn < alt_req->buffer->len && data[posn] != '\n')
 			posn++;
 		if (data[posn] == '\n') {
 			int okay = 0;
@@ -596,9 +596,8 @@ static void process_alternates_response(void *callback_data)
 
 static void fetch_alternates(struct walker *walker, const char *base)
 {
-	struct buffer buffer;
+	struct strbuf buffer = STRBUF_INIT;
 	char *url;
-	char *data;
 	struct active_request_slot *slot;
 	struct alternates_request alt_req;
 	struct walker_data *cdata = walker->data;
@@ -619,11 +618,6 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	/* Start the fetch */
 	cdata->got_alternates = 0;
 
-	data = xmalloc(4096);
-	buffer.size = 4096;
-	buffer.posn = 0;
-	buffer.buffer = data;
-
 	if (walker->get_verbosely)
 		fprintf(stderr, "Getting alternates list for %s\n", base);
 
@@ -652,7 +646,7 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	else
 		cdata->got_alternates = -1;
 
-	free(data);
+	strbuf_release(&buffer);
 	free(url);
 }
 
@@ -660,7 +654,7 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 {
 	unsigned char sha1[20];
 	char *url;
-	struct buffer buffer;
+	struct strbuf buffer = STRBUF_INIT;
 	char *data;
 	int i = 0;
 
@@ -670,11 +664,6 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 	if (repo->got_indices)
 		return 0;
 
-	data = xmalloc(4096);
-	buffer.size = 4096;
-	buffer.posn = 0;
-	buffer.buffer = data;
-
 	if (walker->get_verbosely)
 		fprintf(stderr, "Getting pack list for %s\n", repo->base);
 
@@ -690,28 +679,27 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
+			strbuf_release(&buffer);
 			if (missing_target(&results)) {
 				repo->got_indices = 1;
-				free(buffer.buffer);
 				return 0;
 			} else {
 				repo->got_indices = 0;
-				free(buffer.buffer);
 				return error("%s", curl_errorstr);
 			}
 		}
 	} else {
 		repo->got_indices = 0;
-		free(buffer.buffer);
+		strbuf_release(&buffer);
 		return error("Unable to start request");
 	}
 
-	data = buffer.buffer;
-	while (i < buffer.posn) {
+	data = buffer.buf;
+	while (i < buffer.len) {
 		switch (data[i]) {
 		case 'P':
 			i++;
-			if (i + 52 <= buffer.posn &&
+			if (i + 52 <= buffer.len &&
 			    !prefixcmp(data + i, " pack-") &&
 			    !prefixcmp(data + i + 46, ".pack\n")) {
 				get_sha1_hex(data + i + 6, sha1);
@@ -720,13 +708,13 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 				break;
 			}
 		default:
-			while (i < buffer.posn && data[i] != '\n')
+			while (i < buffer.len && data[i] != '\n')
 				i++;
 		}
 		i++;
 	}
 
-	free(buffer.buffer);
+	strbuf_release(&buffer);
 	repo->got_indices = 1;
 	return 0;
 }
@@ -958,17 +946,12 @@ static char *quote_ref_url(const char *base, const char *ref)
 
 static int fetch_ref(struct walker *walker, char *ref, unsigned char *sha1)
 {
-        char *url;
-        char hex[42];
-        struct buffer buffer;
+	char *url;
+	struct strbuf buffer = STRBUF_INIT;
 	struct walker_data *data = walker->data;
 	const char *base = data->alt->base;
 	struct active_request_slot *slot;
 	struct slot_results results;
-        buffer.size = 41;
-        buffer.posn = 0;
-        buffer.buffer = hex;
-        hex[41] = '\0';
 
 	url = quote_ref_url(base, ref);
 	slot = get_active_slot();
@@ -986,9 +969,9 @@ static int fetch_ref(struct walker *walker, char *ref, unsigned char *sha1)
 		return error("Unable to start request");
 	}
 
-        hex[40] = '\0';
-        get_sha1_hex(hex, sha1);
-        return 0;
+	buffer.buf[40] = '\0';
+	get_sha1_hex(buffer.buf, sha1);
+	return 0;
 }
 
 static void cleanup(struct walker *walker)
diff --git a/http.c b/http.c
index 146f626..2d0b46d 100644
--- a/http.c
+++ b/http.c
@@ -34,31 +34,25 @@ size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb,
 			   struct buffer *buffer)
 {
 	size_t size = eltsize * nmemb;
-	if (size > buffer->size - buffer->posn)
-		size = buffer->size - buffer->posn;
-	memcpy(ptr, (char *) buffer->buffer + buffer->posn, size);
+	if (size > buffer->buf.len - buffer->posn)
+		size = buffer->buf.len - buffer->posn;
+	memcpy(ptr, (char *) buffer->buf.buf + buffer->posn, size);
 	buffer->posn += size;
+
 	return size;
 }
 
 size_t fwrite_buffer(const void *ptr, size_t eltsize,
-			    size_t nmemb, struct buffer *buffer)
+			    size_t nmemb, struct strbuf *buffer)
 {
 	size_t size = eltsize * nmemb;
-	if (size > buffer->size - buffer->posn) {
-		buffer->size = buffer->size * 3 / 2;
-		if (buffer->size < buffer->posn + size)
-			buffer->size = buffer->posn + size;
-		buffer->buffer = xrealloc(buffer->buffer, buffer->size);
-	}
-	memcpy((char *) buffer->buffer + buffer->posn, ptr, size);
-	buffer->posn += size;
+	strbuf_add(buffer, ptr, size);
 	data_received++;
 	return size;
 }
 
 size_t fwrite_null(const void *ptr, size_t eltsize,
-			  size_t nmemb, struct buffer *buffer)
+			  size_t nmemb, struct strbuf *buffer)
 {
 	data_received++;
 	return eltsize * nmemb;
@@ -508,8 +502,8 @@ void run_active_slot(struct active_request_slot *slot)
 
 static void closedown_active_slot(struct active_request_slot *slot)
 {
-        active_requests--;
-        slot->in_use = 0;
+	active_requests--;
+	slot->in_use = 0;
 }
 
 void release_active_slot(struct active_request_slot *slot)
@@ -530,7 +524,7 @@ void release_active_slot(struct active_request_slot *slot)
 static void finish_active_slot(struct active_request_slot *slot)
 {
 	closedown_active_slot(slot);
-        curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
+	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
 
 	if (slot->finished != NULL)
 		(*slot->finished) = 1;
@@ -541,10 +535,10 @@ static void finish_active_slot(struct active_request_slot *slot)
 		slot->results->http_code = slot->http_code;
 	}
 
-        /* Run callback if appropriate */
-        if (slot->callback_func != NULL) {
-                slot->callback_func(slot->callback_data);
-        }
+	/* Run callback if appropriate */
+	if (slot->callback_func != NULL) {
+		slot->callback_func(slot->callback_data);
+	}
 }
 
 void finish_all_active_slots(void)
diff --git a/http.h b/http.h
index fe1b0d1..bf3f12c 100644
--- a/http.h
+++ b/http.h
@@ -6,6 +6,8 @@
 #include <curl/curl.h>
 #include <curl/easy.h>
 
+#include "strbuf.h"
+
 #if LIBCURL_VERSION_NUM >= 0x071000
 #define USE_CURL_MULTI
 #define DEFAULT_MAX_REQUESTS 5
@@ -48,18 +50,17 @@ struct active_request_slot
 
 struct buffer
 {
-        size_t posn;
-        size_t size;
-        void *buffer;
+	struct strbuf buf;
+	size_t posn;
 };
 
 /* Curl request read/write callbacks */
 extern size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb,
 			   struct buffer *buffer);
 extern size_t fwrite_buffer(const void *ptr, size_t eltsize,
-			    size_t nmemb, struct buffer *buffer);
+			    size_t nmemb, struct strbuf *buffer);
 extern size_t fwrite_null(const void *ptr, size_t eltsize,
-			  size_t nmemb, struct buffer *buffer);
+			  size_t nmemb, struct strbuf *buffer);
 
 /* Slot lifecycle functions */
 extern struct active_request_slot *get_active_slot(void);
diff --git a/transport.c b/transport.c
index 58e66f6..22234e8 100644
--- a/transport.c
+++ b/transport.c
@@ -441,7 +441,7 @@ static int missing__target(int code, int result)
 
 static struct ref *get_refs_via_curl(struct transport *transport)
 {
-	struct buffer buffer;
+	struct strbuf buffer = STRBUF_INIT;
 	char *data, *start, *mid;
 	char *ref_name;
 	char *refs_url;
@@ -454,11 +454,6 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 	struct ref *ref = NULL;
 	struct ref *last_ref = NULL;
 
-	data = xmalloc(4096);
-	buffer.size = 4096;
-	buffer.posn = 0;
-	buffer.buffer = data;
-
 	refs_url = xmalloc(strlen(transport->url) + 11);
 	sprintf(refs_url, "%s/info/refs", transport->url);
 
@@ -477,27 +472,26 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
+			strbuf_release(&buffer);
 			if (missing_target(&results)) {
-				free(buffer.buffer);
 				return NULL;
 			} else {
-				free(buffer.buffer);
 				error("%s", curl_errorstr);
 				return NULL;
 			}
 		}
 	} else {
-		free(buffer.buffer);
+		strbuf_release(&buffer);
 		error("Unable to start request");
 		return NULL;
 	}
 
 	http_cleanup();
 
-	data = buffer.buffer;
+	data = buffer.buf;
 	start = NULL;
 	mid = data;
-	while (i < buffer.posn) {
+	while (i < buffer.len) {
 		if (!start)
 			start = &data[i];
 		if (data[i] == '\t')
@@ -520,7 +514,7 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 		i++;
 	}
 
-	free(buffer.buffer);
+	strbuf_release(&buffer);
 
 	return refs;
 }
-- 
1.5.3.7
