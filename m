From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Wed, 14 Oct 2009 00:44:34 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 06:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxvko-0007NA-04
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 06:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbZJNEpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 00:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbZJNEpN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 00:45:13 -0400
Received: from iabervon.org ([66.92.72.58]:38662 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbZJNEpM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 00:45:12 -0400
Received: (qmail 13990 invoked by uid 1000); 14 Oct 2009 04:44:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Oct 2009 04:44:34 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130242>

When detaching HEAD (or "browsing history"), the user has specified
the commit with some "extended SHA1" which is not a local
branch. Exactly what that string was is likely to be useful to the
user later. Also, we can detect the user putting work into the history
for the first time (such that it is no longer going to be protected as
uncommitted changes in the working tree) without a branch to hold it
by seeing that there is such a description for the current state
before the commit. (Afterwards, the description should be dropped; it
doesn't make sense to tell the user they checked out "origin/master"
or "d199fb7" when they've now diverged from that remote branch with
local changes or made a different commit.)

The upshot of the messages should be:

 $ git checkout origin/master
 Since you can't actually change "origin/master" yourself, you'll just
 be sightseeing unless you create a local branch to hold new local work.

 $ git branch
 * (not a local branch, but "origin/master")

 $ git commit
 You've been sightseeing "origin/master". The commit can't change that
 value, so your commit isn't held in any branch. If you want to create
 a branch to hold it, here's how.

"git checkout origin/master" should be similar in complexity to
"svn checkout -r 8655"; the difference is that svn won't let you
commit then and git will but you'll need to understand the
implications if you do so. If you don't commit (because you don't want
to make any changes, because you don't think it would be possible, or
because you don't want to worry about what would happen), there's no
meaningful difference, and you don't need to be told.

The messages have to be improved and made more useful.

The effects of "git checkout HEAD", "git checkout origin/master; git 
checkout HEAD^", and "git checkout origin/master; git reset --hard 
origin/next" aren't handled quite right; none of them keep a description, 
but there should always be some description of a detached HEAD unless the 
user has made a commit (and therefore gotten the message about making a 
local branch to put it on).
---
 branch.c                 |   13 +++++++++++++
 branch.h                 |    6 ++++++
 builtin-branch.c         |   13 ++++++++++++-
 builtin-checkout.c       |    8 +++++++-
 builtin-commit.c         |   10 +++++++++-
 t/t3203-branch-output.sh |    2 +-
 t/t7201-co.sh            |    6 ++----
 7 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index 05ef3f5..2c5b6d3 100644
--- a/branch.c
+++ b/branch.c
@@ -194,6 +194,18 @@ void create_branch(const char *head,
 	free(real_ref);
 }
 
+char *get_detached_head_string(void)
+{
+	char *filename = git_path("DETACH_NAME");
+	struct stat st;
+	if (stat(filename, &st) || !S_ISREG(st.st_mode))
+		return NULL;
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_read_file(&buf, filename, st.st_size);
+	strbuf_trim(&buf);
+	return strbuf_detach(&buf, 0);
+}
+
 void remove_branch_state(void)
 {
 	unlink(git_path("MERGE_HEAD"));
@@ -201,4 +213,5 @@ void remove_branch_state(void)
 	unlink(git_path("MERGE_MSG"));
 	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
+	unlink(git_path("DETACH_NAME"));
 }
diff --git a/branch.h b/branch.h
index eed817a..0a30c3a 100644
--- a/branch.h
+++ b/branch.h
@@ -22,6 +22,12 @@ void create_branch(const char *head, const char *name, const char *start_name,
 void remove_branch_state(void);
 
 /*
+ * Returns the string used when detaching HEAD, or NULL if HEAD is not
+ * detached.
+ */
+char *get_detached_head_string(void);
+
+/*
  * Configure local branch "local" to merge remote branch "remote"
  * taken from origin "origin".
  */
diff --git a/builtin-branch.c b/builtin-branch.c
index 9f57992..9ce4127 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -425,7 +425,18 @@ static void show_detached(struct ref_list *ref_list)
 
 	if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {
 		struct ref_item item;
-		item.name = xstrdup("(no branch)");
+		char *literal = get_detached_head_string();
+		struct stat st;
+		if (literal) {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addstr(&buf, "(no branch, as \"");
+			strbuf_addstr(&buf, literal);
+			strbuf_addstr(&buf, "\")");
+			free(literal);
+			item.name = strbuf_detach(&buf, 0);
+		} else {
+			item.name = xstrdup("(no branch)");
+		}
 		item.len = strlen(item.name);
 		item.kind = REF_LOCAL_BRANCH;
 		item.dest = NULL;
diff --git a/builtin-checkout.c b/builtin-checkout.c
index d050c37..448397d 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -510,11 +510,17 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			   REF_NODEREF, DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old->path)
-				fprintf(stderr, "Note: moving to '%s' which isn't a local branch\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
+				fprintf(stderr, "Note: moving to '%s' which isn't a local branch.\nAny commits you may make will not affect the commit with this name.\n", new->name);
 			describe_detached_head("HEAD is now at", new->commit);
 		}
 	}
 	remove_branch_state();
+	if (!new->path && strcmp(new->name, "HEAD")) {
+		FILE *detach_name;
+		detach_name = fopen(git_path("DETACH_NAME"), "w");
+		fprintf(detach_name, "%s\n", new->name);
+		fclose(detach_name);
+	}
 	strbuf_release(&msg);
 	if (!opts->quiet && (new->path || !strcmp(new->name, "HEAD")))
 		report_tracking(new);
diff --git a/builtin-commit.c b/builtin-commit.c
index 200ffda..2ceb951 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -24,6 +24,7 @@
 #include "string-list.h"
 #include "rerere.h"
 #include "unpack-trees.h"
+#include "branch.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -968,6 +969,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
+	char *detached_string;
 	int allow_fast_forward = 1;
 	struct wt_status s;
 
@@ -1089,10 +1091,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die("cannot update HEAD ref");
 	}
 
+	detached_string = get_detached_head_string();
+
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
 	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
+	unlink(git_path("DETACH_NAME"));
 
 	if (commit_index_files())
 		die ("Repository has been updated, but unable to write\n"
@@ -1101,8 +1106,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	rerere();
 	run_hook(get_index_file(), "post-commit", NULL);
-	if (!quiet)
+	if (!quiet) {
+		if (detached_string)
+			fprintf(stderr, "\nNote: you had checked out '%s' which isn't a local branch.\nIf you want to create a new branch with this commit, you may do so\n(now or later) by using -b with the checkout command. Example:\n  git checkout -b <new_branch_name>\n\n", detached_string);
 		print_summary(prefix, commit_sha1);
+	}
 
 	return 0;
 }
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 809d1c4..08409cd 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -67,7 +67,7 @@ test_expect_success 'git branch -v shows branch summaries' '
 '
 
 cat >expect <<'EOF'
-* (no branch)
+* (no branch, as "HEAD^0")
   branch-one
   branch-two
   master
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index ebfd34d..0f40589 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -171,10 +171,8 @@ test_expect_success 'checkout to detach HEAD' '
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
 	(cat >messages.expect <<EOF
-Note: moving to '\''renamer^'\'' which isn'\''t a local branch
-If you want to create a new branch from this checkout, you may do so
-(now or later) by using -b with the checkout command again. Example:
-  git checkout -b <new_branch_name>
+Note: moving to '\''renamer^'\'' which isn'\''t a local branch.
+Any commits you may make will not affect the commit with this name.
 HEAD is now at 7329388... Initial A one, A two
 EOF
 ) &&
-- 
1.6.5.9.ge994f.dirty
