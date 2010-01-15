From: Michael Wookey <michaelwookey@gmail.com>
Subject: [PATCH] git status: display current branch name in color
Date: Fri, 15 Jan 2010 13:23:16 +1100
Message-ID: <d2e97e801001141823i7519864dy264488d36fca465c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 03:26:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVbtq-0007ID-RK
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 03:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab0AOCXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 21:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411Ab0AOCXh
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 21:23:37 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:49240 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab0AOCXh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 21:23:37 -0500
Received: by pwj9 with SMTP id 9so1848pwj.21
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 18:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=FiQkY98SjoVgI6/2aq9ZHw/morLwSYZZmn6pryohFaQ=;
        b=KdBNDlhL/GG/aBOJhL677DfTkdOUG/P7OJio0EwwTGqcAktcLFxzBV/qbsaJ2NvlR/
         TO4C+v9Lqm0hX12OU5042MwhNSBw+qlx/KS32p9QySKDunTdhfYABQUv0/ExKKC+L1Y8
         j8AaPbIeFadUeHF1F+xJHY+np2YKJRKDDxgX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=u4jtYUobaH9HZHV2aqPlVR9fO1mM5dAsVXKOlSmofG41eODHwuk5prHY3rW2qkzOu/
         PKVSXGByjZ7zVG/nOjJybL7j9ojippXKppb3uM7EDzfNFojewBo4+8JCaHxOmk3mss+n
         f1yLzxfW+/ERGX6CQiJ40S5gxhOtxptN2l8E0=
Received: by 10.115.81.26 with SMTP id i26mr1127330wal.126.1263522216133; Thu, 
	14 Jan 2010 18:23:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137048>

There is an existing highlight when the user is not on any branch.
Enhance this functionality to always provide the name of the current
branch in color.

Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
---
 wt-status.c |   10 ++++++----
 wt-status.h |    3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 5d56988..bdaa98b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -17,6 +17,7 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RED,    /* WT_STATUS_UNTRACKED */
 	GIT_COLOR_RED,    /* WT_STATUS_NOBRANCH */
 	GIT_COLOR_RED,    /* WT_STATUS_UNMERGED */
+	GIT_COLOR_GREEN,  /* WT_STATUS_BRANCH */
 };

 static const char *color(int slot, struct wt_status *s)
@@ -553,7 +554,7 @@ static void wt_status_print_tracking(struct wt_status *s)

 void wt_status_print(struct wt_status *s)
 {
-	const char *branch_color = color(WT_STATUS_HEADER, s);
+	const char *branch_color = color(WT_STATUS_BRANCH, s);

 	if (s->branch) {
 		const char *on_what = "On branch ";
@@ -561,12 +562,13 @@ void wt_status_print(struct wt_status *s)
 		if (!prefixcmp(branch_name, "refs/heads/"))
 			branch_name += 11;
 		else if (!strcmp(branch_name, "HEAD")) {
-			branch_name = "";
+			branch_name = "Not currently on any branch.";
 			branch_color = color(WT_STATUS_NOBRANCH, s);
-			on_what = "Not currently on any branch.";
+			on_what = "";
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "# ");
-		color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
+		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "%s", on_what);
+		color_fprintf_ln(s->fp, branch_color, "%s", branch_name);
 		if (!s->is_initial)
 			wt_status_print_tracking(s);
 	}
diff --git a/wt-status.h b/wt-status.h
index c60f40a..b0cf235 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -12,6 +12,7 @@ enum color_wt_status {
 	WT_STATUS_UNTRACKED,
 	WT_STATUS_NOBRANCH,
 	WT_STATUS_UNMERGED,
+	WT_STATUS_BRANCH,
 };

 enum untracked_status_type {
@@ -40,7 +41,7 @@ struct wt_status {
 	int relative_paths;
 	int submodule_summary;
 	enum untracked_status_type show_untracked_files;
-	char color_palette[WT_STATUS_UNMERGED+1][COLOR_MAXLEN];
+	char color_palette[WT_STATUS_BRANCH+1][COLOR_MAXLEN];

 	/* These are computed during processing of the individual sections */
 	int commitable;
-- 
1.6.6.197.gfd7f6
