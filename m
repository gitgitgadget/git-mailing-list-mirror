From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 03/12] Two new functions for the http API
Date: Sun, 18 Jan 2009 09:04:28 +0100
Message-ID: <1232265877-3649-4-git-send-email-mh@glandium.org>
References: <20090118074911.GB30228@glandium.org>
 <1232265877-3649-1-git-send-email-mh@glandium.org>
 <1232265877-3649-2-git-send-email-mh@glandium.org>
 <1232265877-3649-3-git-send-email-mh@glandium.org>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:06:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSfn-0001kf-Gp
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761006AbZARIE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760151AbZARIEw
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:04:52 -0500
Received: from vuizook.err.no ([85.19.221.46]:42448 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757908AbZARIEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:45 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSe6-0002ET-4J; Sun, 18 Jan 2009 09:04:43 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000yH-Bo; Sun, 18 Jan 2009 09:04:37 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <1232265877-3649-3-git-send-email-mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106151>

http_get_strbuf and http_get_file allow respectively to retrieve contents of
an URL to a strbuf or an opened file handle.

Both these functions are the beginning of the http code refactoring.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 http.h |   17 +++++++++++++
 2 files changed, 102 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index ee58799..82534cf 100644
--- a/http.c
+++ b/http.c
@@ -638,3 +638,88 @@ int http_fetch_ref(const char *base, struct ref *ref)
 	free(url);
 	return ret;
 }
+
+/* http_request() targets */
+#define HTTP_REQUEST_STRBUF	0
+#define HTTP_REQUEST_FILE	1
+
+static int http_request(const char *url, void *result, int target, int options)
+{
+	struct active_request_slot *slot;
+	struct slot_results results;
+	struct curl_slist *headers = NULL;
+	struct strbuf buf = STRBUF_INIT;
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+
+	if (result == NULL) {
+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
+	} else {
+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+		curl_easy_setopt(slot->curl, CURLOPT_FILE, result);
+
+		if (target == HTTP_REQUEST_FILE) {
+			long posn = ftell(result);
+			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
+					 fwrite);
+			if (posn > 0) {
+				strbuf_addf(&buf, "Range: bytes=%ld-", posn);
+				headers = curl_slist_append(headers, buf.buf);
+				strbuf_reset(&buf);
+			}
+			slot->local = result;
+		} else
+			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
+					 fwrite_buffer);
+	}
+
+	strbuf_addstr(&buf, "Pragma:");
+	if (options & HTTP_NO_CACHE)
+		strbuf_addstr(&buf, " no-cache");
+
+	headers = curl_slist_append(headers, buf.buf);
+	strbuf_release(&buf);
+
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
+
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result == CURLE_OK)
+			return HTTP_OK;
+		else if (missing_target(&results))
+			return HTTP_MISSING_TARGET;
+	}
+	return HTTP_ERROR;
+}
+
+int http_get_strbuf(const char *url, struct strbuf *result, int options)
+{
+	return http_request(url, result, HTTP_REQUEST_STRBUF, options);
+}
+
+int http_get_file(const char *url, const char *filename, int options)
+{
+	int ret;
+	struct strbuf tmpfile = STRBUF_INIT;
+	FILE *result;
+
+	strbuf_addf(&tmpfile, "%s.temp", filename);
+	result = fopen(tmpfile.buf, "a");
+	if (! result) {
+		error("Unable to open local file %s", tmpfile.buf);
+		ret = HTTP_ERROR;
+		goto cleanup;
+	}
+
+	ret = http_request(url, result, HTTP_REQUEST_FILE, options);
+	fclose(result);
+
+	if ((ret == HTTP_OK) && move_temp_to_file(tmpfile.buf, filename))
+		ret = HTTP_ERROR;
+cleanup:
+	strbuf_release(&tmpfile);
+	return ret;
+}
diff --git a/http.h b/http.h
index 905b462..323c780 100644
--- a/http.h
+++ b/http.h
@@ -104,4 +104,21 @@ static inline int missing__target(int code, int result)
 
 extern int http_fetch_ref(const char *base, struct ref *ref);
 
+/* Options for http_request_*() */
+#define HTTP_NO_CACHE		1
+
+/* Return values for http_request_*() */
+#define HTTP_OK			0
+#define HTTP_MISSING_TARGET	1
+#define HTTP_ERROR		2
+
+/* Requests an url and stores the result in a strbuf.
+ * If the result pointer is NULL, a HTTP HEAD request is made instead of GET. */
+int http_get_strbuf(const char *url, struct strbuf *result, int options);
+
+/* Downloads an url and stores the result in the given file.
+ * If a previous interrupted download is detected (i.e. a previous temporary
+ * file is still around) the download is resumed. */
+int http_get_file(const char *url, const char *filename, int options);
+
 #endif /* HTTP_H */
-- 
1.6.1.141.gb32a
