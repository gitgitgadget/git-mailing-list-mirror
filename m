From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH v2] Improve portability: Cast pid_t's to intmax_t
Date: Sun, 31 Aug 2008 14:09:39 +0200
Message-ID: <1220184579-13808-1-git-send-email-sn_@gmx.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 14:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZllw-0003e0-WE
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 14:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758332AbYHaMJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 08:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758294AbYHaMJn
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 08:09:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:45761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758330AbYHaMJm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 08:09:42 -0400
Received: (qmail invoked by alias); 31 Aug 2008 12:09:39 -0000
Received: from p57AEC75A.dip.t-dialin.net (EHLO localhost.localdomain) [87.174.199.90]
  by mail.gmx.net (mp011) with SMTP; 31 Aug 2008 14:09:39 +0200
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX1+4K71s/u+48x/qo3BxWWk+HbEahlQKSaAbLLnAAo
	9Lk7vOwgYG7Xu/
X-Mailer: git-send-email 1.6.0.174.gd789c
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94475>

From: David Soria Parra <dsp@php.net>

Some systems (like e.g. OpenSolaris) define pid_t as long,
therefore all our sprintf that use %i/%d cause a compiler warning
beacuse of the implicit long->int cast. To make sure that
we fit the limits, we display pids as PRIuMAX and cast them explicitly
to uintmax_t.

Signed-off-by: David Soria Parra <dsp@php.net>
---

 Here is a revised version of the portability patch. It's based on next to
 avoid conflicts due to the style fixups in
 460c201039471d22194ca871290c098bfe6ce6a3.

 builtin-commit.c     |    2 +-
 builtin-fetch-pack.c |    2 +-
 daemon.c             |    6 +++---
 fast-import.c        |    6 +++---
 receive-pack.c       |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 4182686..8165bb3 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -320,7 +320,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 		die("unable to write new_index file");
 
 	fd = hold_lock_file_for_update(&false_lock,
-				       git_path("next-index-%d", getpid()), 1);
+				       git_path("next-index-%"PRIuMAX, (uintmax_t) getpid()), 1);
 
 	create_base_index();
 	add_remove_files(&partial);
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 273239a..17a5a42 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -540,7 +540,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
 			*av++ = "--fix-thin";
 		if (args.lock_pack || unpack_limit) {
 			int s = sprintf(keep_arg,
-					"--keep=fetch-pack %d on ", getpid());
+					"--keep=fetch-pack %"PRIuMAX " on ", (uintmax_t) getpid());
 			if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
 				strcpy(keep_arg + s, "localhost");
 			*av++ = keep_arg;
diff --git a/daemon.c b/daemon.c
index 23278e2..c315932 100644
--- a/daemon.c
+++ b/daemon.c
@@ -86,7 +86,7 @@ static void logreport(int priority, const char *err, va_list params)
 		 * Since stderr is set to linebuffered mode, the
 		 * logging of different processes will not overlap
 		 */
-		fprintf(stderr, "[%d] ", (int)getpid());
+		fprintf(stderr, "[%"PRIuMAX"] ", (uintmax_t)getpid());
 		vfprintf(stderr, err, params);
 		fputc('\n', stderr);
 	}
@@ -658,7 +658,7 @@ static void check_dead_children(void)
 		remove_child(pid);
 		if (!WIFEXITED(status) || (WEXITSTATUS(status) > 0))
 			dead = " (with error)";
-		loginfo("[%d] Disconnected%s", (int)pid, dead);
+		loginfo("[%"PRIuMAX"] Disconnected%s", (uintmax_t)pid, dead);
 	}
 }
 
@@ -923,7 +923,7 @@ static void store_pid(const char *path)
 	FILE *f = fopen(path, "w");
 	if (!f)
 		die("cannot open pid file %s: %s", path, strerror(errno));
-	if (fprintf(f, "%d\n", getpid()) < 0 || fclose(f) != 0)
+	if (fprintf(f, "%"PRIuMAX"\n", (uintmax_t) getpid()) < 0 || fclose(f) != 0)
 		die("failed to write pid file %s: %s", path, strerror(errno));
 }
 
diff --git a/fast-import.c b/fast-import.c
index d85b3a5..ccdf2e5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -376,7 +376,7 @@ static void dump_marks_helper(FILE *, uintmax_t, struct mark_set *);
 
 static void write_crash_report(const char *err)
 {
-	char *loc = git_path("fast_import_crash_%d", getpid());
+	char *loc = git_path("fast_import_crash_%"PRIuMAX, (uintmax_t) getpid());
 	FILE *rpt = fopen(loc, "w");
 	struct branch *b;
 	unsigned long lu;
@@ -390,8 +390,8 @@ static void write_crash_report(const char *err)
 	fprintf(stderr, "fast-import: dumping crash report to %s\n", loc);
 
 	fprintf(rpt, "fast-import crash report:\n");
-	fprintf(rpt, "    fast-import process: %d\n", getpid());
-	fprintf(rpt, "    parent process     : %d\n", getppid());
+	fprintf(rpt, "    fast-import process: %"PRIuMAX"\n", (uintmax_t) getpid());
+	fprintf(rpt, "    parent process     : %"PRIuMAX"\n", (uintmax_t) getppid());
 	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_LOCAL));
 	fputc('\n', rpt);
 
diff --git a/receive-pack.c b/receive-pack.c
index d44c19e..b81678a 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -407,7 +407,7 @@ static const char *unpack(void)
 		char keep_arg[256];
 		struct child_process ip;
 
-		s = sprintf(keep_arg, "--keep=receive-pack %i on ", getpid());
+		s = sprintf(keep_arg, "--keep=receive-pack %"PRIuMAX" on ", (uintmax_t) getpid());
 		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
 			strcpy(keep_arg + s, "localhost");
 
-- 
1.6.0.174.gd789c
