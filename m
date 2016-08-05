Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4962018E
	for <e@80x24.org>; Fri,  5 Aug 2016 22:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S3003599AbcHEWDZ (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 18:03:25 -0400
Received: from siwi.pair.com ([209.68.5.199]:64360 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S3003588AbcHEWDT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 18:03:19 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id F120484603;
	Fri,  5 Aug 2016 18:03:17 -0400 (EDT)
From:	Jeff Hostetler <git@jeffhostetler.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 2/9] status: cleanup API to wt_status_print
Date:	Fri,  5 Aug 2016 18:00:27 -0400
Message-Id: <1470434434-64283-3-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
References: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Refactor the API between builtin/commit.c and wt-status.[ch].

Hide the details of the various wt_*status_print() routines inside
wt-status.c behind a single (new) wt_status_print() routine.
Eliminate the switch statements from builtin/commit.c.
Allow details of new status formats to be isolated within wt-status.c

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/commit.c | 51 +++++++++------------------------------------------
 wt-status.c      | 25 ++++++++++++++++++++++---
 wt-status.h      | 16 ++++++++++++----
 3 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b80273b..a792deb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -142,14 +142,7 @@ static int show_ignored_in_status, have_option_m;
 static const char *only_include_assumed;
 static struct strbuf message = STRBUF_INIT;
 
-static enum status_format {
-	STATUS_FORMAT_NONE = 0,
-	STATUS_FORMAT_LONG,
-	STATUS_FORMAT_SHORT,
-	STATUS_FORMAT_PORCELAIN,
-
-	STATUS_FORMAT_UNSPECIFIED
-} status_format = STATUS_FORMAT_UNSPECIFIED;
+static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
@@ -500,24 +493,11 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->fp = fp;
 	s->nowarn = nowarn;
 	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
+	s->status_format = status_format;
+	s->ignore_submodule_arg = ignore_submodule_arg;
 
 	wt_status_collect(s);
-
-	switch (status_format) {
-	case STATUS_FORMAT_SHORT:
-		wt_shortstatus_print(s);
-		break;
-	case STATUS_FORMAT_PORCELAIN:
-		wt_porcelain_print(s);
-		break;
-	case STATUS_FORMAT_UNSPECIFIED:
-		die("BUG: finalize_deferred_config() should have been called");
-		break;
-	case STATUS_FORMAT_NONE:
-	case STATUS_FORMAT_LONG:
-		wt_longstatus_print(s);
-		break;
-	}
+	wt_status_print(s);
 
 	return s->commitable;
 }
@@ -1099,7 +1079,7 @@ static const char *read_commit_message(const char *name)
  * is not in effect here.
  */
 static struct status_deferred_config {
-	enum status_format status_format;
+	enum wt_status_format status_format;
 	int show_branch;
 } status_deferred_config = {
 	STATUS_FORMAT_UNSPECIFIED,
@@ -1381,6 +1361,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	s.ignore_submodule_arg = ignore_submodule_arg;
+	s.status_format = status_format;
+	s.verbose = verbose;
+
 	wt_status_collect(&s);
 
 	if (0 <= fd)
@@ -1389,23 +1372,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (s.relative_paths)
 		s.prefix = prefix;
 
-	switch (status_format) {
-	case STATUS_FORMAT_SHORT:
-		wt_shortstatus_print(&s);
-		break;
-	case STATUS_FORMAT_PORCELAIN:
-		wt_porcelain_print(&s);
-		break;
-	case STATUS_FORMAT_UNSPECIFIED:
-		die("BUG: finalize_deferred_config() should have been called");
-		break;
-	case STATUS_FORMAT_NONE:
-	case STATUS_FORMAT_LONG:
-		s.verbose = verbose;
-		s.ignore_submodule_arg = ignore_submodule_arg;
-		wt_longstatus_print(&s);
-		break;
-	}
+	wt_status_print(&s);
 	return 0;
 }
 
diff --git a/wt-status.c b/wt-status.c
index b9a58fd..a9031e4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1447,7 +1447,7 @@ static void wt_longstatus_print_state(struct wt_status *s,
 		show_bisect_in_progress(s, state, state_color);
 }
 
-void wt_longstatus_print(struct wt_status *s)
+static void wt_longstatus_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
@@ -1714,7 +1714,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	fputc(s->null_termination ? '\0' : '\n', s->fp);
 }
 
-void wt_shortstatus_print(struct wt_status *s)
+static void wt_shortstatus_print(struct wt_status *s)
 {
 	int i;
 
@@ -1746,7 +1746,7 @@ void wt_shortstatus_print(struct wt_status *s)
 	}
 }
 
-void wt_porcelain_print(struct wt_status *s)
+static void wt_porcelain_print(struct wt_status *s)
 {
 	s->use_color = 0;
 	s->relative_paths = 0;
@@ -1754,3 +1754,22 @@ void wt_porcelain_print(struct wt_status *s)
 	s->no_gettext = 1;
 	wt_shortstatus_print(s);
 }
+
+void wt_status_print(struct wt_status *s)
+{
+	switch (s->status_format) {
+	case STATUS_FORMAT_SHORT:
+		wt_shortstatus_print(s);
+		break;
+	case STATUS_FORMAT_PORCELAIN:
+		wt_porcelain_print(s);
+		break;
+	case STATUS_FORMAT_UNSPECIFIED:
+		die("BUG: finalize_deferred_config() should have been called");
+		break;
+	case STATUS_FORMAT_NONE:
+	case STATUS_FORMAT_LONG:
+		wt_longstatus_print(s);
+		break;
+	}
+}
diff --git a/wt-status.h b/wt-status.h
index 2023a3c..9389076 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -43,6 +43,15 @@ struct wt_status_change_data {
 	unsigned new_submodule_commits : 1;
 };
 
+enum wt_status_format {
+	STATUS_FORMAT_NONE = 0,
+	STATUS_FORMAT_LONG,
+	STATUS_FORMAT_SHORT,
+	STATUS_FORMAT_PORCELAIN,
+
+	STATUS_FORMAT_UNSPECIFIED
+};
+
 struct wt_status {
 	int is_initial;
 	char *branch;
@@ -66,6 +75,8 @@ struct wt_status {
 	int show_branch;
 	int hints;
 
+	enum wt_status_format status_format;
+
 	/* These are computed during processing of the individual sections */
 	int commitable;
 	int workdir_dirty;
@@ -99,6 +110,7 @@ struct wt_status_state {
 void wt_status_truncate_message_at_cut_line(struct strbuf *);
 void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct wt_status *s);
+void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 void wt_status_get_state(struct wt_status_state *state, int get_detached_from);
 int wt_status_check_rebase(const struct worktree *wt,
@@ -106,10 +118,6 @@ int wt_status_check_rebase(const struct worktree *wt,
 int wt_status_check_bisect(const struct worktree *wt,
 			   struct wt_status_state *state);
 
-void wt_longstatus_print(struct wt_status *s);
-void wt_shortstatus_print(struct wt_status *s);
-void wt_porcelain_print(struct wt_status *s);
-
 __attribute__((format (printf, 3, 4)))
 void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...);
 __attribute__((format (printf, 3, 4)))
-- 
2.8.0.rc4.17.gac42084.dirty

