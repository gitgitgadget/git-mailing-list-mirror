X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Allow subcommand.color and color.subcommand color configuration
Date: Wed, 13 Dec 2006 09:13:28 +0000
Message-ID: <200612130913.28917.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 09:28:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 861 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 04:27:54 EST
X-TUID: 74426b20ebab10bc
X-UID: 191
X-Length: 6179
Content-Disposition: inline
X-OriginalArrivalTime: 13 Dec 2006 09:15:28.0991 (UTC) FILETIME=[3B772EF0:01C71E97]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34190>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuQPA-0005gL-4Z for gcvg-git@gmane.org; Wed, 13 Dec
 2006 10:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932633AbWLMJ14 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 04:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWLMJ14
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 04:27:56 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:4702 "EHLO
 369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S932633AbWLMJ1z (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 04:27:55 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Wed, 13 Dec 2006 09:15:28 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GuQB8-0000o3-00 for <git@vger.kernel.org>; Wed, 13 Dec
 2006 09:13:30 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

While adding colour to the branch command it was pointed out that a
config option like "branch.color" conflicts with the pre-existing
"branch.something" namespace used for specifying default merge urls and
branches.  The suggested solution was to flip the order of the
components to "color.branch", which I did for colourising branch.

This patch does the same thing for
  - git-log (color.diff)
  - git-status (color.status)
  - git-diff (color.diff)
  - pager (color.pager)

I haven't removed the old config options; but they should probably be
deprecated and eventually removed to prevent future namespace
collisions.  I've done this deprecation by changing the documentation
for the config file to match the new names; and adding the "color.XXX"
options to contrib/completion/git-completion.bash.

Unfortunately git-svn reads "diff.color" and "pager.color"; which I
don't like to change unilaterally.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 Documentation/config.txt               |   12 ++++++------
 builtin-log.c                          |    2 +-
 config.c                               |    2 +-
 contrib/completion/git-completion.bash |    3 +++
 diff.c                                 |    4 ++--
 wt-status.c                            |    4 ++--
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9090762..9bdd824 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -130,16 +130,16 @@ branch.<name>.merge::
 	When in branch <name>, it tells `git fetch` the default remote branch
 	to be merged.
 
-pager.color::
+color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
 
-diff.color::
+color.diff::
 	When true (or `always`), always use colors in patch.
 	When false (or `never`), never.  When set to `auto`, use
 	colors only when the output is to the terminal.
 
-diff.color.<slot>::
+color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>`
 	specifies which part of the patch to use the specified
 	color, and is one of `plain` (context text), `meta`
@@ -264,19 +264,19 @@ showbranch.default::
 	The default set of branches for gitlink:git-show-branch[1].
 	See gitlink:git-show-branch[1].
 
-status.color::
+color.status::
 	A boolean to enable/disable color in the output of
 	gitlink:git-status[1]. May be set to `true` (or `always`),
 	`false` (or `never`) or `auto`, in which case colors are used
 	only when the output is to a terminal. Defaults to false.
 
-status.color.<slot>::
+color.status.<slot>::
 	Use customized color for status colorization. `<slot>` is
 	one of `header` (the header text of the status message),
 	`updated` (files which are updated but not committed),
 	`changed` (files which are changed but not updated in the index),
 	or `untracked` (files which are not tracked by git). The values of
-	these variables may be specified as in diff.color.<slot>.
+	these variables may be specified as in color.diff.<slot>.
 
 tar.umask::
 	By default, gitlink:git-tar-tree[1] sets file and directories modes
diff --git a/builtin-log.c b/builtin-log.c
index 7acf5d3..6821a08 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -118,7 +118,7 @@ static int git_format_config(const char *var, const char *value)
 		strcat(extra_headers, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.color")) {
+	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		return 0;
 	}
 	return git_log_config(var, value);
diff --git a/config.c b/config.c
index 3cae390..06e7fdb 100644
--- a/config.c
+++ b/config.c
@@ -314,7 +314,7 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "pager.color")) {
+	if (!strcmp(var, "pager.color") || !strcmp(car, "color.pager")) {
 		pager_use_color = git_config_bool(var,value);
 		return 0;
 	}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 447ec20..9c4d23a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -712,10 +712,13 @@ _git_repo_config ()
 		core.legacyHeaders
 		i18n.commitEncoding
 		diff.color
+		color.diff
 		diff.renameLimit
 		diff.renames
 		pager.color
+		color.pager
 		status.color
+		color.status
 		log.showroot
 		show.difftree
 		showbranch.default
diff --git a/diff.c b/diff.c
index 3315378..726b01e 100644
--- a/diff.c
+++ b/diff.c
@@ -60,7 +60,7 @@ int git_diff_ui_config(const char *var, const char *value)
 		diff_rename_limit_default = git_config_int(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.color")) {
+	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		diff_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
@@ -74,7 +74,7 @@ int git_diff_ui_config(const char *var, const char *value)
 			diff_detect_rename_default = DIFF_DETECT_RENAME;
 		return 0;
 	}
-	if (!strncmp(var, "diff.color.", 11)) {
+	if (!strncmp(var, "diff.color.", 11) || !strncmp(var, "color.diff.", 11)) {
 		int slot = parse_diff_color_slot(var, 11);
 		color_parse(value, var, diff_colors[slot]);
 		return 0;
diff --git a/wt-status.c b/wt-status.c
index de1be5b..df582a0 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -297,11 +297,11 @@ void wt_status_print(struct wt_status *s)
 
 int git_status_config(const char *k, const char *v)
 {
-	if (!strcmp(k, "status.color")) {
+	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		wt_status_use_color = git_config_colorbool(k, v);
 		return 0;
 	}
-	if (!strncmp(k, "status.color.", 13)) {
+	if (!strncmp(k, "status.color.", 13) || !strncmp(k, "color.status", 13)) {
 		int slot = parse_status_slot(k, 13);
 		color_parse(v, k, wt_status_colors[slot]);
 	}
-- 
1.4.4.1.g3ece-dirty
