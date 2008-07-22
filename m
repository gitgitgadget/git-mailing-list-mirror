From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] spawn pager via run_command interface
Date: Tue, 22 Jul 2008 03:14:12 -0400
Message-ID: <20080722071411.GB3584@sigill.intra.peff.net>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net> <20080722053921.GA4983@glandium.org> <20080722060643.GA25023@sigill.intra.peff.net> <20080722061807.GA6714@glandium.org> <20080722064603.GA25221@sigill.intra.peff.net> <20080722071009.GA3610@sigill.intra.peff.net> <20080722071246.GA3584@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:15:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLC5a-0004EF-In
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbYGVHOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbYGVHOO
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:14:14 -0400
Received: from peff.net ([208.65.91.99]:2239 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbYGVHOM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:14:12 -0400
Received: (qmail 3250 invoked by uid 111); 22 Jul 2008 07:14:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 03:14:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 03:14:12 -0400
Content-Disposition: inline
In-Reply-To: <20080722071246.GA3584@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89452>

This has two important effects:

 1. The pager is now the _child_ process, instead of the
    parent. This means that whatever spawned git (e.g., the
    shell) will see the exit code of the git process, and
    not the pager.

 2. The mingw and regular code are now unified, which makes
    the setup_pager function much simpler.

There are two caveats:

 1. We used to call execlp directly on the pager, followed
    by trying to exec it via the shall. We now just use the
    shell (which is what mingw has always done). This may
    have different results for pager names which contain
    shell metacharacters.

    It is also slightly less efficient because we
    unnecessarily run the shell; however, pager spawning is
    by definition an interactive task, so it shouldn't be
    a huge problem.

 2. The git process will remain in memory while the user
    looks through the pager. This is potentially wasteful.
    We could get around this by turning the parent into a
    meta-process which spawns _both_ git and the pager,
    collects the exit status from git, waits for both to
    end, and then exits with git's exit code.
---
 pager.c |   49 ++++++++-----------------------------------------
 1 files changed, 8 insertions(+), 41 deletions(-)

diff --git a/pager.c b/pager.c
index 6b5c9e4..7743742 100644
--- a/pager.c
+++ b/pager.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "run-command.h"
 
 /*
  * This is split up from the rest of git so that we can do
@@ -8,7 +9,7 @@
 static int spawned_pager;
 
 #ifndef __MINGW32__
-static void run_pager(const char *pager)
+static void pager_preexec(void)
 {
 	/*
 	 * Work around bug in "less" by not starting it until we
@@ -20,16 +21,17 @@ static void run_pager(const char *pager)
 	FD_SET(0, &in);
 	select(1, &in, NULL, &in, NULL);
 
-	execlp(pager, pager, NULL);
-	execl("/bin/sh", "sh", "-c", pager, NULL);
+	setenv("LESS", "FRSX", 0);
 }
-#else
-#include "run-command.h"
+#endif
 
 static const char *pager_argv[] = { "sh", "-c", NULL, NULL };
 static struct child_process pager_process = {
 	.argv = pager_argv,
-	.in = -1
+	.in = -1,
+#ifndef __MINGW32__
+	.preexec_cb = pager_preexec,
+#endif
 };
 static void wait_for_pager(void)
 {
@@ -40,14 +42,9 @@ static void wait_for_pager(void)
 	close(2);
 	finish_command(&pager_process);
 }
-#endif
 
 void setup_pager(void)
 {
-#ifndef __MINGW32__
-	pid_t pid;
-	int fd[2];
-#endif
 	const char *pager = getenv("GIT_PAGER");
 
 	if (!isatty(1))
@@ -66,35 +63,6 @@ void setup_pager(void)
 
 	spawned_pager = 1; /* means we are emitting to terminal */
 
-#ifndef __MINGW32__
-	if (pipe(fd) < 0)
-		return;
-	pid = fork();
-	if (pid < 0) {
-		close(fd[0]);
-		close(fd[1]);
-		return;
-	}
-
-	/* return in the child */
-	if (!pid) {
-		dup2(fd[1], 1);
-		dup2(fd[1], 2);
-		close(fd[0]);
-		close(fd[1]);
-		return;
-	}
-
-	/* The original process turns into the PAGER */
-	dup2(fd[0], 0);
-	close(fd[0]);
-	close(fd[1]);
-
-	setenv("LESS", "FRSX", 0);
-	run_pager(pager);
-	die("unable to execute pager '%s'", pager);
-	exit(255);
-#else
 	/* spawn the pager */
 	pager_argv[2] = pager;
 	if (start_command(&pager_process))
@@ -107,7 +75,6 @@ void setup_pager(void)
 
 	/* this makes sure that the parent terminates after the pager */
 	atexit(wait_for_pager);
-#endif
 }
 
 int pager_in_use(void)
-- 
1.6.0.rc0.1.g9291f.dirty
