From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] status: respect "-b" for porcelain format
Date: Mon, 7 May 2012 17:25:04 -0400
Message-ID: <20120507212504.GE19567@sigill.intra.peff.net>
References: <20120507212125.GA19532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Zak Johnson <zakj@nox.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 23:25:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRVQh-0007WS-8T
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 23:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388Ab2EGVZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 17:25:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33260
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757676Ab2EGVZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 17:25:07 -0400
Received: (qmail 27525 invoked by uid 107); 7 May 2012 21:25:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 17:25:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 17:25:04 -0400
Content-Disposition: inline
In-Reply-To: <20120507212125.GA19532@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197313>

There is no reason not to, as the user has to explicitly ask
for it, so we are not breaking compatibility by doing so. We
can do this simply by moving the "show_branch" flag into
the wt_status struct. As a bonus, this saves us from passing
it explicitly, simplifying the code.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c  | 9 ++++-----
 t/t7508-status.sh | 7 ++++++-
 wt-status.c       | 6 +++---
 wt-status.h       | 3 ++-
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 11271c0..a2ec73d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -115,7 +115,6 @@ static enum {
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN
 } status_format = STATUS_FORMAT_LONG;
-static int status_show_branch;
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
@@ -446,7 +445,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 
 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
-		wt_shortstatus_print(s, status_show_branch);
+		wt_shortstatus_print(s);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(s);
@@ -1171,7 +1170,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT_SET_INT('s', "short", &status_format,
 			    "show status concisely", STATUS_FORMAT_SHORT),
-		OPT_BOOLEAN('b', "branch", &status_show_branch,
+		OPT_BOOLEAN('b', "branch", &s.show_branch,
 			    "show branch information"),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    "machine-readable output",
@@ -1228,7 +1227,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
-		wt_shortstatus_print(&s, status_show_branch);
+		wt_shortstatus_print(&s);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(&s);
@@ -1400,7 +1399,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "dry-run", &dry_run, "show what would be committed"),
 		OPT_SET_INT(0, "short", &status_format, "show status concisely",
 			    STATUS_FORMAT_SHORT),
-		OPT_BOOLEAN(0, "branch", &status_show_branch, "show branch information"),
+		OPT_BOOLEAN(0, "branch", &s.show_branch, "show branch information"),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    "machine-readable output", STATUS_FORMAT_PORCELAIN),
 		OPT_BOOLEAN('z', "null", &s.null_termination,
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index f60f49b..28e1848 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -680,9 +680,14 @@ test_expect_success 'status --porcelain ignores color.status' '
 git config --unset color.status
 git config --unset color.ui
 
-test_expect_success 'status --porcelain ignores -b' '
+test_expect_success 'status --porcelain respects -b' '
 
 	git status --porcelain -b >output &&
+	{
+		echo "## master" &&
+		cat expect
+	} >tmp &&
+	mv tmp expect &&
 	test_cmp expect output
 
 '
diff --git a/wt-status.c b/wt-status.c
index 21c0d4d..dd6d8c4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -942,11 +942,11 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	fputc(s->null_termination ? '\0' : '\n', s->fp);
 }
 
-void wt_shortstatus_print(struct wt_status *s, int show_branch)
+void wt_shortstatus_print(struct wt_status *s)
 {
 	int i;
 
-	if (show_branch)
+	if (s->show_branch)
 		wt_shortstatus_print_tracking(s);
 
 	for (i = 0; i < s->change.nr; i++) {
@@ -979,5 +979,5 @@ void wt_porcelain_print(struct wt_status *s)
 	s->use_color = 0;
 	s->relative_paths = 0;
 	s->prefix = NULL;
-	wt_shortstatus_print(s, 0);
+	wt_shortstatus_print(s);
 }
diff --git a/wt-status.h b/wt-status.h
index 26dd21a..14aa9f7 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -58,6 +58,7 @@ struct wt_status {
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
 	unsigned colopts;
 	int null_termination;
+	int show_branch;
 
 	/* These are computed during processing of the individual sections */
 	int commitable;
@@ -74,7 +75,7 @@ void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 
-void wt_shortstatus_print(struct wt_status *s, int show_branch);
+void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
 
 void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...)
-- 
1.7.10.1.12.gd79f7ab
