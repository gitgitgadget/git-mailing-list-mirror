From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 3/3] Return CURL error message when object transfer fails
Date: Mon, 26 Sep 2005 10:52:11 -0700
Message-ID: <20050926175211.GD9410@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 26 19:54:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJx9E-0005uR-Ib
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 19:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVIZRwN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 13:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVIZRwN
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 13:52:13 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:6904 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932446AbVIZRwL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 13:52:11 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8QHqBDN009454
	for <git@vger.kernel.org>; Mon, 26 Sep 2005 10:52:11 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8QHqBZK009452
	for git@vger.kernel.org; Mon, 26 Sep 2005 10:52:11 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9315>


Return CURL error message when object transfer fails

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

It might be better to extend this to all places that curl_easy_perform
is called, rather than just in fetch_object.

 http-fetch.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

330da7634e6a707779dcc8648841f501d2a47568
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -19,6 +19,7 @@
 static CURL *curl;
 static struct curl_slist *no_pragma_header;
 static struct curl_slist *no_range_header;
+static char curl_errorstr[CURL_ERROR_SIZE];
 
 static char *initial_base;
 
@@ -389,6 +390,7 @@ int fetch_object(struct alt_base *repo, 
 	curl_easy_setopt(curl, CURLOPT_FILE, NULL);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
+	curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 
 	url = xmalloc(strlen(repo->base) + 50);
 	strcpy(url, repo->base);
@@ -448,7 +450,7 @@ int fetch_object(struct alt_base *repo, 
 	curl_result = curl_easy_perform(curl);
 	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_range_header);
 	if (curl_result != 0) {
-		return -1;
+		return error(curl_errorstr);
 	}
 
 	fchmod(local, 0444);
