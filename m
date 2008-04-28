From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 4/7] make "git push" update all push repositories.
Date: Mon, 28 Apr 2008 11:32:15 -0400
Message-ID: <d941a7a16cb7d5529b22a47f1dc7b986ba66ee56.1209391615.git.bonzini@gnu.org>
References: <4812DA50.3000702@gnu.org>
 <cover.1209391614.git.bonzini@gnu.org>
 <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org>
 <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org>
 <65b938da49b447129297d4dbf20191be52d16670.1209391614.git.bonzini@gnu.org>
Cc: spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 17:34:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqVMo-0004Kp-0j
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 17:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934486AbYD1PdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 11:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934865AbYD1PdA
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 11:33:00 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60626 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935656AbYD1Pcg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 11:32:36 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JqVL0-0004fB-MQ; Mon, 28 Apr 2008 11:32:18 -0400
X-Mailer: git-send-email 1.5.5.1.89.g36c79d
In-Reply-To: <65b938da49b447129297d4dbf20191be52d16670.1209391614.git.bonzini@gnu.org>
In-Reply-To: <cover.1209391614.git.bonzini@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80541>

This patch builds on the infrastructure for "git remote add --push"
to make the behavior of "git push" more general.  Because now remotes
can be explicitly designated for pushing (previously, you had no
way to do this *and* keep the "matching refspecs" behavior of "git push"),
now "git push" and "git push --mirror" can work like this:

- "git push" pushes to all push remotes.

- "git push --mirror" only updates mirror repositories, without touching
  other push remotes.

Furthermore, "git push --all" is now invalid without a repository.
I did this because --all and --mirror are incompatible, and so the
operation of a DWIM "git push --all" would probably not be what
the user meant.

Among the use cases of this, consider when a project has a public
repository managed by the integrator, but the integrator also wants to
publish his own topic branches somewhere.  In this case, the integrator can
just do "git push" and push the public branches to the public repository,
as well as his own topic branches to his own unofficial mirror.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-push.txt   |   22 +++++++++--
 Documentation/git-remote.txt |   10 +++---
 builtin-push.c               |   67 ++++++++++++++++++++++++++++------
 t/t5400-send-pack.sh         |    2 +-
 t/t5517-push-mirror.sh       |   82 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 161 insertions(+), 22 deletions(-)

	I think it is too early to warn if there is no push refspec for.
	origin (as I'll do for git-fetch in the final patch of the series).
	After all, clones made with any current version of git do *not*
	have a remote.origin.push refspec.

	This changes the behavior of "git push" if the user has a remote
	with push refspecs in his configuration; in this case the user
	should execute "git config remote.origin.push :" so that "git
	push" considers the origin remote too.  This should be written in
	the release notes.

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 0cc44d7..a1436f4 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -29,6 +29,14 @@ OPTIONS
 	The "remote" repository that is destination of a push
 	operation.  See the section <<URLS,GIT URLS>> below.
 
+	Unless \--all or \--tags are given, it is possible to
+	omit the destination repository and refspec.  In this
+	case, git will push to all remotes that have a
+	`remote.<name>.push` configuration line.  In case
+	git finds none, it will push to the "origin" remote;
+	this however is only done for backwards compatibility
+	with older versions of git.
+
 <refspec>::
 	The canonical format of a <refspec> parameter is
 	`+?<src>:<dst>`; that is, an optional plus `+`, followed
@@ -71,8 +79,14 @@ nor in any Push line of the corresponding remotes file---see below).
 	be mirrored to the remote repository.  Newly created local
 	refs will be pushed to the remote end, locally updated refs
 	will be force updated on the remote end, and deleted refs
-	will be removed from the remote end.  This is the default
-	if the configuration option `remote.<remote>.mirror` is
+	will be removed from the remote end.
+
+	For every repository that git tries as a destination, it will
+	also look up the corresponding configuration option
+	`remote.<repository>.mirror` and enables mirror mode
+	if it is set.  Furthermore, if `git push --mirror` is used
+	without specifying a destination repository, git will
+	only push to those remotes that have the configuration option
 	set.
 
 \--dry-run::
@@ -99,8 +113,8 @@ nor in any Push line of the corresponding remotes file---see below).
 	remote repository to lose commits; use it with care.
 
 \--repo=<repo>::
-	When no repository is specified the command defaults to
-	"origin"; this overrides it.
+	Overrides the default behavior of the command when no repository
+	is specified, so that <repo> is used as the destination repository.
 
 \--thin, \--no-thin::
 	These options are passed to `git-send-pack`.  Thin
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index e779905..d313a2f 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -47,8 +47,9 @@ With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch instead of whatever
 branch the `HEAD` at the remote repository actually points at.
 +
-`\--push` mode adds a `push` configuration line for the remote.
-It also affects the operation of mirror mode.
+`\--push` mode configures the remote so that `git push` with
+no arguments will attempt pushing to it.  It also affects the
+operation of `\--mirror`.
 +
 Mirror mode, enabled with `\--mirror`, specifies that one of the
 repositories (either the current one or the remote one) is giving
