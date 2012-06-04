From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC/PATCH] parse-options: introduce parse_subcommands
Date: Mon,  4 Jun 2012 15:05:34 +0530
Message-ID: <1338802534-32394-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 11:38:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbTjZ-0001CO-Ln
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 11:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683Ab2FDJhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 05:37:53 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40874 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab2FDJhw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 05:37:52 -0400
Received: by dady13 with SMTP id y13so5595630dad.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 02:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+qD1Zqq1CONy1z1Xcy416gNIs4nIfv12s7K4ky6clqg=;
        b=SMF+LBeyXPx3Av6ZEllf7GI7wYZRQjpc2GUMgxjvK/7NAm9IjitOJD1cVBC6ViDqP8
         kOyN0iGaIyetfTqDnQp+Nxl2YM0+C8hWtEiHXbIU1FzQr3wGbdebnnJC81rfTGb1glcy
         gFhDeyZmXOYGrNFRhGG7/biSodvjejuJKo9hLUyNcwOueFk1K+gNubxqnYf3Cj6UZZ/d
         7Or9P7Z2ApkdCksIDcPBOg/rbhTi3VQ/u3U6TRhLnDQtFMRsL3BnqjCI+fi5iTlLpYAF
         UGz82xVjdeTAFElZjlBwk2xXvZhm9DBaWr9hiE/1XYsGf+bhOPaBtk+n0CXFcZvA21PI
         IlVQ==
Received: by 10.68.134.37 with SMTP id ph5mr2542916pbb.1.1338802672073;
        Mon, 04 Jun 2012 02:37:52 -0700 (PDT)
Received: from localhost.localdomain ([122.174.84.68])
        by mx.google.com with ESMTPS id u5sm12707103pbu.76.2012.06.04.02.37.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 02:37:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199122>

Some git builtins like git-notes use subcommands to switch between
different modes of operation.  Introduce a parse_subcommands similar
to parse_options to aid parsing these options.  The main advantage of
using it is that subcommands can have a descriptive help text attached
to them.

Make the git-notes builtin use parse_subcommands.  As a result, the
following error:

  $ git notes foo
  error: Unknown subcommand: foo
  usage: git notes [--ref <notes_ref>] [list [<object>]]
     or: git notes [--ref <notes_ref>] add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]
     or: git notes [--ref <notes_ref>] copy [-f] <from-object> <to-object>
     or: git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]
     or: git notes [--ref <notes_ref>] edit [<object>]
     or: git notes [--ref <notes_ref>] show [<object>]
     or: git notes [--ref <notes_ref>] merge [-v | -q] [-s <strategy> ] <notes_ref>
     or: git notes merge --commit [-v | -q]
     or: git notes merge --abort [-v | -q]
     or: git notes [--ref <notes_ref>] remove [<object>...]
     or: git notes [--ref <notes_ref>] prune [-n | -v]
     or: git notes [--ref <notes_ref>] get-ref

    --ref <notes_ref>     use notes from <notes_ref>

is replaced by a more helpful:

  $ git notes foo
  error: unknown subcommand: foo
  usage: git notes [<options>] [<subcommand>] [<options>] [<object>..]

  available subcommands:
      list                  list notes for given object
      add                   add notes for given object
      copy                  copy notes for first object onto second object
      append                append notes to existing object
      edit                  edit notes for given object
      show                  show notes for given object
      merge                 merge given notes ref into current notes ref
      remove                remove notes for given objects
      prune                 remove all notes for non-existing/unreachable objects
      get-ref               print the current notes ref

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I found this patch in one of my branches from a long time ago.  I
 haven't written documentation and tests yet because I'm not fully
 convinced that I like this.

 Thoughts?

 builtin/notes.c |   56 ++++++++++++++++++++++---------------------------------
 parse-options.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++
 parse-options.h |   10 ++++++++++
 3 files changed, 79 insertions(+), 34 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 3644d14..b1d6206 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -20,18 +20,7 @@
 #include "notes-merge.h"
 
 static const char * const git_notes_usage[] = {
-	"git notes [--ref <notes_ref>] [list [<object>]]",
-	"git notes [--ref <notes_ref>] add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
-	"git notes [--ref <notes_ref>] copy [-f] <from-object> <to-object>",
-	"git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
-	"git notes [--ref <notes_ref>] edit [<object>]",
-	"git notes [--ref <notes_ref>] show [<object>]",
-	"git notes [--ref <notes_ref>] merge [-v | -q] [-s <strategy> ] <notes_ref>",
-	"git notes merge --commit [-v | -q]",
-	"git notes merge --abort [-v | -q]",
-	"git notes [--ref <notes_ref>] remove [<object>...]",
-	"git notes [--ref <notes_ref>] prune [-n | -v]",
-	"git notes [--ref <notes_ref>] get-ref",
+	"git notes [<options>] [<subcommand>] [<options>] [<object>..]",
 	NULL
 };
 
@@ -1081,28 +1070,27 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		strbuf_release(&sb);
 	}
 
