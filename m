From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 1.4.0 usability problem
Date: Sun, 18 Jun 2006 15:25:27 -0700
Message-ID: <7vbqsqdru0.fsf@assigned-by-dhcp.cox.net>
References: <449557B6.1080907@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Jun 19 00:25:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs5iE-00076P-5D
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 00:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWFRWZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 18:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWFRWZb
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 18:25:31 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:40111 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751111AbWFRWZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 18:25:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618222528.RWCH18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Jun 2006 18:25:28 -0400
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <449557B6.1080907@garzik.org> (Jeff Garzik's message of "Sun, 18
	Jun 2006 09:40:06 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22107>

Jeff Garzik <jeff@garzik.org> writes:

> Here is how to reproduce:

This is not related to the "not clobbering untracked files"
safety valve under discussion, but one thing I noticed.

> git clone -l $url/torvalds/linux-2.6.git tmp-2.6
> cd tmp-2.6
> cp .git/refs/tags/v2.6.12 .git/refs/heads/tmp
> git checkout -f tmp

This should never have been supported.  At this point tmp is a
tag object that is under heads/ -- a definite no-no.  We should
make checkout more careful to complain about it.

Doing

        git update-ref refs/heads/tmp $(git rev-parse v2.6.12^0)

instead of "cp" is kosher, and

	git-rev-parse v2.6.12^0 >.git/refs/heads/tmp

is OK under the current implementation of refs.

> git pull . master
> # watch OBVIOUS FAST-FORWARD MERGE complain about untracked
> # working tree files

In any case, here is a patch I think would alleviate your
original problem.

Sorry for the trouble.  I really did not want to disrupt the
workflow of old timers in the name of making it safer for new
people.  Could you comment on whether this is an acceptable
approach?

-- >8 --
[PATCH] Conditionally loosen "no clobber untracked files" safety valve.

This introduces a new configuration item "core.oktoclobber" to
control how untracked working tree file is handled during branch
switching.

The safety valve introduced during 1.4.0 development cycle
refrains from checking out a file that exists in the working
tree, not in the current HEAD tree and exists in the branch we
are switching to, in order to prevent accidental and
irreversible lossage of user data.  This can be controlled by
having core.oktoclobber configuration item:

 - When core.oktoclobber is set to "false" (the default),
   untracked working tree files are never overwritten.

 - When core.oktoclobber is set to "true", the check is
   disabled.

 - When core.oktoclobber is set to "ask", and both standard
   input and standard error streams are connected to the
   terminal, we ask the user if it is OK to clobber.  You can
   answer:

	y: to allow clobbering only one path; the question is
	   asked again for other paths.
        n: to stop the operation.
	a: to allow clobbering any untracked files; the question
	   is not asked again.

   If the configuration item is set to "ask" but the program is
   not talking to a terminal, it refrains from clobbering the
   untracked files.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 builtin-read-tree.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 cache.h             |    6 ++++++
 config.c            |   20 ++++++++++++++++++++
 environment.c       |    1 +
 4 files changed, 69 insertions(+), 1 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 04506da..7a7018c 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -477,6 +477,46 @@ static void invalidate_ce_path(struct ca
 		cache_tree_invalidate_path(active_cache_tree, ce->name);
 }
 
+static int ok_to_clobber_untracked(const char *path, const char *action)
+{
+	switch (ok_to_clobber_untracked_files) {
+	case NEVER_CLOBBER:
+		return 0;
+	case OK_TO_CLOBBER:
+		return 1;
+	case ASK_TO_CLOBBER:
+		if (isatty(0) && isatty(2)) {
+			char answer[1024];
+			while (1) {
+				answer[0] = '\0';
+				fprintf(stderr,
+					"Untracked working tree file '%s' is"
+					" about to be %s.  Is it OK "
+					"[y]es/[n]o/yes to [a]ll? ",
+					path, action);
+				fgets(answer, sizeof(answer), stdin);
+				switch (answer[0]) {
+				case 'y': case 'Y':
+					return 1;
+				case 'n': case 'N':
+					return 0;
+				case 'a': case 'A':
+					ok_to_clobber_untracked_files =
+						OK_TO_CLOBBER;
+					return 1;
+				default:
+					fprintf(stderr,
+						"I do not understand.\n");
+				}
+			}
+		}
+		else {
+			ok_to_clobber_untracked_files = NEVER_CLOBBER;
+			return 0;
+		}
+	}
+}
+
 /*
  * We do not want to remove or overwrite a working tree file that
  * is not tracked.
@@ -485,7 +525,8 @@ static void verify_absent(const char *pa
 {
 	struct stat st;
 
-	if (index_only || reset || !update)
+	if (index_only || reset || !update ||
+	    ok_to_clobber_untracked(path, action))
 		return;
 	if (!lstat(path, &st))
 		die("Untracked working tree file '%s' "
diff --git a/cache.h b/cache.h
index f630cf4..7468440 100644
--- a/cache.h
+++ b/cache.h
@@ -183,6 +183,12 @@ extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int diff_rename_limit_default;
 extern int shared_repository;
+enum ok_to_clobber {
+	NEVER_CLOBBER = 0,
+	OK_TO_CLOBBER,
+	ASK_TO_CLOBBER
+};
+extern enum ok_to_clobber ok_to_clobber_untracked_files;
 extern const char *apply_default_whitespace;
 
 #define GIT_REPO_VERSION 0
diff --git a/config.c b/config.c
index 984c75f..13f5f4f 100644
--- a/config.c
+++ b/config.c
@@ -251,6 +251,21 @@ int git_config_bool(const char *name, co
 	return git_config_int(name, value) != 0;
 }
 
+static enum ok_to_clobber git_config_clobber(const char *var, const char *value)
+{
+	if (!strcasecmp(value, "ask"))
+		return ASK_TO_CLOBBER;
+	if (!strcasecmp(value, "yes"))
+		return OK_TO_CLOBBER;
+	if (!strcasecmp(value, "ok"))
+		return NEVER_CLOBBER;
+	if (!strcasecmp(value, "no"))
+		return NEVER_CLOBBER;
+	if (git_config_bool(var, value))
+		return OK_TO_CLOBBER;
+	return NEVER_CLOBBER;
+}
+
 int git_default_config(const char *var, const char *value)
 {
 	/* This needs a better name */
@@ -279,6 +294,11 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
+	if (!strcmp(var, "core.oktoclobber")) {
+		ok_to_clobber_untracked_files = git_config_clobber(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		safe_strncpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
diff --git a/environment.c b/environment.c
index 2e79eab..c388b5b 100644
--- a/environment.c
+++ b/environment.c
@@ -19,6 +19,7 @@ int warn_ambiguous_refs = 1;
 int repository_format_version = 0;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
 int shared_repository = 0;
+extern enum ok_to_clobber ok_to_clobber_untracked_files = NEVER_CLOBBER;
 const char *apply_default_whitespace = NULL;
 
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
