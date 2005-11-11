From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix bunch of fd leaks in http-fetch
Date: Sat, 12 Nov 2005 00:55:16 +0100
Message-ID: <20051111235516.GY30496@pasky.or.cz>
References: <dd9dee136a573d72fc7332373cfd8ac1@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 00:56:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaikC-00007b-NY
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 00:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVKKXzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 18:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVKKXzU
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 18:55:20 -0500
Received: from w241.dkm.cz ([62.24.88.241]:19422 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750745AbVKKXzT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 18:55:19 -0500
Received: (qmail 21765 invoked by uid 2001); 12 Nov 2005 00:55:16 +0100
To: Becky Bruce <becky.bruce@freescale.com>
Content-Disposition: inline
In-Reply-To: <dd9dee136a573d72fc7332373cfd8ac1@freescale.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11648>

Dear diary, on Fri, Nov 11, 2005 at 11:58:39PM CET, I got a letter
where Becky Bruce <becky.bruce@freescale.com> said that...
> I grabbed 0.99.9g this morning, and tried to clone Paul Mackerras' 
> linux merge tree. The clone failed and reported errors in http-fetch 
> with a bunch of messages of the form:
> 
> error: Couldn't create temporary file 
> .git/objects/04/48fa7de8a416a48cd1977f29858be54e67c078.temp for .git
> /objects/04/48fa7de8a416a48cd1977f29858be54e67c078: Error 24: Too many 
> open files

---

The current http-fetch is rather careless about fd leakage, causing
problems while fetching large repositories. This patch does not reserve
exhaustiveness, but I covered everything I spotted. I also left some
safeguards in place in case I missed something, so that we get to know,
sooner or later.

Reported by Becky Bruce <becky.bruce@freescale.com>.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 http-fetch.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 99921cc..e7655d1 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -413,6 +413,8 @@ static void start_request(struct transfe
 	rename(request->tmpfile, prevfile);
 	unlink(request->tmpfile);
 
+	if (request->local != -1)
+		error("fd leakage in start: %d", request->local);
 	request->local = open(request->tmpfile,
 			      O_WRONLY | O_CREAT | O_EXCL, 0666);
 	/* This could have failed due to the "lazy directory creation";
@@ -511,7 +513,7 @@ static void start_request(struct transfe
 	/* Try to get the request started, abort the request on error */
 	if (!start_active_slot(slot)) {
 		request->state = ABORTED;
-		close(request->local);
+		close(request->local); request->local = -1;
 		free(request->url);
 		return;
 	}
@@ -525,7 +527,7 @@ static void finish_request(struct transf
 	struct stat st;
 
 	fchmod(request->local, 0444);
-	close(request->local);
+	close(request->local); request->local = -1;
 
 	if (request->http_code == 416) {
 		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
@@ -557,6 +559,8 @@ static void release_request(struct trans
 {
 	struct transfer_request *entry = request_queue_head;
 
+	if (request->local != -1)
+		error("fd leakage in release: %d", request->local);
 	if (request == request_queue_head) {
 		request_queue_head = request->next;
 	} else {
@@ -613,6 +617,8 @@ static void process_curl_messages(void)
 					if (request->repo->next != NULL) {
 						request->repo =
 							request->repo->next;
+						close(request->local);
+							request->local = -1;
 						start_request(request);
 					}
 				} else {
@@ -743,6 +749,7 @@ static int fetch_index(struct alt_base *
 				     curl_errorstr);
 		}
 	} else {
+		fclose(indexfile);
 		return error("Unable to start request");
 	}
 
@@ -1025,6 +1032,7 @@ static int fetch_pack(struct alt_base *r
 				     curl_errorstr);
 		}
 	} else {
+		fclose(packfile);
 		return error("Unable to start request");
 	}
 
@@ -1087,6 +1095,7 @@ static int fetch_object(struct alt_base 
 			fetch_alternates(alt->base);
 			if (request->repo->next != NULL) {
 				request->repo = request->repo->next;
+				close(request->local); request->local = -1;
 				start_request(request);
 			}
 		} else {
@@ -1095,6 +1104,9 @@ static int fetch_object(struct alt_base 
 		}
 #endif
 	}
+	if (request->local != -1) {
+		close(request->local); request->local = -1;
+	}
 
 	if (request->state == ABORTED) {
 		release_request(request);


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
