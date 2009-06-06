From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 15/23] http.c: new functions for the http API
Date: Sat, 6 Jun 2009 16:43:53 +0800
Message-ID: <20090606164353.967cce80.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrcH-0004Mp-Ol
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbZFFIuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbZFFIuO
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:50:14 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:29467 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbZFFIuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:50:11 -0400
Received: by wf-out-1314.google.com with SMTP id 26so882289wfd.4
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=3QqcjJ3ghQg6vh+/+1Q/5zMl+P7TprxFIx0+IQuMFHc=;
        b=D/MCEgFOjhmIr9nlUBZJqSAhQGRX8zx0BoWcC5Afs5ON4DWDbdX1fQrlzR1uLnjp+i
         v42YelZMdbMdVbkrsqHnCQiVLLkPRcOHAHKCxCIwc2Pc6nKGhfdNgkO9uZNYL5HZ7fBc
         H5jr4KbijOQKQmbmlbXEcJclxSDhSv1SWZCe4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=lWV/9BQwBDqhoSYMbzTGDpTCs0PBhAow7z/3xBg2S8xR5fCnLZRWPQt6wElta8vo2S
         YZch5OI5JOJZIMpsMulGmgSgX6PtCEetuKg4zIfqGXnB1c16WDHZSIUb3Xbs85YApN8v
         ebENcwpVGlSeSh/zGOmZo/ADEJoMC7P6QeRwk=
Received: by 10.143.163.12 with SMTP id q12mr1642430wfo.13.1244278212832;
        Sat, 06 Jun 2009 01:50:12 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 32sm2790115wfa.33.2009.06.06.01.50.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:50:12 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120896>

From:	Mike Hommey <mh@glandium.org>

The new functions added are:
 - http_request() (internal function)
 - http_get_strbuf()
 - http_get_file()
 - http_error()

http_get_strbuf and http_get_file allow respectively to retrieve contents of
an URL to a strbuf or an opened file handle.

http_error prints out an error message containing the URL and the curl error
(in curl_errorstr).

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

This patch is based on Mike's earlier patch:

Subject: [WIP Patch 03/12] Two new functions for the http API
Date:	Sun, 18 Jan 2009 09:04:28 +0100

I've added a new return status code for http_request,
HTTP_START_FAILED, since some callers need to know when
start_active_slot() fails.

http_request() will emit an error message when start_active_slot()
fails; for other cases, no error message is emitted.

I've added http_error(). (see description above)

I've added the list of new functions to the commit message body, as
suggested by Jakub.

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
