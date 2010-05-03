From: Eli Collins <eli@cloudera.com>
Subject: [PATCH] diff: add configuration option for disabling diff prefixes.
Date: Sun,  2 May 2010 19:03:41 -0700
Message-ID: <1272852221-14927-1-git-send-email-eli@cloudera.com>
Cc: Eli Collins <eli@cloudera.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 03 04:05:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8l2F-0002wK-BT
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 04:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab0ECCDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 22:03:45 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:43927 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab0ECCDp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 22:03:45 -0400
Received: by pxi5 with SMTP id 5so9733pxi.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 19:03:44 -0700 (PDT)
Received: by 10.141.2.14 with SMTP id e14mr3131032rvi.115.1272852224436;
        Sun, 02 May 2010 19:03:44 -0700 (PDT)
Received: from eli-laptop.lan (c-98-210-108-252.hsd1.ca.comcast.net [98.210.108.252])
        by mx.google.com with ESMTPS id q10sm1307012rvp.20.2010.05.02.19.03.42
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 19:03:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146212>

From: Eli Collins <eli@cloudera.com>

With new configuration "diff.noprefix", "git diff" does not show a source or destination prefix ala "git diff --no-prefix".

Signed-off-by: Eli Collins <eli@cloudera.com>
---
 Documentation/config.txt |    2 ++
 diff.c                   |    9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 92f851e..e883952 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -796,6 +796,8 @@ diff.mnemonicprefix::
 	standard "a/" and "b/" depending on what is being compared.  When
 	this configuration is in effect, reverse diff output also swaps
 	the order of the prefixes:
+diff.noprefix::
+	If set, 'git diff' does not show any source or destination prefix.
 `git diff`;;
 	compares the (i)ndex and the (w)ork tree;
 `git diff HEAD`;;
diff --git a/diff.c b/diff.c
index d0ecbc3..07269c2 100644
--- a/diff.c
+++ b/diff.c
@@ -30,6 +30,7 @@ static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
+static int diff_no_prefix;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -100,6 +101,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_mnemonic_prefix = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.noprefix")) {
+		diff_no_prefix = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.external"))
 		return git_config_string(&external_diff_cmd_cfg, var, value);
 	if (!strcmp(var, "diff.wordregex"))
@@ -2559,7 +2564,9 @@ void diff_setup(struct diff_options *options)
 		DIFF_OPT_SET(options, COLOR_DIFF);
 	options->detect_rename = diff_detect_rename_default;
 
-	if (!diff_mnemonic_prefix) {
+	if (diff_no_prefix) {
+		options->a_prefix = options->b_prefix = "";
+	} else if (!diff_mnemonic_prefix) {
 		options->a_prefix = "a/";
 		options->b_prefix = "b/";
 	}
-- 
1.7.1.dirty
