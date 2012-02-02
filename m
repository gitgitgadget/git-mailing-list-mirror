From: Jeff King <peff@peff.net>
Subject: Re: Alternates corruption issue
Date: Thu, 2 Feb 2012 16:59:13 -0500
Message-ID: <20120202215913.GA26727@sigill.intra.peff.net>
References: <1328018729.13744.26.camel@ted>
 <20120131193922.GA31551@sigill.intra.peff.net>
 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
 <20120131204417.GA30969@sigill.intra.peff.net>
 <20120131214047.GA13547@burratino>
 <20120131214740.GA2465@sigill.intra.peff.net>
 <20120131215501.GF13252@burratino>
 <20120131220510.GA3253@sigill.intra.peff.net>
 <20120131222258.GG13252@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 22:59:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt4gj-0006vd-L7
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 22:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757488Ab2BBV7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 16:59:19 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53743
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756660Ab2BBV7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 16:59:17 -0500
Received: (qmail 26421 invoked by uid 107); 2 Feb 2012 22:06:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 17:06:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 16:59:13 -0500
Content-Disposition: inline
In-Reply-To: <20120131222258.GG13252@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189714>

On Tue, Jan 31, 2012 at 04:22:58PM -0600, Jonathan Nieder wrote:

> Anyway, thanks for explaining.  Hopefully I can get to this soon and
> factor out a common function for get_repo_path and enter_repo to call
> so playing with the ordering becomes a little less scary. ;-)

So here's what I think we should apply to fix the particular issue that
Richard mentioned at the start of this thread.

Besides tweaking the ordering, the main contribution is a set of tests
that actually check some of these ambiguous cases (especially checking
the fact that both code paths behave identically!). I didn't factor the
logic into a common function, but doing so should be a little safer on
top of these tests, if you're still interested.

-- >8 --
Subject: standardize and improve lookup rules for external local repos

When you specify a local repository on the command line of
clone, ls-remote, upload-pack, receive-pack, or upload-archive,
or in a request to git-daemon, we perform a little bit of
lookup magic, doing things like looking in working trees for
.git directories and appending ".git" for bare repos.

For clone, this magic happens in get_repo_path. For
everything else, it happens in enter_repo. In both cases,
there are some ambiguous or confusing cases that aren't
handled well, and there is one case that is not handled the
same by both methods.

