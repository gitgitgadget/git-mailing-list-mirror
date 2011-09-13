From: Jeff King <peff@peff.net>
Subject: [PATCH 7/7] run_hook: use argv_array API
Date: Tue, 13 Sep 2011 17:58:25 -0400
Message-ID: <20110913215824.GG24490@sigill.intra.peff.net>
References: <20110913215026.GA26743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 23:58:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3azu-0001ma-GA
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 23:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932Ab1IMV61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 17:58:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51547
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932834Ab1IMV61 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 17:58:27 -0400
Received: (qmail 2117 invoked by uid 107); 13 Sep 2011 21:59:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 17:59:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 17:58:25 -0400
Content-Disposition: inline
In-Reply-To: <20110913215026.GA26743@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181313>

This was a pretty straightforward use, so it really doesn't
save that many lines. Still, perhaps it's a little bit more
readable.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index 70e8a24..73e013e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "exec_cmd.h"
+#include "argv-array.h"
 
 static inline void close_pair(int fd[2])
 {
@@ -609,26 +610,23 @@ int finish_async(struct async *async)
 int run_hook(const char *index_file, const char *name, ...)
 {
 	struct child_process hook;
-	const char **argv = NULL, *env[2];
+	struct argv_array argv = ARGV_ARRAY_INIT;
+	const char *p, *env[2];
 	char index[PATH_MAX];
 	va_list args;
 	int ret;
-	size_t i = 0, alloc = 0;
 
 	if (access(git_path("hooks/%s", name), X_OK) < 0)
 		return 0;
 
 	va_start(args, name);
-	ALLOC_GROW(argv, i + 1, alloc);
-	argv[i++] = git_path("hooks/%s", name);
-	while (argv[i-1]) {
-		ALLOC_GROW(argv, i + 1, alloc);
-		argv[i++] = va_arg(args, const char *);
-	}
+	argv_array_push(&argv, git_path("hooks/%s", name));
+	while ((p = va_arg(args, const char *)))
+		argv_array_push(&argv, p);
 	va_end(args);
 
 	memset(&hook, 0, sizeof(hook));
-	hook.argv = argv;
+	hook.argv = argv.argv;
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
 	if (index_file) {
@@ -639,6 +637,6 @@ int run_hook(const char *index_file, const char *name, ...)
 	}
 
 	ret = run_command(&hook);
-	free(argv);
+	argv_array_clear(&argv);
 	return ret;
 }
-- 
1.7.7.rc1.2.gb2409
