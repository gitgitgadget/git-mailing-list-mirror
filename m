From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 3/5] builtin-status: configurable submodule summary size
Date: Fri, 14 Mar 2008 23:28:39 +0800
Message-ID: <1205508521-7407-4-git-send-email-pkufranky@gmail.com>
References: <1205508521-7407-1-git-send-email-pkufranky@gmail.com>
 <1205508521-7407-2-git-send-email-pkufranky@gmail.com>
 <1205508521-7407-3-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 14 16:29:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaBqZ-0003VC-RZ
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 16:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbYCNP2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 11:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbYCNP2s
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 11:28:48 -0400
Received: from mail.qikoo.org ([60.28.205.235]:50525 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753132AbYCNP2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 11:28:46 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 56C9D470B0; Fri, 14 Mar 2008 23:28:41 +0800 (CST)
X-Mailer: git-send-email 1.5.4.4.653.g7cf1e
In-Reply-To: <1205508521-7407-3-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77242>

Add config variable status.submodulesummary which is passed as
arg for '--summary-limit' of 'git submodule summary' to limit the
submodule summary size.

status.submodulesummary is 0 by default which disables the summary.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 wt-status.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index dc4a88f..7a32c51 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -12,6 +12,7 @@
 
 int wt_status_relative_paths = 1;
 int wt_status_use_color = -1;
+int wt_status_submodule_summary = 0;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	"",         /* WT_STATUS_HEADER: normal */
 	"\033[32m", /* WT_STATUS_UPDATED: green */
@@ -222,12 +223,17 @@ static void wt_status_print_changed(struct wt_status *s)
 }
 static void wt_status_print_submodule_summary(struct wt_status *s)
 {
+	if (! wt_status_submodule_summary) return;
 	struct child_process sm_summary;
+	char summary_limit[64];
+	sprintf(summary_limit, "%d", wt_status_submodule_summary);
 	const char *argv[] = {
 		"submodule",
 		"summary",
 		"--cached",
 		"--for-status",
+		"--summary-limit",
+		summary_limit,
 		s->amend ? "HEAD^" : "HEAD",
 		NULL
 	};
@@ -356,6 +362,10 @@ void wt_status_print(struct wt_status *s)
 
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
1.5.4.4.653.g7cf1e
