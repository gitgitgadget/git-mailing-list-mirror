From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-init: set core.workdir when GIT_WORK_DIR is specified
Date: Sat, 17 Mar 2007 00:29:27 -0700
Message-ID: <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net>
References: <20070317015855.GB19305@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sat Mar 17 08:29:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSTM6-000796-B3
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 08:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbXCQH3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 03:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbXCQH3b
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 03:29:31 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:56373 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbXCQH33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 03:29:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070317072927.ZELM1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 17 Mar 2007 03:29:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bjVT1W00R1kojtg0000000; Sat, 17 Mar 2007 03:29:28 -0400
In-Reply-To: <20070317015855.GB19305@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sat, 17 Mar 2007 02:58:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42426>

Matthias Lederhofer <matled@gmx.net> writes:

> git init will die with an error message before doing anything if the
> value of GIT_WORK_DIR is no valid directory.  GIT_WORK_DIR is also
> expanded to an absolute path for the config file and is shown to the
> user (core.workdir = <path>).

No other configuration variable that is automatically set gives
such an unwarranted noise to the standard output.

Applied with printf() removed.  Will cook further in 'pu', as I
am seeing some questionable things that are queued in there
already.

diff --git a/cache.h b/cache.h
index a4762ed..3bacc46 100644
--- a/cache.h
+++ b/cache.h
@@ -144,6 +144,7 @@ enum object_type {
 };
 
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_WORKING_DIR_ENVIRONMENT "GIT_WORK_DIR"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
@@ -164,6 +165,7 @@ extern char *get_graft_file(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
+extern int has_working_directory;
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);

I think "has_working_directory" and "GIT_WORK_DIR" are a bit
confusing, as everybody knows what a working directory is, and
it is returned by `pwd`.  But that is obviously not what you
mean by these words.

We seem to use the word "working tree" in our documentation to
differenciate the concept of "directory that corresponds to the
toplevel of the tree structure represented by the index and a
tree object" from the UNIXy concept of the "current working
directory".

No matter what that concept will end up being called, has_XXX
does not sound right either.  Everybody has the working tree;
the new mechanism is about having the working tree in unusual
location, different from the conventional "attached directly
above the repository" layout.  Perhaps "separate_working_tree"?


diff --git a/environment.c b/environment.c
index 0151ad0..7bf6a87 100644
--- a/environment.c
+++ b/environment.c
@@ -59,8 +59,15 @@ static void setup_git_env(void)
 int is_bare_repository(void)
 {
 	const char *dir, *s;
-	if (0 <= is_bare_repository_cfg)
-		return is_bare_repository_cfg;
+	/* definitely bare */
+	if (is_bare_repository_cfg == 1)
+		return 1;
+	/* GIT_WORK_DIR is set, bare if cwd is outside */
+	if (has_working_directory >= 0)
+		return !has_working_directory;
+	/* configuration says it is not bare */
+	if (is_bare_repository_cfg == 0)
+		return 0;

This feels convoluted.  Both of these variables stay -1
(uninitialized) when unknown, set to 0 if definite negative and
set to 1 if definite positive, so it is unclear why you are
checking only positive is_bare first, then the new setting and
then negative is_bare later.  Wouldn't it be easier to
understand if it were written like this?

	/* if configuration says so, then we obey. */
	if (0 <= is_bare_repository_cfg)
		return is_bare_repository_cfg;

	/*
         * if separate working-tree is specified, then we _do_
         * have the working tree and the repository is not bare.
         */
	if (0 <= separate_working_tree_cfg)
        	return !separate_working_tree_cfg;
 
... especially since you updated git-init so that you can
instruct it not to set core.bare by having working tree location
explicitly specified with an environment variable.

diff --git a/setup.c b/setup.c
index a45ea83..208124f 100644
--- a/setup.c
+++ b/setup.c
@@ -192,28 +192,143 @@ int is_inside_git_dir(void)
 	return inside_git_dir;
 }
 
