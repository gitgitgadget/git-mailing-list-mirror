From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH 3/3] status: add support for structured output
Date: Sun, 11 Apr 2010 12:37:32 +0100
Message-ID: <20100411113733.80010.87627.julian@quantumfyre.co.uk>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
Cc: Eric Raymond <esr@thyrsus.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 11 13:38:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0vUt-0003XF-S5
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 13:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab0DKLih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 07:38:37 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:41433 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143Ab0DKLi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 07:38:28 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 3C24F819C4CC;
	Sun, 11 Apr 2010 12:38:21 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id C560A20CF48;
	Sun, 11 Apr 2010 12:38:26 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DEP4Q3uDy6Ub; Sun, 11 Apr 2010 12:38:26 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 8272820CF4A;
	Sun, 11 Apr 2010 12:38:25 +0100 (BST)
X-git-sha1: 9088dd07ceebc8ecadc5b7c549ade0a93d459e76 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144641>

Add support for using the new structured output modes for outputting
status information.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 builtin/commit.c |   12 +++++++++
 wt-status.c      |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h      |    2 +
 3 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c5ab683..77464d3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -25,6 +25,7 @@
 #include "rerere.h"
 #include "unpack-trees.h"
 #include "quote.h"
+#include "output.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -68,6 +69,7 @@ static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite;
 static char *untracked_files_arg, *force_date;
+static char *structured_output_arg;
 /*
  * The default commit message cleanup mode will remove the lines
  * beginning with # (shell comments) and leading and trailing
@@ -91,6 +93,7 @@ static enum {
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
+	STATUS_FORMAT_STRUCTURED,
 } status_format = STATUS_FORMAT_LONG;
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
@@ -1018,6 +1021,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	struct wt_status s;
 	unsigned char sha1[20];
+	enum output_style output_style;
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose),
 		OPT_SET_INT('s', "short", &status_format,
@@ -1031,6 +1035,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		  "mode",
 		  "show untracked files, optional modes: all, normal, no. (Default: all)",
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		OPT_OUTPUT(0, "structured-output", &structured_output_arg),
 		OPT_END(),
 	};
 
@@ -1045,6 +1050,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			     builtin_status_usage, 0);
 	handle_untracked_files_arg(&s);
 
+	output_style = handle_output_arg(structured_output_arg);
+	if (output_style != OUTPUT_NORMAL)
+		status_format = STATUS_FORMAT_STRUCTURED;
+
 	if (*argv)
 		s.pathspec = get_pathspec(prefix, argv);
 
@@ -1068,6 +1077,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(&s, null_termination);
 		break;
+	case STATUS_FORMAT_STRUCTURED:
+		wt_structured_print(&s, output_style);
+		break;
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
 		wt_status_print(&s);
diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..162f719 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -750,3 +750,76 @@ void wt_porcelain_print(struct wt_status *s, int null_termination)
 	s->prefix = NULL;
 	wt_shortstatus_print(s, null_termination);
 }
+
+static void wt_structured_unmerged(struct string_list_item *it,
+				   struct output_context *oc)
+{
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
+	output_str(oc, "name", it->string);
+	output_str(oc, "ours", ours);
+	output_str(oc, "theirs", theirs);
+	output_end_current(oc);
+}
+
+static void wt_structured_status(struct string_list_item *it,
+				 struct output_context *oc)
+{
+	struct wt_status_change_data *d = it->util;
+	char index = '-', worktree = '-';
+
+	if (d->index_status)
+		index = d->index_status;
+	if (d->worktree_status)
+		worktree = d->worktree_status;
+
+	output_start_object(oc, "entry");
+	output_str(oc, "name", it->string);
+	if (d->head_path)
+		output_str(oc, "orig_name", d->head_path);
+	output_strf(oc, "index", "%c", index);
+	output_strf(oc, "worktree", "%c", worktree);
+	output_end_current(oc);
+}
+
+void wt_structured_print(struct wt_status *s, enum output_style style)
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
+			wt_structured_unmerged(it, oc);
+		else
+			wt_structured_status(it, oc);
+	}
+
+	for (i = 0; i < s->untracked.nr; i++) {
+		output_start_object(oc, "entry");
+		output_str(oc, "name", s->untracked.items[i].string);
+		output_str(oc, "index", "?");
+		output_str(oc, "worktree", "?");
+		output_end_current(oc);
+	}
+
+	output_end(oc);
+}
diff --git a/wt-status.h b/wt-status.h
index 9120673..d5b1342 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -4,6 +4,7 @@
 #include <stdio.h>
 #include "string-list.h"
 #include "color.h"
+#include "output.h"
 
 enum color_wt_status {
 	WT_STATUS_HEADER = 0,
@@ -61,5 +62,6 @@ void wt_status_collect(struct wt_status *s);
 
 void wt_shortstatus_print(struct wt_status *s, int null_termination);
 void wt_porcelain_print(struct wt_status *s, int null_termination);
+void wt_structured_print(struct wt_status *s, enum output_style style);
 
 #endif /* STATUS_H */
-- 
1.7.0.4
