From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/1] status: display "doing what" information in git status
Date: Thu,  5 May 2011 23:48:46 +0200
Message-ID: <1304632126-16733-1-git-send-email-madcoder@debian.org>
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:55:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI6Vd-0007E2-Ne
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 23:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724Ab1EEVyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 17:54:46 -0400
Received: from pan.madism.org ([88.191.52.104]:35375 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335Ab1EEVyo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 17:54:44 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 May 2011 17:54:44 EDT
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 69B7851AA1;
	Thu,  5 May 2011 23:48:57 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id AD374EBF; Thu,  5 May 2011 23:48:56 +0200 (CEST)
X-Mailer: git-send-email 1.7.5.1.289.g76e37.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172919>

This provides the same information as the git bash prompt about the
current operation that is going on: rebase, merge, am, cherry-pick or
bisect.

This is very useful for "beginners" who don't have their shell prompt set
up for git.

The logic has been largely borrowed from
contrib/completion/git-completion.bash

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 wt-status.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 9f4e0ba..aad0f7f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -527,6 +527,79 @@ static void wt_status_print_unmerged(struct wt_status *s)
 
 }
 
+static int wt_has_file(const char *what)
+{
+	char path[PATH_MAX];
+
+	return access(git_snpath(path, sizeof(path), "%s", what), F_OK) == 0;
+}
+
+static void wt_status_print_doingwhat(struct wt_status *s)
+{
+	const char *status_header   = color(WT_STATUS_HEADER, s);
+	const char *status_nobranch = color(WT_STATUS_NOBRANCH, s);
+	struct strbuf sb = STRBUF_INIT;
+	char path[PATH_MAX];
+
+	if (wt_has_file("rebase-merge/interactive")) {
+		status_printf(s, status_header, "");
+
+		git_snpath(path, sizeof(path), "%s", "rebase-merge/head-name");
+		strbuf_read_file(&sb, path, 0);
+		strbuf_rtrim(&sb);
+
+		status_printf_more(s, status_nobranch,
+				   _("in the middle of a git rebase -i of %s"),
+				   prefixcmp(sb.buf, "refs/heads/") == 0 ?
+				   sb.buf + 11 : sb.buf);
+	} else if (wt_has_file("rebase-merge")) {
+		status_printf(s, status_header, "");
+
+		git_snpath(path, sizeof(path), "%s", "rebase-merge/head-name");
+		strbuf_read_file(&sb, path, 0);
+		strbuf_rtrim(&sb);
+
+		status_printf_more(s, status_nobranch,
+				   _("in the middle of a git rebase -m on %s"),
+				   prefixcmp(sb.buf, "refs/heads/") == 0 ?
+				   sb.buf + 11 : sb.buf);
+	} else {
+		if (wt_has_file("rebase-apply")) {
+			status_printf(s, status_header, "");
+
+			if (wt_has_file("rebase-apply/rebasing")) {
+				status_printf_more(s, status_nobranch,
+						   _("in the middle of a git rebase"));
+			} else if (wt_has_file("rebase-apply/applying")) {
+				status_printf_more(s, status_nobranch,
+						   _("in the middle of a git am"));
+			} else {
+				status_printf_more(s, status_nobranch,
+						   _("in the middle of a git rebase or am"));
+			}
+		} else if (wt_has_file("MERGE_HEAD")) {
+			status_printf(s, status_header, "");
+
+			status_printf_more(s, status_nobranch,
+					   _("in the middle of a git merge"));
+		} else if (wt_has_file("CHERRY_PICK_HEAD")) {
+			status_printf(s, status_header, "");
+
+			status_printf_more(s, status_nobranch,
+					   _("in the middle of a git cherry-pick"));
+		} else if (wt_has_file("BISECT_LOG")) {
+			status_printf(s, status_header, "");
+
+			status_printf_more(s, status_nobranch,
+					   _("in the middle of a git bisect"));
+		} else {
+			return;
+		}
+	}
+	status_printf_more(s, status_header, "\n");
+	strbuf_release(&sb);
+}
+
 static void wt_status_print_updated(struct wt_status *s)
 {
 	int shown_header = 0;
@@ -732,6 +805,7 @@ void wt_status_print(struct wt_status *s)
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
 	}
 
+	wt_status_print_doingwhat(s);
 	wt_status_print_updated(s);
 	wt_status_print_unmerged(s);
 	wt_status_print_changed(s);
-- 
1.7.5.1.289.g76e37.dirty