@@ -102,9 +103,8 @@ be updated.  (See linkgit:git-config[1]).
 DISCUSSION
 ----------
 
-The remote configuration is achieved using the `remote.origin.url` and
-`remote.origin.fetch` configuration variables.  (See
-linkgit:git-config[1]).
+The remote configuration is achieved using the `remote.<name>.*`
+configuration variables.  (See linkgit:git-config[1]).
 
 Examples
 --------
diff --git a/builtin-push.c b/builtin-push.c
index b35aad6..f877e49 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -48,14 +48,12 @@ static void set_refspecs(const char **refs, int nr)
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
+	const char **push_refspec = refspec;
+	int push_refspec_nr = refspec_nr;
+
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
@@ -70,8 +68,8 @@ static int do_push(const char *repo, int flags)
 	if (!refspec
 		&& !(flags & TRANSPORT_PUSH_ALL)
 		&& remote->push_refspec_nr) {
-		refspec = remote->push_refspec;
-		refspec_nr = remote->push_refspec_nr;
+		push_refspec = remote->push_refspec;
+		push_refspec_nr = remote->push_refspec_nr;
 	}
 	errs = 0;
 	for (i = 0; i < remote->url_nr; i++) {
@@ -86,7 +84,7 @@ static int do_push(const char *repo, int flags)
 
 		if (verbose)
 			fprintf(stderr, "Pushing to %s\n", remote->url[i]);
-		err = transport_push(transport, refspec_nr, refspec, flags);
+		err = transport_push(transport, push_refspec_nr, push_refspec, flags);
 		err |= transport_disconnect(transport);
 
 		if (!err)
@@ -98,6 +96,27 @@ static int do_push(const char *repo, int flags)
 	return !!errs;
 }
 
+static int num_push_remotes;
+
+static int push_to_remote(struct remote *remote, void *priv)
+{
+	int *p_flags = priv;
+	int rc;
+
+	/* With "git-push --mirror", only push to mirrors.  */
+	if ((*p_flags & TRANSPORT_PUSH_MIRROR) && !remote->mirror)
+		return 0;
+	if (!remote->push_refspec_nr)
+		return 0;
+
+	num_push_remotes++;
+	rc = do_push (remote, *p_flags);
+
+	/* No command-line errors should occur.  */
+	assert (rc != -1);
+	return rc;
+}
+
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
@@ -108,6 +127,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int tags = 0;
 	int rc;
 	const char *repo = NULL;	/* default repository */
+	struct remote *remote;
 
 	struct option options[] = {
 		OPT__VERBOSE(&verbose),
@@ -143,9 +163,32 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1);
 	}
 
-	rc = do_push(repo, flags);
+	if (!repo) {
+		/* Don't attempt to figure DWIM behavior when refspecs are
+		   provided.  */
+		if (all || tags)
+			die("please specify destination repository together "
+			    "with --all or --tags");
+
+		assert (!refspec);
+		rc = for_each_remote (push_to_remote, &flags);
+		if (rc)
+			return rc;
+		if (num_push_remotes)
+			return 0;
+
+		/* Fallback: use origin, but not for "git push --mirror".  */
+		if (mirror)
+			die("no mirrors configured, use git-push --mirror <repo> to force operation");
+	}
+
+	remote = remote_get(repo);
+	if (!remote)
+		die("bad repository '%s'", repo);
+
+	rc = do_push(remote, flags);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
-	else
-		return rc;
+
+	return rc;
 }
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 2b6b6e3..ab01b2a 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -118,7 +118,7 @@ test_expect_success \
 	mkdir parent && cd parent &&
 	git-init && touch file && git-add file && git-commit -m add &&
 	cd .. &&
-	git-clone parent child && cd child && git-push --all &&
+	git-clone parent child && cd child && git-push --all origin &&
 	cd ../parent &&
 	git-branch -a >branches && ! grep origin/master branches
 '
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index cacc08c..9afa741 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -29,6 +29,26 @@ mk_repo_pair () {
 	)
 }
 
+# a more complicated setup where we have also an origin repo
+mk_repo_three () {
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
+		git remote add --push --mirror up ../mirror
+	)
+}
 
 # BRANCH tests
 test_expect_success 'push mirror creates new branches' '
@@ -264,4 +284,66 @@ test_expect_success 'remote.foo.mirror=no has no effect' '
 
 '
 
+test_expect_success 'mirrors are updated by "git push"' '
+
+	mk_repo_three &&
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
+test_expect_success '"git push --all mirror" fails and does not leave half updates' '
+
+	mk_repo_three &&
+	(
+		cd master &&
+		git branch b1 master &&
+		invert git push --all mirror
+	) &&
+	(
+		cd mirror &&
+		invert git show-ref -s --verify refs/heads/b1
+	)
+
+'
+
+test_expect_success 'mirrors are not updated by "git push --repo" or "git push <repo>"' '
+
+	mk_repo_three &&
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
