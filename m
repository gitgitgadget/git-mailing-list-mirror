From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 6/6] branch, checkout: introduce autosetuppush
Date: Sun, 12 Jul 2009 14:17:33 +0200
Message-ID: <1247401053-20429-7-git-send-email-bonzini@gnu.org>
References: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 12 14:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPy0c-0001PY-AH
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 14:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbZGLMR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 08:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbZGLMR4
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 08:17:56 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60356 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbZGLMRv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 08:17:51 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MPy06-0003VA-7R
	for git@vger.kernel.org; Sun, 12 Jul 2009 08:17:50 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123147>

The autosetuppush configuration arranges so that whenever
a merge configuration is setup, a push refspec is added for
the remote.

This is a step towards providing the functionality currently
enabled by push.default=tracking on a per-remote basis, and
without the restriction of pushing a single branch at a time.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/config.txt |   19 +++++++++++++++++++
 branch.c                 |   38 ++++++++++++++++++++++++++++++++++++++
 cache.h                  |    1 +
 config.c                 |    4 ++++
 environment.c            |    3 ++-
 t/t3200-branch.sh        |   36 ++++++++++++++++++++++++++++++++++++
 6 files changed, 100 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 524a222..4c27e9d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -475,6 +475,15 @@ branch.autosetupmerge::
 	done when the starting point is either a local branch or remote
 	branch. This option defaults to true.
 
+branch.autosetuppush::
+	Tells 'git-branch' and 'git-checkout' to setup new branches
+	so that linkgit:git-push[1] will push into the starting point
+	branch.  Note that this option applies only to branches created
+	from a remote branch, and only if git is setting up merging
+	from the remote branch (via any one of branch.autosetupmerge,
+	remote.<name>.autosetupmerge, or `--track`).  This option defaults
+	to false.
+
 branch.autosetuprebase::
 	When a new branch is created with 'git-branch' or 'git-checkout'
 	that tracks another branch, this variable tells git to set
@@ -1369,6 +1378,16 @@ remote.<name>.autosetupmerge::
 	starting point branch.  If present, this overrides the global
 	option branch.autosetupmerge, and can have the same settings.
 
+remote.<name>.autosetuppush::
+	Tells 'git-branch' and 'git-checkout' to setup new branches
+	so that linkgit:git-push[1] will push into the starting point
+	branch.  If present, this overrides the global option
+	branch.autosetuppush, and can have the same settings.
+	Note that this option applies only if git is setting
+	up merging from the remote branch (via any one of
+	branch.autosetupmerge, remote.<name>.autosetupmerge, or
+	`--track`).
+
 remote.<name>.autosetuprebase::
 	When a new branch is created with 'git-branch' or 'git-checkout'
 	that tracks another branch, this variable tells git to set
diff --git a/branch.c b/branch.c
index 8d3e8d8..dfde568 100644
--- a/branch.c
+++ b/branch.c
@@ -51,6 +51,7 @@ void install_branch_config(int flag, const char *local, struct remote *remote,
 			   const char *merge)
 {
 	struct strbuf key = STRBUF_INIT;
+	struct strbuf value = STRBUF_INIT;
 	int rebasing = should_setup_rebase(remote);
 
 	strbuf_addf(&key, "branch.%s.remote", local);
@@ -60,6 +61,13 @@ void install_branch_config(int flag, const char *local, struct remote *remote,
 	strbuf_addf(&key, "branch.%s.merge", local);
 	git_config_set(key.buf, merge);
 
+	if (remote && remote->track.push) {
+		strbuf_reset(&key);
+		strbuf_addf(&key, "remote.%s.push", remote->name);
+		strbuf_addf(&value, "refs/heads/%s:%s", local, merge);
+		git_config_set_multivar(key.buf, value.buf, "^$", 0);
+	}
+
 	if (rebasing) {
 		strbuf_reset(&key);
 		strbuf_addf(&key, "branch.%s.rebase", local);
@@ -83,16 +91,46 @@ void install_branch_config(int flag, const char *local, struct remote *remote,
 		       rebasing ? " by rebasing" : "");
 	}
 	strbuf_release(&key);
+	strbuf_release(&value);
+}
+
+static void strbuf_addstr_escape_re (struct strbuf *buf, const char *add)
+{
+	const char *p = add;
+	while ((add = strpbrk(add, ".*?+^$(){}[]")) != NULL) {
+		strbuf_add(buf, p, add - p);
+		strbuf_addf(buf, "\\%c", *add++);
+		p = add;
+	}
+	strbuf_addstr(buf, p);
 }
 
 void delete_branch_config (const char *name)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf push_re = STRBUF_INIT;
+	struct branch *branch;
+
 	if (prefixcmp(name, "refs/heads/"))
 		return;
+
+	/* git config --unset-all remote.foo.push ^\+?refs/heads/bar:  */
+	branch = branch_get(name + 11);
+	strbuf_addf(&buf, "remote.%s.push", branch->remote_name);
+	strbuf_addstr(&push_re, "^\\+?");
+	strbuf_addstr_escape_re(&push_re, name);
+	strbuf_addch(&push_re, ':');
+	if (git_config_set_multivar(buf.buf, NULL, push_re.buf, 1) < 0) {
+		warning("Update of config-file failed");
+		goto fail;
+	}
+	strbuf_reset(&buf);
 	strbuf_addf(&buf, "branch.%s", name + 11);
 	if (git_config_rename_section(buf.buf, NULL) < 0)
 		warning("Update of config-file failed");
+
+fail:
+	strbuf_release(&push_re);
 	strbuf_release(&buf);
 }
 
