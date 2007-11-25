From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] Use is_absolute_path() in diff-lib.c, lockfile.c, setup.c, trace.c
Date: Sun, 25 Nov 2007 23:29:03 +0100
Message-ID: <11960297431954-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 23:29:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwPyh-0007hJ-9a
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 23:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358AbXKYW3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 17:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754363AbXKYW3I
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 17:29:08 -0500
Received: from mailer.zib.de ([130.73.108.11]:54723 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756137AbXKYW3G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 17:29:06 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAPMT4XM017032
	for <git@vger.kernel.org>; Sun, 25 Nov 2007 23:29:04 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAPMT3BR015756;
	Sun, 25 Nov 2007 23:29:03 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66019>

Using the helper function to test for absolute paths makes porting easier.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 diff-lib.c |    2 +-
 lockfile.c |    2 +-
 setup.c    |    2 +-
 trace.c    |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

BTW, what happend to the msysgit related patches:

[PATCH 1/3] sha1_file.c: Fix size_t related printf format warnings
[PATCH 2/3] builtin-init-db: use get_git_dir() instead of getenv()

I never received comments about them, nor do I find them on pu.

    Steffen

diff --git a/diff-lib.c b/diff-lib.c
index f8e936a..d85d8f3 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -231,7 +231,7 @@ static int handle_diff_files_args(struct rev_info *revs,
 static int is_outside_repo(const char *path, int nongit, const char *prefix)
 {
 	int i;
-	if (nongit || !strcmp(path, "-") || path[0] == '/')
+	if (nongit || !strcmp(path, "-") || is_absolute_path(path))
 		return 1;
 	if (prefixcmp(path, "../"))
 		return 0;
diff --git a/lockfile.c b/lockfile.c
index 258fb3f..f45d3ed 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -94,7 +94,7 @@ static char *resolve_symlink(char *p, size_t s)
 			return p;
 		}
 
-		if (link[0] == '/') {
+		if (is_absolute_path(link)) {
 			/* absolute path simply replaces p */
 			if (link_len < s)
 				strcpy(p, link);
diff --git a/setup.c b/setup.c
index 43cd3f9..2c7b5cb 100644
--- a/setup.c
+++ b/setup.c
@@ -59,7 +59,7 @@ const char *prefix_path(const char *prefix, int len, const char *path)
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
 	static char path[PATH_MAX];
-	if (!pfx || !*pfx || arg[0] == '/')
+	if (!pfx || !*pfx || is_absolute_path(arg))
 		return arg;
 	memcpy(path, pfx, pfx_len);
 	strcpy(path + pfx_len, arg);
diff --git a/trace.c b/trace.c
index 0d89dbe..d3d1b6d 100644
--- a/trace.c
+++ b/trace.c
@@ -37,7 +37,7 @@ static int get_trace_fd(int *need_close)
 		return STDERR_FILENO;
 	if (strlen(trace) == 1 && isdigit(*trace))
 		return atoi(trace);
-	if (*trace == '/') {
+	if (is_absolute_path(trace)) {
 		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT, 0666);
 		if (fd == -1) {
 			fprintf(stderr,
-- 
1.5.3.6.878.g8c9e2