-	if (argc < 1 || !strcmp(argv[0], "list"))
-		result = list(argc, argv, prefix);
-	else if (!strcmp(argv[0], "add"))
-		result = add(argc, argv, prefix);
-	else if (!strcmp(argv[0], "copy"))
-		result = copy(argc, argv, prefix);
-	else if (!strcmp(argv[0], "append") || !strcmp(argv[0], "edit"))
-		result = append_edit(argc, argv, prefix);
-	else if (!strcmp(argv[0], "show"))
-		result = show(argc, argv, prefix);
-	else if (!strcmp(argv[0], "merge"))
-		result = merge(argc, argv, prefix);
-	else if (!strcmp(argv[0], "remove"))
-		result = remove_cmd(argc, argv, prefix);
-	else if (!strcmp(argv[0], "prune"))
-		result = prune(argc, argv, prefix);
-	else if (!strcmp(argv[0], "get-ref"))
-		result = get_ref(argc, argv, prefix);
-	else {
-		result = error(_("Unknown subcommand: %s"), argv[0]);
-		usage_with_options(git_notes_usage, options);
-	}
+	struct subcommand subcmds[] = {
+		{ "list", "list notes for given object", list },
+		{ "add", "add notes for given object", add },
+		{ "copy",
+		  "copy notes for first object onto second object", copy },
+		{ "append", "append notes to existing object", append_edit },
+		{ "edit", "edit notes for given object", append_edit },
+		{ "show", "show notes for given object", show },
+		{ "merge",
+		  "merge given notes ref into current notes ref", merge },
+		{ "remove", "remove notes for given objects", remove_cmd },
+		{ "prune",
+		  "remove all notes for non-existing/unreachable objects", prune },
+		{ "get-ref", "print the current notes ref", get_ref },
+		{ NULL }
+	};
 
+	if (argc < 1)
+		result = list(argc, argv, prefix);
+	else
+		result = parse_subcommands(argc, argv, prefix,
+					subcmds, git_notes_usage);
 	return result ? 1 : 0;
 }
diff --git a/parse-options.c b/parse-options.c
index f0098eb..76640fb 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -583,3 +583,50 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 	return usage_with_options_internal(ctx, usagestr, opts, 0, err);
 }
 
+static void subcommand_usage(const char * const *usagestr,
+			const struct subcommand *subcmds)
+{
+	const struct subcommand *subcmd;
+
+	fprintf(stderr, "usage: %s\n", *usagestr++);
+	while (*usagestr && **usagestr)
+		fprintf(stderr, "   or: %s\n", *usagestr++);
+	while (*usagestr) {
+		fprintf(stderr, "%s%s\n",
+				**usagestr ? "    " : "",
+				*usagestr);
+		usagestr++;
+	}
+
+	fputc('\n', stderr);
+	fprintf(stderr, "available subcommands:\n");
+	for (subcmd = subcmds; subcmd->name != NULL; subcmd ++) {
+		size_t pos;
+		int pad;
+
+		pos = fprintf(stderr, "    ");
+		pos += fprintf(stderr, "%s", subcmd->name);
+
+		if (pos <= USAGE_OPTS_WIDTH)
+			pad = USAGE_OPTS_WIDTH - pos;
+		else {
+			fputc('\n', stderr);
+			pad = USAGE_OPTS_WIDTH;
+		}
+		fprintf(stderr, "%*s%s\n", pad + USAGE_GAP, "", subcmd->help);
+	}
+	fputc('\n', stderr);
+}
+
+int parse_subcommands(int argc, const char **argv, const char *prefix,
+		const struct subcommand *subcmds, const char * const usagestr[])
+{
+	const struct subcommand *subcmd;
+
+	for (subcmd = subcmds; subcmd->name != NULL; subcmd ++)
+		if (!strcmp(subcmd->name, argv[0]))
+			return (*subcmd->callback)(argc, argv, prefix);
+	error("unknown subcommand: %s", argv[0]);
+	subcommand_usage(usagestr, subcmds);
+	exit(129);
+}
diff --git a/parse-options.h b/parse-options.h
index 2e811dc..e95ad10 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -46,6 +46,7 @@ enum parse_opt_option_flags {
 
 struct option;
 typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
+typedef int subcmd_cb(int argc, const char **argv, const char *prefix);
 
 struct parse_opt_ctx_t;
 typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
@@ -117,6 +118,12 @@ struct option {
 	intptr_t defval;
 };
 
+struct subcommand {
+	const char *name;
+	const char *help;
+	subcmd_cb *callback;
+};
+
 #define OPT_END()                   { OPTION_END }
 #define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
 				      (h), PARSE_OPT_NOARG}
@@ -169,6 +176,9 @@ extern int parse_options(int argc, const char **argv, const char *prefix,
                          const struct option *options,
                          const char * const usagestr[], int flags);
 
+extern int parse_subcommands(int argc, const char **argv, const char *prefix,
+			const struct subcommand *subcmds, const char * const usagestr[]);
+
 extern NORETURN void usage_with_options(const char * const *usagestr,
                                         const struct option *options);
 
-- 
1.7.10
