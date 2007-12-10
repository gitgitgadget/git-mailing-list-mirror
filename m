From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 6/5] Move fetch_ref from http-push.c and http-walker.c to http.c
Date: Tue, 11 Dec 2007 00:08:25 +0100
Message-ID: <1197328105-4843-1-git-send-email-mh@glandium.org>
References: <1197322571-25023-5-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 00:09:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1rkF-0007Go-Sb
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 00:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbXLJXIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 18:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbXLJXIm
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 18:08:42 -0500
Received: from vuizook.err.no ([85.19.215.103]:55002 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbXLJXIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 18:08:41 -0500
Received: from aputeaux-153-1-79-219.w81-249.abo.wanadoo.fr ([81.249.109.219] helo=namakemono.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1J1rkP-0004Ka-09; Tue, 11 Dec 2007 00:09:19 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1rjd-0001GW-GL; Tue, 11 Dec 2007 00:08:25 +0100
X-Mailer: git-send-email 1.5.3.7.1160.g1e7a-dirty
In-Reply-To: <1197322571-25023-5-git-send-email-mh@glandium.org>
X-Spam-Status: (score 5.2): Yes, score=5.2 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67769>

Make the necessary changes to be ok with their difference, and rename the
function http_fetch_ref.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-push.c   |   88 ++------------------------------------------------------
 http-walker.c |   80 +---------------------------------------------------
 http.c        |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 http.h        |    2 +
 4 files changed, 89 insertions(+), 163 deletions(-)

diff --git a/http-push.c b/http-push.c
index 610ed9c..a4a9d1c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1063,88 +1063,6 @@ static int fetch_indices(void)
 	return 0;
 }
 
-static inline int needs_quote(int ch)
-{
-	if (((ch >= 'A') && (ch <= 'Z'))
-			|| ((ch >= 'a') && (ch <= 'z'))
-			|| ((ch >= '0') && (ch <= '9'))
-			|| (ch == '/')
-			|| (ch == '-')
-			|| (ch == '.'))
-		return 0;
-	return 1;
-}
-
-static inline int hex(int v)
-{
-	if (v < 10) return '0' + v;
-	else return 'A' + v - 10;
-}
-
-static char *quote_ref_url(const char *base, const char *ref)
-{
-	const char *cp;
-	char *dp, *qref;
-	int len, baselen, ch;
-
-	baselen = strlen(base);
-	len = baselen + 1;
-	for (cp = ref; (ch = *cp) != 0; cp++, len++)
-		if (needs_quote(ch))
-			len += 2; /* extra two hex plus replacement % */
-	qref = xmalloc(len);
-	memcpy(qref, base, baselen);
-	for (cp = ref, dp = qref + baselen; (ch = *cp) != 0; cp++) {
-		if (needs_quote(ch)) {
-			*dp++ = '%';
-			*dp++ = hex((ch >> 4) & 0xF);
-			*dp++ = hex(ch & 0xF);
-		}
-		else
-			*dp++ = ch;
-	}
-	*dp = 0;
-
-	return qref;
-}
-
-int fetch_ref(char *ref, unsigned char *sha1)
-{
-	char *url;
-	struct strbuf buffer = STRBUF_INIT;
-	char *base = remote->url;
-	struct active_request_slot *slot;
-	struct slot_results results;
-	int ret;
-
-	url = quote_ref_url(base, ref);
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result == CURLE_OK) {
-			strbuf_rtrim(&buffer);
-			if (buffer.len == 40)
-				ret = get_sha1_hex(buffer.buf, sha1);
-			else
-				ret = 1;
-		} else {
-			ret = error("Couldn't get %s for %s\n%s",
-				    url, ref, curl_errorstr);
-		}
-	} else {
-		ret = error("Unable to start request");
-	}
-
-	strbuf_release(&buffer);
-	free(url);
-	return ret;
-}
-
 static void one_remote_object(const char *hex)
 {
 	unsigned char sha1[20];
@@ -1827,7 +1745,8 @@ static void one_remote_ref(char *refname)
 	struct object *obj;
 	int len = strlen(refname) + 1;
 
-	if (fetch_ref(refname, remote_sha1) != 0) {
+	if (http_fetch_ref(remote->url, refname + 5 /* "refs/" */,
+			   remote_sha1) != 0) {
 		fprintf(stderr,
 			"Unable to fetch ref %s from %s\n",
 			refname, remote->url);
@@ -1959,7 +1878,8 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 	int len;
 	char *ref_info;
 
-	if (fetch_ref(ls->dentry_name, remote_sha1) != 0) {
+	if (http_fetch_ref(remote->url, ls->dentry_name + 5 /* "refs/" */,
+			   remote_sha1) != 0) {
 		fprintf(stderr,
 			"Unable to fetch ref %s from %s\n",
 			ls->dentry_name, remote->url);
diff --git a/http-walker.c b/http-walker.c
index 4e878b3..2c37868 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -888,88 +888,10 @@ static int fetch(struct walker *walker, unsigned char *sha1)
 		     data->alt->base);
 }
 
-static inline int needs_quote(int ch)
-{
-	if (((ch >= 'A') && (ch <= 'Z'))
-			|| ((ch >= 'a') && (ch <= 'z'))
-			|| ((ch >= '0') && (ch <= '9'))
-			|| (ch == '/')
-			|| (ch == '-')
-			|| (ch == '.'))
-		return 0;
-	return 1;
-}
-
-static inline int hex(int v)
-{
-	if (v < 10) return '0' + v;
-	else return 'A' + v - 10;
-}
-
-static char *quote_ref_url(const char *base, const char *ref)
-{
-	const char *cp;
-	char *dp, *qref;
-	int len, baselen, ch;
-
-	baselen = strlen(base);
-	len = baselen + 7; /* "/refs/" + NUL */
-	for (cp = ref; (ch = *cp) != 0; cp++, len++)
-		if (needs_quote(ch))
-			len += 2; /* extra two hex plus replacement % */
-	qref = xmalloc(len);
-	memcpy(qref, base, baselen);
-	memcpy(qref + baselen, "/refs/", 6);
-	for (cp = ref, dp = qref + baselen + 6; (ch = *cp) != 0; cp++) {
-		if (needs_quote(ch)) {
-			*dp++ = '%';
-			*dp++ = hex((ch >> 4) & 0xF);
-			*dp++ = hex(ch & 0xF);
-		}
-		else
-			*dp++ = ch;
-	}
-	*dp = 0;
-
-	return qref;
-}
-
 static int fetch_ref(struct walker *walker, char *ref, unsigned char *sha1)
 {
-	char *url;
-	struct strbuf buffer = STRBUF_INIT;
 	struct walker_data *data = walker->data;
-	const char *base = data->alt->base;
-	struct active_request_slot *slot;
-	struct slot_results results;
-	int ret;
-
-	url = quote_ref_url(base, ref);
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result == CURLE_OK) {
-			strbuf_rtrim(&buffer);
-			if (buffer.len == 40)
-				ret = get_sha1_hex(buffer.buf, sha1);
-			else
-				ret = 1;
-		} else {
-			ret = error("Couldn't get %s for %s\n%s",
-				    url, ref, curl_errorstr);
-		}
-	} else {
-		ret = error("Unable to start request");
-	}
-
-	strbuf_release(&buffer);
-	free(url);
-	return ret;
+	return http_fetch_ref(data->alt->base, ref, sha1);
 }
 
 static void cleanup(struct walker *walker)
diff --git a/http.c b/http.c
index 784b93e..c6de964 100644
--- a/http.c
+++ b/http.c
@@ -552,3 +552,85 @@ void finish_all_active_slots(void)
 			slot = slot->next;
 		}
 }
