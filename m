From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 1/3] builtin-status: submodule summary support
Date: Wed, 12 Mar 2008 10:21:50 +0800
Message-ID: <1205288512-20435-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 03:22:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZGcC-0003AZ-Gp
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 03:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbYCLCWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 22:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbYCLCWA
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 22:22:00 -0400
Received: from mail.qikoo.org ([60.28.205.235]:55351 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751385AbYCLCV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 22:21:59 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 109EF470AE; Wed, 12 Mar 2008 10:21:53 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76910>

This commit teaches 'git commit/status' show 'Modified submodules'
section given by 'git submodule summary --cached --for-status'
just before 'Untracked files' section.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 wt-status.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 701d13d..6d36e54 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -8,6 +8,7 @@
 #include "revision.h"
 #include "diffcore.h"
 #include "quote.h"
+#include "run-command.h"
 
 int wt_status_relative_paths = 1;
 int wt_status_use_color = -1;
@@ -219,6 +220,33 @@ static void wt_status_print_changed(struct wt_status *s)
 	rev.diffopt.format_callback_data = s;
 	run_diff_files(&rev, 0);
 }
+static void wt_status_print_submodule_summary(struct wt_status *s)
+{
+	struct child_process sm_summary;
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
+	char index[PATH_MAX];
+	const char *env[2] = { index, NULL };
+	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", s->index_file);
+
+	memset(&sm_summary, 0, sizeof(sm_summary));
+	sm_summary.argv = argv;
+	sm_summary.env = env;
+	sm_summary.git_cmd = 1;
+	sm_summary.no_stdin = 1;
+	fflush(s->fp);
+	sm_summary.out = dup(fileno(s->fp));    /* run_command closes it */
+	sm_summary.no_stderr = 1;
+	run_command(&sm_summary);
+}
 
 static void wt_status_print_untracked(struct wt_status *s)
 {
@@ -321,6 +349,9 @@ void wt_status_print(struct wt_status *s)
 	}
 
 	wt_status_print_changed(s);
+	// must flush s->fp since following call will write to s->fp in a child process
+	fflush(s->fp);
+	wt_status_print_submodule_summary(s);
 	wt_status_print_untracked(s);
 
 	if (s->verbose && !s->is_initial)
-- 
1.5.4.3.347.g5314c
