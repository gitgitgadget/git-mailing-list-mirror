From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] Add a remote.<foo>.mirror configuration option
Date: Thu, 17 Apr 2008 13:17:20 +0200
Message-ID: <S1755276AbYDQLcT/20080417113219Z+797@vger.kernel.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 13:33:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmSMS-0004Ni-4f
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 13:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172AbYDQLcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 07:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755276AbYDQLcT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 07:32:19 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:44767 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009AbYDQLcR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 07:32:17 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JmSLg-0006oq-82
	for git@vger.kernel.org; Thu, 17 Apr 2008 07:32:16 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79784>

This patch adds a remote.<foo>.mirror configuration option that,
when set, automatically puts git-push in --mirror mode for that
remote.

Furthermore, the option is set automatically by `git remote
add --mirror'.

The code in remote.c to parse remote.<foo>skipdefaultupdate
had a subtle problem: a comment in the code indicated that
special care was needed for boolean options, but this care was
not used in parsing the option.  Since I was touching related
code, I did this fix too.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/config.txt     |    4 ++++
 Documentation/git-push.txt   |    4 +++-
 Documentation/git-remote.txt |    6 ++++--
 builtin-push.c               |   25 +++++++++++++++++--------
 builtin-remote.c             |    7 +++++++
 remote.c                     |   35 ++++++++++++++++-------------------
 remote.h                     |    1 +
 t/t5517-push-mirror.sh       |   41 ++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 92 insertions(+), 31 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fe43b12..03f1c3f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -910,6 +910,10 @@ remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
 
+remote.<name>.mirror::
+	If true, pushing to this remote will automatically behave
+	as if the `\--mirror` option was given on the command line.
+
 remote.<name>.skipDefaultUpdate::
 	If true, this remote will be skipped by default when updating
 	using the update subcommand of linkgit:git-remote[1].
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3128170..dc1d4b0 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -69,7 +69,9 @@ the remote repository.
 	be mirrored to the remote repository.  Newly created local
 	refs will be pushed to the remote end, locally updated refs
 	will be force updated on the remote end, and deleted refs
-	will be removed from the remote end.
+	will be removed from the remote end.  This is the default
+	if the configuration option `remote.<remote>.mirror` is
+	set.
 
 \--dry-run::
 	Do everything except actually send the updates.
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 2cbd1f7..1ee1127 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -47,9 +47,11 @@ With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch instead of whatever
 branch the `HEAD` at the remote repository actually points at.
 +
-In mirror mode, enabled with `--mirror`, the refs will not be stored
+In mirror mode, enabled with `\--mirror`, the refs will not be stored
 in the 'refs/remotes/' namespace, but in 'refs/heads/'.  This option
-only makes sense in bare repositories.
+only makes sense in bare repositories.  If a remote uses mirror
+mode, furthermore, `git push` will always behave as if `\--mirror`
+was passed.
 
 'rm'::
 
diff --git a/builtin-push.c b/builtin-push.c
index b68c681..e992c37 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -56,6 +56,18 @@ static int do_push(const char *repo, int flags)
 	if (!remote)
 		die("bad repository '%s'", repo);
 
+	if (remote->mirror)
+		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
+
+	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) && refspec)
+		return -1;
+
+	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) ==
+				(TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) {
+		error("--all and --mirror are incompatible");
+		return -1;
+	}
+
 	if (!refspec
 		&& !(flags & TRANSPORT_PUSH_ALL)
 		&& remote->push_refspec_nr) {
@@ -95,6 +107,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int dry_run = 0;
 	int force = 0;
 	int tags = 0;
+	int rc;
 	const char *repo = NULL;	/* default repository */
 
 	struct option options[] = {
@@ -130,14 +143,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		repo = argv[0];
 		set_refspecs(argv + 1, argc - 1);
 	}
-	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) && refspec)
-		usage_with_options(push_usage, options);
 
-	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) ==
-				(TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) {
-		error("--all and --mirror are incompatible");
+	rc = do_push(repo, flags);
+	if (rc == -1)
 		usage_with_options(push_usage, options);
-	}
-
-	return do_push(repo, flags);
+	else
+		return rc;
 }
diff --git a/builtin-remote.c b/builtin-remote.c
index d77f10a..70c9374 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -111,6 +111,13 @@ static int add(int argc, const char **argv)
 			return 1;
 	}
 
+	if (mirror) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "remote.%s.mirror", name);
+		if (git_config_set(buf.buf, "yes"))
+			return 1;
+	}
+	
 	if (fetch && fetch_remote(name))
 		return 1;
 
diff --git a/remote.c b/remote.c
index 369dc33..d5597e0 100644
--- a/remote.c
+++ b/remote.c
@@ -337,22 +337,21 @@ static int handle_config(const char *key, const char *value)
 		return 0;
 	}
 	remote = make_remote(name, subkey - name);
-	if (!value) {
-		/* if we ever have a boolean variable, e.g. "remote.*.disabled"
-		 * [remote "frotz"]
-		 *      disabled
-		 * is a valid way to set it to true; we get NULL in value so
-		 * we need to handle it here.
-		 *
-		 * if (!strcmp(subkey, ".disabled")) {
-		 *      val = git_config_bool(key, value);
-		 *      return 0;
-		 * } else
-		 *
-		 */
-		return 0; /* ignore unknown booleans */
-	}
-	if (!strcmp(subkey, ".url")) {
+	if (!strcmp(subkey, ".mirror"))
+		remote->mirror = git_config_bool(key, value);
+	else if (!strcmp(subkey, ".skipdefaultupdate"))
+		remote->skip_default_update = git_config_bool(key, value);
+
+	/* for a boolean variable,
+	 * [remote "frotz"]
+	 *      mirror
+	 * is a valid way to set it to true; we get NULL in value.
+	 * but we can ignore all other NULL values.
+	 */
+	else if (!value)
+		return 0;
+
+	else if (!strcmp(subkey, ".url")) {
 		add_url(remote, xstrdup(value));
 	} else if (!strcmp(subkey, ".push")) {
 		add_push_refspec(remote, xstrdup(value));
@@ -371,10 +370,8 @@ static int handle_config(const char *key, const char *value)
 	} else if (!strcmp(subkey, ".tagopt")) {
 		if (!strcmp(value, "--no-tags"))
 			remote->fetch_tags = -1;
-	} else if (!strcmp(subkey, ".proxy")) {
+	} else if (!strcmp(subkey, ".proxy"))
 		remote->http_proxy = xstrdup(value);
-	} else if (!strcmp(subkey, ".skipdefaultupdate"))
-		remote->skip_default_update = 1;
 	return 0;
 }
 
diff --git a/remote.h b/remote.h
index 7e9ae79..b58a139 100644
--- a/remote.h
+++ b/remote.h
@@ -26,6 +26,7 @@ struct remote {
 	 */
 	int fetch_tags;
 	int skip_default_update;
+	int mirror;
 
 	const char *receivepack;
 	const char *uploadpack;
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index ed3fec1..ea49ded 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -25,7 +25,7 @@ mk_repo_pair () {
 	(
 		cd master &&
 		git init &&
-		git config remote.up.url ../mirror
+		git remote add $1 up ../mirror
 	)
 }
 
@@ -225,4 +225,43 @@ test_expect_success 'push mirror adds, updates and removes tags together' '
 
 '
 
+test_expect_success 'remote.foo.mirror adds and removes branches' '
+
+	mk_repo_pair --mirror &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch keep master &&
+		git branch remove master &&
+		git push up &&
+		git branch -D remove
+		git push up
+	) &&
+	(
+		cd mirror &&
+		git show-ref -s --verify refs/heads/keep &&
+		invert git show-ref -s --verify refs/heads/remove
+	)
+
+'
+
+test_expect_success 'remote.foo.mirror=no has no effect' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git config --add remote.up.mirror no &&
+		git branch keep master &&
+		git push --mirror up &&
+		git branch -D keep &&
+		git push up
+	) &&
+	(
+		cd mirror &&
+		git show-ref -s --verify refs/heads/keep
+	)
+
+'
+
 test_done
-- 
1.5.5
