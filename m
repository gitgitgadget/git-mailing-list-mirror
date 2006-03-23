From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Cloning from sites with 404 overridden
Date: Thu, 23 Mar 2006 10:43:51 -0800
Message-ID: <20060323184351.GA3892@reactrix.com>
References: <20060322025921.1722.qmail@science.horizon.com> <20060322172227.GO3997@reactrix.com> <20060322183621.GP3997@reactrix.com> <7vslpa8fld.fsf@assigned-by-dhcp.cox.net> <7vacbi8eu1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 19:44:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMUmw-0004hO-4T
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 19:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWCWSn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 13:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbWCWSn7
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 13:43:59 -0500
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:6255 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1422647AbWCWSn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 13:43:58 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2NIhpqA007385;
	Thu, 23 Mar 2006 10:43:51 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2NIhpA0007383;
	Thu, 23 Mar 2006 10:43:51 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vacbi8eu1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17865>

On Wed, Mar 22, 2006 at 11:22:14AM -0800, Junio C Hamano wrote:

> You probably need only one bit here,...
> ... and note if that is an HTML document or not.

/me smacks self...

> However the patch would not help when such a server also did a
> "Sorry, did you mistype the URL?" HTML response, and I was
> wondering how typical that would be.

Seems like there are three cases to worry about:

1) the server returns a 200 status and a text/html response instead of a
   404, and the server's default content type is not text/html
2) the server returns a 200 status and a text/html response instead of a
   404, and the server's default content type is text/html
3) the server returns a corrupt object from the repository

I don't think there's a way to distinguish between #2 and #3, so all we
can really do is display as helpful an error message as possible.

We can detect #1 if there has been a previous successful loose object
transfer by tracking whether the repo's default content type is
text/html.  In such a case should http-fetch behave as if the server
returned 404?  If there have been no successful loose object transfers,
we'd have to respond as with #2.  This approach could potentially break
if requests are load-balanced to servers with different
misconfigurations - but I think trying to detect that is bending
backwards a little too far.

On a related note, I noticed that http-fetch will continue to try
inflating/sha1_updating the response after an inflate error has been
detected.  It's probably not a huge deal, but we could just error out
immediately at that point or at least stop the unnecessary processing.

Something like this?  Tested by cloning
http://digilander.libero.it/mcostalba/scm/qgit.git


[PATCH] http-fetch: try to detect 404s from misconfigured servers

Some HTTP server environments return a 200 status and text/html error
document or a redirect to one rather than a 404 status if a loose
object does not exist.  This patch tries to detect such a response
and treat it as a 404.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

ab97429c5b0a4b4466ee0072f75706399e42b675
diff --git a/http-fetch.c b/http-fetch.c
index dc67218..bb75050 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -16,6 +16,7 @@ struct alt_base
 {
 	char *base;
 	int got_indices;
+	int default_html_content_type;
 	struct packed_git *packs;
 	struct alt_base *next;
 };
@@ -41,6 +42,7 @@ struct object_request
 	CURLcode curl_result;
 	char errorstr[CURL_ERROR_SIZE];
 	long http_code;
+	char html_content_type;
 	unsigned char real_sha1[20];
 	SHA_CTX c;
 	z_stream stream;
@@ -249,6 +251,9 @@ static void finish_object_request(struct
 		unlink(obj_req->tmpfile);
 		return;
 	}
+	if (obj_req->repo->default_html_content_type == -1)
+		obj_req->repo->default_html_content_type =
+			obj_req->html_content_type;
 	obj_req->rename =
 		move_temp_to_file(obj_req->tmpfile, obj_req->filename);
 
@@ -258,9 +263,15 @@ static void finish_object_request(struct
 
 static void process_object_response(void *callback_data)
 {
+	char *content_type;
 	struct object_request *obj_req =
 		(struct object_request *)callback_data;
 
+	curl_easy_getinfo(obj_req->slot->curl, CURLINFO_CONTENT_TYPE,
+			  &content_type);
+	if (content_type && !strcmp(content_type, "text/html"))
+		obj_req->html_content_type = 1;
+
 	obj_req->curl_result = obj_req->slot->curl_result;
 	obj_req->http_code = obj_req->slot->http_code;
 	obj_req->slot = NULL;
@@ -340,6 +351,7 @@ void prefetch(unsigned char *sha1)
 	memcpy(newreq->sha1, sha1, 20);
 	newreq->repo = alt;
 	newreq->url = NULL;
+	newreq->html_content_type = 0;
 	newreq->local = -1;
 	newreq->state = WAITING;
 	snprintf(newreq->filename, sizeof(newreq->filename), "%s", filename);
@@ -539,6 +551,7 @@ static void process_alternates_response(
 				newalt->next = NULL;
 				newalt->base = target;
 				newalt->got_indices = 0;
+				newalt->default_html_content_type = -1;
 				newalt->packs = NULL;
 				while (tail->next != NULL)
 					tail = tail->next;
@@ -835,8 +848,14 @@ static int fetch_object(struct alt_base 
 				    obj_req->errorstr, obj_req->curl_result,
 				    obj_req->http_code, hex);
 	} else if (obj_req->zret != Z_STREAM_END) {
-		corrupt_object_found++;
-		ret = error("File %s (%s) corrupt", hex, obj_req->url);
+		if (obj_req->html_content_type &&
+		    !obj_req->repo->default_html_content_type)
+			ret = -1; /* Be silent, looks like a 404 */
+		else {
+			corrupt_object_found++;
+			ret = error("File %s (%s) corrupt",
+				    sha1_to_hex(obj_req->sha1), obj_req->url);
+		}
 	} else if (memcmp(obj_req->sha1, obj_req->real_sha1, 20)) {
 		ret = error("File %s has bad hash", hex);
 	} else if (obj_req->rename < 0) {
@@ -985,6 +1004,7 @@ int main(int argc, char **argv)
 	alt = xmalloc(sizeof(*alt));
 	alt->base = url;
 	alt->got_indices = 0;
+	alt->default_html_content_type = -1;
 	alt->packs = NULL;
 	alt->next = NULL;
 
-- 
1.2.4.gb1bc1d-dirty
