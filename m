From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] setup_pager: refactor LESS/LV environment setting
Date: Thu, 16 Jan 2014 23:21:02 -0500
Message-ID: <20140117042101.GA23443@sigill.intra.peff.net>
References: <20140117041430.GB19551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Yuri <yuri@rawbw.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 05:21:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W40vt-0007tH-Ir
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 05:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbaAQEVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 23:21:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:33981 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751623AbaAQEVE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 23:21:04 -0500
Received: (qmail 15175 invoked by uid 102); 17 Jan 2014 04:21:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 22:21:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 23:21:02 -0500
Content-Disposition: inline
In-Reply-To: <20140117041430.GB19551@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240570>

The way the code is structured now, we have to repeat
ourselves in fetching the environment variables (which will
get annoying as we add more).  Instead, let's use an
argv_array.  That removes a lot of the extra conditionals
and makes it easier to add new variables.

It does means we'll leak the memory for the array, but:

  1. This function is only called once per program.

  2. We're now leaking heap memory instead of wasting BSS on
     the static array.

Signed-off-by: Jeff King <peff@peff.net>
---
I actually think we can free pager_process.env after
start_command is run. You _cannot_ do so with argv, though,
and I'd rather leak this tiny bit than have a hard-to-track
assumption on memory lifetime buried here.

 pager.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/pager.c b/pager.c
index 0cc75a8..90d237e 100644
--- a/pager.c
+++ b/pager.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "argv-array.h"
 
 #ifndef DEFAULT_PAGER
 #define DEFAULT_PAGER "less"
@@ -63,6 +64,7 @@ const char *git_pager(int stdout_is_tty)
 void setup_pager(void)
 {
 	const char *pager = git_pager(isatty(1));
+	struct argv_array env = ARGV_ARRAY_INIT;
 
 	if (!pager || pager_in_use())
 		return;
@@ -80,17 +82,13 @@ void setup_pager(void)
 	pager_process.use_shell = 1;
 	pager_process.argv = pager_argv;
 	pager_process.in = -1;
-	if (!getenv("LESS") || !getenv("LV")) {
-		static const char *env[3];
-		int i = 0;
-
-		if (!getenv("LESS"))
-			env[i++] = "LESS=FRSX";
-		if (!getenv("LV"))
-			env[i++] = "LV=-c";
-		env[i] = NULL;
-		pager_process.env = env;
-	}
+
+	if (!getenv("LESS"))
+		argv_array_push(&env, "LESS=FRSX");
+	if (!getenv("LV"))
+		argv_array_push(&env, "LV=-c");
+	pager_process.env = argv_array_detach(&env, NULL);
+
 	if (start_command(&pager_process))
 		return;
 
-- 
1.8.5.2.500.g8060133
