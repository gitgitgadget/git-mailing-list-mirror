From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 03/13] git-http-fetch: not a builtin
Date: Wed, 5 Aug 2009 01:01:59 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908050054480.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:02:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYe4-0007Gg-RJ
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 07:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbZHEFCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 01:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbZHEFCC
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 01:02:02 -0400
Received: from iabervon.org ([66.92.72.58]:36998 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547AbZHEFCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 01:02:00 -0400
Received: (qmail 18271 invoked by uid 1000); 5 Aug 2009 05:01:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 05:01:59 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

This splits up git-http-fetch so that it isn't built-in.

It also removes the general dependency on curl, because it is no
longer used by any built-in code. Because they are no longer LIB_OBJS,
add LIB_H to the dependencies of http-related object files, and remove
http.h from the dependencies of transport.o

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile                             |   10 ++++++----
 git.c                                |    3 ---
 builtin-http-fetch.c => http-fetch.c |    5 ++++-
 3 files changed, 10 insertions(+), 8 deletions(-)
 rename builtin-http-fetch.c => http-fetch.c (95%)

diff --git a/Makefile b/Makefile
index 35117fc..0ebf9dd 100644
--- a/Makefile
+++ b/Makefile
@@ -980,10 +980,7 @@ else
 	else
 		CURL_LIBCURL = -lcurl
 	endif
-	BUILTIN_OBJS += builtin-http-fetch.o
 	PROGRAMS += git-remote-http$X git-remote-https$X git-remote-ftp$X git-http-fetch$X
-	EXTLIBS += $(CURL_LIBCURL)
-	LIB_OBJS += http.o http-walker.o
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
@@ -1486,8 +1483,13 @@ git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
 
-http.o http-walker.o http-push.o transport.o: http.h
+http.o http-walker.o http-push.o: http.h
 
+http.o http-walker.o: $(LIB_H)
+
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
1.6.4.rc3.27.g95032.dirty
