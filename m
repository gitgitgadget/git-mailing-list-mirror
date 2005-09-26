From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 2/3] Support for partial HTTP transfers
Date: Mon, 26 Sep 2005 10:52:04 -0700
Message-ID: <20050926175204.GC9410@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 26 19:54:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJx97-0005qO-G9
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 19:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVIZRwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 13:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVIZRwG
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 13:52:06 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:5112 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932443AbVIZRwE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 13:52:04 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8QHq4Ax009446
	for <git@vger.kernel.org>; Mon, 26 Sep 2005 10:52:04 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8QHq4eR009444
	for git@vger.kernel.org; Mon, 26 Sep 2005 10:52:04 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9316>


Support for partial HTTP transfers - if a previous temp file is detected,
read it in and start the HTTP transfer from where the previous left off.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 67 insertions(+), 5 deletions(-)

34a692953368188cbaefbd6c60e400053f8528b4
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -13,8 +13,12 @@
 #define curl_global_init(a) do { /* nothing */ } while(0)
 #endif
 
+#define PREV_BUF_SIZE 4096
+#define RANGE_HEADER_SIZE 30
+
 static CURL *curl;
 static struct curl_slist *no_pragma_header;
+static struct curl_slist *no_range_header;
 
 static char *initial_base;
 
@@ -351,14 +355,26 @@ int fetch_object(struct alt_base *repo, 
 	char *filename = sha1_file_name(sha1);
 	unsigned char real_sha1[20];
 	char tmpfile[PATH_MAX];
+	char prevfile[PATH_MAX];
 	int ret;
 	char *url;
 	char *posn;
+	int prevlocal;
+	unsigned char prev_buf[PREV_BUF_SIZE];
+	ssize_t prev_read = 0;
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct curl_slist *range_header = NULL;
+	CURLcode curl_result;
+
+	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
+	snprintf(prevfile, sizeof(prevfile), "%s.prev", filename);
+	unlink(prevfile);
+	rename(tmpfile, prevfile);
+	unlink(tmpfile);
 
-	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX",
-		 get_object_directory());
+	local = open(tmpfile, O_WRONLY | O_CREAT | O_EXCL, 0666);
 
-	local = mkstemp(tmpfile);
 	if (local < 0)
 		return error("Couldn't create temporary file %s for %s: %s\n",
 			     tmpfile, filename, strerror(errno));
@@ -386,8 +402,52 @@ int fetch_object(struct alt_base *repo, 
 
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 
-	if (curl_easy_perform(curl)) {
-		unlink(filename);
+	/* If a previous temp file is present, process what was already
+	   fetched. */
+	prevlocal = open(prevfile, O_RDONLY);
+	if (prevlocal != -1) {
+		do {
+			prev_read = read(prevlocal, prev_buf, PREV_BUF_SIZE);
+			if (prev_read>0) {
+				if (fwrite_sha1_file(prev_buf,
+						     1,
+						     prev_read,
+						     NULL) == prev_read) {
+					prev_posn += prev_read;
+				} else {
+					prev_read = -1;
+				}
+			}
+		} while (prev_read > 0);
+		close(prevlocal);
+	}
+	unlink(prevfile);
+
+	/* Reset inflate/SHA1 if there was an error reading the previous temp
+	   file; also rewind to the beginning of the local file. */
+	if (prev_read == -1) {
+		memset(&stream, 0, sizeof(stream));
+		inflateInit(&stream);
+		SHA1_Init(&c);
+		if (prev_posn>0) {
+			prev_posn = 0;
+			lseek(local, SEEK_SET, 0);
+		}
+	}
+
+	/* If we have successfully processed data from a previous fetch
+	   attempt, only fetch the data we don't already have. */
+	if (prev_posn>0) {
+		sprintf(range, "Range: bytes=%ld-", prev_posn);
+		range_header = curl_slist_append(range_header, range);
+		curl_easy_setopt(curl, CURLOPT_HTTPHEADER, range_header);
+	}
+
+	/* Clear out the Range: header after performing the request, so
+	   other curl requests don't inherit inappropriate header data */
+	curl_result = curl_easy_perform(curl);
+	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_range_header);
+	if (curl_result != 0) {
 		return -1;
 	}
 
@@ -517,6 +577,7 @@ int main(int argc, char **argv)
 
 	curl = curl_easy_init();
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
+	no_range_header = curl_slist_append(no_range_header, "Range:");
 
         /* Set SSL parameters if they were provided */
 	if (ssl_cert != NULL) {
@@ -549,6 +610,7 @@ int main(int argc, char **argv)
 		return 1;
 
 	curl_slist_free_all(no_pragma_header);
+	curl_slist_free_all(no_range_header);
 	curl_global_cleanup();
 	return 0;
 }
