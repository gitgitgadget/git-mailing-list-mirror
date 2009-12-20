From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Introduce the GIT_HOME environment variable
Date: Sun, 20 Dec 2009 01:34:33 +0100
Message-ID: <20091220003433.GM25474@genesis.frugalware.org>
References: <4B2C0828.4010505@signalbeam.net>
 <20091219013246.GD25474@genesis.frugalware.org>
 <7vhbrnodd9.fsf@alter.siamese.dyndns.org>
 <4B2C5A1A.8000201@signalbeam.net>
 <7vzl5fik3o.fsf@alter.siamese.dyndns.org>
 <20091219153046.GG25474@genesis.frugalware.org>
 <7vhbrmahwq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Moe <moe@signalbeam.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 01:34:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM9kx-0007mg-8G
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 01:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbZLTAei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 19:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754503AbZLTAei
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 19:34:38 -0500
Received: from virgo.iok.hu ([212.40.97.103]:32873 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754540AbZLTAei (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 19:34:38 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 95DB358084;
	Sun, 20 Dec 2009 01:34:34 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6CEF644965;
	Sun, 20 Dec 2009 01:34:34 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 407441240014; Sun, 20 Dec 2009 01:34:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhbrmahwq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135512>

Honor $GIT_HOME that is favoured over $HOME, just like $GIT_EDITOR
overrides $EDITOR.  That allows us to extend the notion more naturally
in the future.  For example, when we start reading from
$HOME/.gitconfig, if the GIT_HOME environment is set, we would instead
read from $GIT_HOME/.gitconfig.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Dec 19, 2009 at 11:21:57AM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> then a mechanical s/getenv("GIT_HOME")/gitcustom_home()/; will make the
> resulting code a lot simpler and a new callsite somebody may add in the
> future would not have to duplicate three lines.

Done.

> But I sense that Moe is retracting his claim that the unmodified git
> doesn't do what he needs to do, after Dscho suggested to use more specific
> environment variables to the task at hand?

I think Moe's problem is now solved by Dscho's suggestion, but this
patch helps other users where the user-specific setting may contain
other settings like diff.color (when $HOME is the same but GIT_HOME is
set based on ssh keys).

 Documentation/config.txt |   14 ++++++++++----
 builtin-config.c         |    4 ++--
 config.c                 |    2 +-
 git-compat-util.h        |    2 ++
 path.c                   |    2 +-
 t/t1300-repo-config.sh   |    7 +++++++
 wrapper.c                |    7 +++++++
 7 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a1e36d7..09cbc71 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -8,6 +8,10 @@ is used to store the configuration for that repository, and
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
 
+In case you want to store your per-user configuration in a directory
+different to `$HOME`, you can use the `$GIT_HOME` environment variable
+which has preference.
+
 The configuration variables are used by both the git plumbing
 and the porcelains. The variables are divided into sections, wherein
 the fully qualified variable name of the variable itself is the last
@@ -406,8 +410,9 @@ core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
 	of files which are not meant to be tracked.  "{tilde}/" is expanded
-	to the value of `$HOME` and "{tilde}user/" to the specified user's
-	home directory.  See linkgit:gitignore[5].
+	to the value of `$GIT_HOME` (or `$HOME` if `$GIT_HOME` is not
+	set) and "{tilde}user/" to the specified user's home directory.  See
+	linkgit:gitignore[5].
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
@@ -707,8 +712,9 @@ color.ui::
 
 commit.template::
 	Specify a file to use as the template for new commit messages.
-	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
-	specified user's home directory.
+	"{tilde}/" is expanded to the value of `$GIT_HOME` (or `$HOME`
+	if `$GIT_HOME` is not set) and "{tilde}user/" to the specified user's
+	home directory.
 
 diff.autorefreshindex::
 	When using 'git-diff' to compare with work tree
diff --git a/builtin-config.c b/builtin-config.c
index a2d656e..97284c6 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -146,7 +146,7 @@ static int get_value(const char *key_, const char *regex_)
 
 	local = config_exclusive_filename;
 	if (!local) {
-		const char *home = getenv("HOME");
+		const char *home = git_custom_home();
 		local = repo_config = git_pathdup("config");
 		if (git_config_global() && home)
 			global = xstrdup(mkpath("%s/.gitconfig", home));
@@ -326,7 +326,7 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	}
 
 	if (use_global_config) {
-		char *home = getenv("HOME");
+		const char *home = git_custom_home();
 		if (home) {
 			char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
 			config_exclusive_filename = user_config;
diff --git a/config.c b/config.c
index 37385ce..cb2add8 100644
--- a/config.c
+++ b/config.c
@@ -711,7 +711,7 @@ int git_config(config_fn_t fn, void *data)
 		found += 1;
 	}
 
-	home = getenv("HOME");
+	home = git_custom_home();
 	if (git_config_global() && home) {
 		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
 		if (!access(user_config, R_OK)) {
diff --git a/git-compat-util.h b/git-compat-util.h
index 5c59687..9f345da 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -465,4 +465,6 @@ void git_qsort(void *base, size_t nmemb, size_t size,
  */
 int unlink_or_warn(const char *path);
 
+const char *git_custom_home(void);
+
 #endif
diff --git a/path.c b/path.c
index 2ec950b..6038a95 100644
--- a/path.c
+++ b/path.c
@@ -236,7 +236,7 @@ char *expand_user_path(const char *path)
 		const char *username = path + 1;
 		size_t username_len = first_slash - username;
 		if (username_len == 0) {
-			const char *home = getenv("HOME");
+			const char *home = git_custom_home();
 			strbuf_add(&user_path, home, strlen(home));
 		} else {
 			struct passwd *pw = getpw_str(username, username_len);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 83b7294..d9818ab 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -18,6 +18,13 @@ EOF
 
 test_expect_success 'initial' 'cmp .git/config expect'
 
+test_expect_success 'GIT_HOME' '
+	GIT_HOME="`pwd`" &&
+	export GIT_HOME &&
+	git config --global core.penguin "little blue" &&
+	cmp "$GIT_HOME"/.gitconfig expect
+'
+
 git config Core.Movie BadPhysics
 
 cat > expect << EOF
diff --git a/wrapper.c b/wrapper.c
index c9be140..b7f6649 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -305,3 +305,10 @@ int unlink_or_warn(const char *file)
 	return rc;
 }
 
+const char *git_custom_home(void)
+{
+	const char *val = getenv("GIT_HOME");
+	if (!val)
+		val = getenv("HOME");
+	return val;
+}
-- 
1.6.5.2
