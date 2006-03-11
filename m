From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 2/6] HTTP slot reuse fixes
Date: Fri, 10 Mar 2006 20:18:01 -0800
Message-ID: <20060311041801.GD3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 11 05:18:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHvYO-0004ss-UQ
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 05:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWCKESE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 23:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWCKESE
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 23:18:04 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:58574 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932392AbWCKESB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 23:18:01 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2B4I1Dm007640
	for <git@vger.kernel.org>; Fri, 10 Mar 2006 20:18:01 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2B4I1JJ007638
	for git@vger.kernel.org; Fri, 10 Mar 2006 20:18:01 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17487>

Incorporate into http-push a fix related to accessing slot results after
the slot was reused, and fix a case in run_active_slot where a
finished slot wasn't detected if the slot was reused.

---

 http-push.c |   56 +++++++++++++++++++++++++++++++++++++++-----------------
 http.c      |    8 +++++++-
 http.h      |    1 +
 3 files changed, 47 insertions(+), 18 deletions(-)

097851a0a1d713a9b69eb700b37809734af0c31e
diff --git a/http-push.c b/http-push.c
index 4c1b0c3..1b0b3a8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -302,6 +302,7 @@ static void start_move(struct transfer_r
 static int refresh_lock(struct remote_lock *check_lock)
 {
 	struct active_request_slot *slot;
+	struct slot_results results;
 	char *if_header;
 	char timeout_header[25];
 	struct curl_slist *dav_headers = NULL;
@@ -329,6 +330,7 @@ static int refresh_lock(struct remote_lo
 		dav_headers = curl_slist_append(dav_headers, timeout_header);
 
 		slot = get_active_slot();
+		slot->results = &results;
 		curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
 		curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
@@ -337,8 +339,8 @@ static int refresh_lock(struct remote_lo
 
 		if (start_active_slot(slot)) {
 			run_active_slot(slot);
-			if (slot->curl_result != CURLE_OK) {
-				fprintf(stderr, "Got HTTP error %ld\n", slot->http_code);
+			if (results.curl_result != CURLE_OK) {
+				fprintf(stderr, "Got HTTP error %ld\n", results.http_code);
 				lock->active = 0;
 			} else {
 				lock->active = 1;
@@ -509,16 +511,18 @@ static int fetch_index(unsigned char *sh
 
 	FILE *indexfile;
 	struct active_request_slot *slot;
+	struct slot_results results;
 
 	/* Don't use the index if the pack isn't there */
 	url = xmalloc(strlen(remote->url) + 65);
 	sprintf(url, "%s/objects/pack/pack-%s.pack", remote->url, hex);
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result != CURLE_OK) {
+		if (results.curl_result != CURLE_OK) {
 			free(url);
 			return error("Unable to verify pack %s is available",
 				     hex);
@@ -543,6 +547,7 @@ static int fetch_index(unsigned char *sh
 			     filename);
 
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
@@ -566,7 +571,7 @@ static int fetch_index(unsigned char *sh
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result != CURLE_OK) {
+		if (results.curl_result != CURLE_OK) {
 			free(url);
 			fclose(indexfile);
 			return error("Unable to get pack index %s\n%s", url,
@@ -606,6 +611,7 @@ static int fetch_indices(void)
 	int i = 0;
 
 	struct active_request_slot *slot;
+	struct slot_results results;
 
 	data = xmalloc(4096);
 	memset(data, 0, 4096);
@@ -620,16 +626,17 @@ static int fetch_indices(void)
 	sprintf(url, "%s/objects/info/packs", remote->url);
 
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result != CURLE_OK) {
+		if (results.curl_result != CURLE_OK) {
 			free(buffer.buffer);
 			free(url);
-			if (slot->http_code == 404)
+			if (results.http_code == 404)
 				return 0;
 			else
 				return error("%s", curl_errorstr);
@@ -716,6 +723,7 @@ int fetch_ref(char *ref, unsigned char *
         struct buffer buffer;
 	char *base = remote->url;
 	struct active_request_slot *slot;
+	struct slot_results results;
         buffer.size = 41;
         buffer.posn = 0;
         buffer.buffer = hex;
@@ -723,13 +731,14 @@ int fetch_ref(char *ref, unsigned char *
         
 	url = quote_ref_url(base, ref);
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result != CURLE_OK)
+		if (results.curl_result != CURLE_OK)
 			return error("Couldn't get %s for %s\n%s",
 				     url, ref, curl_errorstr);
 	} else {
@@ -913,6 +922,7 @@ xml_cdata(void *userData, const XML_Char
 static struct remote_lock *lock_remote(char *path, long timeout)
 {
 	struct active_request_slot *slot;
+	struct slot_results results;
 	struct buffer out_buffer;
 	struct buffer in_buffer;
 	char *out_data;
@@ -946,14 +956,15 @@ static struct remote_lock *lock_remote(c
 	while (ep) {
 		*ep = 0;
 		slot = get_active_slot();
+		slot->results = &results;
 		curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 		curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 		curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_MKCOL);
 		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
 		if (start_active_slot(slot)) {
 			run_active_slot(slot);
-			if (slot->curl_result != CURLE_OK &&
-			    slot->http_code != 405) {
+			if (results.curl_result != CURLE_OK &&
+			    results.http_code != 405) {
 				fprintf(stderr,
 					"Unable to create branch path %s\n",
 					url);
@@ -985,6 +996,7 @@ static struct remote_lock *lock_remote(c
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
 
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
@@ -1003,7 +1015,7 @@ static struct remote_lock *lock_remote(c
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result == CURLE_OK) {
+		if (results.curl_result == CURLE_OK) {
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
 			ctx.cdata = NULL;
@@ -1053,6 +1065,7 @@ static struct remote_lock *lock_remote(c
 static int unlock_remote(struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
+	struct slot_results results;
 	char *lock_token_header;
 	struct curl_slist *dav_headers = NULL;
 	int rc = 0;
@@ -1063,6 +1076,7 @@ static int unlock_remote(struct remote_l
 	dav_headers = curl_slist_append(dav_headers, lock_token_header);
 
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_UNLOCK);
@@ -1070,11 +1084,11 @@ static int unlock_remote(struct remote_l
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result == CURLE_OK)
+		if (results.curl_result == CURLE_OK)
 			rc = 1;
 		else
 			fprintf(stderr, "Got HTTP error %ld\n",
-				slot->http_code);
+				results.http_code);
 	} else {
 		fprintf(stderr, "Unable to start request\n");
 	}
@@ -1091,6 +1105,7 @@ static void crawl_remote_refs(char *path
 {
 	char *url;
 	struct active_request_slot *slot;
+	struct slot_results results;
 	struct buffer in_buffer;
 	struct buffer out_buffer;
 	char *in_data;
@@ -1125,6 +1140,7 @@ static void crawl_remote_refs(char *path
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
 
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
@@ -1137,7 +1153,7 @@ static void crawl_remote_refs(char *path
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result == CURLE_OK) {
+		if (results.curl_result == CURLE_OK) {
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
 			ctx.cdata = NULL;
@@ -1171,6 +1187,7 @@ static void get_remote_object_list(unsig
 {
 	char *url;
 	struct active_request_slot *slot;
+	struct slot_results results;
 	struct buffer in_buffer;
 	struct buffer out_buffer;
 	char *in_data;
@@ -1203,6 +1220,7 @@ static void get_remote_object_list(unsig
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
 
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
@@ -1215,7 +1233,7 @@ static void get_remote_object_list(unsig
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result == CURLE_OK) {
+		if (results.curl_result == CURLE_OK) {
 			remote_dir_exists[parent] = 1;
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
@@ -1250,6 +1268,7 @@ static void get_remote_object_list(unsig
 static int locking_available(void)
 {
 	struct active_request_slot *slot;
+	struct slot_results results;
 	struct buffer in_buffer;
 	struct buffer out_buffer;
 	char *in_data;
@@ -1278,6 +1297,7 @@ static int locking_available(void)
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
 	
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
@@ -1290,7 +1310,7 @@ static int locking_available(void)
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result == CURLE_OK) {
+		if (results.curl_result == CURLE_OK) {
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
 			ctx.cdata = NULL;
@@ -1416,6 +1436,7 @@ static void get_delta(struct rev_info *r
 static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
+	struct slot_results results;
 	char *out_data;
 	char *if_header;
 	struct buffer out_buffer;
@@ -1437,6 +1458,7 @@ static int update_remote(unsigned char *
 	out_buffer.buffer = out_data;
 
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
@@ -1451,10 +1473,10 @@ static int update_remote(unsigned char *
 		run_active_slot(slot);
 		free(out_data);
 		free(if_header);
-		if (slot->curl_result != CURLE_OK) {
+		if (results.curl_result != CURLE_OK) {
 			fprintf(stderr,
 				"PUT error: curl result=%d, HTTP code=%ld\n",
-				slot->curl_result, slot->http_code);
+				results.curl_result, results.http_code);
 			/* We should attempt recovery? */
 			return 0;
 		}
diff --git a/http.c b/http.c
index 14a7669..9604e33 100644
--- a/http.c
+++ b/http.c
@@ -339,6 +339,7 @@ struct active_request_slot *get_active_s
 	slot->in_use = 1;
 	slot->local = NULL;
 	slot->results = NULL;
+	slot->finished = NULL;
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
@@ -389,8 +390,10 @@ void run_active_slot(struct active_reque
 	fd_set excfds;
 	int max_fd;
 	struct timeval select_timeout;
+	int finished = 0;
 
-	while (slot->in_use) {
+	slot->finished = &finished;
+	while (!finished) {
 		data_received = 0;
 		step_active_slots();
 
@@ -442,6 +445,9 @@ static void finish_active_slot(struct ac
 	closedown_active_slot(slot);
         curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
 
+	if (slot->finished != NULL)
+		(*slot->finished) = 1;
+
 	/* Store slot results so they can be read after the slot is reused */
 	if (slot->results != NULL) {
 		slot->results->curl_result = slot->curl_result;
diff --git a/http.h b/http.h
index 36fa154..9ca16ac 100644
--- a/http.h
+++ b/http.h
@@ -35,6 +35,7 @@ struct active_request_slot
 	int in_use;
 	CURLcode curl_result;
 	long http_code;
+	int *finished;
 	struct slot_results *results;
 	void *callback_data;
 	void (*callback_func)(void *data);
-- 
1.2.4.g8e81-dirty
