From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 2/7] New config option push.default
Date: Mon,  9 Mar 2009 23:35:46 +0100
Message-ID: <1236638151-6465-3-git-send-email-finnag@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 00:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgonQ-0003Hb-Qc
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 00:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbZCIXUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 19:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbZCIXUn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 19:20:43 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:36508 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538AbZCIXUm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 19:20:42 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1Lgo53-0002Lo-6r
	for git@vger.kernel.org; Mon, 09 Mar 2009 23:36:19 +0100
X-Mailer: git-send-email 1.6.2.99.g52e77
In-Reply-To: <1236638151-6465-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112756>

This option takes effect when no refspec is given explicitly or implicitly
by any of the command line arguments to push, and no refspec is configured
for the current remote. The possible values are:
* nothing - do not push anything
* current - push the current branch to whatever it is tracking
* matching - push all branches that already exist remotely (same name)

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 Documentation/config.txt |   18 ++++++++++++++++++
 cache.h                  |    8 ++++++++
 config.c                 |   23 +++++++++++++++++++++++
 environment.c            |    1 +
 4 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f5152c5..50bc1d0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1160,6 +1160,24 @@ pull.octopus::
 pull.twohead::
 	The default merge strategy to use when pulling a single branch.
 
+push.default::
+	Defines the action git push should take if no refspec is given
+	on the command line, no refspec is configured in the remote, and
+	no refspec is implied by any of the options given on the command
+	line.
+
+	The term `current remote` means the remote configured for the current
+	branch, or `origin` if no remote is configured. `origin` is also used
+	if you are not on any branch.
++
+* `nothing` do not push anything
+* `matching` push all matching branches to the current remote.
+  All branches having the same name in both ends are considered to be
+  matching. This is the default value.
+* `current` push the current branch to the branch it is tracking on
+  the remote
+
+
 receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
 	objects. It will abort in the case of a malformed object or a
diff --git a/cache.h b/cache.h
index 189151d..3a6acb8 100644
--- a/cache.h
+++ b/cache.h
@@ -541,8 +541,16 @@ enum rebase_setup_type {
 	AUTOREBASE_ALWAYS,
 };
 
+enum push_default_type {
+	PUSH_DEFAULT_UNSPECIFIED = -1,
+	PUSH_DEFAULT_NOTHING = 0,
+	PUSH_DEFAULT_MATCHING,
+	PUSH_DEFAULT_CURRENT,
+};
+
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
+extern enum push_default_type push_default;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index 0c8c76f..12d5a2b 100644
--- a/config.c
+++ b/config.c
@@ -565,6 +565,26 @@ static int git_default_branch_config(const char *var, const char *value)
 	return 0;
 }
 
+static int git_default_push_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "push.default")) {
+		if (!value)
+			return config_error_nonbool(var);
+		else if (!strcmp(value, "nothing"))
+			push_default = PUSH_DEFAULT_NOTHING;
+		else if (!strcmp(value, "current"))
+			push_default = PUSH_DEFAULT_CURRENT;
+		else if (!strcmp(value, "matching"))
+			push_default = PUSH_DEFAULT_MATCHING;
+		else
+			return error("Malformed value for %s", var);
+		return 0;
+	}
+
+	/* Add other config variables here and to Documentation/config.txt. */
+	return 0;
+}
+
 static int git_default_mailmap_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "mailmap.file"))
@@ -588,6 +608,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	if (!prefixcmp(var, "branch."))
 		return git_default_branch_config(var, value);
 
+	if (!prefixcmp(var, "push."))
+		return git_default_push_config(var, value);
+
 	if (!prefixcmp(var, "mailmap."))
 		return git_default_mailmap_config(var, value);
 
diff --git a/environment.c b/environment.c
index e278bce..4696885 100644
--- a/environment.c
+++ b/environment.c
@@ -42,6 +42,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
+enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
-- 
1.6.2.105.g6ff1f.dirty
