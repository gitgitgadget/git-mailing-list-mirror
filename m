From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Restore functionality to allow proxies to cache objects
Date: Sat, 8 Oct 2005 09:40:45 -0700
Message-ID: <20051008164045.GA8736@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 08 18:43:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOHlm-0002Sn-2v
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 18:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVJHQkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 12:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVJHQku
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 12:40:50 -0400
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:12087 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932144AbVJHQku (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2005 12:40:50 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j98Gejm2009268
	for <git@vger.kernel.org>; Sat, 8 Oct 2005 09:40:45 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j98GejTs009266
	for git@vger.kernel.org; Sat, 8 Oct 2005 09:40:45 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9839>

The parallel request changes didn't properly implement the previous patch to
allow caching of retrieved objects by proxy servers.  Restore the previous
functionality such that by default requests include the "Pragma: no-cache"
header, and this header is removed on requests for pack indexes, packs, and
objects.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

Reading the revision history is useful...


 http-fetch.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

6a9799a063e53764338d8c54b17464f46321ec60
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -29,6 +29,7 @@ static int max_requests = DEFAULT_MAX_RE
 static CURLM *curlm;
 #endif
 static CURL *curl_default;
+static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
 static struct curl_slist *no_range_header;
 static char curl_errorstr[CURL_ERROR_SIZE];
@@ -203,7 +204,7 @@ struct active_request_slot *get_active_s
 	slot->in_use = 1;
 	slot->done = 0;
 	slot->local = NULL;
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_range_header);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 
@@ -358,6 +359,7 @@ void start_request(struct transfer_reque
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
 
 	/* If we have successfully processed data from a previous fetch
 	   attempt, only fetch the data we don't already have. */
@@ -568,6 +570,7 @@ static int fetch_index(struct alt_base *
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
 	slot->local = indexfile;
 
 	/* If there is data present from a previous transfer attempt,
@@ -837,6 +840,7 @@ static int fetch_pack(struct alt_base *r
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, packfile);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
 	slot->local = packfile;
 
 	/* If there is data present from a previous transfer attempt,
@@ -1067,6 +1071,7 @@ int main(int argc, char **argv)
 		return 1;
 	}
 #endif
+	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 	no_range_header = curl_slist_append(no_range_header, "Range:");
 
@@ -1106,6 +1111,7 @@ int main(int argc, char **argv)
 	if (pull(commit_id))
 		return 1;
 
+	curl_slist_free_all(pragma_header);
 	curl_slist_free_all(no_pragma_header);
 	curl_slist_free_all(no_range_header);
 	curl_easy_cleanup(curl_default);
