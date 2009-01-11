From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] pager: do wait_for_pager on signal death
Date: Sun, 11 Jan 2009 06:36:49 -0500
Message-ID: <20090111113649.GD29791@coredump.intra.peff.net>
References: <20090111112222.GA29656@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Jan 11 12:38:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLydz-0002cG-3o
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 12:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbZAKLgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 06:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbZAKLgv
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 06:36:51 -0500
Received: from peff.net ([208.65.91.99]:60619 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbZAKLgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 06:36:51 -0500
Received: (qmail 22794 invoked by uid 107); 11 Jan 2009 11:36:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Jan 2009 06:36:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Jan 2009 06:36:49 -0500
Content-Disposition: inline
In-Reply-To: <20090111112222.GA29656@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105170>

Since ea27a18 (spawn pager via run_command interface), the
original git process actually does git work, and the pager
is a child process (actually, on Windows it has always been
that way, since Windows lacks fork). After spawning the
pager, we register an atexit() handler that waits for the
pager to finish.

Unfortunately, that handler does not always run. In
particular, if git is killed by a signal, then we exit
immediately. The calling shell then thinks that git is done;
however, the pager is still trying to run and impact the
terminal. The result can be seen by running a long git
process with a pager (e.g., "git log -p") and hitting ^C.
Depending on your config, you should see the shell prompt,
but pressing a key causes the pager to do any terminal
de-initialization sequence.

This patch just intercepts any death-dealing signals and
waits for the pager before dying. Under typical less
configuration, that means hitting ^C will cause git to stop
generating output, but the pager will keep running.

Signed-off-by: Jeff King <peff@peff.net>
---
 pager.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/pager.c b/pager.c
index f19ddbc..4921843 100644
--- a/pager.c
+++ b/pager.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "run-command.h"
+#include "sigchain.h"
 
 /*
  * This is split up from the rest of git so that we can do
@@ -38,6 +39,13 @@ static void wait_for_pager(void)
 	finish_command(&pager_process);
 }
 
+static void wait_for_pager_signal(int signo)
+{
+	wait_for_pager();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 void setup_pager(void)
 {
 	const char *pager = getenv("GIT_PAGER");
@@ -75,6 +83,7 @@ void setup_pager(void)
 	close(pager_process.in);
 
 	/* this makes sure that the parent terminates after the pager */
+	sigchain_push_common(wait_for_pager_signal);
 	atexit(wait_for_pager);
 }
 
-- 
1.6.1.84.g8150
