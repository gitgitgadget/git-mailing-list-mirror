From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH v2 3/4] status: use output library for porcelain output
Date: Mon, 12 Apr 2010 00:21:16 +0100
Message-ID: <20100411232118.67460.35240.julian@quantumfyre.co.uk>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
Cc: Jakub Narebsk <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 01:25:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O16Wf-0000OT-Pg
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 01:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab0DKXZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 19:25:07 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:38499 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753188Ab0DKXYq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 19:24:46 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 04E9E819C4A5;
	Mon, 12 Apr 2010 00:24:39 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 4D44820CF50;
	Mon, 12 Apr 2010 00:24:44 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cmTSS0NCkPWf; Mon, 12 Apr 2010 00:24:43 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 15FE420CF54;
	Mon, 12 Apr 2010 00:24:43 +0100 (BST)
X-git-sha1: 752c7ad1ef990107114a98cef8a448c787fc8fe8 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144695>

Use the new output library for output when in porcelain mode.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 builtin/commit.c |   21 +++++++++++-
 wt-status.c      |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 wt-status.h      |    3 +-
 3 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c5ab683..4e506b1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -25,6 +25,7 @@
 #include "rerere.h"
 #include "unpack-trees.h"
 #include "quote.h"
+#include "output.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -68,6 +69,8 @@ static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite;
 static char *untracked_files_arg, *force_date;
+static char *structured_output_arg;
+static enum output_style output_style;
 /*
  * The default commit message cleanup mode will remove the lines
  * beginning with # (shell comments) and leading and trailing
@@ -137,6 +140,7 @@ static struct option builtin_commit_options[] = {
 		    "show porcelain output format", STATUS_FORMAT_PORCELAIN),
 	OPT_BOOLEAN('z', "null", &null_termination,
 		    "terminate entries with NUL"),
+	OPT_OUTPUT(0, "output", &structured_output_arg),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-rewrite hook"),
 	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
@@ -420,7 +424,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 		wt_shortstatus_print(s, null_termination);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
-		wt_porcelain_print(s, null_termination);
+		wt_porcelain_print(s, output_style);
 		break;
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
@@ -933,6 +937,11 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (null_termination && status_format == STATUS_FORMAT_LONG)
 		status_format = STATUS_FORMAT_PORCELAIN;
+	output_style = handle_output_arg(structured_output_arg);
+	if (output_style == OUTPUT_NORMAL && null_termination)
+		output_style = OUTPUT_ZERO;
+	if (output_style != OUTPUT_NORMAL && status_format == STATUS_FORMAT_LONG)
+		status_format = STATUS_FORMAT_PORCELAIN;
 	if (status_format != STATUS_FORMAT_LONG)
 		dry_run = 1;
 
@@ -1031,6 +1040,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		  "mode",
 		  "show untracked files, optional modes: all, normal, no. (Default: all)",
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		OPT_OUTPUT(0, "output", &structured_output_arg),
 		OPT_END(),
 	};
 
@@ -1045,6 +1055,13 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			     builtin_status_usage, 0);
 	handle_untracked_files_arg(&s);
 
+	output_style = handle_output_arg(structured_output_arg);
+
+	if (output_style == OUTPUT_NORMAL && null_termination)
+		output_style = OUTPUT_ZERO;
+	if (output_style != OUTPUT_NORMAL && status_format == STATUS_FORMAT_LONG)
+		status_format = STATUS_FORMAT_PORCELAIN;
+
 	if (*argv)
 		s.pathspec = get_pathspec(prefix, argv);
 
@@ -1066,7 +1083,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		wt_shortstatus_print(&s, null_termination);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
-		wt_porcelain_print(&s, null_termination);
+		wt_porcelain_print(&s, output_style);
 		break;
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..2a1e0fe 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -743,10 +743,88 @@ void wt_shortstatus_print(struct wt_status *s, int null_termination)
 	}
 }
 
-void wt_porcelain_print(struct wt_status *s, int null_termination)
+static void wt_porcelain_unmerged(struct string_list_item *it,
+				  struct output_context *oc)
 {
-	s->use_color = 0;
-	s->relative_paths = 0;
-	s->prefix = NULL;
-	wt_shortstatus_print(s, null_termination);
+	struct wt_status_change_data *d = it->util;
+	char *ours = "?", *theirs = "?";
+
+	switch (d->stagemask) {
+	case 1: ours = "D"; theirs = "D"; break; /* both deleted */
+	case 2: ours = "A"; theirs = "U"; break; /* added by us */
+	case 3: ours = "U"; theirs = "D"; break; /* deleted by them */
+	case 4: ours = "U"; theirs = "A"; break; /* added by them */
+	case 5: ours = "D"; theirs = "U"; break; /* deleted by us */
+	case 6: ours = "A"; theirs = "A"; break; /* both added */
+	case 7: ours = "U"; theirs = "U"; break; /* both modified */
+	}
+
+	output_start_object(oc, "entry");
+	output_str(oc, "ours", ours);
+	output_str(oc, "theirs", theirs);
+	output_token(oc, " ");
+	output_str(oc, "name", it->string);
+	output_newline(oc);
+	output_end_current(oc);
+}
+
+
+static void wt_porcelain_status(struct string_list_item *it,
+				struct output_context *oc)
+{
+	struct wt_status_change_data *d = it->util;
+	char index = ' ', worktree = ' ';
+
+	if (d->index_status)
+		index = d->index_status;
+	if (d->worktree_status)
+		worktree = d->worktree_status;
+
+	output_start_object(oc, "entry");
+	output_strf(oc, "index", "%c", index);
+	output_strf(oc, "worktree", "%c", worktree);
+	output_token(oc, " ");
+	if (d->head_path && oc->style == OUTPUT_NORMAL) {
+		output_str(oc, "orig_name", d->head_path);
+		output_token(oc, " -> ");
+	}
+	output_str(oc, "name", it->string);
+	if (d->head_path && oc->style != OUTPUT_NORMAL) {
+		output_nul(oc);
+		output_str(oc, "orig_name", d->head_path);
+	}
+	output_newline(oc);
+	output_end_current(oc);
+}
+
+void wt_porcelain_print(struct wt_status *s, enum output_style style)
+{
+	int i;
+	struct output_context *oc = output_start(style);
+
+	output_start_array(oc, "entries");
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+
+		it = &(s->change.items[i]);
+		d = it->util;
+		if (d->stagemask)
+			wt_porcelain_unmerged(it, oc);
+		else
+			wt_porcelain_status(it, oc);
+	}
+
+	for (i = 0; i < s->untracked.nr; i++) {
+		output_start_object(oc, "entry");
+		output_str(oc, "index", "?");
+		output_str(oc, "worktree", "?");
+		output_token(oc, " ");
+		output_str(oc, "name", s->untracked.items[i].string);
+		output_newline(oc);
+		output_end_current(oc);
+	}
+
+	output_end(oc);
 }
diff --git a/wt-status.h b/wt-status.h
index 9120673..4461c64 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -4,6 +4,7 @@
 #include <stdio.h>
 #include "string-list.h"
 #include "color.h"
+#include "output.h"
 
 enum color_wt_status {
 	WT_STATUS_HEADER = 0,
@@ -60,6 +61,6 @@ void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 
 void wt_shortstatus_print(struct wt_status *s, int null_termination);
-void wt_porcelain_print(struct wt_status *s, int null_termination);
+void wt_porcelain_print(struct wt_status *s, enum output_style style);
 
 #endif /* STATUS_H */
-- 
1.7.0.4