diff --git a/cache.h b/cache.h
index 703dc45..2d9a864 100644
--- a/cache.h
+++ b/cache.h
@@ -553,6 +553,7 @@ enum push_default_type {
 struct tracking_config {
 	enum branch_track merge;
 	enum rebase_setup_type rebase;
+	int push;
 };
 
 extern struct tracking_config git_branch_track;
diff --git a/config.c b/config.c
index aa695d4..04380bb 100644
--- a/config.c
+++ b/config.c
@@ -556,6 +556,10 @@ int git_tracking_config(const char *var, const char *value, struct tracking_conf
 		cfg->merge = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, ".autosetuppush")) {
+		cfg->push = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, ".autosetuprebase")) {
 		if (!value)
 			value = "always";
diff --git a/environment.c b/environment.c
index 049d269..2b66ac6 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,8 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 struct tracking_config git_branch_track = {
 	BRANCH_TRACK_REMOTE,
-	AUTOREBASE_NEVER
+	AUTOREBASE_NEVER,
+	0
 };
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 186ba56..5e23cf5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -233,11 +233,47 @@ test_expect_success 'avoid ambiguous track' '
 	git branch all1 master &&
 	test -z "$(git config branch.all1.merge)"
 '
+test_expect_success 'test push setup' \
+    'git config branch.autosetupmerge true &&
+     git config branch.autosetuppush true &&
+     git config remote.local.url . &&
+     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+     (git show-ref -q refs/remotes/local/master || git fetch local) &&
+     git branch my11 local/master &&
+     test $(git config branch.my11.remote) = local &&
+     test $(git config branch.my11.merge) = refs/heads/master
+     test $(git config remote.local.push) = refs/heads/my11:refs/heads/master
+'
+
+test_expect_success 'test multiple push setups' \
+    'git config remote.local.url . &&
+     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+     (git show-ref -q refs/remotes/local/master || git fetch local) &&
+     git branch my12 local/master &&
+     test $(git config branch.my12.remote) = local &&
+     test $(git config branch.my12.merge) = refs/heads/master &&
+     (if git config remote.local.push; then exit 1; else test $? = 2; fi)
+'
+
+test_expect_success 'test push setup cleanup' \
+    'git config branch.autosetupmerge true &&
+     git config branch.autosetuppush true &&
+     git config remote.local.url . &&
+     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+     (git show-ref -q refs/remotes/local/master || git fetch local) &&
+     (git branch my11 local/master || :) &&
+     (git branch my12 local/master || :) &&
+     git branch -d my11 &&
+     test $(git config remote.local.push) = refs/heads/my12:refs/heads/master &&
+     git branch -d my12 &&
+     test z$(git config remote.local.push) = z
+'
 
 test_expect_success 'autosetuprebase local on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase local &&
+	git config branch.autosetuppush false &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase &&
 	git branch --track myr1 mybase &&
-- 
1.6.2.5
