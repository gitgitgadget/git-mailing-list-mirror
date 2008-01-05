From: Matthias Kestenholz <mk@spinlock.ch>
Subject: [PATCH 1/4] Add infrastructure for a single color config variable
Date: Sat,  5 Jan 2008 15:11:36 +0100
Message-ID: <1199542299-12082-1-git-send-email-mk@spinlock.ch>
References: <1199542226.6209.34.camel@futex>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 05 15:29:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBA1n-0001r9-5u
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 15:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbYAEO3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 09:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbYAEO3I
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 09:29:08 -0500
Received: from mail16.bluewin.ch ([195.186.19.63]:36707 "EHLO
	mail16.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbYAEO3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 09:29:08 -0500
Received: from localhost.localdomain (83.78.66.175) by mail16.bluewin.ch (Bluewin 7.3.121)
        id 476BDE6F002BBBDC; Sat, 5 Jan 2008 14:11:40 +0000
X-Mailer: git-send-email 1.5.4.rc2.1104.gec8ae5-dirty
In-Reply-To: <1199542226.6209.34.camel@futex>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69672>

From: Matthias Kestenholz <matthias@spinlock.ch>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 Documentation/config.txt |    6 ++++++
 color.c                  |   19 +++++++++++++++++++
 color.h                  |   17 +++++++++++++++++
 3 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ee08845..4bebd47 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -438,6 +438,12 @@ color.status.<slot>::
 commit.template::
 	Specify a file to use as the template for new commit messages.
 
+color.ui::
+	When set to `always`, always use colors in all git commands which
+	are capable of colored output. When false (or `never`), never. When
+	set to `true` or `auto`, use colors only when the output is to the
+	terminal. Defaults to false.
+
 diff.autorefreshindex::
 	When using `git diff` to compare with work tree
 	files, do not consider stat-only change as changed.
diff --git a/color.c b/color.c
index 7f66c29..0792571 100644
--- a/color.c
+++ b/color.c
@@ -3,6 +3,9 @@
 
 #define COLOR_RESET "\033[m"
 
+int git_use_color = -1;
+int git_use_color_default = -1;
+
 static int parse_color(const char *name, int len)
 {
 	static const char * const color_names[] = {
@@ -143,6 +146,22 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 	return 0;
 }
 
+int git_color_default_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "color.ui")) {
+		git_use_color_default = git_config_colorbool(var, value, -1);
+		return 0;
+	}
+
+	return git_default_config(var, value);
+}
+
+void git_color_config()
+{
+	if (git_use_color == -1 && git_use_color_default != -1)
+		git_use_color = git_use_color_default;
+}
+
 static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
 		va_list args, const char *trail)
 {
diff --git a/color.h b/color.h
index ff63513..bcb845d 100644
--- a/color.h
+++ b/color.h
@@ -4,7 +4,24 @@
 /* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
 #define COLOR_MAXLEN 24
 
+/*
+ * Use this variable to store the colorbool when reading from the config file.
+ */
+extern int git_use_color;
+
 int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
+
+/*
+ * Use this instead of git_default_config if you need the value of color.ui.
+ */
+int git_color_default_config(const char *var, const char *value);
+
+/*
+ * Call this function after git_config(config_fn_t fn) to set git_use_color,
+ * respecting the value of color.ui.
+ */
+void git_color_config();
+
 void color_parse(const char *var, const char *value, char *dst);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
-- 
1.5.4.rc2.1104.gec8ae5-dirty