+static int stat_git_work_dir(struct stat *st)
+{
+	char workdir[PATH_MAX], cwd[PATH_MAX];
+	const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
+	const char *gitwd = getenv(GIT_WORKING_DIR_ENVIRONMENT);
+
+	if (gitwd) {
+		if (!stat(gitwd, st))
+			return 1;
+		die("Unable to stat git working directory '%s'", gitwd);
+	}
+
+	/* get workdir from config */
+	workdir[0] = '\0';
+	git_work_dir = workdir;
+	git_config(git_workdir_config);
+	git_work_dir = NULL;
+	if (!workdir[0])
+		return 0;
+
+	/* relative path: change to gitdir for stat */
+	if (workdir[0] != '/') {
+		if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
+			die("Unable to read current working directory");
+		if (chdir(gitdir))
+			die("Cannot change directory to '%s'", gitdir);
+	}
+
+	if (stat(workdir, st))
+		die("Unable to stat git working directory '%s'", workdir);
+
+	if (workdir[0] != '/' && chdir(cwd))
+		die("Cannot come back to cwd");
+
+	return 1;
+}

Blech.  stat_* that returns 1 for success, 0 for wtf (perhaps
meaning "n/a")?

I think naming this function "stat" is exposing too much
implementation detail.  Can the name describe _why_ the caller
may want to call this function, iow, to achieve what goal?  For
example, "check_separate_working_tree()" that returns false when
separate-working-tree feature is not used is easier to
understand, I would say.  And as a side effect of checking, you
would get stat info back that you can later use to dig into the
working tree, but that is an implementation detail.

+int has_working_directory = -1;
+
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
 	int len, offset;
 
-	/*
-	 * If GIT_DIR is set explicitly, we're not going
-	 * to do any discovery, but we still do repository
-	 * validation.
-	 */

Isn't this comment still half-valid?  We never do "discovery";
we however now allow the working tree to be specified explicitly
as an option.

 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv) {
+		struct stat st, st_work, st_git;
+		char *prefix;
+		char c;
+		int len;
+
 		if (PATH_MAX - 40 < strlen(gitdirenv))
 			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
-		if (is_git_directory(gitdirenv))
-			return NULL;
-		if (nongit_ok) {
-			*nongit_ok = 1;
+		if (!is_git_directory(gitdirenv)) {
+			if (nongit_ok) {
+				*nongit_ok = 1;
+				return NULL;
+			}
+			die("Not a git repository: '%s'", gitdirenv);
+		}

... and this part is the "validation" part.

+
+		/* check for working directory */
+		if (!stat_git_work_dir(&st_work))
 			return NULL;

... and this return is "is the separate, explicit working tree
feature is in use?".  And the rest is the new codepath that can
be triggered with the optional stuff.

+		if (inside_git_dir == -1 && stat(gitdirenv, &st_git))
+			die("Unable to stat git directory");
+		if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
+			die("Unable to read current working directory");
+		len = strlen(cwd);
+
+		prefix = cwd+len;
+		for (;;) {
+			c = *prefix;
+			*prefix = '\0';
+			if (stat(cwd, &st))
+				die("Unable to stat '%s'", cwd);
+			if (st_work.st_dev == st.st_dev &&
+			    st_work.st_ino == st.st_ino)
+				break;
+			if (inside_git_dir == -1 &&
+			    st_git.st_dev == st.st_dev &&
+			    st_git.st_ino == st.st_ino)
+				inside_git_dir = 1;
+			*prefix = c;
+
+			if (prefix == cwd+1) {
+				has_working_directory = 0;
+				return NULL;
+			}
+			while (*(--prefix) != '/')
+				; /* do nothing */
+			if (prefix == cwd)
+				prefix++;
 		}

Is it safe to assume that we can rely on st_dev/st_ino
comparison?

Do we really need to do this?  Unless symlinks and automounts
are involved, shouldn't git_work_dir be a substring of cwd and
in that case can't you simply find the prefix with prefixcmp()?
I know doing that would not let you test the "is this inside
git-dir" condition when GIT_DIR is relative path, but I suspect
the user deserves it if he is dissociating the working tree from
the usual repository location with the new mechanism, specify
GIT_DIR with relative path _and_ chdir around into GIT_DIR.  I
know you meant well, but the above feels rather scary code for
dubious benefit.
