From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Fri, 24 Jul 2009 15:13:07 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907241505400.3960@localhost.localdomain>
References: <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <7vtz146mgr.fsf@alter.siamese.dyndns.org>
 <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
 <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Carlos R. Mafra" <crmafra2@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 00:14:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUT1j-0005pc-2a
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbZGXWN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbZGXWN7
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:13:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48080 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754779AbZGXWN6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 18:13:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6OMD86d007720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Jul 2009 15:13:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6OMD7jx029419;
	Fri, 24 Jul 2009 15:13:07 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123955>


On Fri, 24 Jul 2009, Linus Torvalds wrote:
> 
> ie we're talking a _huge_ hit in startup times for that curl support. 
> That's really really sad - especially considering how all the curl support 
> is for very random occasional stuff. I never use it myself, for example, 
> since I don't use http at all. And even for people who do, they only need 
> it for non-local operations.
> 
> I wonder if there is some way to only load the crazy curl stuff when we 
> actually want open a http: connection.

Here's the simple step#1: make 'git-http-fetch' be an external program 
rather than a built-in.

Sadly, I have no idea hot to turn the transport.c code into an external 
walker sanely (turn the ref/object walkers into an exec of an external 
program). So we still end up linking with curl. But maybe somebody 
(Daniel? Dscho?) who knows the transport code could try to make it an 
external process?

The performance angle of http fetching is non-existent, we really should 
try very hard to make the curl-dependent parts be in a binary of their 
own.

		Linus

---
>From 3cfc50d497266dc73a414ed1460b36b712ad10de Mon Sep 17 00:00:00 2001
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Jul 2009 14:54:55 -0700
Subject: [PATCH] git-http-fetch: not a builtin

We should really try to avoid having a dependency on the curl libraries
for the core 'git' executable. It adds huge overheads, for no advantage.

This splits up git-http-fetch so that it isn't built-in.  We still do
end up linking with curl for the git binary due to the transport.c http
walker, but that's at least partially an independent issue.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 Makefile                             |    8 +++++++-
 git.c                                |    3 ---
 builtin-http-fetch.c => http-fetch.c |    5 ++++-
 3 files changed, 11 insertions(+), 5 deletions(-)
 rename builtin-http-fetch.c => http-fetch.c (95%)

diff --git a/Makefile b/Makefile
index bde27ed..8cbd863 100644
--- a/Makefile
+++ b/Makefile
@@ -978,9 +978,12 @@ else
 	else
 		CURL_LIBCURL = -lcurl
 	endif
-	BUILTIN_OBJS += builtin-http-fetch.o
+	PROGRAMS += git-http-fetch$X
+
+	# FIXME! Sadly 'transport.c' still needs these for the builtin case
 	EXTLIBS += $(CURL_LIBCURL)
 	LIB_OBJS += http.o http-walker.o
+
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
@@ -1485,6 +1488,9 @@ git-imap-send$X: imap-send.o $(GITLIBS)
 
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
1.6.4.rc1.5.gb84f
