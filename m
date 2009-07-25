From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/3] git-http-fetch: not a builtin
Date: Sat, 25 Jul 2009 13:51:40 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907251335530.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 19:51:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUlPP-0006lO-Bl
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 19:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbZGYRvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 13:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZGYRvn
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 13:51:43 -0400
Received: from iabervon.org ([66.92.72.58]:45354 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbZGYRvl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 13:51:41 -0400
Received: (qmail 30895 invoked by uid 1000); 25 Jul 2009 17:51:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jul 2009 17:51:40 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124030>

From: Linus Torvalds <torvalds@linux-foundation.org>

This splits up git-http-fetch so that it isn't built-in.

It also removes the general dependency on curl, because it is no
longer used by any built-in code.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This is Linus's original patch, except that I actually dropped the -lcurl 
and such, since, between this and the beginning of my series, it is 
possible.

 Makefile                             |    8 ++++----
 git.c                                |    3 ---
 builtin-http-fetch.c => http-fetch.c |    5 ++++-
 3 files changed, 8 insertions(+), 8 deletions(-)
 rename builtin-http-fetch.c => http-fetch.c (95%)

diff --git a/Makefile b/Makefile
index d3dd2ed..3425336 100644
--- a/Makefile
+++ b/Makefile
@@ -979,10 +979,7 @@ else
 	else
 		CURL_LIBCURL = -lcurl
 	endif
-	BUILTIN_OBJS += builtin-http-fetch.o
-	PROGRAMS += git-shim-curl$X
-	EXTLIBS += $(CURL_LIBCURL)
-	LIB_OBJS += http.o http-walker.o
+	PROGRAMS += git-shim-curl$X git-http-fetch$X
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
@@ -1487,6 +1484,9 @@ git-imap-send$X: imap-send.o $(GITLIBS)
 
 http.o http-walker.o http-push.o transport.o: http.h
 
+git-http-fetch$X: revision.o http.o http-push.o $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
diff --git a/git.c b/git.c
index 807d875..c1e8f05 100644
--- a/git.c
+++ b/git.c
@@ -309,9 +309,6 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
 		{ "help", cmd_help },
-#ifndef NO_CURL
-		{ "http-fetch", cmd_http_fetch, RUN_SETUP },
-#endif
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
diff --git a/builtin-http-fetch.c b/http-fetch.c
similarity index 95%
rename from builtin-http-fetch.c
rename to http-fetch.c
index f3e63d7..e8f44ba 100644
--- a/builtin-http-fetch.c
+++ b/http-fetch.c
@@ -1,8 +1,9 @@
 #include "cache.h"
 #include "walker.h"
 
-int cmd_http_fetch(int argc, const char **argv, const char *prefix)
+int main(int argc, const char **argv)
 {
+	const char *prefix;
 	struct walker *walker;
 	int commits_on_stdin = 0;
 	int commits;
@@ -18,6 +19,8 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)
 	int get_verbosely = 0;
 	int get_recover = 0;
 
+	prefix = setup_git_directory();
+
 	git_config(git_default_config, NULL);
 
 	while (arg < argc && argv[arg][0] == '-') {
-- 
1.6.3.2.425.g3dedc
