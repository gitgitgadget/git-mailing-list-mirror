From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Cloning from sites with 404 overridden
Date: Wed, 22 Mar 2006 10:36:21 -0800
Message-ID: <20060322183621.GP3997@reactrix.com>
References: <20060322025921.1722.qmail@science.horizon.com> <20060322172227.GO3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 22 19:36:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM8C5-0001k7-EX
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 19:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWCVSg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 13:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWCVSg0
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 13:36:26 -0500
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:26234 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751053AbWCVSg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 13:36:26 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2MIaLTM025849
	for <git@vger.kernel.org>; Wed, 22 Mar 2006 10:36:21 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2MIaLYW025847
	for git@vger.kernel.org; Wed, 22 Mar 2006 10:36:21 -0800
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060322172227.GO3997@reactrix.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17818>

On Wed, Mar 22, 2006 at 09:22:27AM -0800, Nick Hengeveld wrote:

> It might be feasible to detect this condition using the Content-Type:
> header in the server response.  So far, all the GIT repositories I've
> tried return text/plain for loose objects and a special 404 page will
> likely be text/html.

Something like this:

http_fetch: report text/html responses for loose objects

Some HTTP server environments return a 200 status and text/html error
document or a redirect to one rather than a 404 status if a loose
object does not exist.  This patch detects and reports this condition
to differentiate between a misconfigured server and an actual corrupt
object on the server.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

61069cc348640fef2b8c503b8b8f00f689872cab
diff --git a/http-fetch.c b/http-fetch.c
index dc67218..ee5b585 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -41,6 +41,7 @@ struct object_request
 	CURLcode curl_result;
 	char errorstr[CURL_ERROR_SIZE];
 	long http_code;
+	char *content_type;
 	unsigned char real_sha1[20];
 	SHA_CTX c;
 	z_stream stream;
@@ -258,9 +259,15 @@ static void finish_object_request(struct
 
 static void process_object_response(void *callback_data)
 {
+	char *content_type;
 	struct object_request *obj_req =
 		(struct object_request *)callback_data;
 
+	curl_easy_getinfo(obj_req->slot->curl, CURLINFO_CONTENT_TYPE,
+			  &content_type);
+	if (content_type)
+		obj_req->content_type = strdup(content_type);
+
 	obj_req->curl_result = obj_req->slot->curl_result;
 	obj_req->http_code = obj_req->slot->http_code;
 	obj_req->slot = NULL;
@@ -298,6 +305,8 @@ static void release_object_request(struc
 			entry->next = entry->next->next;
 	}
 
+	if (obj_req->content_type)
+		free(obj_req->content_type);
 	free(obj_req->url);
 	free(obj_req);
 }
@@ -340,6 +349,7 @@ void prefetch(unsigned char *sha1)
 	memcpy(newreq->sha1, sha1, 20);
 	newreq->repo = alt;
 	newreq->url = NULL;
+	newreq->content_type = NULL;
 	newreq->local = -1;
 	newreq->state = WAITING;
 	snprintf(newreq->filename, sizeof(newreq->filename), "%s", filename);
@@ -836,7 +846,14 @@ static int fetch_object(struct alt_base 
 				    obj_req->http_code, hex);
 	} else if (obj_req->zret != Z_STREAM_END) {
 		corrupt_object_found++;
-		ret = error("File %s (%s) corrupt", hex, obj_req->url);
+		if (obj_req->content_type &&
+		    !strcmp(obj_req->content_type, "text/html")) {
+			ret = error("text/html response for file %s (%s)",
+				    sha1_to_hex(obj_req->sha1), obj_req->url);
+		} else {
+			ret = error("File %s (%s) corrupt",
+				    sha1_to_hex(obj_req->sha1), obj_req->url);
+		}
 	} else if (memcmp(obj_req->sha1, obj_req->real_sha1, 20)) {
 		ret = error("File %s has bad hash", hex);
 	} else if (obj_req->rename < 0) {
-- 
1.2.4.gb1bc1d-dirty
