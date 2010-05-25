From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Show branch information in short output of git status
Date: Tue, 25 May 2010 15:45:51 +0200
Message-ID: <284d7af64fec2dc0cabdb5cf29ab3fd34fad79f0.1274794889.git.git@drmicha.warpmail.net>
References: <AANLkTinNYcuiyRpgMGpQAEaStj2MDg9UooozooLPwv_0@mail.gmail.com>
Cc: Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89+git@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 25 15:46:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGuSv-00019W-21
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 15:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517Ab0EYNqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 09:46:31 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48530 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755661Ab0EYNqa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 09:46:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2376BF854B;
	Tue, 25 May 2010 09:46:16 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 25 May 2010 09:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=5X9/qDI2FM57PSnjuEWwaXL+tH8=; b=u1gqdZ8z9jLOtR7H/SFSnZg9GleRHpSrGTwGgY1j/TBjZM2BbBX6e5pR9rjq8i3AMejgU3ksaF4wC+ueF0oQ9+H/zPRdY4ocIWus9IEn0YqA8yHblfZzexhauVlgXJQBdHV/VRJuaRxBmuG+0oWdz3qIT+xgZf8/eU4VwYcnvV0=
X-Sasl-enc: Y5Wh0I0ONQYS77IIAU53KJdyytQCeAdOlnnCMk9XfDGU 1274795165
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9B74F4E2F25;
	Tue, 25 May 2010 09:46:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.342.g1c280
In-Reply-To: <AANLkTinNYcuiyRpgMGpQAEaStj2MDg9UooozooLPwv_0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147710>

From: Daniel Knittl-Frank <knittl89+git@googlemail.com>

This patch adds a first line in the output of `git status -s` when given
the option `-b` or `--branch`, showing which branch the user is
currently on, and in case of tracking branches the number of commits on
each branch.

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---
Sent by the not-so-atomatic mob-robot...
I noticed some white space issue but assume Junio fixes that automatically
when applying.

 builtin/commit.c |    8 ++++-
 wt-status.c      |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 wt-status.h      |    6 +++-
 3 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index ddf77e4..2328293 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -93,6 +93,7 @@ static enum {
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
 } status_format = STATUS_FORMAT_LONG;
+static int status_show_branch;
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
@@ -134,6 +135,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN(0, "dry-run", &dry_run, "show what would be committed"),
 	OPT_SET_INT(0, "short", &status_format, "show status concisely",
 		    STATUS_FORMAT_SHORT),
+	OPT_BOOLEAN(0, "branch", &status_show_branch, "show branch information"),
 	OPT_SET_INT(0, "porcelain", &status_format,
 		    "show porcelain output format", STATUS_FORMAT_PORCELAIN),
 	OPT_BOOLEAN('z', "null", &null_termination,
@@ -424,7 +426,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 
 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
-		wt_shortstatus_print(s, null_termination);
+		wt_shortstatus_print(s, null_termination, status_show_branch);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(s, null_termination);
@@ -1030,6 +1032,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&verbose),
 		OPT_SET_INT('s', "short", &status_format,
 			    "show status concisely", STATUS_FORMAT_SHORT),
+		OPT_BOOLEAN('b', "branch", &status_show_branch,
+		            "show branch information"),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    "show porcelain output format",
 			    STATUS_FORMAT_PORCELAIN),
@@ -1082,7 +1086,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
-		wt_shortstatus_print(&s, null_termination);
+		wt_shortstatus_print(&s, null_termination, status_show_branch);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(&s, null_termination);
diff --git a/wt-status.c b/wt-status.c
index 14e0acc..871315a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "run-command.h"
 #include "remote.h"
+#include "refs.h"
 
 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -17,6 +18,8 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RED,    /* WT_STATUS_UNTRACKED */
 	GIT_COLOR_RED,    /* WT_STATUS_NOBRANCH */
 	GIT_COLOR_RED,    /* WT_STATUS_UNMERGED */
