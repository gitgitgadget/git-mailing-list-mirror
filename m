From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/3] trace.c: ensure NULL is not passed to printf
Date: Wed,  5 Jan 2011 18:30:01 -0600
Message-ID: <gmeXEearzUOUEst4-B2b8sVUo0XhywYUDm7rCJikom1xi9tIroh9GnJRv-bJTzbCbvqI-4DOU3A@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 06 01:46:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PadzL-0000XT-GC
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 01:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab1AFApT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 19:45:19 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49402 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab1AFAa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 19:30:29 -0500
Received: by mail.nrlssc.navy.mil id p060UK6S019971; Wed, 5 Jan 2011 18:30:20 -0600
X-OriginalArrivalTime: 06 Jan 2011 00:30:20.0026 (UTC) FILETIME=[E6176DA0:01CBAD38]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164614>

From: Brandon Casey <drafnel@gmail.com>

GNU printf, and many others, will print the string "(null)" if a NULL
pointer is passed as the argument to a "%s" format specifier.  Some
implementations (like on Solaris) do not detect a NULL pointer and will
produce a segfault in this case.

So, fix this by ensuring that pointer variables do not contain the value
NULL.  Assign the string "(null)" to the variables are NULL.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 trace.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/trace.c b/trace.c
index 02279b8..35d388d 100644
--- a/trace.c
+++ b/trace.c
@@ -154,6 +154,7 @@ static const char *quote_crnl(const char *path)
 /* FIXME: move prefix to startup_info struct and get rid of this arg */
 void trace_repo_setup(const char *prefix)
 {
+	const char *git_work_tree;
 	char cwd[PATH_MAX];
 	char *trace = getenv("GIT_TRACE");
 
@@ -164,8 +165,14 @@ void trace_repo_setup(const char *prefix)
 	if (!getcwd(cwd, PATH_MAX))
 		die("Unable to get current working directory");
 
+	if (!(git_work_tree = get_git_work_tree()))
+		git_work_tree = "(null)";
+
+	if (!prefix)
+		prefix = "(null)";
+
 	trace_printf("setup: git_dir: %s\n", quote_crnl(get_git_dir()));
-	trace_printf("setup: worktree: %s\n", quote_crnl(get_git_work_tree()));
+	trace_printf("setup: worktree: %s\n", quote_crnl(git_work_tree));
 	trace_printf("setup: cwd: %s\n", quote_crnl(cwd));
 	trace_printf("setup: prefix: %s\n", quote_crnl(prefix));
 }
-- 
1.7.3.1
