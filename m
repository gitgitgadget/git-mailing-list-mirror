From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 3/6] introduce a struct tracking_config
Date: Sun, 12 Jul 2009 14:17:30 +0200
Message-ID: <1247401053-20429-4-git-send-email-bonzini@gnu.org>
References: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 12 14:17:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPy09-0001H1-Oe
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 14:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbZGLMRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 08:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZGLMRq
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 08:17:46 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60353 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbZGLMRn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 08:17:43 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MPxzy-0003Sx-UU
	for git@vger.kernel.org; Sun, 12 Jul 2009 08:17:43 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123144>

This struct groups together the settings for autosetupmerge and
autosetuprebase.

This refactoring will make it easier to add per-remote tracking
configuration, as well as making the addition of autosetuppush
more tidy.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 branch.c           |    2 +-
 builtin-branch.c   |    2 +-
 builtin-checkout.c |    2 +-
 cache.h            |    9 +++++++--
 config.c           |   34 +++++++++++++++++++++++++---------
 environment.c      |    6 ++++--
 6 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/branch.c b/branch.c
index d17c5ec..be683d9 100644
--- a/branch.c
+++ b/branch.c
@@ -34,7 +34,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 
 static int should_setup_rebase(struct remote *origin)
 {
-	switch (autorebase) {
+	switch (git_branch_track.rebase) {
 	case AUTOREBASE_NEVER:
 		return 0;
 	case AUTOREBASE_LOCAL:
diff --git a/builtin-branch.c b/builtin-branch.c
index 5687d60..fdd6c05 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -595,7 +595,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (branch_use_color == -1)
 		branch_use_color = git_use_color_default;
 
-	track = git_branch_track;
+	track = git_branch_track.merge;
 
 	head = resolve_ref("HEAD", head_sha1, 0, NULL);
 	if (!head)
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 8a9a474..446cac7 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -624,7 +624,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	}
 
 	if (opts.track == BRANCH_TRACK_UNSPECIFIED)
-		opts.track = git_branch_track;
+		opts.track = git_branch_track.merge;
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
diff --git a/cache.h b/cache.h
index f1e5ede..2db4c3b 100644
--- a/cache.h
+++ b/cache.h
@@ -550,8 +550,12 @@ enum push_default_type {
 	PUSH_DEFAULT_CURRENT,
 };
 
-extern enum branch_track git_branch_track;
-extern enum rebase_setup_type autorebase;
+struct tracking_config {
+	enum branch_track merge;
+	enum rebase_setup_type rebase;
+};
+
+extern struct tracking_config git_branch_track;
 extern enum push_default_type push_default;
 
 enum object_creation_mode {
@@ -632,6 +636,7 @@ enum sharedrepo {
 	PERM_EVERYBODY      = 0664,
 };
 int git_config_perm(const char *var, const char *value);
+int git_config_tracking(const char *var, const char *value, struct tracking_config *cfg);
 int set_shared_perm(const char *path, int mode);
 #define adjust_shared_perm(path) set_shared_perm((path), 0)
 int safe_create_leading_directories(char *path);
diff --git a/config.c b/config.c
index b47a40e..aa695d4 100644
--- a/config.c
+++ b/config.c
@@ -545,29 +545,30 @@ static int git_default_i18n_config(const char *var, const char *value)
 	return 0;
 }
 
-static int git_default_branch_config(const char *var, const char *value)
+int git_tracking_config(const char *var, const char *value, struct tracking_config *cfg)
 {
-	if (!strcmp(var, "branch.autosetupmerge")) {
+	var = strrchr (var, '.');
+	if (!strcmp(var, ".autosetupmerge")) {
 		if (value && !strcasecmp(value, "always")) {
-			git_branch_track = BRANCH_TRACK_ALWAYS;
+			cfg->merge = BRANCH_TRACK_ALWAYS;
 			return 0;
 		}
-		git_branch_track = git_config_bool(var, value);
+		cfg->merge = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "branch.autosetuprebase")) {
+	if (!strcmp(var, ".autosetuprebase")) {
 		if (!value)
 			value = "always";
-		autorebase = AUTOREBASE_NEVER;
+		cfg->rebase = AUTOREBASE_NEVER;
 		if (!strcmp(value, "never"))
 			;
 		else if (!strcmp(value, "local"))
-			autorebase = AUTOREBASE_LOCAL;
+			cfg->rebase = AUTOREBASE_LOCAL;
 		else if (!strcmp(value, "remote"))
-			autorebase = AUTOREBASE_REMOTE;
+			cfg->rebase = AUTOREBASE_REMOTE;
 		else if (!strcmp(value, "always") ||
 			 git_config_bool (var, value))
-			autorebase = AUTOREBASE_ALWAYS;
+			cfg->rebase = AUTOREBASE_ALWAYS;
 		return 0;
 	}
 
@@ -575,6 +576,21 @@ static int git_default_branch_config(const char *var, const char *value)
 	return 0;
 }
 
+static int git_default_branch_config(const char *var, const char *value)
+{
+	int result;
+
+	if (!prefixcmp(var, "branch.")
+	    && !strchr (var + 7, '.')) {
+		result = git_tracking_config (var, value, &git_branch_track);
+		if (result)
+			return result;
+	}
+
+	/* Add other config variables here and to Documentation/config.txt. */
+	return 0;
+}
+
 static int git_default_push_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "push.default")) {
diff --git a/environment.c b/environment.c
index 801a005..049d269 100644
--- a/environment.c
+++ b/environment.c
@@ -40,8 +40,10 @@ const char *excludes_file;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
-enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
-enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
+struct tracking_config git_branch_track = {
+	BRANCH_TRACK_REMOTE,
+	AUTOREBASE_NEVER
+};
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
-- 
1.6.2.5
