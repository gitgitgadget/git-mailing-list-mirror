From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] git-http-fetch: Remove size limit for objects/info/{packs,alternates}
Date: Thu, 13 Oct 2005 20:01:48 +0400
Message-ID: <20051013160148.GB12092@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 18:08:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ5Wx-0000E4-80
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 18:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbVJMQCD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 12:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbVJMQCD
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 12:02:03 -0400
Received: from mivlgu.ru ([81.18.140.87]:29316 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751592AbVJMQCD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 12:02:03 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id CF3DD18010F; Thu, 13 Oct 2005 20:01:48 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10080>

git-http-fetch received objects/info/packs into a fixed-size buffer
and started to fail when this file became larger than the buffer.
Change it to grow the buffer dynamically, and do the same thing for
objects/info/alternates.  Also add missing free() calls for these
buffers.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 The problem currently happens with the linux-2.4 repository:

 http://www.kernel.org/pub/scm/linux/kernel/git/marcelo/linux-2.4.git/

 For some reason, objects/info/packs in that repository has grown to 662K.


 http-fetch.c |   43 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 36 insertions(+), 7 deletions(-)

applies-to: 1970e5869a42fd4095917d861654dc84d60f02b7
341e03b5a2f197b1e60c3d38c0803d552dc6cd4d
diff --git a/http-fetch.c b/http-fetch.c
index 0aba891..c6daf6a 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -110,6 +110,22 @@ static size_t fwrite_buffer(void *ptr, s
         return size;
 }
 
+static size_t fwrite_buffer_dynamic(const void *ptr, size_t eltsize,
+				    size_t nmemb, struct buffer *buffer)
+{
+	size_t size = eltsize * nmemb;
+	if (size > buffer->size - buffer->posn) {
+		buffer->size = buffer->size * 3 / 2;
+		if (buffer->size < buffer->posn + size)
+			buffer->size = buffer->posn + size;
+		buffer->buffer = xrealloc(buffer->buffer, buffer->size);
+	}
+	memcpy(buffer->buffer + buffer->posn, ptr, size);
+	buffer->posn += size;
+	data_received++;
+	return size;
+}
+
 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 			       void *data)
 {
@@ -618,11 +634,12 @@ static int fetch_alternates(char *base)
 	int i = 0;
 	int http_specific = 1;
 	struct alt_base *tail = alt;
+	static const char null_byte = '\0';
 
 	struct active_request_slot *slot;
 
 	data = xmalloc(4096);
-	buffer.size = 4095;
+	buffer.size = 4096;
 	buffer.posn = 0;
 	buffer.buffer = data;
 
@@ -634,7 +651,8 @@ static int fetch_alternates(char *base)
 
 	slot = get_active_slot();
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
+			 fwrite_buffer_dynamic);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
@@ -646,20 +664,24 @@ static int fetch_alternates(char *base)
 			slot = get_active_slot();
 			curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
 			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-					 fwrite_buffer);
+					 fwrite_buffer_dynamic);
 			curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 			if (start_active_slot(slot)) {
 				run_active_slot(slot);
 				if (slot->curl_result != CURLE_OK) {
+					free(buffer.buffer);
 					return 0;
 				}
 			}
 		}
 	} else {
+		free(buffer.buffer);
 		return 0;
 	}
 
-	data[buffer.posn] = '\0';
+	fwrite_buffer_dynamic(&null_byte, 1, 1, &buffer);
+	buffer.posn--;
+	data = buffer.buffer;
 
 	while (i < buffer.posn) {
 		int posn = i;
@@ -718,7 +740,8 @@ static int fetch_alternates(char *base)
 		}
 		i = posn + 1;
 	}
-	
+
+	free(buffer.buffer);
 	return ret;
 }
 
@@ -748,17 +771,22 @@ static int fetch_indices(struct alt_base
 
 	slot = get_active_slot();
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
+			 fwrite_buffer_dynamic);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result != CURLE_OK)
+		if (slot->curl_result != CURLE_OK) {
+			free(buffer.buffer);
 			return error("%s", curl_errorstr);
+		}
 	} else {
+		free(buffer.buffer);
 		return error("Unable to start request");
 	}
 
+	data = buffer.buffer;
 	while (i < buffer.posn) {
 		switch (data[i]) {
 		case 'P':
@@ -778,6 +806,7 @@ static int fetch_indices(struct alt_base
 		i++;
 	}
 
+	free(buffer.buffer);
 	repo->got_indices = 1;
 	return 0;
 }
---
0.99.8.GIT
