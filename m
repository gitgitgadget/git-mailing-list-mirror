From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Decide whether to build http-push in the Makefile
Date: Fri, 18 Nov 2005 17:08:36 -0800
Message-ID: <20051119010836.GL3968@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 19 02:10:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdHE5-0002BK-DU
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 02:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbVKSBIj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 20:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbVKSBIj
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 20:08:39 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:37049 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1161098AbVKSBIi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 20:08:38 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAJ18a1V010359
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 17:08:36 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAJ18alR010357
	for git@vger.kernel.org; Fri, 18 Nov 2005 17:08:36 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12315>

The decision about whether to build http-push or not belongs in the
Makefile.  This follows Junio's suggestion to determine whether curl
is new enough to support http-push.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

I should have thought this through better before I posted the HTTP
refactoring patch set.  Apologies.

I've confirmed that http-push will not build unless
- curl-config is executable from the current PATH
- the --vernum flag is a valid option
- --vernum returns a value at least as recent as 070908


 Makefile    |    9 ++++++---
 http-push.c |    9 ---------
 2 files changed, 6 insertions(+), 12 deletions(-)

applies-to: 769e3c5498df32db6fc5ee764cd999608c6f1d9a
6d56bf9f18c029e15fcfd59fdd65f652961913af
diff --git a/Makefile b/Makefile
index 285b3ed..0efb0b6 100644
--- a/Makefile
+++ b/Makefile
@@ -242,9 +242,12 @@ ifndef NO_CURL
 		CURL_LIBCURL = -lcurl
 	endif
 	PROGRAMS += git-http-fetch$X
-	ifndef NO_EXPAT
-		EXPAT_LIBEXPAT = -lexpat
-		PROGRAMS += git-http-push$X
+	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
+	ifeq "$(curl_check)" "070908"
+		ifndef NO_EXPAT
+			EXPAT_LIBEXPAT = -lexpat
+			PROGRAMS += git-http-push$X
+		endif
 	endif
 endif
 
diff --git a/http-push.c b/http-push.c
index f3c92c9..76c7886 100644
--- a/http-push.c
+++ b/http-push.c
@@ -6,8 +6,6 @@
 #include "blob.h"
 #include "http.h"
 
-#ifdef USE_CURL_MULTI
-
 #include <expat.h>
 
 static const char http_push_usage[] =
@@ -1426,10 +1424,3 @@ int main(int argc, char **argv)
 
 	return rc;
 }
-#else /* ifdef USE_CURL_MULTI */
-int main(int argc, char **argv)
-{
-	fprintf(stderr, "http-push requires curl 7.9.8 or higher.\n");
-	return 1;
-}
-#endif
---
0.99.9.GIT