+
+static inline int needs_quote(int ch)
+{
+	if (((ch >= 'A') && (ch <= 'Z'))
+			|| ((ch >= 'a') && (ch <= 'z'))
+			|| ((ch >= '0') && (ch <= '9'))
+			|| (ch == '/')
+			|| (ch == '-')
+			|| (ch == '.'))
+		return 0;
+	return 1;
+}
+
+static inline int hex(int v)
+{
+	if (v < 10) return '0' + v;
+	else return 'A' + v - 10;
+}
+
+static char *quote_ref_url(const char *base, const char *ref)
+{
+	const char *cp;
+	char *dp, *qref;
+	int len, baselen, ch;
+
+	baselen = strlen(base);
+	len = baselen + 7; /* "/refs/" + NUL */
+	for (cp = ref; (ch = *cp) != 0; cp++, len++)
+		if (needs_quote(ch))
+			len += 2; /* extra two hex plus replacement % */
+	qref = xmalloc(len);
+	memcpy(qref, base, baselen);
+	memcpy(qref + baselen, "/refs/", 6);
+	for (cp = ref, dp = qref + baselen + 6; (ch = *cp) != 0; cp++) {
+		if (needs_quote(ch)) {
+			*dp++ = '%';
+			*dp++ = hex((ch >> 4) & 0xF);
+			*dp++ = hex(ch & 0xF);
+		}
+		else
+			*dp++ = ch;
+	}
+	*dp = 0;
+
+	return qref;
+}
+
+int http_fetch_ref(const char *base, const char *ref, unsigned char *sha1)
+{
+	char *url;
+	struct strbuf buffer = STRBUF_INIT;
+	struct active_request_slot *slot;
+	struct slot_results results;
+	int ret;
+
+	url = quote_ref_url(base, ref);
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result == CURLE_OK) {
+			strbuf_rtrim(&buffer);
+			if (buffer.len == 40)
+				ret = get_sha1_hex(buffer.buf, sha1);
+			else
+				ret = 1;
+		} else {
+			ret = error("Couldn't get %s for %s\n%s",
+				    url, ref, curl_errorstr);
+		}
+	} else {
+		ret = error("Unable to start request");
+	}
+
+	strbuf_release(&buffer);
+	free(url);
+	return ret;
+}
diff --git a/http.h b/http.h
index 87d638b..b709222 100644
--- a/http.h
+++ b/http.h
@@ -96,4 +96,6 @@ static inline int missing__target(int code, int result)
 
 #define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
 
+extern int http_fetch_ref(const char *base, const char *ref, unsigned char *sha1);
+
 #endif /* HTTP_H */
-- 
1.5.3.7.1160.g1e7a-dirty
