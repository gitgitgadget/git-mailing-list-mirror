From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 5/5] http-push memory/fd cleanup
Date: Fri, 18 Nov 2005 11:03:25 -0800
Message-ID: <20051118190324.GJ3968@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 19 00:17:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdBWE-0006el-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 20:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbVKRTD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 14:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbVKRTD0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 14:03:26 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:9812 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750776AbVKRTDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 14:03:25 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAIJ3Pg3026745
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 11:03:25 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAIJ3P0n026743
	for git@vger.kernel.org; Fri, 18 Nov 2005 11:03:25 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12281>

Clean up memory and file descriptor usage

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-push.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

applies-to: 697c3fa609568c3befb803dd8a131814ca1fad6a
898a8d2e69916757f423a8bd487d97f19c06c1e0
diff --git a/http-push.c b/http-push.c
index 2932693..f3c92c9 100644
--- a/http-push.c
+++ b/http-push.c
@@ -165,6 +165,7 @@ static void start_check(struct transfer_
 	} else {
 		request->state = ABORTED;
 		free(request->url);
+		request->url = NULL;
 	}
 }
 
@@ -198,6 +199,7 @@ static void start_mkcol(struct transfer_
 	} else {
 		request->state = ABORTED;
 		free(request->url);
+		request->url = NULL;
 	}
 }
 
@@ -244,8 +246,6 @@ static void start_put(struct transfer_re
 	request->buffer.size = stream.total_out;
 	request->buffer.posn = 0;
 
-	if (request->url != NULL)
-		free(request->url);
 	request->url = xmalloc(strlen(remote->url) + 
 			       strlen(request->lock->token) + 51);
 	strcpy(request->url, remote->url);
@@ -281,6 +281,7 @@ static void start_put(struct transfer_re
 	} else {
 		request->state = ABORTED;
 		free(request->url);
+		request->url = NULL;
 	}
 }
 
@@ -306,6 +307,7 @@ static void start_move(struct transfer_r
 	} else {
 		request->state = ABORTED;
 		free(request->url);
+		request->url = NULL;
 	}
 }
 
@@ -370,6 +372,13 @@ static void finish_request(struct transf
 
 	if (request->headers != NULL)
 		curl_slist_free_all(request->headers);
+
+	/* URL is reused for MOVE after PUT */
+	if (request->state != RUN_PUT) {
+		free(request->url);
+		request->url = NULL;
+	}		
+
 	if (request->state == RUN_HEAD) {
 		if (request->http_code == 404) {
 			request->state = NEED_PUSH;
@@ -435,7 +444,8 @@ static void release_request(struct trans
 			entry->next = entry->next->next;
 	}
 
-	free(request->url);
+	if (request->url != NULL)
+		free(request->url);
 	free(request);
 }
 
@@ -575,6 +585,7 @@ static int fetch_index(unsigned char *sh
 		}
 	} else {
 		free(url);
+		fclose(indexfile);
 		return error("Unable to start request");
 	}
 
---
0.99.9.GIT
