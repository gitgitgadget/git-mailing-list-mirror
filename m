From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/16] add NO_EXTERNAL_GREP build option
Date: Thu, 13 Mar 2008 08:41:03 -0400
Message-ID: <20080313124103.GC19485@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net> <20080312213916.GK26286@coredump.intra.peff.net> <47D8DCC0.9090303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 13:41:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZmkm-0003fp-QY
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 13:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbYCMMlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 08:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbYCMMlI
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 08:41:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2723 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798AbYCMMlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 08:41:07 -0400
Received: (qmail 28772 invoked by uid 111); 13 Mar 2008 12:41:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 08:41:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 08:41:03 -0400
Content-Disposition: inline
In-Reply-To: <47D8DCC0.9090303@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77068>

On Thu, Mar 13, 2008 at 08:50:24AM +0100, Johannes Sixt wrote:

> > This might have fallouts for msysgit (i.e., they need to define
> > NO_EXTERNAL_GREP instead of relying on __unix__ not being defined).
> 
> You name it. Would you mind converting exec_grep() to use run_command(),
> too? Or better inline it since it won't do a lot more than run_command()?
> That way we at least won't get a broken git when I merge git.git that has
> this patch.

Junio's fixups should restore the automagic behavior, so you shouldn't
see any problems now, I think. But the run_command cleanup is sensible.

This is on top of what Junio has in pu.

-- >8 --
use run_command for external grep

The behavior should be identical, but there's no good reason
not to use our abstraction library.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-grep.c |   32 ++++----------------------------
 1 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index ef29910..44d9bac 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -11,6 +11,7 @@
 #include "tree-walk.h"
 #include "builtin.h"
 #include "grep.h"
+#include "run-command.h"
 
 #ifndef NO_EXTERNAL_GREP
 #ifdef __unix__
@@ -162,32 +163,6 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 }
 
 #if !NO_EXTERNAL_GREP
-static int exec_grep(int argc, const char **argv)
-{
-	pid_t pid;
-	int status;
-
-	argv[argc] = NULL;
-	pid = fork();
-	if (pid < 0)
-		return pid;
-	if (!pid) {
-		execvp("grep", (char **) argv);
-		exit(255);
-	}
-	while (waitpid(pid, &status, 0) < 0) {
-		if (errno == EINTR)
-			continue;
-		return -1;
-	}
-	if (WIFEXITED(status)) {
-		if (!WEXITSTATUS(status))
-			return 1;
-		return 0;
-	}
-	return -1;
-}
-
 #define MAXARGS 1000
 #define ARGBUF 4096
 #define push_arg(a) do { \
@@ -253,7 +228,8 @@ static int flush_grep(struct grep_opt *opt,
 		argc -= 2;
 	}
 
-	status = exec_grep(argc, argv);
+	argv[argc] = NULL;
+	status = run_command_v_opt(argv, 0);
 
 	if (kept_0) {
 		/*
@@ -264,7 +240,7 @@ static int flush_grep(struct grep_opt *opt,
 		argv[arg0++] = kept_0;
 		argv[arg0] = argv[argc+1];
 	}
-	return status;
+	return status == 0 ? 1 : -1;
 }
 
 static int external_grep(struct grep_opt *opt, const char **paths, int cached)
-- 
1.5.4.4.553.g83e84.dirty
