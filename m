From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH v2] New config push.default to decide default behavior for
	push
Date: Wed, 11 Mar 2009 23:01:45 +0100
Message-ID: <20090311220144.GA6782@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 23:08:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhWYs-0006FW-79
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 23:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755603AbZCKWBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 18:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755609AbZCKWBv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 18:01:51 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:54680 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702AbZCKWBu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 18:01:50 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LhWUj-0000xx-1H; Wed, 11 Mar 2009 23:01:45 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112982>

This is intended to replace fg/push-default, I'll repost some of the missing
parts as other patches.

--8<--
New config push.default to decide default behavior for push

Currently git push will push all matching branches to the current
remote.  For some workflows this default is suboptimal, for new users
it is often surprising, and some have found the default behaviour too
easy to trig by accident with unwanted consequences.

Introduce a new configuration variable "push.default" that decides what
action git push should take if no refspecs are given or implied by the
command line arguments or the current remote configuration. If this
variable is unconfigured, display a prominent warning when default
behavior is trigged.

Possible values are:
'nothing'  : Push nothing
'matching' : Current default behaviour, push all branches that already exist
   in the current remote
'tracking' : Push the current branch to whatever it is tracking
'current'  : Push the current branch to a branch of the same name

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 Documentation/RelNotes-1.6.3.txt |    7 +++
 Documentation/config.txt         |   19 +++++++++
 builtin-push.c                   |   80 +++++++++++++++++++++++++++++++++++--
 cache.h                          |    9 ++++
 config.c                         |   25 ++++++++++++
 environment.c                    |    1 +
 6 files changed, 136 insertions(+), 5 deletions(-)

diff --git a/Documentation/RelNotes-1.6.3.txt b/Documentation/RelNotes-1.6.3.txt
index ee1fddb..3eb6bf0 100644
--- a/Documentation/RelNotes-1.6.3.txt
+++ b/Documentation/RelNotes-1.6.3.txt
@@ -22,6 +22,13 @@ branch pointed at by its HEAD, gets a large warning.  You can choose what
 should happen upon such a push by setting the configuration variable
 receive.denyDeleteCurrent in the receiving repository.
 
+In a future release, the default of "git push" without further
+arguments may be changed. Currently, it will push all matching
+refspecs to the current remote.  A configuration variable push.default
+has been introduced to select the default behaviour.  To ease the
+transition, a big warning is issued if this is not configured and a
+git push without arguments is attempted.
+
 
 Updates since v1.6.2
 --------------------
diff --git a/Documentation/config.txt b/Documentation/config.txt
index f5152c5..6fdf829 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1160,6 +1160,25 @@ pull.octopus::
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
+
+	Possible values are:
++
+* `nothing` do not push anything.
+* `matching` push all matching branches to the current remote.
+  All branches having the same name in both ends are considered to be
+  matching. This is the current default value.
+* `tracking` push the current branch to whatever it is tracking.
+* `current` push the current branch to a branch of the same name.
+
 receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
 	objects. It will abort in the case of a malformed object or a
diff --git a/builtin-push.c b/builtin-push.c
index 122fdcf..fa5eabb 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -48,6 +48,75 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
+static void setup_push_tracking(struct remote *remote)
+{
+	int n;
+	struct branch *branch = branch_get(NULL);
+	if (!branch)
+		die("You are not currently on a branch.");
+	if (!branch->merge_nr)
+		die("The current branch %s is not tracking anything.",
+		    branch->name);
+	if (branch->remote != remote)
+		die("The current branch is tracking \"%s\", not \"%s\"!",
+		    branch->remote->name, remote->name);
+	for (n = 0; n < branch->merge_nr; n++) {
+		struct strbuf rs = STRBUF_INIT;
+		strbuf_addf(&rs, "%s:%s", branch->name, branch->merge[n]->src);
+		add_refspec(rs.buf);
+	}
+}
+
+static const char *warn_unconfigured_push_msg[] = {
+	"You did not specify any refspecs to push, and the current remote",
+	"has not configured any push refspecs. The default action in this",
+	"case has been to push all matching refspecs, that is, all branches",
+	"that exist both locally and remotely will be updated.",
+	"This default may change in the future.",
+	"",
+	"You can specify what action you want to take in this case, and",
+	"avoid seeing this message again, by configuring 'push.default' to:",
+	"  'nothing'  : Do not push anythig",
+	"  'matching' : Push all matching branches (the current default)",
+	"  'tracking' : Push the current branch to whatever it is tracking",
+	"  'current'  : Push the current branch",
+	""
+};
+
+static void warn_unconfigured_push()
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(warn_unconfigured_push_msg); i++)
+		warning("%s", warn_unconfigured_push_msg[i]);
+}
+
+static void do_default_push(struct remote *remote)
+{
+	git_config(git_default_config, NULL);
+	switch (push_default) {
+	case PUSH_DEFAULT_UNSPECIFIED:
+		warn_unconfigured_push();
+		/* fallthrough */
+
+	case PUSH_DEFAULT_MATCHING:
+		add_refspec(":");
+		break;
+
+	case PUSH_DEFAULT_TRACKING:
+		setup_push_tracking(remote);
+		break;
+
+	case PUSH_DEFAULT_CURRENT:
+		add_refspec("HEAD");
+		break;
+
+	case PUSH_DEFAULT_NOTHING:
+		die("Nothing to push, and push is configured to push nothing "
+		    "by default.");
+		break;
+	}
+}
+
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
@@ -76,11 +145,12 @@ static int do_push(const char *repo, int flags)
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
+			do_default_push(remote);
 	}
 	errs = 0;
 	for (i = 0; i < remote->url_nr; i++) {
diff --git a/cache.h b/cache.h
index 189151d..df4f117 100644
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
index 0c8c76f..e36a2b0 100644
--- a/config.c
+++ b/config.c
@@ -565,6 +565,28 @@ static int git_default_branch_config(const char *var, const char *value)
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
@@ -588,6 +610,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
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
1.6.2.107.ge47ee.dirty
