From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] status: refactor null_termination option
Date: Mon, 7 May 2012 17:24:23 -0400
Message-ID: <20120507212423.GC19567@sigill.intra.peff.net>
References: <20120507212125.GA19532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Zak Johnson <zakj@nox.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 23:24:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRVPy-0007LX-Pb
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 23:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266Ab2EGVY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 17:24:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33251
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756667Ab2EGVYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 17:24:25 -0400
Received: (qmail 27459 invoked by uid 107); 7 May 2012 21:24:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 17:24:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 17:24:23 -0400
Content-Disposition: inline
In-Reply-To: <20120507212125.GA19532@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197311>

This option is passed separately to the wt_status printing
functions, whereas every other formatting option is
contained in the wt_status struct itself. Let's do the same
here, so we can avoid passing it around through the call
stack.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 17 ++++++++---------
 wt-status.c      | 26 +++++++++++++-------------
 wt-status.h      |  5 +++--
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1a69cb0..11271c0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -110,7 +110,6 @@ static int show_ignored_in_status;
 static const char *only_include_assumed;
 static struct strbuf message = STRBUF_INIT;
 
-static int null_termination;
 static enum {
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
@@ -447,10 +446,10 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 
 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
-		wt_shortstatus_print(s, null_termination, status_show_branch);
+		wt_shortstatus_print(s, status_show_branch);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
-		wt_porcelain_print(s, null_termination);
+		wt_porcelain_print(s);
 		break;
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
@@ -1076,7 +1075,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (all && argc > 0)
 		die(_("Paths with -a does not make sense."));
 
-	if (null_termination && status_format == STATUS_FORMAT_LONG)
+	if (s->null_termination && status_format == STATUS_FORMAT_LONG)
 		status_format = STATUS_FORMAT_PORCELAIN;
 	if (status_format != STATUS_FORMAT_LONG)
 		dry_run = 1;
@@ -1177,7 +1176,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    "machine-readable output",
 			    STATUS_FORMAT_PORCELAIN),
-		OPT_BOOLEAN('z', "null", &null_termination,
+		OPT_BOOLEAN('z', "null", &s.null_termination,
 			    "terminate entries with NUL"),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
 		  "mode",
@@ -1204,7 +1203,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			     builtin_status_usage, 0);
 	finalize_colopts(&s.colopts, -1);
 
-	if (null_termination && status_format == STATUS_FORMAT_LONG)
+	if (s.null_termination && status_format == STATUS_FORMAT_LONG)
 		status_format = STATUS_FORMAT_PORCELAIN;
 
 	handle_untracked_files_arg(&s);
@@ -1229,10 +1228,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
-		wt_shortstatus_print(&s, null_termination, status_show_branch);
+		wt_shortstatus_print(&s, status_show_branch);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
-		wt_porcelain_print(&s, null_termination);
+		wt_porcelain_print(&s);
 		break;
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
@@ -1404,7 +1403,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "branch", &status_show_branch, "show branch information"),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    "machine-readable output", STATUS_FORMAT_PORCELAIN),
-		OPT_BOOLEAN('z', "null", &null_termination,
+		OPT_BOOLEAN('z', "null", &s.null_termination,
 			    "terminate entries with NUL"),
 		OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 		OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-rewrite hook"),
diff --git a/wt-status.c b/wt-status.c
index eeef17e..284dc61 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -801,7 +801,7 @@ void wt_status_print(struct wt_status *s)
 	}
 }
 
-static void wt_shortstatus_unmerged(int null_termination, struct string_list_item *it,
+static void wt_shortstatus_unmerged(struct string_list_item *it,
 			   struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
@@ -817,7 +817,7 @@ static void wt_shortstatus_unmerged(int null_termination, struct string_list_ite
 	case 7: how = "UU"; break; /* both modified */
 	}
 	color_fprintf(s->fp, color(WT_STATUS_UNMERGED, s), "%s", how);
-	if (null_termination) {
+	if (s->null_termination) {
 		fprintf(stdout, " %s%c", it->string, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
@@ -828,7 +828,7 @@ static void wt_shortstatus_unmerged(int null_termination, struct string_list_ite
 	}
 }
 
-static void wt_shortstatus_status(int null_termination, struct string_list_item *it,
+static void wt_shortstatus_status(struct string_list_item *it,
 			 struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
@@ -842,7 +842,7 @@ static void wt_shortstatus_status(int null_termination, struct string_list_item
 	else
 		putchar(' ');
 	putchar(' ');
-	if (null_termination) {
+	if (s->null_termination) {
 		fprintf(stdout, "%s%c", it->string, 0);
 		if (d->head_path)
 			fprintf(stdout, "%s%c", d->head_path, 0);
@@ -870,10 +870,10 @@ static void wt_shortstatus_status(int null_termination, struct string_list_item
 	}
 }
 
-static void wt_shortstatus_other(int null_termination, struct string_list_item *it,
+static void wt_shortstatus_other(struct string_list_item *it,
 				 struct wt_status *s, const char *sign)
 {
-	if (null_termination) {
+	if (s->null_termination) {
 		fprintf(stdout, "%s %s%c", sign, it->string, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
@@ -941,7 +941,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	color_fprintf_ln(s->fp, header_color, "]");
 }
 
-void wt_shortstatus_print(struct wt_status *s, int null_termination, int show_branch)
+void wt_shortstatus_print(struct wt_status *s, int show_branch)
 {
 	int i;
 
@@ -955,28 +955,28 @@ void wt_shortstatus_print(struct wt_status *s, int null_termination, int show_br
 		it = &(s->change.items[i]);
 		d = it->util;
 		if (d->stagemask)
-			wt_shortstatus_unmerged(null_termination, it, s);
+			wt_shortstatus_unmerged(it, s);
 		else
-			wt_shortstatus_status(null_termination, it, s);
+			wt_shortstatus_status(it, s);
 	}
 	for (i = 0; i < s->untracked.nr; i++) {
 		struct string_list_item *it;
 
 		it = &(s->untracked.items[i]);
-		wt_shortstatus_other(null_termination, it, s, "??");
+		wt_shortstatus_other(it, s, "??");
 	}
 	for (i = 0; i < s->ignored.nr; i++) {
 		struct string_list_item *it;
 
 		it = &(s->ignored.items[i]);
-		wt_shortstatus_other(null_termination, it, s, "!!");
+		wt_shortstatus_other(it, s, "!!");
 	}
 }
 
-void wt_porcelain_print(struct wt_status *s, int null_termination)
+void wt_porcelain_print(struct wt_status *s)
 {
 	s->use_color = 0;
 	s->relative_paths = 0;
 	s->prefix = NULL;
-	wt_shortstatus_print(s, null_termination, 0);
+	wt_shortstatus_print(s, 0);
 }
diff --git a/wt-status.h b/wt-status.h
index 5386077..26dd21a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -57,6 +57,7 @@ struct wt_status {
 	const char *ignore_submodule_arg;
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
 	unsigned colopts;
+	int null_termination;
 
 	/* These are computed during processing of the individual sections */
 	int commitable;
@@ -73,8 +74,8 @@ void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 
-void wt_shortstatus_print(struct wt_status *s, int null_termination, int show_branch);
-void wt_porcelain_print(struct wt_status *s, int null_termination);
+void wt_shortstatus_print(struct wt_status *s, int show_branch);
+void wt_porcelain_print(struct wt_status *s);
 
 void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...)
 	;
-- 
1.7.10.1.12.gd79f7ab
