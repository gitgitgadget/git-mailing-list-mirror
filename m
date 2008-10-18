From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] parse-opt: migrate builtin-checkout-index.
Date: Sat, 18 Oct 2008 03:17:23 +0200
Message-ID: <1224292643-28704-1-git-send-email-vmiklos@frugalware.org>
References: <7v63nqg4f4.fsf@gitster.siamese.dyndns.org>
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 03:18:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr0SE-0001wZ-R6
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 03:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbYJRBQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 21:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbYJRBQy
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 21:16:54 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:35873 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbYJRBQx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 21:16:53 -0400
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id 5D095446CCD;
	Sat, 18 Oct 2008 03:16:50 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id DF1FE8B379; Sat, 18 Oct 2008 03:17:23 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <7v63nqg4f4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98511>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-checkout-index.c |  152 +++++++++++++++++++++++++---------------------
 1 files changed, 83 insertions(+), 69 deletions(-)

On Fri, Oct 17, 2008 at 04:58:23PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > +           { OPTION_CALLBACK, 'z', NULL, NULL, NULL,
> > +                   "paths are separated with NUL character",
> > +                   PARSE_OPT_NOARG, option_parse_z },
>
> This adds a new feature to say --no-z from the command line, doesn't
> it?
> And I suspect the feature is broken ;-).

Right, I fixed this in option_parse_z(). --no-z should set
line_termination to \n instead of 1.

> > +           OPT_BOOLEAN(0, "stdin", &read_from_stdin,
> > +                   "read list of paths from the standard input"),
> > ...
> > +   argc = parse_options(argc, argv, builtin_checkout_index_options,
> > +                   builtin_checkout_index_usage, 0);
> > +   state.force = force;
> > +   state.quiet = quiet;
> > +   state.not_new = not_new;
> > +   if (argc && read_from_stdin)
> > +           die("--stdin must be at the end");
>
> Is this comment still correct?  Do the original and your version act
> the
> same way when the user says "checkout --stdin -f", for example?  I
> suspect
> the original refused it and yours take it (and do much more sensible
> thing), which would be an improvement, but then the error message
> should
> be reworded perhaps?

Unless I missed something, that was a limitation of the option parser.
checkout-index --stdin -f works fine for me after removing those two
lines, so I left them out from the updated patch.

diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 4ba2702..0d534bc 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -40,6 +40,7 @@
 #include "cache.h"
 #include "quote.h"
 #include "cache-tree.h"
+#include "parse-options.h"
 
 #define CHECKOUT_ALL 4
 static int line_termination = '\n';
@@ -153,11 +154,58 @@ static void checkout_all(const char *prefix, int prefix_length)
 		exit(128);
 }
 
-static const char checkout_cache_usage[] =
-"git checkout-index [-u] [-q] [-a] [-f] [-n] [--stage=[123]|all] [--prefix=<string>] [--temp] [--] <file>...";
+static const char * const builtin_checkout_index_usage[] = {
+	"git checkout-index [options] [--] <file>...",
+	NULL
+};
 
 static struct lock_file lock_file;
 
+static int option_parse_u(const struct option *opt,
+			      const char *arg, int unset)
+{
+	int *newfd = opt->value;
+
+	state.refresh_cache = 1;
+	if (*newfd < 0)
+		*newfd = hold_locked_index(&lock_file, 1);
+	return 0;
+}
+
+static int option_parse_z(const struct option *opt,
+			  const char *arg, int unset)
+{
+	if (unset)
+		line_termination = '\n';
+	else
+		line_termination = 0;
+	return 0;
+}
+
+static int option_parse_prefix(const struct option *opt,
+			       const char *arg, int unset)
+{
+	state.base_dir = arg;
+	state.base_dir_len = strlen(arg);
+	return 0;
+}
+
+static int option_parse_stage(const struct option *opt,
+			      const char *arg, int unset)
+{
+	if (!strcmp(arg, "all")) {
+		to_tempfile = 1;
+		checkout_stage = CHECKOUT_ALL;
+	} else {
+		int ch = arg[0];
+		if ('1' <= ch && ch <= '3')
+			checkout_stage = arg[0] - '0';
+		else
+			die("stage should be between 1 and 3 or all");
+	}
+	return 0;
+}
+
 int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -165,6 +213,33 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	int all = 0;
 	int read_from_stdin = 0;
 	int prefix_length;
