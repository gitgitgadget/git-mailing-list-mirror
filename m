From: Matthias Kestenholz <mk@spinlock.ch>
Subject: [PATCH 3/4] status and commit: Use color configuration infrastructure
Date: Sat,  5 Jan 2008 15:11:38 +0100
Message-ID: <1199542299-12082-3-git-send-email-mk@spinlock.ch>
References: <1199542226.6209.34.camel@futex>
 <1199542299-12082-1-git-send-email-mk@spinlock.ch>
 <1199542299-12082-2-git-send-email-mk@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 05 15:19:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB9sG-0007dv-5v
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 15:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYAEOTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 09:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbYAEOTH
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 09:19:07 -0500
Received: from mail16.bluewin.ch ([195.186.19.63]:34956 "EHLO
	mail16.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbYAEOTG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 09:19:06 -0500
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jan 2008 09:19:06 EST
Received: from localhost.localdomain (83.78.66.175) by mail16.bluewin.ch (Bluewin 7.3.121)
        id 476BDE6F002BBBDE; Sat, 5 Jan 2008 14:11:40 +0000
X-Mailer: git-send-email 1.5.4.rc2.1104.gec8ae5-dirty
In-Reply-To: <1199542299-12082-2-git-send-email-mk@spinlock.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69671>

From: Matthias Kestenholz <matthias@spinlock.ch>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 builtin-commit.c |    8 +++++---
 wt-status.c      |    7 +++----
 wt-status.h      |    1 -
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 73f1e35..e442b5f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -7,6 +7,7 @@
 
 #include "cache.h"
 #include "cache-tree.h"
+#include "color.h"
 #include "dir.h"
 #include "builtin.h"
 #include "diff.h"
@@ -435,10 +436,10 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 	if (only_include_assumed)
 		fprintf(fp, "# %s\n", only_include_assumed);
 
-	saved_color_setting = wt_status_use_color;
-	wt_status_use_color = 0;
+	saved_color_setting = git_use_color;
+	git_use_color = 0;
 	commitable = run_status(fp, index_file, prefix, 1);
-	wt_status_use_color = saved_color_setting;
+	git_use_color = saved_color_setting;
 
 	fclose(fp);
 
@@ -639,6 +640,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	int commitable;
 
 	git_config(git_status_config);
+	git_color_config();
 
 	argc = parse_and_validate_options(argc, argv, builtin_status_usage);
 
diff --git a/wt-status.c b/wt-status.c
index c0c2472..ebcbe5a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -9,7 +9,6 @@
 #include "diffcore.h"
 
 int wt_status_relative_paths = 1;
-int wt_status_use_color = 0;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	"",         /* WT_STATUS_HEADER: normal */
 	"\033[32m", /* WT_STATUS_UPDATED: green */
@@ -40,7 +39,7 @@ static int parse_status_slot(const char *var, int offset)
 
 static const char* color(int slot)
 {
-	return wt_status_use_color ? wt_status_colors[slot] : "";
+	return git_use_color > 0 ? wt_status_colors[slot] : "";
 }
 
 void wt_status_prepare(struct wt_status *s)
@@ -397,7 +396,7 @@ void wt_status_print(struct wt_status *s)
 int git_status_config(const char *k, const char *v)
 {
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
-		wt_status_use_color = git_config_colorbool(k, v, -1);
+		git_use_color = git_config_colorbool(k, v, -1);
 		return 0;
 	}
 	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
@@ -409,5 +408,5 @@ int git_status_config(const char *k, const char *v)
 		wt_status_relative_paths = git_config_bool(k, v);
 		return 0;
 	}
-	return git_default_config(k, v);
+	return git_color_default_config(k, v);
 }
diff --git a/wt-status.h b/wt-status.h
index 02afaa6..05b05ba 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -28,7 +28,6 @@ struct wt_status {
 };
 
 int git_status_config(const char *var, const char *value);
-int wt_status_use_color;
 int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
-- 
1.5.4.rc2.1104.gec8ae5-dirty
