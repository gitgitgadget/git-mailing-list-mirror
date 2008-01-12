From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 4/5] git-status: submodule summary support
Date: Sat, 12 Jan 2008 15:37:14 +0800
Message-ID: <b220c31f973576dfc1a90ee588bbfd01cd8f6409.1200122041.git.pkufranky@gmail.com>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
 <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
 <62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
 <bce0ee9fde688c27fc788fab91a571184918da67.1200122041.git.pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 08:53:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDbBH-00043k-Me
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759445AbYALHxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 02:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758804AbYALHw7
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:52:59 -0500
Received: from mail.qikoo.org ([60.28.205.235]:51678 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758568AbYALHwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 02:52:47 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 9245947098; Sat, 12 Jan 2008 15:37:15 +0800 (CST)
X-Mailer: git-send-email 1.5.4.rc2.9.gf5146-dirty
In-Reply-To: <bce0ee9fde688c27fc788fab91a571184918da67.1200122041.git.pkufranky@gmail.com>
In-Reply-To: <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
References: <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70287>

By introducing this commit, 'git commit/status' will additionally show
'Submodules modified' section given by 'git --cached submodule summary' just
before 'Untracked files' section.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 wt-status.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index c0c2472..df5be80 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "diffcore.h"
+#include "run-command.h"
 
 int wt_status_relative_paths = 1;
 int wt_status_use_color = 0;
@@ -271,6 +272,30 @@ static void wt_status_print_changed(struct wt_status *s)
 	wt_read_cache(s);
 	run_diff_files(&rev, 0);
 }
+static void wt_status_print_submodule_summary(struct wt_status *s)
+{
+	struct child_process sm_summary;
+	const char *argv[] = {
+		"submodule",
+		"summary",
+		"--cached",
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
@@ -374,6 +399,9 @@ void wt_status_print(struct wt_status *s)
 	}
 
 	wt_status_print_changed(s);
+	// we must flush s->fp here since the following call will write to s->fp in a child process
+	fflush(s->fp);
+	wt_status_print_submodule_summary(s);
 	wt_status_print_untracked(s);
 
 	if (s->verbose && !s->is_initial)
-- 
1.5.4.rc2.9.gf5146-dirty
