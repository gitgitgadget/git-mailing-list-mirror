From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 15/23] http.c: new functions for the http API
Date: Sat, 6 Jun 2009 00:05:50 +0800
Message-ID: <20090606000550.17d48ace.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzI-00053w-V2
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755675AbZFEQJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755630AbZFEQJF
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:09:05 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:43072 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590AbZFEQJD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:09:03 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so944213pzk.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=TzQnpvNu1w+/rmP2MOtLCahWDs/t+01C//jjHOAWNiA=;
        b=EFYnDDgMZehs7YsHQfZcg1Zim36Ky7vQtI/kO8WbSdSCSWHk7FyjHaRkECWRgNF2yV
         DdzzcRHDnrQbsi8XYst4mVM0wXXl9Fp7YIAHmsFr3AuQBxjR2Wqs5Hl2+pG0WbC9ngZt
         gOfyXij5RnK2hdzYG4osj21JC9gcScp4U1lwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=K7mSmEwlJMlar9RmEHkGI7T40kHGeisR/3NS+6IF3XXYNUqXJxPdBtgvD/QGorvIIh
         W0SEgSd3O0ENmrTl35D25xZd6SszPTZWehqgntsRrMnTHSucrtmtetyopypkU2RGbjKL
         N5bkGZF2GzXLeXl05+UGZxi6x0t0OlVZcZPVI=
Received: by 10.142.88.4 with SMTP id l4mr1325451wfb.136.1244218146305;
        Fri, 05 Jun 2009 09:09:06 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 20sm435054wfi.20.2009.06.05.09.09.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:09:06 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120795>

From:	Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 03/12] Two new functions for the http API
Date:	Sun, 18 Jan 2009 09:04:28 +0100

http_get_strbuf and http_get_file allow respectively to retrieve contents of
an URL to a strbuf or an opened file handle.

http_error prints out an error message containing the URL and the curl error
(in curl_errorstr).

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

I've added an additional slot->local = NULL when cleaning up in
http_request().

 http.c |  104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 http.h |   30 ++++++++++++++++++
 2 files changed, 134 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 75fce9e..df22180 100644
--- a/http.c
+++ b/http.c
@@ -665,6 +665,110 @@ static char *quote_ref_url(const char *base, const char *ref)
 	return strbuf_detach(&buf, NULL);
 }

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
+	int ret;
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
+
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
+
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result == CURLE_OK)
+			ret = HTTP_OK;
+		else if (missing_target(&results))
+			ret = HTTP_MISSING_TARGET;
+		else
+			ret = HTTP_ERROR;
+	} else {
+		error("Unable to start HTTP request for %s", url);
+		ret = HTTP_START_FAILED;
+	}
+
+	slot->local = NULL;
+	curl_slist_free_all(headers);
+	strbuf_release(&buf);
+
+	return ret;
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
+
+int http_error(const char *url, int ret)
+{
+	/* http_request has already handled HTTP_START_FAILED. */
+	if (ret != HTTP_START_FAILED)
+		error("%s while accessing %s\n", curl_errorstr, url);
+
+	return ret;
+}
+
 int http_fetch_ref(const char *base, struct ref *ref)
 {
 	char *url;
diff --git a/http.h b/http.h
index 1ef7dc1..3d878d5 100644
--- a/http.h
+++ b/http.h
@@ -114,6 +114,36 @@ static inline int missing__target(int code, int result)

 #define missing_target(a) missing__target((a)->http_code, (a)->curl_result)

+/* Options for http_request_*() */
+#define HTTP_NO_CACHE		1
+
+/* Return values for http_request_*() */
+#define HTTP_OK			0
+#define HTTP_MISSING_TARGET	1
+#define HTTP_ERROR		2
+#define HTTP_START_FAILED	3
+
+/*
+ * Requests an url and stores the result in a strbuf.
+ *
+ * If the result pointer is NULL, a HTTP HEAD request is made instead of GET.
+ */
+int http_get_strbuf(const char *url, struct strbuf *result, int options);
+
+/*
+ * Downloads an url and stores the result in the given file.
+ *
+ * If a previous interrupted download is detected (i.e. a previous temporary
+ * file is still around) the download is resumed.
+ */
+int http_get_file(const char *url, const char *filename, int options);
+
+/*
+ * Prints an error message using error() containing url and curl_errorstr,
+ * and returns ret.
+ */
+int http_error(const char *url, int ret);
+
 extern int http_fetch_ref(const char *base, struct ref *ref);

 #endif /* HTTP_H */
--
1.6.3.1
