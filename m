From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 3/4] builtin-status: configurable submodule summary size
Date: Thu, 13 Mar 2008 21:48:04 +0800
Message-ID: <1205416085-23431-4-git-send-email-pkufranky@gmail.com>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
 <1205416085-23431-2-git-send-email-pkufranky@gmail.com>
 <1205416085-23431-3-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 14:49:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZnng-0002ba-Nd
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbYCMNsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 09:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbYCMNsO
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 09:48:14 -0400
Received: from mail.qikoo.org ([60.28.205.235]:36328 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752691AbYCMNsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 09:48:10 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 9A2DB470B0; Thu, 13 Mar 2008 21:48:06 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1205416085-23431-3-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77084>

Add config variable status.submodulesummary which is passed as
arg for '--summary-limit' of 'git submodule summary' to limit the
submodule summary size.

status.submodulesummary is 0 by default which disables the summary.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 wt-status.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 75ee7ba..2f47e36 100644
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
+	if (wt_status_submodule_summary == 0) return;
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
@@ -371,6 +377,10 @@ void wt_status_print(struct wt_status *s)
 
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
1.5.4.3.347.g5314c
