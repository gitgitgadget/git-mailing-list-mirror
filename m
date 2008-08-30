From: David Soria Parra <dsoria@gmx.net>
Subject: Re: [PATCH 1/2] Improvate portability: Display pid_t's always as
 long
Date: Sat, 30 Aug 2008 22:40:31 +0200
Message-ID: <48B9B03F.1080304@gmx.net>
References: <1219858743-4476-1-git-send-email-sn_@gmx.net> <1219858743-4476-2-git-send-email-sn_@gmx.net> <7vsksqp9f1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Soria Parra <dsp@php.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 22:41:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXGM-0000bB-Lh
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 22:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbYH3Ukd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 16:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbYH3Ukd
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 16:40:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:49515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754003AbYH3Ukc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 16:40:32 -0400
Received: (qmail invoked by alias); 30 Aug 2008 20:40:30 -0000
Received: from p57AEE144.dip.t-dialin.net (EHLO [192.168.1.116]) [87.174.225.68]
  by mail.gmx.net (mp061) with SMTP; 30 Aug 2008 22:40:30 +0200
X-Authenticated: #235172
X-Provags-ID: V01U2FsdGVkX18BGn0LtUsBflQH6Y2cMzlhYr9H1XnR8MZtYD/osy
	qooGxH7gLGg2tG
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7vsksqp9f1.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94420>


 > On the other hand, if you are shooting for maximum compatibility perhaps
 > you may want to cast it to "intmax_t" and format as such.
Yes, good point, casting to long isn't enough. I think it's a good approach to cast the pids to intmax_t as pids
are also used in git_path() and therefore might result in equal paths for separate processes if
the pid is higher than int.

so here is an updated patch:

 From da5519b3ae5ce84c703aeaab2bc4ea363897c334 Mon Sep 17 00:00:00 2001
From: David Soria Parra <dsp at>
Date: Fri, 29 Aug 2008 01:19:43 +0200
Subject: [PATCH] Improvate portability: Cast pid_t's to intmax_t

Some systems (like e.g. OpenSolaris) define pid_t as long,
therefore all our sprintf that use %i cause a compiler warning
beacuse if the implicit long->int cast. So to make sure that
we fit the limits we display pids as intmax_t and cast them explicitly.

Signed-off-by: David Soria Parra <dsp@php.net>
---
  builtin-commit.c     |    2 +-
  builtin-fetch-pack.c |    2 +-
  daemon.c             |    6 +++---
  fast-import.c        |    6 +++---
  receive-pack.c       |    2 +-
  5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index c870037..90ef3d5 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -320,7 +320,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
  		die("unable to write new_index file");

  	fd = hold_lock_file_for_update(&false_lock,
-				       git_path("next-index-%d", getpid()), 1);
+				       git_path("next-index-%jd", (intmax_t) getpid()), 1);

  	create_base_index();
  	add_remove_files(&partial);
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 273239a..91616e7 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -540,7 +540,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
  			*av++ = "--fix-thin";
  		if (args.lock_pack || unpack_limit) {
  			int s = sprintf(keep_arg,
-					"--keep=fetch-pack %d on ", getpid());
+					"--keep=fetch-pack %jd on ", (intmax_t) getpid());
  			if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
  				strcpy(keep_arg + s, "localhost");
  			*av++ = keep_arg;
diff --git a/daemon.c b/daemon.c
index 23278e2..6081986 100644
--- a/daemon.c
+++ b/daemon.c
@@ -86,7 +86,7 @@ static void logreport(int priority, const char *err, va_list params)
  		 * Since stderr is set to linebuffered mode, the
  		 * logging of different processes will not overlap
  		 */
-		fprintf(stderr, "[%d] ", (int)getpid());
+		fprintf(stderr, "[%jd] ", (intmax_t)getpid());
  		vfprintf(stderr, err, params);
  		fputc('\n', stderr);
  	}
@@ -658,7 +658,7 @@ static void check_dead_children(void)
  		remove_child(pid);
  		if (!WIFEXITED(status) || (WEXITSTATUS(status) > 0))
  			dead = " (with error)";
-		loginfo("[%d] Disconnected%s", (int)pid, dead);
+		loginfo("[%jd] Disconnected%s", (intmax_t)pid, dead);
  	}
  }

@@ -923,7 +923,7 @@ static void store_pid(const char *path)
  	FILE *f = fopen(path, "w");
  	if (!f)
  		die("cannot open pid file %s: %s", path, strerror(errno));
-	if (fprintf(f, "%d\n", getpid()) < 0 || fclose(f) != 0)
+	if (fprintf(f, "%jd\n", (intmax_t) getpid()) < 0 || fclose(f) != 0)
  		die("failed to write pid file %s: %s", path, strerror(errno));
  }

diff --git a/fast-import.c b/fast-import.c
index 7089e6f..e3a6510 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -376,7 +376,7 @@ static void dump_marks_helper(FILE *, uintmax_t, struct mark_set *);

  static void write_crash_report(const char *err)
  {
-	char *loc = git_path("fast_import_crash_%d", getpid());
+	char *loc = git_path("fast_import_crash_%jd", (intmax_t) getpid());
  	FILE *rpt = fopen(loc, "w");
  	struct branch *b;
  	unsigned long lu;
@@ -390,8 +390,8 @@ static void write_crash_report(const char *err)
  	fprintf(stderr, "fast-import: dumping crash report to %s\n", loc);

  	fprintf(rpt, "fast-import crash report:\n");
-	fprintf(rpt, "    fast-import process: %d\n", getpid());
-	fprintf(rpt, "    parent process     : %d\n", getppid());
+	fprintf(rpt, "    fast-import process: %jd\n", (intmax_t) getpid());
+	fprintf(rpt, "    parent process     : %jd\n", (intmax_t) getppid());
  	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_LOCAL));
  	fputc('\n', rpt);

diff --git a/receive-pack.c b/receive-pack.c
index d44c19e..ec770d0 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -407,7 +407,7 @@ static const char *unpack(void)
  		char keep_arg[256];
  		struct child_process ip;

-		s = sprintf(keep_arg, "--keep=receive-pack %i on ", getpid());
+		s = sprintf(keep_arg, "--keep=receive-pack %ji on ", (intmax_t) getpid());
  		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
  			strcpy(keep_arg + s, "localhost");

-- 
1.6.0.174.gd789c
