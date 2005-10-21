From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 3/3] Allow running requests to finish after a pull error
Date: Fri, 21 Oct 2005 12:06:27 -0700
Message-ID: <20051021190627.GG6160@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 21 21:08:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET2Do-0000L1-0d
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 21:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVJUTG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 15:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVJUTG2
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 15:06:28 -0400
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:25339 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S965098AbVJUTG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 15:06:27 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9LJ6RnC023871
	for <git@vger.kernel.org>; Fri, 21 Oct 2005 12:06:27 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9LJ6RGs023869
	for git@vger.kernel.org; Fri, 21 Oct 2005 12:06:27 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10441>

Allow running requests to finish after a pull error

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

applies-to: 3f355bb154eb7b68de698d1e2692615820445cae
584ac10ab8c1f869ea475246012683db95c9088c
diff --git a/http-fetch.c b/http-fetch.c
index ed1053a..1ee1df2 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1226,6 +1226,8 @@ int main(int argc, char **argv)
 	struct active_request_slot *slot;
 	char *low_speed_limit;
 	char *low_speed_time;
+	char *wait_url;
+	int rc = 0;
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
@@ -1313,7 +1315,7 @@ int main(int argc, char **argv)
 	alt->next = NULL;
 
 	if (pull(commit_id))
-		return 1;
+		rc = 1;
 
 	curl_slist_free_all(pragma_header);
 	curl_slist_free_all(no_pragma_header);
@@ -1323,6 +1325,15 @@ int main(int argc, char **argv)
 #endif
 	slot = active_queue_head;
 	while (slot != NULL) {
+		if (slot->in_use) {
+			if (get_verbosely) {
+				curl_easy_getinfo(slot->curl,
+						  CURLINFO_EFFECTIVE_URL,
+						  &wait_url);
+				fprintf(stderr, "Waiting for %s\n", wait_url);
+			}
+			run_active_slot(slot);
+		}
 		if (slot->curl != NULL)
 			curl_easy_cleanup(slot->curl);
 		slot = slot->next;
@@ -1331,5 +1342,5 @@ int main(int argc, char **argv)
 	curl_multi_cleanup(curlm);
 #endif
 	curl_global_cleanup();
-	return 0;
+	return rc;
 }
---
0.99.8.GIT
