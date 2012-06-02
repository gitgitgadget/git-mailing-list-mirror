From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] http: get default user-agent from git_user_agent
Date: Sat, 2 Jun 2012 15:03:08 -0400
Message-ID: <20120602190308.GC14369@sigill.intra.peff.net>
References: <20120602184948.GA14269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 21:03:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SatbX-0005or-JK
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 21:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965643Ab2FBTDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 15:03:12 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41291
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965521Ab2FBTDL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 15:03:11 -0400
Received: (qmail 16622 invoked by uid 107); 2 Jun 2012 19:03:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jun 2012 15:03:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jun 2012 15:03:08 -0400
Content-Disposition: inline
In-Reply-To: <20120602184948.GA14269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199058>

This means we will respect the GIT_USER_AGENT build-time
configuration and run-time environment variable.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that this needs to be applied on the recent "http.o depends
on GIT-VERSION-FILE" fix by Erik, which just went into master. It
actually undoes that commit, but that is because the dependency no
longer exists.

 Makefile | 5 +----
 http.c   | 3 ++-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index e6e65ca..62de0b4 100644
--- a/Makefile
+++ b/Makefile
@@ -2104,7 +2104,7 @@ configure: configure.ac
 	$(RM) $<+
 
 # These can record GIT_VERSION
-version.o git.spec http.o \
+version.o git.spec \
 	$(patsubst %.sh,%,$(SCRIPT_SH)) \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
@@ -2274,9 +2274,6 @@ attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
 	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
 
-http.sp http.s http.o: EXTRA_CPPFLAGS = \
-	-DGIT_HTTP_USER_AGENT='"git/$(GIT_VERSION)"'
-
 ifdef NO_EXPAT
 http-walker.sp http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
 endif
diff --git a/http.c b/http.c
index 5cb87f1..b61ac85 100644
--- a/http.c
+++ b/http.c
@@ -4,6 +4,7 @@
 #include "run-command.h"
 #include "url.h"
 #include "credential.h"
+#include "version.h"
 
 int active_requests;
 int http_is_verbose;
@@ -299,7 +300,7 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
 
 	curl_easy_setopt(result, CURLOPT_USERAGENT,
-		user_agent ? user_agent : GIT_HTTP_USER_AGENT);
+		user_agent ? user_agent : git_user_agent());
 
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
-- 
1.7.7.7.32.g4b73117
