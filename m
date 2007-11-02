From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH 1/3] Implement parsing for new core.whitespace.* options.
Date: Sat,  3 Nov 2007 00:34:19 +1100
Message-ID: <11940104611948-git-send-email-dsymonds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	David Symonds <dsymonds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 14:35:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inwfv-0003VG-QS
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 14:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266AbXKBNe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 09:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756243AbXKBNe3
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 09:34:29 -0400
Received: from ipmail03.adl2.internode.on.net ([203.16.214.135]:7063 "EHLO
	ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756205AbXKBNe1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 09:34:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAO3DKkd5LCBH/2dsb2JhbACBW45c
X-IronPort-AV: E=Sophos;i="4.21,362,1188743400"; 
   d="scan'208";a="180027720"
Received: from ppp121-44-32-71.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.32.71])
  by ipmail03.adl2.internode.on.net with ESMTP; 03 Nov 2007 00:04:25 +1030
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63119>

Each of the new core.whitespace.* options (enumerated below) can be set to one
of:
	* okay (default): Whitespace of this type is okay
	* warn: Whitespace of this type should be warned about
	* error: Whitespace of this type should raise an error
	* autofix: Whitespace of this type should be automatically fixed

The initial options are:
	* trailing: Whitespace at the end of a line
	* space-before-tab: SP HT sequence in the initial whitespace of a line
	* space-indent: At least 8 spaces in a row at the start of a line

Example usage:
	[core "whitespace"]
		trailing = autofix
		space-before-tab = error
		space-indent = warn

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 cache.h       |   16 ++++++++++++++++
 config.c      |   28 ++++++++++++++++++++++++++++
 environment.c |    3 +++
 3 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index bfffa05..51e3982 100644
--- a/cache.h
+++ b/cache.h
@@ -602,4 +602,20 @@ extern int diff_auto_refresh_index;
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
 
+/*
+ * whitespace rules.
+ * used by both diff and apply
+ */
+enum whitespace_mode {
+	WS_OKAY = 0,
+	WS_WARN,
+	WS_ERROR,
+	WS_AUTOFIX
+};
+extern enum whitespace_mode ws_mode_trailing;
+extern enum whitespace_mode ws_mode_space_before_tab;
+extern enum whitespace_mode ws_mode_space_indent;
+extern enum whitespace_mode git_config_whitespace_mode(const char *, const char *);
+
+
 #endif /* CACHE_H */
diff --git a/config.c b/config.c
index dc3148d..8e6f252 100644
--- a/config.c
+++ b/config.c
@@ -297,6 +297,19 @@ int git_config_bool(const char *name, const char *value)
 	return git_config_int(name, value) != 0;
 }
 
+enum whitespace_mode git_config_whitespace_mode(const char *name, const char *value)
+{
+	if (!strcasecmp(value, "okay"))
+		return WS_OKAY;
+	if (!strcasecmp(value, "warn"))
+		return WS_WARN;
+	if (!strcasecmp(value, "error"))
+		return WS_ERROR;
+	if (!strcasecmp(value, "autofix"))
+		return WS_AUTOFIX;
+	die("bad config value for '%s' in %s", name, config_file_name);
+}
+
 int git_default_config(const char *var, const char *value)
 {
 	/* This needs a better name */
@@ -431,6 +444,21 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.whitespace.trailing")) {
+		ws_mode_trailing = git_config_whitespace_mode(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.whitespace.space-before-tab")) {
+		ws_mode_space_before_tab = git_config_whitespace_mode(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.whitespace.space-indent")) {
+		ws_mode_space_indent = git_config_whitespace_mode(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index b5a6c69..71502fc 100644
--- a/environment.c
+++ b/environment.c
@@ -35,6 +35,9 @@ int pager_in_use;
 int pager_use_color = 1;
 char *editor_program;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
+enum whitespace_mode ws_mode_trailing = WS_OKAY;
+enum whitespace_mode ws_mode_space_before_tab = WS_OKAY;
+enum whitespace_mode ws_mode_space_indent = WS_OKAY;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
-- 
1.5.3.1
