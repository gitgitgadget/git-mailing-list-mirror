From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Don't fetch objects that exist in the local repository
Date: Fri, 7 Oct 2005 15:01:51 -0700
Message-ID: <20051007220151.GB4989@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 08 00:03:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO0I6-0005ce-Vn
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 00:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbVJGWB7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 18:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVJGWB7
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 18:01:59 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:31914 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932677AbVJGWB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 18:01:58 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j97M1qOc014211
	for <git@vger.kernel.org>; Fri, 7 Oct 2005 15:01:52 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j97M1pCD014209
	for git@vger.kernel.org; Fri, 7 Oct 2005 15:01:51 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9821>

Be sure not to fetch objects that already exist in the local repository.
The main process loop no longer performs this check, http-fetch now checks
prior to starting a new request queue entry and when fetch_object() is called,
and local-fetch now checks when fetch_object() is called.

As discussed in this thread: http://marc.theaimsgroup.com/?t=112854890500001

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 fetch.c       |    2 +-
 http-fetch.c  |   10 +++++++++-
 local-fetch.c |    5 ++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

41b78748fe458224fc1d621f5f0a4df2a3ac3253
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -165,7 +165,7 @@ static int loop(void)
 		 * the queue because we needed to fetch it first.
 		 */
 		if (! (obj->flags & TO_SCAN)) {
-			if (!has_sha1_file(obj->sha1) && fetch(obj->sha1)) {
+			if (fetch(obj->sha1)) {
 				report_missing(obj->type
 					       ? obj->type
 					       : "object", obj->sha1);
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -489,7 +489,10 @@ void process_request_queue()
 
 	while (active_requests < max_requests && request != NULL) {
 		if (request->state == WAITING) {
-			start_request(request);
+			if (has_sha1_file(request->sha1))
+				release_request(request);
+			else
+				start_request(request);
 			curl_multi_perform(curlm, &num_transfers);
 		}
 		request = request->next;
@@ -890,6 +893,11 @@ static int fetch_object(struct alt_base 
 	if (request == NULL)
 		return error("Couldn't find request for %s in the queue", hex);
 
+	if (has_sha1_file(request->sha1)) {
+		release_request(request);
+		return 0;
+	}
+
 #ifdef USE_CURL_MULTI
 	int num_transfers;
 	while (request->state == WAITING) {
diff --git a/local-fetch.c b/local-fetch.c
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -166,7 +166,10 @@ static int fetch_file(const unsigned cha
 
 int fetch(unsigned char *sha1)
 {
-	return fetch_file(sha1) && fetch_pack(sha1);
+	if (has_sha1_file(sha1))
+		return 0;
+	else
+		return fetch_file(sha1) && fetch_pack(sha1);
 }
 
 int fetch_ref(char *ref, unsigned char *sha1)
