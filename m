From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] HTTP partial transfer support for object, pack, and index transfers
Date: Wed, 28 Sep 2005 10:14:04 -0700
Message-ID: <20050928171404.GA15593@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 28 19:15:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKfVZ-0001Iw-Ui
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 19:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVI1ROP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 13:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVI1ROP
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 13:14:15 -0400
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:60112 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751423AbVI1ROO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 13:14:14 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8SHE4ii016008
	for <git@vger.kernel.org>; Wed, 28 Sep 2005 10:14:04 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8SHE4sY016006
	for git@vger.kernel.org; Wed, 28 Sep 2005 10:14:04 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9440>

HTTP partial transfer support for object, pack, and index transfers

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |  185 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 161 insertions(+), 24 deletions(-)

492f6dfd5f0e7030fe96b3646a07a9adb1a7a2d0
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
 
@@ -82,12 +86,37 @@ void prefetch(unsigned char *sha1)
 {
 }
 
+int relink_or_rename(char *old, char *new) {
+	int ret;
+
+	ret = link(old, new);
+	if (ret < 0) {
+		/* Same Coda hack as in write_sha1_file(sha1_file.c) */
+		ret = errno;
+		if (ret == EXDEV && !rename(old, new))
+			return 0;
+	}
+	unlink(old);
+	if (ret) {
+		if (ret != EEXIST)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int got_alternates = 0;
 
 static int fetch_index(struct alt_base *repo, unsigned char *sha1)
 {
 	char *filename;
 	char *url;
+	char tmpfile[PATH_MAX];
+	int ret;
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct curl_slist *range_header = NULL;
+	CURLcode curl_result;
 
 	FILE *indexfile;
 
@@ -103,7 +132,8 @@ static int fetch_index(struct alt_base *
 		repo->base, sha1_to_hex(sha1));
 	
 	filename = sha1_pack_index_name(sha1);
-	indexfile = fopen(filename, "w");
+	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
+	indexfile = fopen(tmpfile, "a");
 	if (!indexfile)
 		return error("Unable to open local file %s for pack index",
 			     filename);
@@ -113,12 +143,35 @@ static int fetch_index(struct alt_base *
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
 	
-	if (curl_easy_perform(curl)) {
+	/* If there is data present from a previous transfer attempt,
+	   resume where it left off */
+	prev_posn = ftell(indexfile);
+	if (prev_posn>0) {
+		if (get_verbosely)
+			fprintf(stderr,
+				"Resuming fetch of index for pack %s at byte %ld\n",
+				sha1_to_hex(sha1), prev_posn);
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
 		fclose(indexfile);
 		return error("Unable to get pack index %s", url);
 	}
 
 	fclose(indexfile);
+
+	ret = relink_or_rename(tmpfile, filename);
+	if (ret)
+		return error("unable to write index filename %s: %s",
+			     filename, strerror(ret));
+
 	return 0;
 }
 
@@ -299,6 +352,12 @@ static int fetch_pack(struct alt_base *r
 	struct packed_git **lst;
 	FILE *packfile;
 	char *filename;
+	char tmpfile[PATH_MAX];
+	int ret;
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct curl_slist *range_header = NULL;
+	CURLcode curl_result;
 
 	if (fetch_indices(repo))
 		return -1;
@@ -318,7 +377,8 @@ static int fetch_pack(struct alt_base *r
 		repo->base, sha1_to_hex(target->sha1));
 
 	filename = sha1_pack_name(target->sha1);
-	packfile = fopen(filename, "w");
+	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
+	packfile = fopen(tmpfile, "a");
 	if (!packfile)
 		return error("Unable to open local file %s for pack",
 			     filename);
@@ -327,14 +387,36 @@ static int fetch_pack(struct alt_base *r
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
-	
-	if (curl_easy_perform(curl)) {
+
+	/* If there is data present from a previous transfer attempt,
+	   resume where it left off */
+	prev_posn = ftell(packfile);
+	if (prev_posn>0) {
+		if (get_verbosely)
+			fprintf(stderr,
+				"Resuming fetch of pack %s at byte %ld\n",
+				sha1_to_hex(target->sha1), prev_posn);
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
 		fclose(packfile);
 		return error("Unable to get pack file %s", url);
 	}
 
 	fclose(packfile);
 
+	ret = relink_or_rename(tmpfile, filename);
+	if (ret)
+		return error("unable to write pack filename %s: %s",
+			     filename, strerror(ret));
+
 	lst = &repo->packs;
 	while (*lst != target)
 		lst = &((*lst)->next);
@@ -351,14 +433,29 @@ int fetch_object(struct alt_base *repo, 
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
+
+	local = open(tmpfile, O_WRONLY | O_CREAT | O_EXCL, 0666);
 
-	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX",
-		 get_object_directory());
+	/* Note: if another instance starts now, it will turn our new
+	   tmpfile into its prevfile. */
 
-	local = mkstemp(tmpfile);
 	if (local < 0)
 		return error("Couldn't create temporary file %s for %s: %s\n",
 			     tmpfile, filename, strerror(errno));
@@ -386,8 +483,56 @@ int fetch_object(struct alt_base *repo, 
 
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
+		if (get_verbosely)
+			fprintf(stderr,
+				"Resuming fetch of object %s at byte %ld\n",
+				hex, prev_posn);
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
 
@@ -403,20 +548,11 @@ int fetch_object(struct alt_base *repo, 
 		unlink(tmpfile);
 		return error("File %s has bad hash\n", hex);
 	}
-	ret = link(tmpfile, filename);
-	if (ret < 0) {
-		/* Same Coda hack as in write_sha1_file(sha1_file.c) */
-		ret = errno;
-		if (ret == EXDEV && !rename(tmpfile, filename))
-			goto out;
-	}
-	unlink(tmpfile);
-	if (ret) {
-		if (ret != EEXIST)
-			return error("unable to write sha1 filename %s: %s",
-				     filename, strerror(ret));
-	}
- out:
+	ret = relink_or_rename(tmpfile, filename);
+	if (ret)
+		return error("unable to write sha1 filename %s: %s",
+			     filename, strerror(ret));
+
 	pull_say("got %s\n", hex);
 	return 0;
 }
@@ -505,6 +641,7 @@ int main(int argc, char **argv)
 
 	curl = curl_easy_init();
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
+	no_range_header = curl_slist_append(no_range_header, "Range:");
 
 	curl_ssl_verify = getenv("GIT_SSL_NO_VERIFY") ? 0 : 1;
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
