From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] http: prevent segfault during curl handle reuse
Date: Wed, 31 May 2006 16:25:03 -0700
Message-ID: <20060531232503.GC12261@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 01 01:25:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fla3r-0008VH-AS
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 01:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965255AbWEaXZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 19:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbWEaXZE
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 19:25:04 -0400
Received: from 241.37.26.69.virtela.net ([69.26.37.241]:45109 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S965255AbWEaXZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 19:25:03 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k4VNP30t008369
	for <git@vger.kernel.org>; Wed, 31 May 2006 16:25:03 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k4VNP3Rc008367
	for git@vger.kernel.org; Wed, 31 May 2006 16:25:03 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21099>

If a curl handle is configured with special options, they may reference
information that is freed after the request is complete which can cause
a segfault if the curl handle is reused for a different type of request.

This patch resets these options to a safe state when a transfer slot is
assigned to a new request.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>
---
 http.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 0cb42a8..146cf7b 100644
--- a/http.c
+++ b/http.c
@@ -25,7 +25,6 @@ long curl_low_speed_limit = -1;
 long curl_low_speed_time = -1;
 
 struct curl_slist *pragma_header;
-struct curl_slist *no_range_header;
 
 struct active_request_slot *active_queue_head = NULL;
 
@@ -208,7 +207,6 @@ void http_init(void)
 	curl_global_init(CURL_GLOBAL_ALL);
 
 	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
-	no_range_header = curl_slist_append(no_range_header, "Range:");
 
 #ifdef USE_CURL_MULTI
 	{
@@ -344,9 +342,14 @@ #endif
 	slot->finished = NULL;
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_range_header);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
+	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 
 	return slot;
 }
-- 
1.3.3.g2186-dirty
