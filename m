From: marcnarc@xiplink.com
Subject: [PATCH 3/6] Teach "git remote" about remote.default.
Date: Wed, 11 Jul 2012 11:33:58 -0400
Message-ID: <1342020841-24368-4-git-send-email-marcnarc@xiplink.com>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com, Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 17:34:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Soyvf-0005bj-Si
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 17:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758133Ab2GKPeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 11:34:12 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:24319 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755896Ab2GKPeK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jul 2012 11:34:10 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q6BFY4Uc029776;
	Wed, 11 Jul 2012 11:34:06 -0400
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201305>

From: Marc Branchaud <marcnarc@xiplink.com>

The "rename" and "rm" commands now handle the case where the remote being
changed is the default remote.

If the "add" command is used to add the repo's first remote, that remote
becomes the default remote.

Also introduce a "default" sub-command to get or set the default remote:

 - "git remote default" (with no parameter) displays the current default remote.

 - "git remote default <remo>" checks if <remo> is a configured remote and if
   so changes remote.default to <remo>.

These changes needed a couple of new helper functions in remote.c:
 - remote_get_default_name() returns default_remote_name.
 - remote_count() returns the number of remotes.

(The test in t5528 had to be changed because now with push.default=matching
a plain "git push" succeeds with "Everything up-to-date".  It used to
fail with "No configured push destination".)

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/git-remote.txt | 32 ++++++++++++++++---
 builtin/remote.c             | 29 +++++++++++++++++
 remote.c                     | 12 +++++++
 remote.h                     |  2 ++
 t/t5505-remote.sh            | 76 ++++++++++++++++++++++++++++++++++++++++++++
 t/t5512-ls-remote.sh         |  8 ++++-
 t/t5528-push-default.sh      |  4 +--
 7 files changed, 156 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index a308f4c..f4de21d 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git remote' [-v | --verbose]
 'git remote add' [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>
+'git remote default' [<name>]
 'git remote rename' <old> <new>
 'git remote rm' <name>
 'git remote set-head' <name> (-a | -d | <branch>)
@@ -75,20 +76,43 @@ because a fetch would overwrite any local commits.
 +
 When a push mirror is created with `--mirror=push`, then `git push`
 will always behave as if `--mirror` was passed.
++
+When the first remote is added to a repository, it becomes the repository's
+default remote.
+
+'default'::
+
+Displays or sets the name of the repository's default remote.  When git needs
+to automatically choose a remote to use, it first tries to use the remote
+associated with the currently checked-out branch.  If the currently
+checked-out branch has no remote, git uses the repository's default remote.
+If the repository has no default remote, git tries to use a remote named
+"origin" even if there is no actual remote named "origin".  (In other words,
+the default value for the default remote name is "origin".)
++
+With no <name> parameter, displays the current default remote name.
++
+With the <name> parameter, sets the repository's default remote to <name>.
 
 'rename'::
 
-Rename the remote named <old> to <new>. All remote-tracking branches and
+Renames the remote named <old> to <new>. All remote-tracking branches and
 configuration settings for the remote are updated.
 +
 In case <old> and <new> are the same, and <old> is a file under
 `$GIT_DIR/remotes` or `$GIT_DIR/branches`, the remote is converted to
 the configuration file format.
++
+If <old> was the repository's default remote name, the default remote name
+changes to <new>.
 
 'rm'::
 
-Remove the remote named <name>. All remote-tracking branches and
-configuration settings for the remote are removed.
+Removes the remote named <name>. All remote-tracking branches and
+configuration settings for the remote are removed.  If the remote was
+the repository's default remote, then the repository's default remote
+name is changed to "origin".  Use 'git remote default <name>' to set
+the repository's default remote name.
 
 'set-head'::
 
@@ -160,7 +184,7 @@ actually prune them.
 
 'update'::
 
-Fetch updates for a named set of remotes in the repository as defined by
+Fetches updates for a named set of remotes in the repository as defined by
 remotes.<group>.  If a named group is not specified on the command line,
 the configuration parameter remotes.default will be used; if
 remotes.default is not defined, all remotes which do not have the
diff --git a/builtin/remote.c b/builtin/remote.c
index 920262d..1fb272c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -12,6 +12,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
+	"git remote default [<name>]",
 	"git remote set-head <name> (-a | -d | <branch>)",
 	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
@@ -198,6 +199,9 @@ static int add(int argc, const char **argv)
 	if (!valid_fetch_refspec(buf2.buf))
 		die(_("'%s' is not a valid remote name"), name);
 
+	if (remote_count() == 1) /* remote_get() adds a remote if it's new */
+		git_config_set("remote.default", name);
+
 	strbuf_addf(&buf, "remote.%s.url", name);
 	if (git_config_set(buf.buf, url))
 		return 1;
@@ -656,6 +660,10 @@ static int mv(int argc, const char **argv)
 		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
 
+	if (!strcmp(oldremote->name, remote_get_default_name())) {
+		git_config_set("remote.default", newremote->name);
+	}
+
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
 	if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
@@ -798,6 +806,10 @@ static int rm(int argc, const char **argv)
 	if (git_config_rename_section(buf.buf, NULL) < 1)
 		return error(_("Could not remove config section '%s'"), buf.buf);
 
+	if (!strcmp(remote->name, remote_get_default_name())) {
+		git_config_set("remote.default", NULL);
+	}
+
 	read_branches();
 	for (i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
@@ -845,6 +857,21 @@ static int rm(int argc, const char **argv)
 	return result;
 }
 
+static int deflt(int argc, const char **argv)
+{
+	if (argc < 2)
+		printf_ln("%s", remote_get_default_name());
+	else {
+		const char *name = argv[1];
+		if (remote_is_configured(name)) {
+			git_config_set("remote.default", name);
+			printf_ln(_("Default remote set to '%s'."), name);
+		} else
+			return error(_("No remote named '%s'."), name);
+	}
+	return 0;
+}
+
 static void clear_push_info(void *util, const char *string)
 {
 	struct push_info *info = util;
@@ -1582,6 +1609,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = mv(argc, argv);
 	else if (!strcmp(argv[0], "rm"))
 		result = rm(argc, argv);
+	else if (!strcmp(argv[0], "default"))
+		result = deflt(argc, argv);
 	else if (!strcmp(argv[0], "set-head"))
 		result = set_head(argc, argv);
 	else if (!strcmp(argv[0], "set-branches"))
diff --git a/remote.c b/remote.c
index 2ebdbbd..8d9e8a8 100644
--- a/remote.c
+++ b/remote.c
@@ -679,6 +679,18 @@ static int valid_remote_nick(const char *name)
 	return !strchr(name, '/'); /* no slash */
 }
 
+const char *remote_get_default_name(void)
+{
+	read_config();
+	return default_remote_name;
+}
+
+int remote_count(void)
+{
+	read_config();
+	return remotes_nr;
+}
+
 struct remote *remote_get(const char *name)
 {
 	struct remote *ret;
diff --git a/remote.h b/remote.h
index 251d8fd..c8c54e8 100644
--- a/remote.h
+++ b/remote.h
@@ -52,6 +52,8 @@ struct remote {
 
 struct remote *remote_get(const char *name);
 int remote_is_configured(const char *name);
+const char *remote_get_default_name(void);
+int remote_count(void);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
 int for_each_remote(each_remote_fn fn, void *priv);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e8af615..0027a82 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -77,6 +77,15 @@ test_expect_success 'add another remote' '
 )
 '
 
+test_expect_success 'add first remote sets default' '
+(
+	test_create_repo default-first-remote &&
+	cd default-first-remote &&
+	git remote add first /path/to/first &&
+	test "$(git config --get remote.default)" = first
+)
+'
+
 test_expect_success 'remote forces tracking branches' '
 (
 	cd test &&
@@ -107,6 +116,16 @@ test_expect_success 'remove remote' '
 )
 '
 
+test_expect_success 'remove default remote' '
+(
+	git clone one no-default
+	cd no-default &&
+	test "$(git config --get remote.default)" = origin   # Sanity check
+	git remote rm origin &&
+	test_must_fail git config --get remote.default
+)
+'
+
 test_expect_success 'remove remote protects local branches' '
 (
 	cd test &&
@@ -662,6 +681,28 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 
 '
 
+test_expect_success 'rename the default remote' '
+	git clone one default-rename &&
+	(cd default-rename &&
+		test "$(git config --get remote.default)" = origin   # Sanity?
+		git remote rename origin tyrion
+		test "$(git config --get remote.default)" = tyrion
+	)
+
+'
+
+# This test ensures that repos created wth an older version of git and that
+# have a remote named "origin" get remote.default updated properly.
+test_expect_success 'rename the "origin" remote if remote.default is not set' '
+	git clone one default-oldschool &&
+	(cd default-oldschool &&
+		git config --unset remote.default
+		git remote rename origin stark
+		test "$(git config --get remote.default)" = stark
+	)
+'
+
+
 cat > remotes_origin << EOF
 URL: $(pwd)/one
 Push: refs/heads/master:refs/heads/upstream
@@ -997,4 +1038,39 @@ test_expect_success 'remote set-url --delete baz' '
 	cmp expect actual
 '
 
+test_expect_success 'remote default' '
+(
+	git clone -o up one default
+	cd default &&
+	test "$(git remote default)" = up
+)
+'
+
+test_expect_success 'remote default (none)' '
+(
+	test_create_repo default-none &&
+	cd default-none &&
+	test "$(git remote default)" = origin
+)
+'
+
+test_expect_success 'remote default set' '
+(
+	test_create_repo default-set &&
+	cd default-set &&
+	git remote add A /foo-A &&
+	git remote add B /foo-A &&
+	git remote default B &&
+	test "$(git remote default)" = B
+)
+'
+
+test_expect_success 'remote default bad' '
+(
+	git clone one default-bad &&
+	cd default-bad &&
+	test_must_fail git remote default NonExistant
+)
+'
+
 test_done
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 6764d51..853b045 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -40,7 +40,13 @@ test_expect_success 'ls-remote self' '
 '
 
 test_expect_success 'dies when no remote specified and no default remotes found' '
-	test_must_fail git ls-remote
+	test_create_repo no-remotes &&
+	(
+		cd no-remotes &&
+		test_must_fail git ls-remote &&
+		test_config remote.default blop &&
+		test_must_fail git ls-remote
+	)
 '
 
 test_expect_success 'use "origin" when no remote specified' '
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 4736da8..6a08998 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -71,10 +71,10 @@ test_expect_success '"upstream" does not push when remotes do not match' '
 	test_must_fail git push parent2
 '
 
-test_expect_success 'push from/to new branch with upstream, matching and simple' '
+test_expect_success 'push from/to new remoteless branch with upstream, matching and simple' '
 	git checkout -b new-branch &&
 	test_push_failure simple &&
-	test_push_failure matching &&
+	test_push_success matching master &&
 	test_push_failure upstream
 '
 
-- 
1.7.11.1
