From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] make "git push" update origin and mirrors, "git push --mirror" update mirrors
Date: Mon, 21 Apr 2008 11:42:11 +0200
Message-ID: <S1754769AbYDUJrX/20080421094723Z+119@vger.kernel.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 21 11:48:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnsd8-0003EP-1Z
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 11:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbYDUJrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 05:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754769AbYDUJrX
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 05:47:23 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:34337 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbYDUJrW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 05:47:22 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JnscI-0002Kz-TS
	for git@vger.kernel.org; Mon, 21 Apr 2008 05:47:18 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80016>

This patch builds on the infrastructure for remote.<nick>.mirror and
tweaks the behavior of "git push".  The idea is that "git push",
"git push --all", "git push --mirror", instead of defaulting to origin,
become DWIM commands:

- "git push" pushes to origin *and* to all mirrors

- "git push --all" pushes to origin with --all.  I didn't make it push
  to mirrors because --all and --mirror are incompatible.

- "git push --mirror" only updates mirror repositories, without touching
  origin.

This is useful when a project has a public repository managed by the
integrator, but the integrator also wants to publish his own mirror
somewhere.  In this case, the integrator will just do "git push".
Similarly, if a developer uses the integrator's repository but
wishes to publish his own mirror somewhere, he can just do "git push
--mirror".

The code explicitly disables pushing to mirrors when a refspec is present.
This is just defensive, because right now refspecs cannot be specified
without giving a repository too.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-push.txt |   17 ++++++---
 builtin-push.c             |   43 ++++++++++++++++------
 t/t5517-push-mirror.sh     |   86 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index dc1d4b0..8195517 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -29,6 +29,11 @@ OPTIONS
 	The "remote" repository that is destination of a push
 	operation.  See the section <<URLS,GIT URLS>> below.
 
+	The default behavior of the command when no repository is specified
+	is to push to "origin" if \--all is given, to push to all mirror
+	remotes if \--mirror is given, and to do both actions if neither
+	\--all nor \--mirror is given.
+
 <refspec>::
 	The canonical format of a <refspec> parameter is
 	`+?<src>:<dst>`; that is, an optional plus `+`, followed
@@ -69,9 +74,11 @@ the remote repository.
 	be mirrored to the remote repository.  Newly created local
 	refs will be pushed to the remote end, locally updated refs
 	will be force updated on the remote end, and deleted refs
-	will be removed from the remote end.  This is the default
-	if the configuration option `remote.<remote>.mirror` is
-	set.
+	will be removed from the remote end.
+
+	When a <repository> is given on the command line, git looks up the
+	corresponding configuration option `remote.<repository>.mirror`
+	and enables mirror mode if it is set.
 
 \--dry-run::
 	Do everything except actually send the updates.
@@ -97,8 +104,8 @@ the remote repository.
 	remote repository to lose commits; use it with care.
 
 \--repo=<repo>::
-	When no repository is specified the command defaults to
-	"origin"; this overrides it.
+	Overrides the default behavior of the command when no repository
+	is specified, so that <repo> is used as the destination repository.
 
 \--thin, \--no-thin::
 	These options are passed to `git-send-pack`.  Thin
diff --git a/builtin-push.c b/builtin-push.c
index e992c37..3756d5e 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -48,14 +48,9 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
-static int do_push(const char *repo, int flags)
+static int do_push(struct remote *remote, int flags)
 {
 	int i, errs;
-	struct remote *remote = remote_get(repo);
-
-	if (!remote)
-		die("bad repository '%s'", repo);
-
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
@@ -99,6 +94,18 @@ static int do_push(const char *repo, int flags)
 	return !!errs;
 }
 
+static int push_to_mirrors(struct remote *remote, void *priv)
+{
+	int *p_flags = priv;
+	int rc = 0;
+	if (remote->mirror)
+		rc = do_push (remote, *p_flags);
+	
+	/* No command-line errors should occur.  */
+	assert (rc != -1);
+	return rc;
+}
+
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
@@ -109,6 +116,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int tags = 0;
 	int rc;
 	const char *repo = NULL;	/* default repository */
+	struct remote *remote;
 
 	struct option options[] = {
 		OPT__VERBOSE(&verbose),
@@ -144,9 +152,22 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1);
 	}
 
-	rc = do_push(repo, flags);
-	if (rc == -1)
-		usage_with_options(push_usage, options);
-	else
-		return rc;
+	/* "git push --mirror" will only push to mirrors.  */
+	if (repo || !mirror) {
+		remote = remote_get(repo);
+		if (!remote)
+			die("bad repository '%s'", repo);
+	
+		rc = do_push(remote, flags);
+		if (rc == -1)
+			usage_with_options(push_usage, options);
+	}
+
+	/* "git push" with only --force, --dry-run, --verbose, --mirror options
+	   will also (or, in the case of "git push --mirror", only) push to
+	   all mirrors.  */
+	if (!rc && !repo && !refspec && !all)
+		rc = for_each_remote (push_to_mirrors, &flags);
+	
+	return rc;
 }
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index ea49ded..beb71f4 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -29,6 +29,26 @@ mk_repo_pair () {
 	)
 }
 
+# a more complicated setup where we have also an origin repo
+mk_repo_threesome () {
+	rm -rf master mirror origin &&
+	mkdir mirror &&
+	(
+		cd mirror &&
+		git init
+	) &&
+	mkdir origin &&
+	(
+		cd origin &&
+		git init
+		echo one >foo && git add foo && git commit -m one
+	) &&
+	git clone origin master &&
+	(
+		cd master &&
+		git remote add --mirror up ../mirror
+	)
+}
 
 # BRANCH tests
 test_expect_success 'push mirror creates new branches' '
@@ -264,4 +284,70 @@ test_expect_success 'remote.foo.mirror=no has no effect' '
 
 '
 
+test_expect_success 'mirrors are updated by "git push"' '
+
+	mk_repo_threesome &&
+	(
+		cd master &&
+		git branch keep master &&
+		git branch remove master &&
+		git push &&
+		git branch -D remove
+		git push
+	) &&
+	(
+		cd mirror &&
+		git show-ref -s --verify refs/heads/keep &&
+		invert git show-ref -s --verify refs/heads/remove
+	) &&
+	(
+		cd origin &&
+		invert git show-ref -s --verify refs/heads/keep &&
+		invert git show-ref -s --verify refs/heads/remove
+	)
+
+'
+
+test_expect_success 'mirrors are not updated by "git push --all"' '
+
+	mk_repo_threesome &&
+	(
+		cd master &&
+		git branch b1 master &&
+		git push --all
+	) &&
+	(
+		cd mirror &&
+		invert git show-ref -s --verify refs/heads/b1
+	) &&
+	(
+		cd origin &&
+		git show-ref -s --verify refs/heads/b1
+	)
+
+'
+
+test_expect_success 'mirrors are not updated by "git push --repo" or "git push <repo>"' '
+
+	mk_repo_threesome &&
+	(
+		cd master &&
+		git branch b1 master &&
+		git push origin
+		git branch b2 master &&
+		git push --repo=origin
+	) &&
+	(
+		cd mirror &&
+		invert git show-ref -s --verify refs/heads/b1 &&
+		invert git show-ref -s --verify refs/heads/b2
+	) &&
+	(
+		cd origin &&
+		invert git show-ref -s --verify refs/heads/b1 &&
+		invert git show-ref -s --verify refs/heads/b2
+	)
+
+'
+
 test_done
-- 
1.5.5
