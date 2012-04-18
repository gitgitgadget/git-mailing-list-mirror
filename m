From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: fix off-by-one in append_option
Date: Wed, 18 Apr 2012 12:18:50 -0700
Message-ID: <20120418191849.GA12619@sigill.intra.peff.net>
References: <20120417233255.GA24626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 21:19:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKaP5-0006n7-M2
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 21:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763Ab2DRTSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 15:18:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37937
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754727Ab2DRTSx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 15:18:53 -0400
Received: (qmail 19498 invoked by uid 107); 18 Apr 2012 19:19:02 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Apr 2012 15:19:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Apr 2012 12:18:50 -0700
Content-Disposition: inline
In-Reply-To: <20120417233255.GA24626@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195886>

On Tue, Apr 17, 2012 at 04:32:55PM -0700, Jeff King wrote:

> I noticed this when trying a "git gc --aggressive" with the current
> "next". The culprit is my 7e52f56 (gc: do not explode objects which will
> be immediately pruned) which adds two extra options to the repack
> invocation.
> 
> This patch is enough to fix it, as the current limit is big enough when
> the off-by-one error is removed.  The currentl limit is 10, which
> appears to have been pulled out of thin air by 0d7566a (Add --aggressive
> option to 'git gc', 2007-05-09) as "big enough".

Ugh, I take that back. If you do "git gc --aggressive -q", it will
overflow the arbitrary 10-element limit. So we need something else on
top, even if it's just bumping MAX_ADD.

> Obviously this would be much nicer with argv_array. Unfortunately, I
> don't think there is a way to have a nice initializer with argv_array.
> The current code looks like this:
> 
>   static const char *argv_repack[MAX_ADD] = {"repack", "-d", "-l", NULL };
> 
> and in an ideal world you would have something like:
> 
>   static struct argv_array argv_repack = ARGV_ARRAY_INIT("repack", "-d", "-l");
> 
> Of course that would involve variadic macros, which we can't count on.
> But even beyond that it's tough, because you are mixing static
> initialization with a dynamic structure. You can hack around that by
> copying the defaults during first push, but that's extra complexity, and
> the syntax is still ugly.

I've included a patch below that makes this look like:

  static const char repack_cmd[] = {"repack", "-d", "-l", NULL };
  static struct argv_array repack = ARGV_ARRAY_INIT_DEFAULT(repack_cmd);

which is way less nice than I would prefer, but I think may be the best
we can do with static initialization.

> What do you think of just:
> 
>   static struct argv_array argv_repack;
>   [...]
>   argv_init_from_string(&argv_repack, "repack -d -l");

I looked into this, but it seems our sq_dequote_* functions insist that
it be spelled "'repack' '-d' '-l'", so I would have to teach them to be
more liberal first.

Thoughts?

---
Here's the patch to do static initializers. I went ahead and converted
all of the commands in use. In addition to fixing repack, this gets rid
of some ugly constant indices in the prune command. The others don't
benefit immediately, but it makes tweaking them later much less
error-prone.

 argv-array.c |   10 +++++---
 argv-array.h |    1 +
 builtin/gc.c |   77 ++++++++++++++++++++++++----------------------------------
 3 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/argv-array.c b/argv-array.c
index a4e0420..cb96714 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -14,10 +14,14 @@ void argv_array_init(struct argv_array *array)
 
 static void argv_array_push_nodup(struct argv_array *array, const char *value)
 {
-	if (array->argv == empty_argv)
-		array->argv = NULL;
+	if (!array->alloc) {
+		const char **old = array->argv;
+		array->argv = xmalloc((array->argc + 2) * sizeof(*array->argv));
+		memcpy(array->argv, old, array->argc * sizeof(*array->argv));
+	}
+	else
+		ALLOC_GROW(array->argv, array->argc + 2, array->alloc);
 
-	ALLOC_GROW(array->argv, array->argc + 2, array->alloc);
 	array->argv[array->argc++] = value;
 	array->argv[array->argc] = NULL;
 }
diff --git a/argv-array.h b/argv-array.h
index 74dd2b1..60d5731 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -9,6 +9,7 @@ struct argv_array {
 	int alloc;
 };
 
+#define ARGV_ARRAY_INIT_DEFAULT(def) { (def), (ARRAY_SIZE(def)-1), 0 }
 #define ARGV_ARRAY_INIT { empty_argv, 0, 0 }
 
 void argv_array_init(struct argv_array *);
diff --git a/builtin/gc.c b/builtin/gc.c
index 1bc2fe3..69dc705 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -14,6 +14,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "argv-array.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -28,12 +29,16 @@ static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
 static const char *prune_expire = "2.weeks.ago";
 
-#define MAX_ADD 10
-static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
-static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
-static const char *argv_repack[MAX_ADD] = {"repack", "-d", "-l", NULL};
-static const char *argv_prune[] = {"prune", "--expire", NULL, NULL, NULL};
-static const char *argv_rerere[] = {"rerere", "gc", NULL};
+static const char *pack_refs_default[] = {"pack-refs", "--all", "--prune", NULL};
+static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT_DEFAULT(pack_refs_default);
+static const char *reflog_default[] = {"reflog", "expire", "--all", NULL};
+static struct argv_array reflog = ARGV_ARRAY_INIT_DEFAULT(reflog_default);
+static const char *repack_default[] = {"repack", "-d", "-l", NULL};
+static struct argv_array repack = ARGV_ARRAY_INIT_DEFAULT(repack_default);
+static const char *prune_default[] = {"prune", "--expire", NULL };
+static struct argv_array prune = ARGV_ARRAY_INIT_DEFAULT(prune_default);
+static const char *rerere_default[] = {"rerere", "gc", NULL};
+static struct argv_array rerere = ARGV_ARRAY_INIT_DEFAULT(rerere_default);
 
 static int gc_config(const char *var, const char *value, void *cb)
 {
@@ -67,19 +72,6 @@ static int gc_config(const char *var, const char *value, void *cb)
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
@@ -147,13 +139,11 @@ static int too_many_packs(void)
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
 
@@ -187,7 +177,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	int aggressive = 0;
 	int auto_gc = 0;
 	int quiet = 0;
-	char buf[80];
 
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, "suppress progress reporting"),
@@ -213,15 +202,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
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
@@ -239,25 +226,25 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
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
