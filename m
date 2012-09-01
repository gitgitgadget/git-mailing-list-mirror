From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] fetch: use argv_array instead of hand-building arrays
Date: Sat, 1 Sep 2012 07:27:35 -0400
Message-ID: <20120901112735.GB19163@sigill.intra.peff.net>
References: <20120901112251.GA11445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <ossi@kde.org>
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 13:27:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7lrd-0007Pq-HT
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 13:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485Ab2IAL1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 07:27:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50821 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755423Ab2IAL1i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 07:27:38 -0400
Received: (qmail 27111 invoked by uid 107); 1 Sep 2012 11:27:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Sep 2012 07:27:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Sep 2012 07:27:35 -0400
Content-Disposition: inline
In-Reply-To: <20120901112251.GA11445@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204626>

Fetch invokes itself recursively when recursing into
submodules or handling "fetch --multiple". In both cases, it
builds the child's command line by pushing options onto a
statically-sized array. In both cases, the array is
currently just big enough to handle the largest possible
case. However, this technique is brittle and error-prone, so
let's replace it with a dynamic argv_array.

Signed-off-by: Jeff King <peff@peff.net>
---
Not very well tested by me, but hopefully it is simple enough that I
managed not to screw it up.

It may be that fetch_populated_submodules would also benefit from
conversion (here I just pass in the argc and argv separately), but I
didn't look.

 builtin/fetch.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bb9a074..b6a8be0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -14,6 +14,7 @@
 #include "transport.h"
 #include "submodule.h"
 #include "connected.h"
+#include "argv-array.h"
 
 static const char * const builtin_fetch_usage[] = {
 	"git fetch [<options>] [<repository> [<refspec>...]]",
@@ -841,38 +842,35 @@ static int fetch_multiple(struct string_list *list)
 	return 1;
 }
 
-static void add_options_to_argv(int *argc, const char **argv)
+static void add_options_to_argv(struct argv_array *argv)
 {
 	if (dry_run)
-		argv[(*argc)++] = "--dry-run";
+		argv_array_push(argv, "--dry-run");
 	if (prune)
-		argv[(*argc)++] = "--prune";
+		argv_array_push(argv, "--prune");
 	if (update_head_ok)
-		argv[(*argc)++] = "--update-head-ok";
+		argv_array_push(argv, "--update-head-ok");
 	if (force)
-		argv[(*argc)++] = "--force";
+		argv_array_push(argv, "--force");
 	if (keep)
-		argv[(*argc)++] = "--keep";
+		argv_array_push(argv, "--keep");
 	if (recurse_submodules == RECURSE_SUBMODULES_ON)
-		argv[(*argc)++] = "--recurse-submodules";
+		argv_array_push(argv, "--recurse-submodules");
 	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
-		argv[(*argc)++] = "--recurse-submodules=on-demand";
+		argv_array_push(argv, "--recurse-submodules=on-demand");
 	if (verbosity >= 2)
-		argv[(*argc)++] = "-v";
+		argv_array_push(argv, "-v");
 	if (verbosity >= 1)
-		argv[(*argc)++] = "-v";
+		argv_array_push(argv, "-v");
 	else if (verbosity < 0)
-		argv[(*argc)++] = "-q";
+		argv_array_push(argv, "-q");
 
 }
 
 static int fetch_multiple(struct string_list *list)
 {
 	int i, result = 0;
-	const char *argv[12] = { "fetch", "--append" };
-	int argc = 2;
-
-	add_options_to_argv(&argc, argv);
+	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	if (!append && !dry_run) {
 		int errcode = truncate_fetch_head();
@@ -880,18 +878,22 @@ static int fetch_multiple(struct string_list *list)
 			return errcode;
 	}
 
+	argv_array_pushl(&argv, "fetch", "--append", NULL);
+	add_options_to_argv(&argv);
+
 	for (i = 0; i < list->nr; i++) {
 		const char *name = list->items[i].string;
-		argv[argc] = name;
-		argv[argc + 1] = NULL;
+		argv_array_push(&argv, name);
 		if (verbosity >= 0)
 			printf(_("Fetching %s\n"), name);
-		if (run_command_v_opt(argv, RUN_GIT_CMD)) {
+		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
 			error(_("Could not fetch %s"), name);
 			result = 1;
 		}
+		argv_array_pop(&argv);
 	}
 
+	argv_array_clear(&argv);
 	return result;
 }
 
@@ -1007,13 +1009,14 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
-		const char *options[10];
-		int num_options = 0;
-		add_options_to_argv(&num_options, options);
-		result = fetch_populated_submodules(num_options, options,
+		struct argv_array options = ARGV_ARRAY_INIT;
+
+		add_options_to_argv(&options);
+		result = fetch_populated_submodules(options.argc, options.argv,
 						    submodule_prefix,
 						    recurse_submodules,
 						    verbosity < 0);
+		argv_array_clear(&options);
 	}
 
 	/* All names were strdup()ed or strndup()ed */
-- 
1.7.12.rc3.8.g89db099
