From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Silence confusing and false-positive curl error message
Date: Fri, 21 Oct 2005 18:18:46 +0200
Message-ID: <20051021161846.18478.50202.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 18:23:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESzbY-00078i-JN
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 18:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVJUQSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 12:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVJUQSt
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 12:18:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28642 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965015AbVJUQSs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 12:18:48 -0400
Received: (qmail 18490 invoked from network); 21 Oct 2005 18:18:46 +0200
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 21 Oct 2005 18:18:46 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10438>

git-http-fetch spits out curl 404 error message when unable to fetch an object,
but that's confusing since no error really happenned and the object is usually
found in a pack it tries right after that. And if the object still cannot be
retrieved, it will say another error message anyway. OTOH other HTTP errors
(403 etc) are likely fatal and the user should be still informed about them.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 http-fetch.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index a7dc2cc..2d76ee1 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1069,9 +1069,12 @@ static int fetch_object(struct alt_base 
 	}
 
 	if (request->curl_result != CURLE_OK && request->http_code != 416) {
-		ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
-			    request->errorstr, request->curl_result,
-			    request->http_code, hex);
+		if (request->http_code == 404)
+			ret = -1; /* Be silent, it is probably in a pack. */
+		else
+			ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
+				    request->errorstr, request->curl_result,
+				    request->http_code, hex);
 		release_request(request);
 		return ret;
 	}
