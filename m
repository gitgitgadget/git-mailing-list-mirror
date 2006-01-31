From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Fix HTTP request result processing after slot reuse
Date: Tue, 31 Jan 2006 11:06:55 -0800
Message-ID: <20060131190655.GE3873@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 31 20:09:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F40qC-00075T-GT
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 20:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWAaTG5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 14:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWAaTG5
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 14:06:57 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:43744 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751357AbWAaTG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 14:06:56 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k0VJ6uc7002031
	for <git@vger.kernel.org>; Tue, 31 Jan 2006 11:06:56 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k0VJ6uiu002028
	for git@vger.kernel.org; Tue, 31 Jan 2006 11:06:56 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15334>

Add a way to store the results of an HTTP request when a slot finishes
so the results can be processed after the slot has been reused.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |   20 ++++++++++++++------
 http.c       |    9 ++++++++-
 http.h       |    7 +++++++
 3 files changed, 29 insertions(+), 7 deletions(-)

ecda781d5eec60edc3683a4e7408c99eb93b463c
diff --git a/http-fetch.c b/http-fetch.c
index 61b2188..92326f9 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -375,6 +375,7 @@ static int fetch_index(struct alt_base *
 
 	FILE *indexfile;
 	struct active_request_slot *slot;
+	static struct slot_results results;
 
 	if (has_pack_index(sha1))
 		return 0;
@@ -393,6 +394,7 @@ static int fetch_index(struct alt_base *
 			     filename);
 
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
@@ -414,7 +416,7 @@ static int fetch_index(struct alt_base *
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result != CURLE_OK) {
+		if (results.curl_result != CURLE_OK) {
 			fclose(indexfile);
 			return error("Unable to get pack index %s\n%s", url,
 				     curl_errorstr);
@@ -616,6 +618,7 @@ static int fetch_indices(struct alt_base
 	int i = 0;
 
 	struct active_request_slot *slot;
+	static struct slot_results results;
 
 	if (repo->got_indices)
 		return 0;
@@ -632,15 +635,16 @@ static int fetch_indices(struct alt_base
 	sprintf(url, "%s/objects/info/packs", repo->base);
 
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result != CURLE_OK) {
-			if (slot->http_code == 404 ||
-			    slot->curl_result == CURLE_FILE_COULDNT_READ_FILE) {
+		if (results.curl_result != CURLE_OK) {
+			if (results.http_code == 404 ||
+			    results.curl_result == CURLE_FILE_COULDNT_READ_FILE) {
 				repo->got_indices = 1;
 				free(buffer.buffer);
 				return 0;
@@ -695,6 +699,7 @@ static int fetch_pack(struct alt_base *r
 	struct curl_slist *range_header = NULL;
 
 	struct active_request_slot *slot;
+	static struct slot_results results;
 
 	if (fetch_indices(repo))
 		return -1;
@@ -721,6 +726,7 @@ static int fetch_pack(struct alt_base *r
 			     filename);
 
 	slot = get_active_slot();
+	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, packfile);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
@@ -742,7 +748,7 @@ static int fetch_pack(struct alt_base *r
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result != CURLE_OK) {
+		if (results.curl_result != CURLE_OK) {
 			fclose(packfile);
 			return error("Unable to get pack file %s\n%s", url,
 				     curl_errorstr);
@@ -894,6 +900,7 @@ int fetch_ref(char *ref, unsigned char *
         struct buffer buffer;
 	char *base = alt->base;
 	struct active_request_slot *slot;
+	static struct slot_results results;
         buffer.size = 41;
         buffer.posn = 0;
         buffer.buffer = hex;
@@ -901,13 +908,14 @@ int fetch_ref(char *ref, unsigned char *
         
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
diff --git a/http.c b/http.c
index 75e6717..eefb0f0 100644
--- a/http.c
+++ b/http.c
@@ -335,6 +335,7 @@ struct active_request_slot *get_active_s
 	active_requests++;
 	slot->in_use = 1;
 	slot->local = NULL;
+	slot->results = NULL;
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
@@ -421,7 +422,13 @@ static void finish_active_slot(struct ac
         active_requests--;
         slot->in_use = 0;
         curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
- 
+
+	/* Store slot results so they can be read after the slot is reused */
+	if (slot->results != NULL) {
+		slot->results->curl_result = slot->curl_result;
+		slot->results->http_code = slot->http_code;
+	}
+
         /* Run callback if appropriate */
         if (slot->callback_func != NULL) {
                 slot->callback_func(slot->callback_data);
diff --git a/http.h b/http.h
index ed4ea33..d6dc9d8 100644
--- a/http.h
+++ b/http.h
@@ -22,6 +22,12 @@
 #define NO_CURL_EASY_DUPHANDLE
 #endif
 
+struct slot_results
+{
+	CURLcode curl_result;
+	long http_code;
+};
+
 struct active_request_slot
 {
 	CURL *curl;
@@ -29,6 +35,7 @@ struct active_request_slot
 	int in_use;
 	CURLcode curl_result;
 	long http_code;
+	struct slot_results *results;
 	void *callback_data;
 	void (*callback_func)(void *data);
 	struct active_request_slot *next;
-- 
1.1.6.g1a5c3-dirty
