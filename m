From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2 05/13] parse the -L options
Date: Wed, 30 Jun 2010 23:25:18 +0800
Message-ID: <1277911526-12105-5-git-send-email-struggleyb.nku@gmail.com>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 17:29:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzE2-0000C4-0S
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788Ab0F3P3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:29:17 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41998 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab0F3P3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:29:16 -0400
Received: by pzk7 with SMTP id 7so138520pzk.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+4sJXaIPVYMmsA2CZIwq+tJ4VmzrvrneJEM0UZCXEz0=;
        b=KyHedeRnZeApyG8x1tw30CpZ+peVBC5zE8CReZDr2v+LqjMhMMG96YUQnrNzxTIHX9
         8rc3S2ka1nRx0MwYAIeoclkwM5ehjKQgCCGI7tzjqgGiky48qet/EdSSnC7XaYko+ObV
         a/xwJ33Pb4GdgrGCJ6aKwruyZtIFtBhwOI96c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JEUtjTK35thFPmOJgiqyUPT99T+3T4jxOE+Yjg3isOoLPtGj605A0r0QXIIcGmPOO/
         wHdFPdun3EJ61Ta18wqNl5QbpigxaE/1UCgkQWG+n5um2sP3FxDLxK4JGWDk+s3JjS3/
         T/bR36byPo688FXazhf7vsyuDZYcAUJJGzSJo=
Received: by 10.115.39.39 with SMTP id r39mr9978640waj.157.1277911755458;
        Wed, 30 Jun 2010 08:29:15 -0700 (PDT)
Received: from localhost.localdomain ([117.15.79.69])
        by mx.google.com with ESMTPS id d38sm75050850wam.20.2010.06.30.08.28.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 08:29:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.27.g1c5fd
In-Reply-To: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149968>

With the two new APIs of parse options added in the previous
commit, we parse the multiple '-L n,m <file>' syntax.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/log.c |  102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f068583..d0faf07 100644
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
@@ -49,12 +63,41 @@ static int parse_decoration_style(const char *var, const char *value)
 	return -1;
 }
 
+static int log_line_range_callback(const struct option *option, const char *arg, int unset)
+{
+	struct line_opt_callback_data *data = option->value;
+	struct diff_line_range *r = *data->range;
+	struct parse_opt_ctx_t *ctx = data->ctx;
+	if (!arg)
+		return -1;
+
+	if (r->nr == 0 && r->next == NULL) {
+		ctx->out[ctx->cpidx++] = dashdash;
+	}
+
+	diff_line_range_append(r, arg);
+	data->rev->line = 1;
+	return 0;
+}
+
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	int i;
 	int decoration_given = 0;
 	struct userformat_want w;
+	const char *path = NULL, *pathspec = NULL;
+	static struct diff_line_range *range = NULL;
+	static struct parse_opt_ctx_t ctx;
+	static struct line_opt_callback_data line_cb = {&range, &ctx, NULL};
+	static const struct option options[] = {
+		OPT_CALLBACK('L', NULL, &line_cb, "n,m", "Process only line range n,m, counting from 1", log_line_range_callback),
+		OPT_END()
+	};
+
+	line_cb.rev = rev;
+	range = xmalloc(sizeof(*range));
+	DIFF_LINE_RANGE_INIT(range);
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
@@ -75,6 +118,58 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
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
+			pathspec = prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
+			range->spec = alloc_filespec(pathspec);
+			free((void *)pathspec);
+			if (range->nr == 0) {
+				if(range->next) {
+					die("Path %s need a -L <range> option\n"
+					"If you want follow the history of the whole file "
+					"whether to using 'git log' without -L or using "
+					"'git log -L 1,$ <path>'", range->spec->path);
+				} else {
+					parse_options_next(&ctx, 1);
+					continue;
+				}
+			}
+			struct diff_line_range *r = xmalloc(sizeof(*r));
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
+	if (range->nr > 0 && range->spec == NULL) {
+		die("Each -L should follow a pathspec");
+	}
+	/* clear up the last range */
+	if (range->nr == 0) {
+		struct diff_line_range *r = range->next;
+		DIFF_LINE_RANGE_CLEAR(range);
+		range = r;
+	}
+
 	argc = setup_revisions(argc, argv, rev, opt);
 
 	memset(&w, 0, sizeof(w));
@@ -125,6 +220,11 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		rev->show_decorations = 1;
 		load_ref_decorations(decoration_style);
 	}
+
+	/* Test whether line level history is asked for */
+	if (range && range->nr > 0) {
+		setup_line(rev, range);
+	}
 }
 
 /*
-- 
1.7.0.2.273.gc2413.dirty
