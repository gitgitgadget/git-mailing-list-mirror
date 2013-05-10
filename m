From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] Support running an arbitrary git action through checkout
Date: Fri, 10 May 2013 17:06:07 +0200
Message-ID: <2d5cfb3be9487f607051cad3d5230434660307ba.1368198269.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Steve Losh <steve@stevelosh.com>, Jeff King <peff@peff.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 17:06:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaotn-0001HY-RZ
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab3EJPGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:06:15 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:58809 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340Ab3EJPGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 11:06:15 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 10 May
 2013 17:06:03 +0200
Received: from linux-k42r.v.cablecom.net (213.221.117.227) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 10 May
 2013 17:06:11 +0200
X-Mailer: git-send-email 1.8.3.rc1.425.g49e5819
X-Originating-IP: [213.221.117.227]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223861>

[1] correctly observed that we are already wrapping three different
operations under the git-checkout command.  To lead that design -- and
the Koan -- to the obvious conclusion, some additional work is
required.

With this patch, you can say

  git checkout --reset foo      # reset HEAD to foo
  git checkout --bisect start   # begin a bisection
  git checkout --rebase master  # rebase the current branch on master

and so on for any git command.

Note that this actually shadows the long form of the existing --merge
option.  But since all reasonable Git users are extremely lazy typers,
they will just use the short form (-m) and this change is not expected
to cause them any problems.

[1] http://stevelosh.com/blog/2013/04/git-koans/

Cc: Steve Losh <steve@stevelosh.com>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 builtin/checkout.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f5b50e5..17419a2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -20,6 +20,8 @@
 #include "resolve-undo.h"
 #include "submodule.h"
 #include "argv-array.h"
+#include "help.h"
+#include "exec_cmd.h"
 
 static const char * const checkout_usage[] = {
 	N_("git checkout [options] <branch>"),
@@ -1071,6 +1073,25 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	if (argc > 1 && !prefixcmp(argv[1], "--")) {
+		const char *subcommand = argv[1] + 2;
+		struct cmdnames main_cmds, other_cmds;
+
+		memset(&main_cmds, 0, sizeof(main_cmds));
+		memset(&other_cmds, 0, sizeof(other_cmds));
+
+		load_command_list("git-", &main_cmds, &other_cmds);
+
+		if (is_in_cmdlist(&main_cmds, subcommand) ||
+		    is_in_cmdlist(&other_cmds, subcommand)) {
+			const char **args = xmalloc((argc) * sizeof(char*));
+			args[0] = subcommand;
+			memcpy(args+1, argv+2, argc*sizeof(char*));
+			args[argc] = NULL;
+			execv_git_cmd(args);
+		}
+	}
+
 	memset(&opts, 0, sizeof(opts));
 	memset(&new, 0, sizeof(new));
 	opts.overwrite_ignore = 1;
-- 
1.8.3.rc1.425.g49e5819
