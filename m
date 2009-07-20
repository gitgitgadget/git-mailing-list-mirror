From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH RFC 8/8] clone: add --push option
Date: Mon, 20 Jul 2009 19:49:55 +0200
Message-ID: <1248112195-3761-9-git-send-email-bonzini@gnu.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:51:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSx10-0005yL-Ai
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 19:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbZGTRuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 13:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbZGTRuX
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 13:50:23 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56558 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbZGTRuV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 13:50:21 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSx0G-00033y-BH
	for git@vger.kernel.org; Mon, 20 Jul 2009 13:50:20 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123628>

This patch completes the series by supporting --push within
git clone as well.

The bulk of the patch actually is just moving the options struct
for builtin-clone as late as possible to make it possible to use
OPT_CALLBACK.  The actual implementation of --push is essentially
reusing setup_remote_config, and actually simplifies the code.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-clone.txt |   13 ++++++-
 builtin-clone.c             |   90 ++++++++++++++++++++++++++-----------------
 t/t5601-clone.sh            |   78 +++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b14de6c..d5753c4 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -27,6 +27,9 @@ all the remote-tracking branches, and a `git pull` without
 arguments will in addition merge the remote master branch into the
 current master branch, if any.
 
+Optionally, `git clone` can also set up the behavior upon `git push`.
+This will be done only if the `--push` option is provided.
+
 This default configuration is achieved by creating references to
 the remote branch heads under `$GIT_DIR/refs/remotes/origin` and
 by initializing `remote.origin.url` and `remote.origin.fetch`
@@ -111,8 +114,16 @@ then the cloned repository will become corrupt.
 	used, neither remote-tracking branches nor the related
 	configuration variables are created.
 
