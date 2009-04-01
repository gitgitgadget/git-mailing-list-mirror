From: =?iso-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: [PATCH] Allow curl to rewind the read buffers
Date: Wed, 1 Apr 2009 19:48:24 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0904011946510.5901@localhost.localdomain>
References: <Pine.LNX.4.64.0904011809080.5901@localhost.localdomain>
 <7vbprg1h3m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 18:50:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp3da-0006hL-EH
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 18:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762485AbZDAQs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 12:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759235AbZDAQs2
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 12:48:28 -0400
Received: from smtp2.abo.fi ([130.232.213.77]:60231 "EHLO smtp2.abo.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757991AbZDAQs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 12:48:27 -0400
Received: from albin.abo.fi (albin.abo.fi [130.232.81.192])
	by smtp2.abo.fi (8.14.3/8.12.9) with ESMTP id n31GmOFw002550
	for <git@vger.kernel.org>; Wed, 1 Apr 2009 19:48:24 +0300
X-X-Sender: mstorsjo@localhost.localdomain
In-Reply-To: <7vbprg1h3m.fsf@gitster.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (smtp2.abo.fi [130.232.213.77]); Wed, 01 Apr 2009 19:48:24 +0300 (EEST)
X-Virus-Scanned: by foxy.abo.fi (foxy.abo.fi: Wed Apr  1 19:48:24 2009)
X-Scanned-By: MIMEDefang 2.64 on 130.232.213.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115403>

When using multi-pass authentication methods, the curl library may
need to rewind the read buffers (depending on how much already has
been fed to the server) used for providing data to HTTP PUT, POST or
PROPFIND, and in order to allow the library to do so, we need to tell
it how by providing either an ioctl callback or a seek callback.

This patch adds an ioctl callback, which should be usable on older
curl versions (since 7.12.3) than the seek callback (introduced in
curl 7.18.0).

Some HTTP servers (such as Apache) give an 401 error reply immediately
after receiving the headers (so no data has been read from the read
buffers, and thus no rewinding is needed), but other servers (such
as Lighttpd) only replies after the whole request has been sent and
all data has been read from the read buffers, making rewinding necessary.

Signed-off-by: Martin Storsjo <martin@martin.st>
---

Updated comment to better describe the potential need for this.

 http-push.c |   24 ++++++++++++++++++++++++
 http.c      |   19 +++++++++++++++++++
 http.h      |    7 +++++++
 3 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index 6ce5a1d..7dc0dd4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -567,6 +567,10 @@ static void start_put(struct transfer_request *request)
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &request->buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, request->buffer.buf.len);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
+#ifndef NO_CURL_IOCTL
+	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &request->buffer);
+#endif
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
@@ -1267,6 +1271,10 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
+#ifndef NO_CURL_IOCTL
+	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &out_buffer);
+#endif
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
@@ -1508,6 +1516,10 @@ static void remote_ls(const char *path, int flags,
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
+#ifndef NO_CURL_IOCTL
+	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &out_buffer);
+#endif
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
@@ -1584,6 +1596,10 @@ static int locking_available(void)
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
+#ifndef NO_CURL_IOCTL
+	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &out_buffer);
+#endif
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, repo->url);
@@ -1766,6 +1782,10 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
+#ifndef NO_CURL_IOCTL
+	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &out_buffer);
+#endif
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
@@ -1910,6 +1930,10 @@ static void update_remote_info_refs(struct remote_lock *lock)
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, &buffer);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, buffer.buf.len);
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
+#ifndef NO_CURL_IOCTL
+		curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
+		curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &buffer);
+#endif
 		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
 		curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
 		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
diff --git a/http.c b/http.c
index eae74aa..3e8d548 100644
--- a/http.c
+++ b/http.c
@@ -44,6 +44,25 @@ size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return size;
 }
 
+#ifndef NO_CURL_IOCTL
+curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
+{
+	struct buffer *buffer = clientp;
+
+	switch (cmd) {
+	case CURLIOCMD_NOP:
+		return CURLIOE_OK;
+
+	case CURLIOCMD_RESTARTREAD:
+		buffer->posn = 0;
+		return CURLIOE_OK;
+
+	default:
+		return CURLIOE_UNKNOWNCMD;
+	}
+}
+#endif
+
 size_t fwrite_buffer(const void *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
diff --git a/http.h b/http.h
index 905b462..26abebe 100644
--- a/http.h
+++ b/http.h
@@ -37,6 +37,10 @@
 #define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
 #endif
 
+#if LIBCURL_VERSION_NUM < 0x070c03
+#define NO_CURL_IOCTL
+#endif
+
 struct slot_results
 {
 	CURLcode curl_result;
@@ -67,6 +71,9 @@ struct buffer
 extern size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 extern size_t fwrite_buffer(const void *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 extern size_t fwrite_null(const void *ptr, size_t eltsize, size_t nmemb, void *strbuf);
+#ifndef NO_CURL_IOCTL
+extern curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
+#endif
 
 /* Slot lifecycle functions */
 extern struct active_request_slot *get_active_slot(void);
-- 
1.6.0.2