This patch tries to provide (and test!) standard, sensible
lookup rules for both code paths. The intended changes are:

  1. When looking up "foo", we have always preferred
     a working tree "foo" (containing "foo/.git" over the
     bare "foo.git". But we did not prefer a bare "foo" over
     "foo.git". With this patch, we do so.

  2. We would select directories that existed but didn't
     actually look like git repositories. With this patch,
     we make sure a selected directory looks like a git
     repo. Not only is this more sensible in general, but it
     will help anybody who is negatively affected by change
     (1) negatively (e.g., if they had "foo.git" next to its
     separate work tree "foo", and expect to keep finding
     "foo.git" when they reference "foo").

  3. The enter_repo code path would, given "foo", look for
     "foo.git/.git" (i.e., do the ".git" append magic even
     for a repo with working tree). The clone code path did
     not; with this patch, they now behave the same.

In the unlikely case of a working tree overlaying a bare
repo (i.e., a ".git" directory _inside_ a bare repo), we
continue to treat it as a working tree (prefering the
"inner" .git over the bare repo). This is mainly because the
combination seems nonsensical, and I'd rather stick with
existing behavior on the off chance that somebody is relying
on it.

Signed-off-by: Jeff King <peff@peff.net>
---
I could go either way with the "prefer foo to foo/.git" thing we've been
discussing. I left it as-is here out of a sense of being conservative.
But I have no objection at all to you doing a patch on top that
justifies the change. You'll just need to tweak the "check" line of the
final test.

 builtin/clone.c           |    4 +-
 cache.h                   |    1 +
 path.c                    |    7 ++-
 setup.c                   |    2 +-
 t/t5900-repo-selection.sh |  100 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 109 insertions(+), 5 deletions(-)
 create mode 100755 t/t5900-repo-selection.sh

diff --git a/builtin/clone.c b/builtin/clone.c
index c62d4b5..637611a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -107,7 +107,7 @@ static const char *argv_submodule[] = {
 
 static char *get_repo_path(const char *repo, int *is_bundle)
 {
-	static char *suffix[] = { "/.git", ".git", "" };
+	static char *suffix[] = { "/.git", "", ".git/.git", ".git" };
 	static char *bundle_suffix[] = { ".bundle", "" };
 	struct stat st;
 	int i;
@@ -117,7 +117,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 		path = mkpath("%s%s", repo, suffix[i]);
 		if (stat(path, &st))
 			continue;
-		if (S_ISDIR(st.st_mode)) {
+		if (S_ISDIR(st.st_mode) && is_git_directory(path)) {
 			*is_bundle = 0;
 			return xstrdup(absolute_path(path));
 		} else if (S_ISREG(st.st_mode) && st.st_size > 8) {
diff --git a/cache.h b/cache.h
index 9bd8c2d..ae0396b 100644
--- a/cache.h
+++ b/cache.h
@@ -432,6 +432,7 @@ extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
 extern int have_git_dir(void);
 extern const char *get_git_dir(void);
+extern int is_git_directory(const char *path);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
diff --git a/path.c b/path.c
index b6f71d1..6f2aa69 100644
--- a/path.c
+++ b/path.c
@@ -293,7 +293,7 @@ const char *enter_repo(const char *path, int strict)
 
 	if (!strict) {
 		static const char *suffix[] = {
-			".git/.git", "/.git", ".git", "", NULL,
+			"/.git", "", ".git/.git", ".git", NULL,
 		};
 		const char *gitfile;
 		int len = strlen(path);
@@ -324,8 +324,11 @@ const char *enter_repo(const char *path, int strict)
 			return NULL;
 		len = strlen(used_path);
 		for (i = 0; suffix[i]; i++) {
+			struct stat st;
 			strcpy(used_path + len, suffix[i]);
-			if (!access(used_path, F_OK)) {
+			if (!stat(used_path, &st) &&
+			    (S_ISREG(st.st_mode) ||
+			    (S_ISDIR(st.st_mode) && is_git_directory(used_path)))) {
 				strcat(validated_path, suffix[i]);
 				break;
 			}
diff --git a/setup.c b/setup.c
index 61c22e6..7a3618f 100644
--- a/setup.c
+++ b/setup.c
@@ -247,7 +247,7 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
  *    a proper "ref:", or a regular file HEAD that has a properly
  *    formatted sha1 object name.
  */
-static int is_git_directory(const char *suspect)
+int is_git_directory(const char *suspect)
 {
 	char path[PATH_MAX];
 	size_t len = strlen(suspect);
diff --git a/t/t5900-repo-selection.sh b/t/t5900-repo-selection.sh
new file mode 100755
index 0000000..3d5b418
--- /dev/null
+++ b/t/t5900-repo-selection.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+
+test_description='selecting remote repo in ambiguous cases'
+. ./test-lib.sh
+
+reset() {
+	rm -rf foo foo.git fetch clone
+}
+
+make_tree() {
+	git init "$1" &&
+	(cd "$1" && test_commit "$1")
+}
+
+make_bare() {
+	git init --bare "$1" &&
+	(cd "$1" &&
+	 tree=`git hash-object -w -t tree /dev/null` &&
+	 commit=$(echo "$1" | git commit-tree $tree) &&
+	 git update-ref HEAD $commit
+	)
+}
+
+get() {
+	git init --bare fetch &&
+	(cd fetch && git fetch "../$1") &&
+	git clone "$1" clone
+}
+
+check() {
+	echo "$1" >expect &&
+	(cd fetch && git log -1 --format=%s FETCH_HEAD) >actual.fetch &&
+	(cd clone && git log -1 --format=%s HEAD) >actual.clone &&
+	test_cmp expect actual.fetch &&
+	test_cmp expect actual.clone
+}
+
+test_expect_success 'find .git dir in worktree' '
+	reset &&
+	make_tree foo &&
+	get foo &&
+	check foo
+'
+
+test_expect_success 'automagically add .git suffix' '
+	reset &&
+	make_bare foo.git &&
+	get foo &&
+	check foo.git
+'
+
+test_expect_success 'automagically add .git suffix to worktree' '
+	reset &&
+	make_tree foo.git &&
+	get foo &&
+	check foo.git
+'
+
+test_expect_success 'prefer worktree foo over bare foo.git' '
+	reset &&
+	make_tree foo &&
+	make_bare foo.git &&
+	get foo &&
+	check foo
+'
+
+test_expect_success 'prefer bare foo over bare foo.git' '
+	reset &&
+	make_bare foo &&
+	make_bare foo.git &&
+	get foo &&
+	check foo
+'
+
+test_expect_success 'disambiguate with full foo.git' '
+	reset &&
+	make_bare foo &&
+	make_bare foo.git &&
+	get foo.git &&
+	check foo.git
+'
+
+test_expect_success 'we are not fooled by non-git foo directory' '
+	reset &&
+	make_bare foo.git &&
+	mkdir foo &&
+	get foo &&
+	check foo.git
+'
+
+test_expect_success 'prefer inner .git over outer bare' '
+	reset &&
+	make_tree foo &&
+	make_bare foo.git &&
+	mv foo/.git foo.git &&
+	get foo.git &&
+	check foo
+'
+
+test_done
-- 
1.7.9.rc1.28.gf4be5