+	GIT_COLOR_GREEN,  /* WT_STATUS_LOCAL_BRANCH */
+	GIT_COLOR_RED,    /* WT_STATUS_REMOTE_BRANCH */
 };
 
 static const char *color(int slot, struct wt_status *s)
@@ -756,9 +759,70 @@ static void wt_shortstatus_other(int null_termination, struct string_list_item *
 	}
 }
 
-void wt_shortstatus_print(struct wt_status *s, int null_termination)
+static void wt_shortstatus_print_tracking(struct wt_status *s)
+{
+	struct branch *branch;
+	const char *header_color = color(WT_STATUS_HEADER, s);
+	const char *branch_color_local = color(WT_STATUS_LOCAL_BRANCH, s);
+	const char *branch_color_remote = color(WT_STATUS_REMOTE_BRANCH, s);
+
+	const char *base;
+	const char *branch_name;
+	int num_ours, num_theirs;
+
+	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");
+
+	if(!s->branch)
+		return;
+	branch_name = s->branch;
+
+	if (!prefixcmp(branch_name, "refs/heads/"))
+		branch_name += 11;
+	else if (!strcmp(branch_name, "HEAD")) {
+		branch_name = "HEAD (no branch)";
+		branch_color_local = color(WT_STATUS_NOBRANCH, s);
+	}
+
+	branch = branch_get(s->branch + 11);
+	if(s->is_initial) {
+		color_fprintf(s->fp, header_color, "Initial commit on ");
+	}
+	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
+		color_fprintf_ln(s->fp, branch_color_local,
+			"%s", branch_name);
+		return;
+	}
+
+	base = branch->merge[0]->dst;
+	base = shorten_unambiguous_ref(base, 0);
+	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
+	color_fprintf(s->fp, header_color, "...");
+	color_fprintf(s->fp, branch_color_remote, "%s", base);
+
+	color_fprintf(s->fp, header_color, " [");
+	if (!num_ours) {
+		color_fprintf(s->fp, header_color, "behind ");
+		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
+	} else if (!num_theirs) {
+		color_fprintf(s->fp, header_color, "ahead ");
+		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
+	} else {
+		color_fprintf(s->fp, header_color, "ahead ");
+		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
+		color_fprintf(s->fp, header_color, ", behind ");
+		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
+	}
+
+	color_fprintf_ln(s->fp, header_color, "]");
+}
+
+void wt_shortstatus_print(struct wt_status *s, int null_termination, int show_branch)
 {
 	int i;
+
+	if(show_branch)
+		wt_shortstatus_print_tracking(s);
+
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		struct string_list_item *it;
@@ -789,5 +853,5 @@ void wt_porcelain_print(struct wt_status *s, int null_termination)
 	s->use_color = 0;
 	s->relative_paths = 0;
 	s->prefix = NULL;
-	wt_shortstatus_print(s, null_termination);
+	wt_shortstatus_print(s, null_termination, 0);
 }
diff --git a/wt-status.h b/wt-status.h
index 1093e65..4f19045 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -12,6 +12,8 @@ enum color_wt_status {
 	WT_STATUS_UNTRACKED,
 	WT_STATUS_NOBRANCH,
 	WT_STATUS_UNMERGED,
+	WT_STATUS_LOCAL_BRANCH,
+	WT_STATUS_REMOTE_BRANCH,
 };
 
 enum untracked_status_type {
@@ -43,7 +45,7 @@ struct wt_status {
 	int submodule_summary;
 	int show_ignored_files;
 	enum untracked_status_type show_untracked_files;
-	char color_palette[WT_STATUS_UNMERGED+1][COLOR_MAXLEN];
+	char color_palette[WT_STATUS_REMOTE_BRANCH+1][COLOR_MAXLEN];
 
 	/* These are computed during processing of the individual sections */
 	int commitable;
@@ -60,7 +62,7 @@ void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 
-void wt_shortstatus_print(struct wt_status *s, int null_termination);
+void wt_shortstatus_print(struct wt_status *s, int null_termination, int show_branch);
 void wt_porcelain_print(struct wt_status *s, int null_termination);
 
 #endif /* STATUS_H */
-- 
1.7.1.342.g1c280