+	int force = 0, quiet = 0, not_new = 0;
+	struct option builtin_checkout_index_options[] = {
+		OPT_BOOLEAN('a', "all", &all,
+			"checks out all files in the index"),
+		OPT_BOOLEAN('f', "force", &force,
+			"forces overwrite of existing files"),
+		OPT__QUIET(&quiet),
+		OPT_BOOLEAN('n', "no-create", &not_new,
+			"don't checkout new files"),
+		{ OPTION_CALLBACK, 'u', "index", &newfd, NULL,
+			"update stat information in the index file",
+			PARSE_OPT_NOARG, option_parse_u },
+		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
+			"paths are separated with NUL character",
+			PARSE_OPT_NOARG, option_parse_z },
+		OPT_BOOLEAN(0, "stdin", &read_from_stdin,
+			"read list of paths from the standard input"),
+		OPT_BOOLEAN(0, "temp", &to_tempfile,
+			"write the content to temporary files"),
+		OPT_CALLBACK(0, "prefix", NULL, "string",
+			"when creating files, prepend <string>",
+			option_parse_prefix),
+		OPT_CALLBACK(0, "stage", NULL, NULL,
+			"copy out the files from named stage",
+			option_parse_stage),
+		OPT_END()
+	};
 
 	git_config(git_default_config, NULL);
 	state.base_dir = "";
@@ -174,72 +249,11 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		die("invalid cache");
 	}
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-
-		if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		if (!strcmp(arg, "-a") || !strcmp(arg, "--all")) {
-			all = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-f") || !strcmp(arg, "--force")) {
-			state.force = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet")) {
-			state.quiet = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-n") || !strcmp(arg, "--no-create")) {
-			state.not_new = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-u") || !strcmp(arg, "--index")) {
-			state.refresh_cache = 1;
-			if (newfd < 0)
-				newfd = hold_locked_index(&lock_file, 1);
-			continue;
-		}
-		if (!strcmp(arg, "-z")) {
-			line_termination = 0;
-			continue;
-		}
-		if (!strcmp(arg, "--stdin")) {
-			if (i != argc - 1)
-				die("--stdin must be at the end");
-			read_from_stdin = 1;
-			i++; /* do not consider arg as a file name */
-			break;
-		}
-		if (!strcmp(arg, "--temp")) {
-			to_tempfile = 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "--prefix=")) {
-			state.base_dir = arg+9;
-			state.base_dir_len = strlen(state.base_dir);
-			continue;
-		}
-		if (!prefixcmp(arg, "--stage=")) {
-			if (!strcmp(arg + 8, "all")) {
-				to_tempfile = 1;
-				checkout_stage = CHECKOUT_ALL;
-			} else {
-				int ch = arg[8];
-				if ('1' <= ch && ch <= '3')
-					checkout_stage = arg[8] - '0';
-				else
-					die("stage should be between 1 and 3 or all");
-			}
-			continue;
-		}
-		if (arg[0] == '-')
-			usage(checkout_cache_usage);
-		break;
-	}
+	argc = parse_options(argc, argv, builtin_checkout_index_options,
+			builtin_checkout_index_usage, 0);
+	state.force = force;
+	state.quiet = quiet;
+	state.not_new = not_new;
 
 	if (state.base_dir_len || to_tempfile) {
 		/* when --prefix is specified we do not
@@ -253,7 +267,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Check out named files first */
-	for ( ; i < argc; i++) {
+	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		const char *p;
 
-- 
1.6.0.2
