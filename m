From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 1/2] New config push.default to decide default behavior for push
Date: Mon, 16 Mar 2009 16:42:51 +0100
Message-ID: <1237218172-16565-2-git-send-email-finnag@pvv.org>
References: <1237218172-16565-1-git-send-email-finnag@pvv.org>
Cc: gitster@pobox.com, Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 16:45:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjF0H-0001AL-NM
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 16:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbZCPPnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 11:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbZCPPnd
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 11:43:33 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:53585 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbZCPPnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 11:43:32 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1LjEyJ-0004WS-GX; Mon, 16 Mar 2009 16:43:25 +0100
X-Mailer: git-send-email 1.6.2.99.g52e77
In-Reply-To: <1237218172-16565-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113337>

When "git push" is not told what refspecs to push, it pushes all matching
branches to the current remote.  For some workflows this default is not
useful, and surprises new users.  Some have even found that this default
behaviour is too easy to trigger by accident with unwanted consequences.

Introduce a new configuration variable "push.default" that decides what
action git push should take if no refspecs are given or implied by the
command line arguments or the current remote configuration.

Possible values are:

  'nothing'  : Push nothing;
  'matching' : Current default behaviour, push all branches that already
               exist in the current remote;
  'tracking' : Push the current branch to whatever it is tracking;
  'current'  : Push the current branch to a branch of the same name,
               i.e. HEAD.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 Documentation/config.txt |   18 +++++++++++++++
 builtin-push.c           |   53 +++++++++++++++++++++++++++++++++++++++++----
 cache.h                  |    9 +++++++
 config.c                 |   28 ++++++++++++++++++++++++
 environment.c            |    1 +
 5 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 56bd781..1a27f60 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1170,6 +1170,24 @@ pull.octopus::
 pull.twohead::
 	The default merge strategy to use when pulling a single branch.
 
+push.default::
+	Defines the action git push should take if no refspec is given
+	on the command line, no refspec is configured in the remote, and
+	no refspec is implied by any of the options given on the command
+	line.
++
+The term `current remote` means the remote configured for the current
+branch, or `origin` if no remote is configured. `origin` is also used
+if you are not on any branch. Possible values are:
++
+* `nothing` do not push anything.
+* `matching` push all matching branches to the current remote.
+  All branches having the same name in both ends are considered to be
+  matching. This is the current default value.
+* `tracking` push the current branch to the branch it is tracking.
+* `current` push the current branch to a branch of the same name on the
+  current remote.
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
diff --git a/builtin-push.c b/builtin-push.c
index 122fdcf..45fe843 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -48,6 +48,48 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
+static void setup_push_tracking(void)
+{
+	struct strbuf refspec = STRBUF_INIT;
+	struct branch *branch = branch_get(NULL);
+	if (!branch)
+		die("You are not currently on a branch.");
+	if (!branch->merge_nr)
+		die("The current branch %s is not tracking anything.",
+		    branch->name);
+	if (branch->merge_nr != 1)
+		die("The current branch %s is tracking multiple branches, "
+		    "refusing to push.", branch->name);
+	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
+	add_refspec(refspec.buf);
+}
+
+static void setup_default_push_refspecs(void)
+{
+	git_config(git_default_config, NULL);
+	switch (push_default) {
+	case PUSH_DEFAULT_UNSPECIFIED:
+		/* fallthrough */
+
+	case PUSH_DEFAULT_MATCHING:
+		add_refspec(":");
+		break;
+
+	case PUSH_DEFAULT_TRACKING:
+		setup_push_tracking();
+		break;
+
+	case PUSH_DEFAULT_CURRENT:
+		add_refspec("HEAD");
+		break;
+
+	case PUSH_DEFAULT_NOTHING:
+		die("You didn't specify any refspecs to push, and "
+		    "push.default is \"nothing\".");
+		break;
+	}
+}
+
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
@@ -76,11 +118,12 @@ static int do_push(const char *repo, int flags)
 		return error("--all and --mirror are incompatible");
 	}
 
-	if (!refspec
-		&& !(flags & TRANSPORT_PUSH_ALL)
-		&& remote->push_refspec_nr) {
-		refspec = remote->push_refspec;
-		refspec_nr = remote->push_refspec_nr;
+	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
+		if (remote->push_refspec_nr) {
+			refspec = remote->push_refspec;
+			refspec_nr = remote->push_refspec_nr;
+		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
+			setup_default_push_refspecs();
 	}
 	errs = 0;
 	for (i = 0; i < remote->url_nr; i++) {
diff --git a/cache.h b/cache.h
index fdc4ada..93f00a4 100644
--- a/cache.h
+++ b/cache.h
@@ -541,8 +541,17 @@ enum rebase_setup_type {
 	AUTOREBASE_ALWAYS,
 };
 
+enum push_default_type {
+	PUSH_DEFAULT_UNSPECIFIED = -1,
+	PUSH_DEFAULT_NOTHING = 0,
+	PUSH_DEFAULT_MATCHING,
+	PUSH_DEFAULT_TRACKING,
+	PUSH_DEFAULT_CURRENT,
+};
+
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
+extern enum push_default_type push_default;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index 0c8c76f..28ac0fb 100644
--- a/config.c
+++ b/config.c
@@ -565,6 +565,31 @@ static int git_default_branch_config(const char *var, const char *value)
 	return 0;
 }
 
+static int git_default_push_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "push.default")) {
+		if (!value)
+			return config_error_nonbool(var);
+		else if (!strcmp(value, "nothing"))
+			push_default = PUSH_DEFAULT_NOTHING;
+		else if (!strcmp(value, "matching"))
+			push_default = PUSH_DEFAULT_MATCHING;
+		else if (!strcmp(value, "tracking"))
+			push_default = PUSH_DEFAULT_TRACKING;
+		else if (!strcmp(value, "current"))
+			push_default = PUSH_DEFAULT_CURRENT;
+		else {
+			error("Malformed value for %s: %s", var, value);
+			return error("Must be one of nothing, matching, "
+				     "tracking or current.");
+		}		
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
@@ -588,6 +613,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
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
1.6.2.1.138.gc403b.dirty
