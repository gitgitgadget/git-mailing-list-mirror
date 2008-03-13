From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 2/4] builtin-status: submodule summary support
Date: Thu, 13 Mar 2008 21:48:03 +0800
Message-ID: <1205416085-23431-3-git-send-email-pkufranky@gmail.com>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
 <1205416085-23431-2-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 14:48:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZnng-0002ba-1a
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbYCMNsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 09:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbYCMNsM
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 09:48:12 -0400
Received: from mail.qikoo.org ([60.28.205.235]:36325 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752757AbYCMNsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 09:48:10 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 6D541470AF; Thu, 13 Mar 2008 21:48:06 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1205416085-23431-2-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77082>

This commit teaches 'git commit/status' show 'Modified submodules'
section given by 'git submodule summary --cached --for-status'
just before 'Untracked files' section.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 wt-status.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 701d13d..75ee7ba 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -8,6 +8,7 @@
 #include "revision.h"
 #include "diffcore.h"
 #include "quote.h"
+#include "run-command.h"
 
 int wt_status_relative_paths = 1;
 int wt_status_use_color = -1;
@@ -219,6 +220,30 @@ static void wt_status_print_changed(struct wt_status *s)
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
+	run_command(&sm_summary);
+}
 
 static void wt_status_print_untracked(struct wt_status *s)
 {
@@ -321,6 +346,9 @@ void wt_status_print(struct wt_status *s)
 	}
 
 	wt_status_print_changed(s);
+	// must flush s->fp since following call will write to s->fp in a child process
+	fflush(s->fp);
+	wt_status_print_submodule_summary(s);
 	wt_status_print_untracked(s);
 
 	if (s->verbose && !s->is_initial)
-- 
1.5.4.3.347.g5314c
