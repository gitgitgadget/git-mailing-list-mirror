From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 05/17] Parse the -L options
Date: Wed, 11 Aug 2010 23:03:30 +0800
Message-ID: <1281539022-31616-6-git-send-email-struggleyb.nku@gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:05:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCrU-00050d-Hj
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab0HKPEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:04:51 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56122 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab0HKPEt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:04:49 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so73597pzk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2Bf5RG/5N8U88yjcOzu6KguKBV3RN3fozLJsyAhlabQ=;
        b=ejoCdJ0cLhHMDZXtrUrdIHLaEdGYca0xrb7T/hh0I5czLvGjxAewQYVkk4luWa5mkA
         BbGqnhy+oEyJ5BNq5yfOGj+6H8F7b3zmBIe38J8CAgXDp/WPbmtrluaGZTyeafPPnDaV
         W3qqurwXPfo44egPebKts10oRkkj37A4IoW/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nR36aBqvZGNiYYkJ+dGQWsXTOXmQ5OdTFx8hc4iKMMrWxgpo12JZaYU6xlVSlkyQwe
         rGk8Z9mhZpT5uA/z0XntDDx/62yPXcxK6NvLS/vxEidSW0kEMKesBtLKsIkd9gj1caos
         7UoACJWHhUz2+e0Ufl8SH2pS6Sqt5WDS1caI4=
Received: by 10.114.59.1 with SMTP id h1mr22110214waa.28.1281539089549;
        Wed, 11 Aug 2010 08:04:49 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.04.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:04:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153243>

With the two new APIs of parse options added in the previous
commit, we parse the multiple '-L n,m <pathspec>' syntax.

Notice that users can give more than one '-L n,m' for each pathspec.
And a pathspec with all its '-L' options maps to a single
diff_line_range structure.

This has the exactly the same semantics as 'git blame -L n,m <pathspec>'
because we refactored and reused the blame code.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/log.c |  102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 08b8722..e7c5111 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -19,6 +19,7 @@
 #include "remote.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "line.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -27,11 +28,24 @@ static int default_show_root = 1;
 static int decoration_style;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
+static const char *dashdash = "--";
 
-static const char * const builtin_log_usage =
+static char builtin_log_usage[] =
 	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
+	"git log [<options>] -L n,m <path>\n"
 	"   or: git show [options] <object>...";
 
+static const char *log_opt_usage[] = {
+	builtin_log_usage,
+	NULL
+};
+
+struct line_opt_callback_data {
+	struct diff_line_range **range;
+	struct parse_opt_ctx_t *ctx;
+	struct rev_info *rev;
+};
+
 static int parse_decoration_style(const char *var, const char *value)
 {
 	switch (git_config_maybe_bool(var, value)) {
@@ -49,12 +63,44 @@ static int parse_decoration_style(const char *var, const char *value)
 	return -1;
 }
 
+static int log_line_range_callback(const struct option *option, const char *arg, int unset)
+{
+	struct line_opt_callback_data *data = option->value;
+	struct diff_line_range *r = *data->range;
+	struct parse_opt_ctx_t *ctx = data->ctx;
+
+	if (!arg)
+		return -1;
+
+	if (r->nr == 0 && r->next == NULL)
+		ctx->out[ctx->cpidx++] = dashdash;
+
+	diff_line_range_append(r, arg);
+	data->rev->line_level_traverse = 1;
+	return 0;
+}
+
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	int i;
 	int decoration_given = 0;
 	struct userformat_want w;
+	const char *path = NULL, *fullpath = NULL;
+	static struct diff_line_range *range;
+	struct diff_line_range *r = NULL;
+	static struct parse_opt_ctx_t ctx;
+	static struct line_opt_callback_data line_cb = {&range, &ctx, NULL};
+	static const struct option options[] = {
+		OPT_CALLBACK('L', NULL, &line_cb, "n,m",
+			     "Process only line range n,m, counting from 1",
+			     log_line_range_callback),
+		OPT_END()
+	};
+
+	line_cb.rev = rev;
+	range = xmalloc(sizeof(*range));
+	DIFF_LINE_RANGE_INIT(range);
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
@@ -75,6 +121,56 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	 */
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_log_usage);
+
+	parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KEEP_DASHDASH |
+			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_STOP_AT_NON_OPTION);
+	for (;;) {
+		switch (parse_options_step(&ctx, options, log_opt_usage)) {
+		case PARSE_OPT_HELP:
+			exit(129);
+		case PARSE_OPT_DONE:
+			goto parse_done;
+		case PARSE_OPT_NON_OPTION:
+			path = parse_options_current(&ctx);
+			fullpath = prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
+			range->spec = alloc_filespec(fullpath);
+			free((void *)fullpath);
+			if (range->nr == 0) {
+				if (range->next) {
+					die("Path %s need a -L <range> option\n"
+					"If you want follow the history of the whole file "
+					"use 'git log -L 1,$ <path>'", range->spec->path);
+				} else {
+					parse_options_next(&ctx, 1);
+					continue;
+				}
+			}
+			r = xmalloc(sizeof(*r));
+			DIFF_LINE_RANGE_INIT(r);
+			r->next = range;
+			range = r;
+			parse_options_next(&ctx, 1);
+			continue;
+		case PARSE_OPT_UNKNOWN:
+			parse_options_next(&ctx, 1);
+			continue;
+		}
+
+		parse_revision_opt(rev, &ctx, options, log_opt_usage);
+	}
+parse_done:
+	argc = parse_options_end(&ctx);
+
+	/* die if '-L <range>' with no pathspec follow */
+	if (range->nr > 0 && range->spec == NULL)
+		die("Each -L should follow a path");
+	/* clear up the last range */
+	if (range->nr == 0) {
+		struct diff_line_range *r = range->next;
+		DIFF_LINE_RANGE_CLEAR(range);
+		range = r;
+	}
+
 	argc = setup_revisions(argc, argv, rev, opt);
 
 	memset(&w, 0, sizeof(w));
@@ -125,6 +221,10 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		rev->show_decorations = 1;
 		load_ref_decorations(decoration_style);
 	}
+
+	/* Test whether line level history is asked for */
+	if (range && range->nr > 0)
+		setup_line(rev, range);
 }
 
 /*
-- 
1.7.2.19.g79e5d
