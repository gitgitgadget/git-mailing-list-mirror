From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] gc: use argv-array for sub-commands
Date: Wed, 18 Apr 2012 14:10:19 -0700
Message-ID: <20120418211018.GC21301@sigill.intra.peff.net>
References: <20120418210740.GA21214@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:10:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKc8y-000559-SK
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 23:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab2DRVKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 17:10:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38008
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274Ab2DRVKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 17:10:22 -0400
Received: (qmail 20807 invoked by uid 107); 18 Apr 2012 21:10:31 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Apr 2012 17:10:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Apr 2012 14:10:19 -0700
Content-Disposition: inline
In-Reply-To: <20120418210740.GA21214@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195906>

git-gc executes many sub-commands. The argument list for
some of these is constant, but for others we add more
arguments at runtime. The latter is implemented by allocating
a constant extra number of NULLs, and either using a custom
append function, or just referencing unused slots by number.

As of commit 7e52f56, which added two new arguments, it is
possible to exceed the constant number of slots for "repack"
by running "git gc --aggressive", causing "git gc" to die.

This patch converts all of the static argv lists to use
argv-array. In addition to fixing the overflow caused by
7e52f56, it has a few advantages:

  1. We can drop the custom append function (which,
     incidentally, had an off-by-one error exacerbating the
     static limit).

  2. We can drop the ugly magic numbers used when adding
     arguments to "prune".

  3. Adding further arguments will be easier; you can just
     add new "push" calls without worrying about increasing
     any static limits.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/gc.c |   78 +++++++++++++++++++++++++---------------------------------
 1 file changed, 33 insertions(+), 45 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 1bc2fe3..9b4232c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -14,6 +14,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "argv-array.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -28,12 +29,11 @@ static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
 static const char *prune_expire = "2.weeks.ago";
 
-#define MAX_ADD 10
-static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
-static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
-static const char *argv_repack[MAX_ADD] = {"repack", "-d", "-l", NULL};
-static const char *argv_prune[] = {"prune", "--expire", NULL, NULL, NULL};
-static const char *argv_rerere[] = {"rerere", "gc", NULL};
+static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT;
+static struct argv_array reflog = ARGV_ARRAY_INIT;
+static struct argv_array repack = ARGV_ARRAY_INIT;
+static struct argv_array prune = ARGV_ARRAY_INIT;
+static struct argv_array rerere = ARGV_ARRAY_INIT;
 
 static int gc_config(const char *var, const char *value, void *cb)
 {
@@ -67,19 +67,6 @@ static int gc_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static void append_option(const char **cmd, const char *opt, int max_length)
-{
-	int i;
-
-	for (i = 0; cmd[i]; i++)
-		;
-
-	if (i + 2 >= max_length)
-		die(_("Too many options specified"));
-	cmd[i++] = opt;
-	cmd[i] = NULL;
-}
-
 static int too_many_loose_objects(void)
 {
 	/*
@@ -147,13 +134,11 @@ static int too_many_packs(void)
 static void add_repack_all_option(void)
 {
 	if (prune_expire && !strcmp(prune_expire, "now"))
-		append_option(argv_repack, "-a", MAX_ADD);
+		argv_array_push(&repack, "-a");
 	else {
-		append_option(argv_repack, "-A", MAX_ADD);
-		if (prune_expire) {
-			append_option(argv_repack, "--unpack-unreachable", MAX_ADD);
-			append_option(argv_repack, prune_expire, MAX_ADD);
-		}
+		argv_array_push(&repack, "-A");
+		if (prune_expire)
+			argv_array_pushf(&repack, "--unpack-unreachable=%s", prune_expire);
 	}
 }
 
@@ -187,7 +172,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	int aggressive = 0;
 	int auto_gc = 0;
 	int quiet = 0;
-	char buf[80];
 
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, "suppress progress reporting"),
@@ -202,6 +186,12 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
 
+	argv_array_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
+	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
+	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
+	argv_array_pushl(&prune, "prune", "--expire", NULL );
+	argv_array_pushl(&rerere, "rerere", "gc", NULL);
+
 	git_config(gc_config, NULL);
 
 	if (pack_refs < 0)
@@ -213,15 +203,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
 
 	if (aggressive) {
-		append_option(argv_repack, "-f", MAX_ADD);
-		append_option(argv_repack, "--depth=250", MAX_ADD);
-		if (aggressive_window > 0) {
-			sprintf(buf, "--window=%d", aggressive_window);
-			append_option(argv_repack, buf, MAX_ADD);
-		}
+		argv_array_push(&repack, "-f");
+		argv_array_push(&repack, "--depth=250");
+		if (aggressive_window > 0)
+			argv_array_pushf(&repack, "--window=%d", aggressive_window);
 	}
 	if (quiet)
-		append_option(argv_repack, "-q", MAX_ADD);
+		argv_array_push(&repack, "-q");
 
 	if (auto_gc) {
 		/*
@@ -239,25 +227,25 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	} else
 		add_repack_all_option();
 
-	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
-		return error(FAILED_RUN, argv_pack_refs[0]);
+	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
+		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
 
-	if (run_command_v_opt(argv_reflog, RUN_GIT_CMD))
-		return error(FAILED_RUN, argv_reflog[0]);
+	if (run_command_v_opt(reflog.argv, RUN_GIT_CMD))
+		return error(FAILED_RUN, reflog.argv[0]);
 
-	if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
-		return error(FAILED_RUN, argv_repack[0]);
+	if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
+		return error(FAILED_RUN, repack.argv[0]);
 
 	if (prune_expire) {
-		argv_prune[2] = prune_expire;
+		argv_array_push(&prune, prune_expire);
 		if (quiet)
-			argv_prune[3] = "--no-progress";
-		if (run_command_v_opt(argv_prune, RUN_GIT_CMD))
-			return error(FAILED_RUN, argv_prune[0]);
+			argv_array_push(&prune, "--no-progress");
+		if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
+			return error(FAILED_RUN, prune.argv[0]);
 	}
 
-	if (run_command_v_opt(argv_rerere, RUN_GIT_CMD))
-		return error(FAILED_RUN, argv_rerere[0]);
+	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
+		return error(FAILED_RUN, rerere.argv[0]);
 
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
-- 
1.7.9.6.8.g992e5
