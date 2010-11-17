From: aga@iki.fi
Subject: [PATCH] status: show branchname with a configurable color
Date: Thu, 18 Nov 2010 01:40:05 +0200
Message-ID: <1290037205-19470-1-git-send-email-aga@iki.fi>
Cc: gitster@pobox.com, Aleksi Aalto <aga@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 00:48:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIrjW-0007ug-Kt
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 00:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859Ab0KQXsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 18:48:05 -0500
Received: from dusk.niksula.hut.fi ([130.233.40.6]:54154 "EHLO
	mail.niksula.hut.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab0KQXsE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 18:48:04 -0500
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Nov 2010 18:48:03 EST
Received: by mail.niksula.hut.fi (Postfix, from userid 60001)
	id 6107E74184; Thu, 18 Nov 2010 01:41:09 +0200 (EET)
X-Spam-Checker-Version: SpamAssassin 3.3.1-niksula20080612 (2010-03-16) on dusk
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=disabled
	version=3.3.1-niksula20080612
X-Spam-Niksula: No
Received: from kekkonen.cs.hut.fi (kekkonen.cs.hut.fi [130.233.41.50])
	by mail.niksula.hut.fi (Postfix) with ESMTP id 074AE74181;
	Thu, 18 Nov 2010 01:41:06 +0200 (EET)
Received: (from ajaalto@localhost)
	by kekkonen.cs.hut.fi (8.14.3+Sun/8.14.3/Submit) id oAHNf5ra019567;
	Thu, 18 Nov 2010 01:41:05 +0200 (EET)
X-Mailer: git-send-email 1.7.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161640>

From: Aleksi Aalto <aga@iki.fi>

The configuration variable is color.status.branch.

The default color is magenta.

Signed-off-by: Aleksi Aalto <aga@iki.fi>
---
 Documentation/config.txt |   15 +++++++--------
 builtin/commit.c         |    2 ++
 t/t7508-status.sh        |    2 +-
 wt-status.c              |   25 ++++++++++++++-----------
 wt-status.h              |    1 +
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ba9639c..1dd3669 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -769,14 +769,13 @@ color.status::
 	only when the output is to a terminal. Defaults to false.
 
 color.status.<slot>::
-	Use customized color for status colorization. `<slot>` is
-	one of `header` (the header text of the status message),
-	`added` or `updated` (files which are added but not committed),
-	`changed` (files which are changed but not added in the index),
-	`untracked` (files which are not tracked by git), or
-	`nobranch` (the color the 'no branch' warning is shown in, defaulting
-	to red). The values of these variables may be specified as in
-	color.branch.<slot>.
+	Use customized color for status colorization. `<slot>` is one of
+	`header` (the header text of the status message), `added` or `updated`
+	(files which are added but not committed), `changed` (files which
+	are changed but not added in the index), `untracked` (files which
+	are not tracked by git), `branch` (the current branch) or `nobranch`
+	(the color the 'no branch' warning is shown in, defaulting to red). The
+	values of these variables may be specified as in color.branch.<slot>.
 
 color.ui::
 	When set to `always`, always use colors in all git commands which
diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..df4d189 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -984,6 +984,8 @@ static int parse_status_slot(const char *var, int offset)
 {
 	if (!strcasecmp(var+offset, "header"))
 		return WT_STATUS_HEADER;
+	if (!strcasecmp(var+offset, "branch"))
+		return WT_STATUS_ONBRANCH;
 	if (!strcasecmp(var+offset, "updated")
 		|| !strcasecmp(var+offset, "added"))
 		return WT_STATUS_UPDATED;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c9300f3..d755e2a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -386,7 +386,7 @@ test_expect_success 'setup unique colors' '
 '
 
 cat >expect <<\EOF
-# On branch master
+# On branch <MAGENTA>master<RESET>
 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
 #
diff --git a/wt-status.c b/wt-status.c
index fc2438f..ffbbb8f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -13,14 +13,15 @@
 #include "submodule.h"
 
 static char default_wt_status_colors[][COLOR_MAXLEN] = {
-	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
-	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
-	GIT_COLOR_RED,    /* WT_STATUS_CHANGED */
-	GIT_COLOR_RED,    /* WT_STATUS_UNTRACKED */
-	GIT_COLOR_RED,    /* WT_STATUS_NOBRANCH */
-	GIT_COLOR_RED,    /* WT_STATUS_UNMERGED */
-	GIT_COLOR_GREEN,  /* WT_STATUS_LOCAL_BRANCH */
-	GIT_COLOR_RED,    /* WT_STATUS_REMOTE_BRANCH */
+	GIT_COLOR_NORMAL,  /* WT_STATUS_HEADER */
+	GIT_COLOR_MAGENTA, /* WT_STATUS_ONBRANCH */
+	GIT_COLOR_GREEN,   /* WT_STATUS_UPDATED */
+	GIT_COLOR_RED,     /* WT_STATUS_CHANGED */
+	GIT_COLOR_RED,     /* WT_STATUS_UNTRACKED */
+	GIT_COLOR_RED,     /* WT_STATUS_NOBRANCH */
+	GIT_COLOR_RED,     /* WT_STATUS_UNMERGED */
+	GIT_COLOR_GREEN,   /* WT_STATUS_LOCAL_BRANCH */
+	GIT_COLOR_RED,     /* WT_STATUS_REMOTE_BRANCH */
 };
 
 static const char *color(int slot, struct wt_status *s)
@@ -625,7 +626,8 @@ static void wt_status_print_tracking(struct wt_status *s)
 
 void wt_status_print(struct wt_status *s)
 {
-	const char *branch_color = color(WT_STATUS_HEADER, s);
+	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
+	const char *branch_status_color = color(WT_STATUS_HEADER, s);
 
 	if (s->branch) {
 		const char *on_what = "On branch ";
@@ -634,11 +636,12 @@ void wt_status_print(struct wt_status *s)
 			branch_name += 11;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_name = "";
-			branch_color = color(WT_STATUS_NOBRANCH, s);
+			branch_status_color = color(WT_STATUS_NOBRANCH, s);
 			on_what = "Not currently on any branch.";
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "# ");
-		color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
+		color_fprintf(s->fp, branch_status_color, "%s", on_what);
+		color_fprintf_ln(s->fp, branch_color, "%s", branch_name);
 		if (!s->is_initial)
 			wt_status_print_tracking(s);
 	}
diff --git a/wt-status.h b/wt-status.h
index 9df9c9f..2457f20 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -7,6 +7,7 @@
 
 enum color_wt_status {
 	WT_STATUS_HEADER = 0,
+	WT_STATUS_ONBRANCH,
 	WT_STATUS_UPDATED,
 	WT_STATUS_CHANGED,
 	WT_STATUS_UNTRACKED,
-- 
1.7.3.3.gc2223.dirty
