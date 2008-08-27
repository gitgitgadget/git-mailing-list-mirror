From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH 1/2] Improvate portability: Display pid_t's always as long
Date: Wed, 27 Aug 2008 19:39:02 +0200
Message-ID: <1219858743-4476-2-git-send-email-sn_@gmx.net>
References: <1219858743-4476-1-git-send-email-sn_@gmx.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 19:40:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYP0C-0007ze-Ir
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 19:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbYH0RjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 13:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYH0RjJ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 13:39:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:49316 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751628AbYH0RjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 13:39:06 -0400
Received: (qmail invoked by alias); 27 Aug 2008 17:39:03 -0000
Received: from p57AEDFED.dip.t-dialin.net (EHLO localhost.localdomain) [87.174.223.237]
  by mail.gmx.net (mp038) with SMTP; 27 Aug 2008 19:39:03 +0200
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX1/j9XlxwjfjzepWMJhiEbPOHK+OHQAg4RttvpX4me
	G+AZI7slYEMi38
X-Mailer: git-send-email 1.6.0.174.gd789c
In-Reply-To: <1219858743-4476-1-git-send-email-sn_@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93906>

From: David Soria Parra <dsp@php.net>

Some systems (like e.g. OpenSolaris) define pid_t as long,
therefore all our sprintf that use %i cause a compiler warning
beacuse if the implicit long->int cast. So to make sure that
we fit the limits we display pids as longs and cast them explicitly.

Signed-off-by: David Soria Parra <dsp@php.net>
---
 builtin-commit.c     |    2 +-
 builtin-fetch-pack.c |    2 +-
 daemon.c             |    2 +-
 fast-import.c        |    6 +++---
 receive-pack.c       |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 649c8be..b4c940f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -320,7 +320,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 		die("unable to write new_index file");
 
 	fd = hold_lock_file_for_update(&false_lock,
-				       git_path("next-index-%d", getpid()), 1);
+				       git_path("next-index-%ld", (long) getpid()), 1);
 
 	create_base_index();
 	add_remove_files(&partial);
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 273239a..46bb3e2 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -540,7 +540,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
 			*av++ = "--fix-thin";
 		if (args.lock_pack || unpack_limit) {
 			int s = sprintf(keep_arg,
-					"--keep=fetch-pack %d on ", getpid());
+					"--keep=fetch-pack %ld on ", (long) getpid());
 			if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
 				strcpy(keep_arg + s, "localhost");
 			*av++ = keep_arg;
diff --git a/daemon.c b/daemon.c
index 23278e2..1e5cb58 100644
--- a/daemon.c
+++ b/daemon.c
@@ -923,7 +923,7 @@ static void store_pid(const char *path)
 	FILE *f = fopen(path, "w");
 	if (!f)
 		die("cannot open pid file %s: %s", path, strerror(errno));
-	if (fprintf(f, "%d\n", getpid()) < 0 || fclose(f) != 0)
+	if (fprintf(f, "%ld\n", (long) getpid()) < 0 || fclose(f) != 0)
 		die("failed to write pid file %s: %s", path, strerror(errno));
 }
 
diff --git a/fast-import.c b/fast-import.c
index 7089e6f..e04ed94 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -376,7 +376,7 @@ static void dump_marks_helper(FILE *, uintmax_t, struct mark_set *);
 
 static void write_crash_report(const char *err)
 {
-	char *loc = git_path("fast_import_crash_%d", getpid());
+	char *loc = git_path("fast_import_crash_%ld", (long) getpid());
 	FILE *rpt = fopen(loc, "w");
 	struct branch *b;
 	unsigned long lu;
@@ -390,8 +390,8 @@ static void write_crash_report(const char *err)
 	fprintf(stderr, "fast-import: dumping crash report to %s\n", loc);
 
 	fprintf(rpt, "fast-import crash report:\n");
-	fprintf(rpt, "    fast-import process: %d\n", getpid());
-	fprintf(rpt, "    parent process     : %d\n", getppid());
+	fprintf(rpt, "    fast-import process: %ld\n", (long) getpid());
+	fprintf(rpt, "    parent process     : %ld\n", (long) getppid());
 	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_LOCAL));
 	fputc('\n', rpt);
 
diff --git a/receive-pack.c b/receive-pack.c
index d44c19e..0a82f73 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -407,7 +407,7 @@ static const char *unpack(void)
 		char keep_arg[256];
 		struct child_process ip;
 
-		s = sprintf(keep_arg, "--keep=receive-pack %i on ", getpid());
+		s = sprintf(keep_arg, "--keep=receive-pack %li on ", (long) getpid());
 		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
 			strcpy(keep_arg + s, "localhost");
 
-- 
1.6.0.174.gd789c
