From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 2/3] builtin-status: submodule summary support
Date: Thu, 10 Apr 2008 23:35:26 +0800
Message-ID: <1207841727-7840-3-git-send-email-pkufranky@gmail.com>
References: <1207841727-7840-1-git-send-email-pkufranky@gmail.com>
 <1207841727-7840-2-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 10 17:38:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjyp2-0005sp-Li
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 17:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355AbYDJPfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 11:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757345AbYDJPfg
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 11:35:36 -0400
Received: from mail.qikoo.org ([60.28.205.235]:42967 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756979AbYDJPfd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 11:35:33 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id E96D1470AF; Thu, 10 Apr 2008 23:35:27 +0800 (CST)
X-Mailer: git-send-email 1.5.5.23.g2a5f
In-Reply-To: <1207841727-7840-2-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79218>

This commit teaches 'git commit/status' show 'Modified submodules'
section given by

git submodule summary --cached --for-status --summary-limit <limit>

just before 'Untracked files' section.

The <limit> is given by the config variable status.submodulesummary
to limit the submodule summary size. status.submodulesummary is 0 by
default which disables the summary.

Also mention status.submodulesummary in the documentation.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 Documentation/git-status.txt |    4 ++++
 wt-status.c                  |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 3ea269a..32b6660 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -52,6 +52,10 @@ If the config variable `status.relativePaths` is set to false, then all
 paths shown are relative to the repository root, not to the current
 directory.
 
+If 'status.submodulesummary' is set to a non zero number, the submodule
+summary will be enabled and a summary of commits for modified submodules
+will be shown (see --summary-limit option of linkgit:git-submodule[1]).
+
 See Also
 --------
 linkgit:gitignore[5]
diff --git a/wt-status.c b/wt-status.c
index b3fd57b..369c519 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -8,9 +8,11 @@
 #include "revision.h"
 #include "diffcore.h"
 #include "quote.h"
+#include "run-command.h"
 
 int wt_status_relative_paths = 1;
 int wt_status_use_color = -1;
+int wt_status_submodule_summary = 0;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	"",         /* WT_STATUS_HEADER: normal */
 	"\033[32m", /* WT_STATUS_UPDATED: green */
@@ -219,6 +221,38 @@ static void wt_status_print_changed(struct wt_status *s)
 	rev.diffopt.format_callback_data = s;
 	run_diff_files(&rev, 0);
 }
+static void wt_status_print_submodule_summary(struct wt_status *s)
+{
+	struct child_process sm_summary;
+	char summary_limit[64];
+	char index[PATH_MAX];
+	const char *env[] = { index, NULL };
+	const char *argv[] = {
+		"submodule",
+		"summary",
+		"--cached",
+		"--for-status",
+		"--summary-limit",
+		summary_limit,
+		s->amend ? "HEAD^" : "HEAD",
+		NULL
+	};
+
+	if (!wt_status_submodule_summary)
+		return;
+
+	sprintf(summary_limit, "%d", wt_status_submodule_summary);
+	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", s->index_file);
+
+	memset(&sm_summary, 0, sizeof(sm_summary));
+	sm_summary.argv = argv;
+	sm_summary.env = env;
+	sm_summary.git_cmd = 1;
+	sm_summary.no_stdin = 1;
+	fflush(s->fp);
+	sm_summary.out = dup(fileno(s->fp));    /* run_command closes it */
+	run_command(&sm_summary);
+}
 
 static void wt_status_print_untracked(struct wt_status *s)
 {
@@ -308,6 +342,7 @@ void wt_status_print(struct wt_status *s)
 	}
 
 	wt_status_print_changed(s);
+	wt_status_print_submodule_summary(s);
 	wt_status_print_untracked(s);
 
 	if (s->verbose && !s->is_initial)
@@ -330,6 +365,10 @@ void wt_status_print(struct wt_status *s)
 
 int git_status_config(const char *k, const char *v)
 {
+	if (!strcmp(k, "status.submodulesummary")) {
+		wt_status_submodule_summary = atoi(v);
+		return 0;
+	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		wt_status_use_color = git_config_colorbool(k, v, -1);
 		return 0;
-- 
1.5.5.23.g2a5f
