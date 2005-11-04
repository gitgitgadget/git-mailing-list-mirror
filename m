From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 2/4] Support remote references with slashes in their names
Date: Fri, 4 Nov 2005 14:22:25 -0800
Message-ID: <20051104222225.GE3001@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 04 23:27:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY9x6-0004Nk-TZ
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 23:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVKDWW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVKDWW0
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 17:22:26 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:31274 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751068AbVKDWWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 17:22:25 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA4MMPiL017936
	for <git@vger.kernel.org>; Fri, 4 Nov 2005 14:22:25 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA4MMPVc017934
	for git@vger.kernel.org; Fri, 4 Nov 2005 14:22:25 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11169>

Support remote references with slashes in their names

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-push.c |   42 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 39 insertions(+), 3 deletions(-)

applies-to: 54e1d462248523bfac7d7c4b42e3b1ce1270fbd9
33cd543dfe656dce9c5722e4fe6af22fa5a80e7e
diff --git a/http-push.c b/http-push.c
index 134d405..6a241aa 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1066,12 +1066,44 @@ char *lock_remote(char *file, int timeou
 	struct buffer out_buffer;
 	char *out_data;
 	char *url;
+	char *ep;
 	char timeout_header[25];
 	struct curl_slist *dav_headers = NULL;
 
 	if (lock_token != NULL)
 		free(lock_token);
 
+	url = xmalloc(strlen(remote->url) + strlen(file) + 1);
+	sprintf(url, "%s%s", remote->url, file);
+
+	/* Make sure leading directories exist for the remote ref */
+	ep = strchr(url + strlen(remote->url) + 11, '/');
+	while (ep) {
+		*ep = 0;
+		slot = get_active_slot();
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+		curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_MKCOL);
+		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
+		if (start_active_slot(slot)) {
+			run_active_slot(slot);
+			if (slot->curl_result != CURLE_OK &&
+			    slot->http_code != 405) {
+				fprintf(stderr,
+					"Unable to create branch path %s\n",
+					url);
+				free(url);
+				return NULL;
+			}
+		} else {
+			fprintf(stderr, "Unable to start request\n");
+			free(url);
+			return NULL;
+		}
+		*ep = '/';
+		ep = strchr(ep + 1, '/');
+	}
+
 	out_buffer.size = strlen(LOCK_REQUEST) + strlen(git_default_email) - 2;
 	out_data = xmalloc(out_buffer.size + 1);
 	snprintf(out_data, out_buffer.size + 1, LOCK_REQUEST, git_default_email);
@@ -1079,8 +1111,6 @@ char *lock_remote(char *file, int timeou
 	out_buffer.buffer = out_data;
 
 	sprintf(timeout_header, "Timeout: Second-%d", timeout);
-	url = xmalloc(strlen(remote->url) + strlen(file) + 1);
-	sprintf(url, "%s%s", remote->url, file);
 	dav_headers = curl_slist_append(dav_headers, timeout_header);
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
 
@@ -1098,16 +1128,22 @@ char *lock_remote(char *file, int timeou
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		free(out_data);
 		if (slot->curl_result != CURLE_OK) {
 			fprintf(stderr, "Got HTTP error %ld\n", slot->http_code);
+			free(url);
+			free(out_data);
 			return NULL;
 		}
 	} else {
+		free(url);
 		free(out_data);
 		fprintf(stderr, "Unable to start request\n");
+		return NULL;
 	}
 
+	free(url);
+	free(out_data);
+
 	return strdup(lock_token);
 }
 
---
0.99.9.GIT
