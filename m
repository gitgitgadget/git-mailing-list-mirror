From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] prune: handle --progress/no-progress
Date: Tue, 8 Nov 2011 00:34:08 -0500
Message-ID: <20111108053407.GA16852@sigill.intra.peff.net>
References: <20111108053149.GA29643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 06:34:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNeK7-00080K-1V
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 06:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301Ab1KHFeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 00:34:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36064
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab1KHFeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 00:34:10 -0500
Received: (qmail 918 invoked by uid 107); 8 Nov 2011 05:34:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 00:34:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 00:34:08 -0500
Content-Disposition: inline
In-Reply-To: <20111108053149.GA29643@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185068>

And have "git gc" pass no-progress when quiet.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of the prune progress patch you sent earlier.

I did these as separate patches so you could see each change, but I'd
also be fine if they are just squashed into your patch.

 builtin/gc.c    |    4 +++-
 builtin/prune.c |   11 +++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 0498094..271376d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,7 +32,7 @@
 static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
 static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
 static const char *argv_repack[MAX_ADD] = {"repack", "-d", "-l", NULL};
-static const char *argv_prune[] = {"prune", "--expire", NULL, NULL};
+static const char *argv_prune[] = {"prune", "--expire", NULL, NULL, NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
 
 static int gc_config(const char *var, const char *value, void *cb)
@@ -243,6 +243,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (prune_expire) {
 		argv_prune[2] = prune_expire;
+		if (quiet)
+			argv_prune[3] = "--no-progress";
 		if (run_command_v_opt(argv_prune, RUN_GIT_CMD))
 			return error(FAILED_RUN, argv_prune[0]);
 	}
diff --git a/builtin/prune.c b/builtin/prune.c
index 6b39d3f..58d7cb8 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -15,6 +15,7 @@
 static int show_only;
 static int verbose;
 static unsigned long expire;
+static int show_progress = -1;
 
 static int prune_tmp_object(const char *path, const char *filename)
 {
@@ -125,10 +126,11 @@ static void remove_temporary_files(const char *path)
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-	struct progress *progress;
+	struct progress *progress = NULL;
 	const struct option options[] = {
 		OPT__DRY_RUN(&show_only, "do not remove, show only"),
 		OPT__VERBOSE(&verbose, "report pruned objects"),
+		OPT_BOOL(0, "progress", &show_progress, "show progress"),
 		OPT_DATE(0, "expire", &expire,
 			 "expire objects older than <time>"),
 		OPT_END()
@@ -154,7 +156,12 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		else
 			die("unrecognized argument: %s", name);
 	}
-	progress = start_progress_delay("Checking connectivity", 0, 0, 2);
+
+	if (show_progress == -1)
+		show_progress = isatty(2);
+	if (show_progress)
+		progress = start_progress_delay("Checking connectivity", 0, 0, 2);
+
 	mark_reachable_objects(&revs, 1, progress);
 	stop_progress(&progress);
 	prune_object_dir(get_object_directory());
-- 
1.7.7.2.7.g9f96f.dirty
