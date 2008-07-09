From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] revisions: refactor handle_revision_opt into parse_revision_opt.
Date: Wed,  9 Jul 2008 23:38:34 +0200
Message-ID: <1215639514-1612-2-git-send-email-madcoder@debian.org>
References: <1215639514-1612-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 23:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGhNv-0006ES-UP
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 23:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbYGIVii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 17:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbYGIVii
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 17:38:38 -0400
Received: from pan.madism.org ([88.191.52.104]:57141 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbYGIVih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 17:38:37 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 31E583480F;
	Wed,  9 Jul 2008 23:38:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id EDA8485E6; Wed,  9 Jul 2008 23:38:34 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.428.gdce6.dirty
In-Reply-To: <1215639514-1612-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87920>

It seems we're using handle_revision_opt the same way each time, have a
wrapper around it that does the 9-liner we copy each time instead.

handle_revision_opt can be static in the module for now, it's always
possible to make it public again if needed.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-blame.c    |   11 +----------
 builtin-shortlog.c |   10 +---------
 revision.c         |   18 ++++++++++++++++--
 revision.h         |    7 +++++--
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 73d26c6..06c7de4 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2305,8 +2305,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	parse_options_start(&ctx, argc, argv, PARSE_OPT_KEEP_DASHDASH |
 			    PARSE_OPT_KEEP_ARGV0);
 	for (;;) {
-		int n;
-
 		switch (parse_options_step(&ctx, options, blame_opt_usage)) {
 		case PARSE_OPT_HELP:
 			exit(129);
@@ -2320,14 +2318,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			ctx.argv[0] = "--children";
 			reverse = 1;
 		}
-		n = handle_revision_opt(&revs, ctx.argc, ctx.argv,
-					&ctx.cpidx, ctx.out);
-		if (n <= 0) {
-			error("unknown option `%s'", ctx.argv[0]);
-			usage_with_options(blame_opt_usage, options);
-		}
-		ctx.argv += n;
-		ctx.argc -= n;
+		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
 	}
 parse_done:
 	argc = parse_options_end(&ctx);
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 9107bff..0136202 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -255,21 +255,13 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_KEEP_ARGV0);
 
 	for (;;) {
-		int n;
 		switch (parse_options_step(&ctx, options, shortlog_usage)) {
 		case PARSE_OPT_HELP:
 			exit(129);
 		case PARSE_OPT_DONE:
 			goto parse_done;
 		}
-		n = handle_revision_opt(&rev, ctx.argc, ctx.argv,
-					&ctx.cpidx, ctx.out);
-		if (n <= 0) {
-			error("unknown option `%s'", ctx.argv[0]);
-			usage_with_options(shortlog_usage, options);
-		}
-		ctx.argv += n;
-		ctx.argc -= n;
+		parse_revision_opt(&rev, &ctx, options, shortlog_usage);
 	}
 parse_done:
 	argc = parse_options_end(&ctx);
diff --git a/revision.c b/revision.c
index 9d5d933..bbd563e 100644
--- a/revision.c
+++ b/revision.c
@@ -974,8 +974,8 @@ static void add_ignore_packed(struct rev_info *revs, const char *name)
 	revs->ignore_packed[num] = NULL;
 }
 
-int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
-			int *unkc, const char **unkv)
+static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
+			       int *unkc, const char **unkv)
 {
 	const char *arg = argv[0];
 
@@ -1180,6 +1180,20 @@ int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 	return 1;
 }
 
+void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
+			const struct option *options,
+			const char * const usagestr[])
+{
+	int n = handle_revision_opt(revs, ctx->argc, ctx->argv,
+				    &ctx->cpidx, ctx->out);
+	if (n <= 0) {
+		error("unknown option `%s'", ctx->argv[0]);
+		usage_with_options(usagestr, options);
+	}
+	ctx->argv += n;
+	ctx->argc -= n;
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
diff --git a/revision.h b/revision.h
index cc80fcd..fa68c65 100644
--- a/revision.h
+++ b/revision.h
@@ -1,6 +1,8 @@
 #ifndef REVISION_H
 #define REVISION_H
 
+#include "parse-options.h"
+
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
 #define TREESAME	(1u<<2)
@@ -122,8 +124,9 @@ volatile show_early_output_fn_t show_early_output;
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
 extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
-extern int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
-			       int *unkc, const char **unkv);
+extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
+				 const struct option *options,
+				 const char * const usagestr[]);
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,int cant_be_filename);
 
 extern int prepare_revision_walk(struct rev_info *revs);
-- 
1.5.6.2.428.gdce6.dirty
