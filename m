From: Jeff King <peff@peff.net>
Subject: Re: Alternates corruption issue
Date: Tue, 31 Jan 2012 14:39:22 -0500
Message-ID: <20120131193922.GA31551@sigill.intra.peff.net>
References: <1328018729.13744.26.camel@ted>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 20:39:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsJYA-0006i4-Ui
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 20:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072Ab2AaTj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 14:39:26 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51113
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755062Ab2AaTjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 14:39:25 -0500
Received: (qmail 429 invoked by uid 107); 31 Jan 2012 19:46:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Jan 2012 14:46:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2012 14:39:22 -0500
Content-Disposition: inline
In-Reply-To: <1328018729.13744.26.camel@ted>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189467>

On Tue, Jan 31, 2012 at 02:05:29PM +0000, Richard Purdie wrote:

> I have a problem with git clone commands using alternates failing by
> mixing up different repositories. I have a situation where I could end
> up with both:
> 
> /srv/mirrors/repo
> /srv/mirrors/repo.git

I think the alternates thing is just a side effect. The real problem is
that clone is picking the wrong repo to clone from! So a simple complete
test would be something like:

    # make confusing bare repos
    git init --bare bare &&
    git init --bare bare.git &&

    # now make some commits; after this
    # segment, "bare" should have its tip
    # at commit "one", and "bare.git" should
    # be at "two".
    git init source &&
    (cd source &&
     echo content >file &&
     git add file &&
     git commit -m one &&
     git push ../bare HEAD &&
     echo content >>file &&
     git commit -a -m two &&
     git push ../bare.git HEAD
    ) &&

    # now try to clone bare and see which one we get;
    # we would expect the tip to be at "one", but it's not
    git clone bare clone &&
    cd clone &&
    echo one >expect &&
    git log -1 --format=%s >actual &&
    diff -u expect actual

    # we cloned the wrong repository!

> Looking at the code, the cause seems to be
> 
> clone.c:get_repo_path():
> 
> 	static char *suffix[] = { "/.git", ".git", "" };
> 
> since its looking in order for:
>  repo/.git (fails)
>  repo.git (suceeds, incorrect)
>  repo (never looked at)

Yeah, this seems brain-dead. It's good that git looks through a magic
list to guess what I meant, but shouldn't the first thing it tries be
the literal string that I gave, and only _then_ kick in the magic?

But even weirder, this doesn't match the lookup in other parts of git. I
see four distinct places in git where we do repository lookup:

  1. get_repo_path used by clone (i.e., this)

  2. enter_repo used by upload-pack, receive-pack, and git-daemon; this
     looks first for ".git/.git", to find a non-bare repo which is named
     like a bare one.

  3. setup_git_directory_*, used by most git programs. This starts
     looking in the current directory and going up, looking first for
     ".git", and then checking for a bare repo. So if you were to do
     "cd bare && git foo", then we would correctly find the current
     directory, not "bare.git".

  4. setup_explicit_git_dir, which gets called if you use --git-dir or
     set GIT_DIR. This expects to find the repo directly in the
     directory you specified, with no magic.

So I think (3) and (4) are sensible, but I tend to think that (1) and
(2) are wrong, and should prefer the directory you gave before the
magic.

> I'm not sure what would break if that order were to change, swapping the
> last two options.

I believe that would work in your case, but it seems like the most
correct thing would actually be:

  { "", "/.git", ".git" }

That is:

  1. Try the literal path the user gave as a repo

  2. Otherwise, try it as the root of a working tree (containing .git)

  3. Otherwise, assume they were too lazy to type ".git" and include it

If you simply swap the last two, then there is one obscure case you
would miss: a bare repo which contains a .git directory. Of course, that
seems like an insane thing to have, but if you did have it, I would
expect git to follow the rules I outlined above. That being said,
if you follow the rules in setup_git_directory_gently_1, it actually
prefers "/.git" to a bare repo. So probably your swap is better, as it
matches the lookup here with the regular setup_git_directory one.

One slight complication is that get_repo_path only checks whether the
paths exist, not whether they are actually git repositories. So by
simply swapping the order, you are breaking some other obscure cases,
like where a "foo" directory exists but is _not_ a git repo, and a
"foo.git" exists alongside it (which sounds a bit crazy, but I could see
somebody using that scheme if they wanted didn't want the git repository
to live inside the worktree for some reason).

One way of dealing with that would be to make get_repo_path a little
more robust by only selecting paths which actually look like git
directories.

The patch below does this, and makes my test above pass. But I think
before talking too much about code, it would be best to decide on what
the lookup order _should_ be, and then we can write tests and implement
to them.

-Peff

---
diff --git a/builtin/clone.c b/builtin/clone.c
index 9084feb..0fbbae9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -108,7 +108,7 @@ static const char *argv_submodule[] = {
 
 static char *get_repo_path(const char *repo, int *is_bundle)
 {
-	static char *suffix[] = { "/.git", ".git", "" };
+	static char *suffix[] = { "/.git", "", ".git" };
 	static char *bundle_suffix[] = { ".bundle", "" };
 	struct stat st;
 	int i;
@@ -118,7 +118,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 		path = mkpath("%s%s", repo, suffix[i]);
 		if (stat(path, &st))
 			continue;
-		if (S_ISDIR(st.st_mode)) {
+		if (S_ISDIR(st.st_mode) && is_git_directory(path)) {
 			*is_bundle = 0;
 			return xstrdup(absolute_path(path));
 		} else if (S_ISREG(st.st_mode) && st.st_size > 8) {
diff --git a/cache.h b/cache.h
index 9bd8c2d..7b2857f 100644
--- a/cache.h
+++ b/cache.h
@@ -436,6 +436,7 @@ extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
+extern int is_git_directory(const char *path);
 extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
diff --git a/path.c b/path.c
index b6f71d1..1ca6567 100644
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
+			     (S_ISDIR(st.st_mode) && is_git_directory(used_path)))) {
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
