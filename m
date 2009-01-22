From: Jeff King <peff@peff.net>
Subject: [PATCH v2 5/5] pager: do wait_for_pager on signal death
Date: Thu, 22 Jan 2009 01:03:28 -0500
Message-ID: <20090122060328.GE30133@coredump.intra.peff.net>
References: <20090122042643.GB31427@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 07:04:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPsgS-0006qG-77
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 07:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842AbZAVGDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 01:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754777AbZAVGDb
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 01:03:31 -0500
Received: from peff.net ([208.65.91.99]:46680 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898AbZAVGDa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 01:03:30 -0500
Received: (qmail 24493 invoked by uid 107); 22 Jan 2009 06:03:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 22 Jan 2009 01:03:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jan 2009 01:03:28 -0500
Content-Disposition: inline
In-Reply-To: <20090122042643.GB31427@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106728>

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
Same as before.

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
1.6.1.403.g6c435
