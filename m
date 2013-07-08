From: Michael Schubert <mschub@elegosoft.com>
Subject: [RFC/PATCH] fetch: make --prune configurable
Date: Mon,  8 Jul 2013 14:56:57 +0200
Message-ID: <1373288217-20580-1-git-send-email-mschub@elegosoft.com>
Cc: Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 08 15:07:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwBAK-0004ST-P8
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 15:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab3GHNHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 09:07:37 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:50297 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278Ab3GHNHg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 09:07:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 1E094DE062;
	Mon,  8 Jul 2013 15:07:35 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PgJpf6Z8nl1Y; Mon,  8 Jul 2013 15:07:35 +0200 (CEST)
Received: from pc.elego.de (unknown [46.189.27.162])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id EE1C7DE05B;
	Mon,  8 Jul 2013 15:07:34 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.2.734.gbcd3b20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229847>

$gmane/201715 brought up the idea to fetch --prune by default.
Since --prune is a "potentially destructive operation" (Git doesn't
keep reflogs for deleted references yet), we don't want to prune
without users consent.

To accommodate users who want to either prune always or when fetching
from a particular remote, add two new configuration variables
"fetch.prune" and "remote.<name>.prune":

 - "fetch.prune" allows to enable prune for all fetch operations.

 - "remote.<name>.prune" allows to change the behaviour per remote.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---

http://thread.gmane.org/gmane.comp.version-control.git/201715


 Documentation/config.txt |  9 +++++++++
 builtin/fetch.c          | 28 +++++++++++++++++++++++++---
 remote.c                 |  2 ++
 remote.h                 |  1 +
 t/t5510-fetch.sh         | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b4d4887..74e8026 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1067,6 +1067,10 @@ fetch.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+fetch.prune::
+	If true, fetch will automatically behave as if the `--prune`
+	option was given on the command line.
+
 format.attach::
 	Enable multipart/mixed attachments as the default for
 	'format-patch'.  The value can also be a double quoted string
@@ -2010,6 +2014,11 @@ remote.<name>.vcs::
 	Setting this to a value <vcs> will cause Git to interact with
 	the remote with the git-remote-<vcs> helper.
 
+remote.<name>.prune::
+	When set to true, fetching from this remote by default will also
+	remove any remote-tracking branches which no longer exist on the
+	remote (as if the `--prune` option was give on the command line).
+
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
diff --git a/builtin/fetch.c b/builtin/fetch.c
index d784b2e..3953317 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -30,7 +30,14 @@ enum {
 	TAGS_SET = 2
 };
 
-static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
+enum {
+	PRUNE_UNSET = 0,
+	PRUNE_DEFAULT = 1,
+	PRUNE_FORCE = 2
+};
+
+static int prune = PRUNE_DEFAULT;
+static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow;
 static const char *depth;
@@ -54,6 +61,17 @@ static int option_parse_recurse_submodules(const struct option *opt,
 	return 0;
 }
 
+static int git_fetch_config(const char *k, const char *v, void *cb)
+{
+	if (!strcmp(k, "fetch.prune")) {
+		int boolval = git_config_bool(k, v);
+		if (boolval)
+			prune = PRUNE_FORCE;
+		return 0;
+	}
+	return git_default_config(k, v, cb);
+}
+
 static struct option builtin_fetch_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOLEAN(0, "all", &all,
@@ -770,7 +788,7 @@ static int do_fetch(struct transport *transport,
 		retcode = 1;
 		goto cleanup;
 	}
-	if (prune) {
+	if (prune == PRUNE_FORCE || (transport->remote->prune && prune)) {
 		/* If --tags was specified, pretend the user gave us the canonical tags refspec */
 		if (tags == TAGS_SET) {
 			const char *tags_str = "refs/tags/*:refs/tags/*";
@@ -882,8 +900,10 @@ static void add_options_to_argv(struct argv_array *argv)
 {
 	if (dry_run)
 		argv_array_push(argv, "--dry-run");
-	if (prune)
+	if (prune == PRUNE_FORCE)
 		argv_array_push(argv, "--prune");
+	else if (prune == PRUNE_UNSET)
+		argv_array_push(argv, "--no-prune");
 	if (update_head_ok)
 		argv_array_push(argv, "--update-head-ok");
 	if (force)
@@ -1007,6 +1027,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
+	git_config(git_fetch_config, NULL);
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
diff --git a/remote.c b/remote.c
index 6f57830..e6f2acb 100644
--- a/remote.c
+++ b/remote.c
@@ -404,6 +404,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		remote->skip_default_update = git_config_bool(key, value);
 	else if (!strcmp(subkey, ".skipfetchall"))
 		remote->skip_default_update = git_config_bool(key, value);
+	else if (!strcmp(subkey, ".prune"))
+		remote->prune = git_config_bool(key, value);
 	else if (!strcmp(subkey, ".url")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
diff --git a/remote.h b/remote.h
index cf56724..4db3498 100644
--- a/remote.h
+++ b/remote.h
@@ -40,6 +40,7 @@ struct remote {
 	int fetch_tags;
 	int skip_default_update;
 	int mirror;
+	int prune;
 
 	const char *receivepack;
 	const char *uploadpack;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index fde6891..f3d63ca 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -497,6 +497,44 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
 	)
 '
 
+test_expect_success 'fetch should prune when fetch.prune is true' '
+  cd "$D" &&
+  git branch somebranch &&
+  (
+    cd one &&
+    git fetch &&
+    test -f .git/refs/remotes/origin/somebranch
+  ) &&
+  git branch -d somebranch &&
+  (
+    cd one &&
+    git config fetch.prune true &&
+    git fetch --no-prune &&
+    test -f .git/refs/remotes/origin/somebranch &&
+    git fetch &&
+    ! test -f .git/refs/remotes/origin/somebranch
+  )
+'
+
+test_expect_success 'fetch should prune when remote.<name>.prune is true' '
+  cd "$D" &&
+  git branch somebranch &&
+  (
+    cd one &&
+    git fetch &&
+    test -f .git/refs/remotes/origin/somebranch
+  ) &&
+  git branch -d somebranch &&
+  (
+    cd one &&
+    git config remote.origin.prune true &&
+    git fetch --no-prune &&
+    test -f .git/refs/remotes/origin/somebranch &&
+    git fetch &&
+    ! test -f .git/refs/remotes/origin/somebranch
+  )
+'
+
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
 	test_commit oneside &&
-- 
1.8.3.2.734.gbcd3b20