+--push=<strategy>::
+	Set up the clone's behavior upon `git push`.  Valid values
+	for `\--push` are `matching`, `mirror, `tracking`, `current`
+	and `nothing`.  The meanings are the same as for the
+	`push.default` configuration key.  If no strategy is
+	specified, the contents of `push.default` will be used.
+
 --mirror::
-	Set up a mirror of the remote repository.  This implies --bare.
+	Set up a mirror of the remote repository.  This is the
+	same as `\--push=mirror --bare`.
 
 --origin <name>::
 -o <name>::
diff --git a/builtin-clone.c b/builtin-clone.c
index 68d8a68..b9f2f16 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -40,40 +40,12 @@ static const char * const builtin_clone_usage[] = {
 
 static int option_quiet, option_no_checkout, option_bare, option_mirror;
 static int option_local, option_no_hardlinks, option_shared;
+static int option_push = PUSH_DEFAULT_UNKNOWN;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbose;
 
-static struct option builtin_clone_options[] = {
-	OPT__QUIET(&option_quiet),
-	OPT__VERBOSE(&option_verbose),
-	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
-		    "don't create a checkout"),
-	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
-	OPT_BOOLEAN(0, "naked", &option_bare, "create a bare repository"),
-	OPT_BOOLEAN(0, "mirror", &option_mirror,
-		    "create a mirror repository (implies bare)"),
-	OPT_BOOLEAN('l', "local", &option_local,
-		    "to clone from a local repository"),
-	OPT_BOOLEAN(0, "no-hardlinks", &option_no_hardlinks,
-		    "don't use local hardlinks, always copy"),
-	OPT_BOOLEAN('s', "shared", &option_shared,
-		    "setup as shared repository"),
-	OPT_STRING(0, "template", &option_template, "path",
-		   "path the template repository"),
-	OPT_STRING(0, "reference", &option_reference, "repo",
-		   "reference repository"),
-	OPT_STRING('o', "origin", &option_origin, "branch",
-		   "use <branch> instead of 'origin' to track upstream"),
-	OPT_STRING('u', "upload-pack", &option_upload_pack, "path",
-		   "path to git-upload-pack on the remote"),
-	OPT_STRING(0, "depth", &option_depth, "depth",
-		    "create a shallow clone of that depth"),
-
-	OPT_END()
-};
-
 static char *get_repo_path(const char *repo, int *is_bundle)
 {
 	static char *suffix[] = { "/.git", ".git", "" };
@@ -341,6 +313,50 @@ static struct ref *write_remote_refs(const struct ref *refs,
 	return local_refs;
 }
 
+static int opt_parse_push(const struct option *opt, const char *arg, int not)
+{
+	int *value = opt->value;
+	if (not)
+		*value = PUSH_DEFAULT_NOTHING;
+	else if (!arg)
+		*value = push_default;
+	else
+		return git_parse_push_default("--push", arg, value);
+
+	return 0;
+}
+
+static struct option builtin_clone_options[] = {
+	OPT__QUIET(&option_quiet),
+	OPT__VERBOSE(&option_verbose),
+	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
+		    "don't create a checkout"),
+	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
+	OPT_BOOLEAN(0, "naked", &option_bare, "create a bare repository"),
+	{ OPTION_CALLBACK, 0, "push", &option_push, "strategy",
+		"how to setup pushing", PARSE_OPT_OPTARG, opt_parse_push },
+	OPT_BOOLEAN(0, "mirror", &option_mirror,
+		    "create a mirror repository (implies --bare and --push=mirror)"),
+	OPT_BOOLEAN('l', "local", &option_local,
+		    "to clone from a local repository"),
+	OPT_BOOLEAN(0, "no-hardlinks", &option_no_hardlinks,
+		    "don't use local hardlinks, always copy"),
+	OPT_BOOLEAN('s', "shared", &option_shared,
+		    "setup as shared repository"),
+	OPT_STRING(0, "template", &option_template, "path",
+		   "path the template repository"),
+	OPT_STRING(0, "reference", &option_reference, "repo",
+		   "reference repository"),
+	OPT_STRING('o', "origin", &option_origin, "branch",
+		   "use <branch> instead of 'origin' to track upstream"),
+	OPT_STRING('u', "upload-pack", &option_upload_pack, "path",
+		   "path to git-upload-pack on the remote"),
+	OPT_STRING(0, "depth", &option_depth, "depth",
+		    "create a shallow clone of that depth"),
+
+	OPT_END()
+};
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0;
@@ -358,14 +374,22 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	junk_pid = getpid();
 
+	git_config_norepo(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
 	if (argc == 0)
 		die("You must specify a repository to clone.");
 
-	if (option_mirror)
+	if (option_push == PUSH_DEFAULT_UNKNOWN)
+		option_push = (option_mirror
+			       ? PUSH_DEFAULT_MIRROR
+			       : PUSH_DEFAULT_NOTHING);
+	if (option_mirror) {
 		option_bare = 1;
+		if (option_push != PUSH_DEFAULT_MIRROR)
+			die ("--mirror and --push are incompatible");
+	}
 
 	if (option_bare) {
 		if (option_origin)
@@ -454,11 +478,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (option_mirror || !option_bare) {
 		struct string_list track = { NULL, 0, 0 };
-		setup_remote_config (option_origin, repo,
-				     option_mirror
-				     ? PUSH_DEFAULT_MIRROR
-				     : PUSH_DEFAULT_NOTHING,
-				     &track);
+		setup_remote_config(option_origin, repo, option_push, &track);
 		fetch_pattern = track.items[0].util;
 		refspec = parse_fetch_refspec(1, &fetch_pattern);
 		string_list_clear(&track, 1);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 2335d8b..6445dad 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -83,11 +83,89 @@ test_expect_success 'clone --mirror' '
 	test ! -f mirror/file &&
 	FETCH="$(cd mirror && git config remote.origin.fetch)" &&
 	test "+refs/*:refs/*" = "$FETCH" &&
+	PUSH="$(cd mirror && git config remote.origin.push)" &&
+	test "+refs/*:refs/*" = "$PUSH" &&
 	MIRROR="$(cd mirror && git config --bool remote.origin.mirror)" &&
 	test "$MIRROR" = true
 
 '
 
+test_expect_success 'clone --push=mirror' '
+
+	git clone --push=mirror src mirrorx &&
+	test -f mirrorx/.git/HEAD &&
+	test -f mirrorx/file &&
+	FETCH="$(cd mirrorx && git config remote.origin.fetch)" &&
+	test "+refs/*:refs/*" = "$FETCH" &&
+	PUSH="$(cd mirrorx && git config remote.origin.push)" &&
+	test "+refs/*:refs/*" = "$PUSH" &&
+	MIRROR="$(cd mirrorx && git config --bool remote.origin.mirror)" &&
+	test "$MIRROR" = true
+
+'
+
+test_expect_success 'clone --push=current' '
+
+	git clone --push=current src current &&
+	test -f current/.git/HEAD &&
+	test -f current/file &&
+	! (cd current/.git && git config --bool remote.origin.mirror) &&
+	(cd current/.git && git config --bool remote.origin.pushHeadOnly) &&
+	! (cd current/.git && git config --bool remote.origin.autosetuppush) &&
+	test "+refs/heads/*:refs/remotes/origin/*" = \
+		"$(cd current && git config remote.origin.fetch)" &&
+	test HEAD = "$(cd current && git config remote.origin.push)"
+
+'
+
+test_expect_success 'clone --push' '
+
+	HOME=$(pwd) &&
+	export HOME &&
+	test_config="$HOME/.gitconfig" &&
+	unset GIT_CONFIG_NOGLOBAL &&
+	echo "[push] default=current" > $test_config
+	git clone --push src default &&
+	test -f default/.git/HEAD &&
+	test -f default/file &&
+	! (cd default/.git && git config --bool remote.origin.mirror) &&
+	(cd default/.git && git config --bool remote.origin.pushHeadOnly) &&
+	! (cd default/.git && git config --bool remote.origin.autosetuppush) &&
+	test "+refs/heads/*:refs/remotes/origin/*" = \
+		"$(cd default && git config remote.origin.fetch)" &&
+	test HEAD = "$(cd default && git config remote.origin.push)"
+
+'
+
+test_expect_success 'clone --push=tracking' '
+
+	git clone --push=tracking src tracking &&
+	test -f tracking/.git/HEAD &&
+	test -f tracking/file &&
+	! (cd tracking && git config --bool remote.origin.mirror) &&
+	(cd tracking && git config --bool remote.origin.pushHeadOnly) &&
+	(cd tracking && git config --bool remote.origin.autosetuppush) &&
+	test "+refs/heads/*:refs/remotes/origin/*" = \
+		"$(cd tracking && git config remote.origin.fetch)" &&
+	test refs/heads/master:refs/heads/master = \
+		"$(cd tracking && git config remote.origin.push)"
+
+'
+
+test_expect_success 'clone --push=matching' '
+
+	git clone --push=matching src matching &&
+	test -f matching/.git/HEAD &&
+	test -f matching/file &&
+	! (cd matching && git config --bool remote.origin.mirror) &&
+	! (cd matching && git config --bool remote.origin.pushHeadOnly) &&
+	! (cd matching && git config --bool remote.origin.autosetuppush) &&
+	test "+refs/heads/*:refs/remotes/origin/*" = \
+		"$(cd matching && git config remote.origin.fetch)" &&
+	test : = "$(cd matching && git config remote.origin.push)"
+
+'
+
 test_expect_success 'clone --bare names the local repository <name>.git' '
 
 	git clone --bare src &&
-- 
1.6.2.5
