From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/8] revert: Improve error handling by cascading errors upwards
Date: Wed, 11 May 2011 13:30:15 +0530
Message-ID: <1305100822-20470-2-git-send-email-artagnon@gmail.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 18:28:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKCH5-00007y-97
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757607Ab1EKQ2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 12:28:04 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:35201 "EHLO
	smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757491Ab1EKQ2B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 12:28:01 -0400
X-IronPort-AV: E=Sophos;i="4.64,351,1301875200"; 
   d="scan'208";a="77409984"
Received: from smtp-in-5102.iad5.amazon.com ([10.218.9.29])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 May 2011 08:02:01 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-5102.iad5.amazon.com (8.13.8/8.13.8) with ESMTP id p4B81xQ7024404;
	Wed, 11 May 2011 08:02:00 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 8A277754816; Wed, 11 May 2011 13:30:22 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
In-Reply-To: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173407>

As a prelude to libification, we would like to propogate errors
upwards through the callchain, so as to correctly handle errors and
clean up afterwards.  Also introduce a new function
"error_resolve_conflict" in advice.c in an attempt to unify the way
conflicts are reported by the various components of Git.  As a general
guideline for libification, "die" should be only be called in two
cases: by toplevel callers like command-line argument parsing
routines, or when an irrecoverable situation is encountered.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Has the commit message justified this change fully?

 How do I trap and handle the exit status from write_message in
 do_pick_commit correctly?  There's already a call to
 do_recursive_merge whose exit status is being trapped -- what happens
 when do_recursive_merge succeeds and write_message fails, or
 viceversa?

 Junio has suggested dropping error_errno, and simply using error and
 returning -errno by hand in one email.  Considering the number of
 times I've used that tecnique, and I think we should get something
 like an error_errno atleast for the sake of terseness.

 advice.c         |   14 +++++
 advice.h         |    1 +
 builtin/revert.c |  158 ++++++++++++++++++++++++++++++-----------------------
 3 files changed, 104 insertions(+), 69 deletions(-)

diff --git a/advice.c b/advice.c
index 0be4b5f..3c3c187 100644
--- a/advice.c
+++ b/advice.c
@@ -47,3 +47,17 @@ void NORETURN die_resolve_conflict(const char *me)
 	else
 		die("'%s' is not possible because you have unmerged files.", me);
 }
+
+int error_resolve_conflict(const char *me)
+{
+	if (advice_resolve_conflict)
+		/*
+		 * Message used both when 'git commit' fails and when
+		 * other commands doing a merge do.
+		 */
+		return error("'%s' is not possible because you have unmerged files.\n"
+			"Please, fix them up in the work tree, and then use 'git add/rm <file>' as\n"
+			"appropriate to mark resolution and make a commit, or use 'git commit -a'.", me);
+	else
+		return error("'%s' is not possible because you have unmerged files.", me);
+}
diff --git a/advice.h b/advice.h
index 3244ebb..7b7cea5 100644
--- a/advice.h
+++ b/advice.h
@@ -13,5 +13,6 @@ extern int advice_detached_head;
 int git_default_advice_config(const char *var, const char *value);
 
 extern void NORETURN die_resolve_conflict(const char *me);
+extern int error_resolve_conflict(const char *me);
 
 #endif /* ADVICE_H */
diff --git a/builtin/revert.c b/builtin/revert.c
index f697e66..fefb18b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -167,9 +167,11 @@ static char *get_encoding(const char *message)
 {
 	const char *p = message, *eol;
 
-	if (!p)
-		die (_("Could not read commit message of %s"),
-				sha1_to_hex(commit->object.sha1));
+	if (!p) {
+		error(_("Could not read commit message of %s"),
+			sha1_to_hex(commit->object.sha1));
+		return NULL;
+	}
 	while (*p && *p != '\n') {
 		for (eol = p + 1; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
@@ -198,7 +200,7 @@ static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
 	strbuf_addstr(msgbuf, p);
 }
 
-static void write_cherry_pick_head(void)
+static int write_cherry_pick_head(void)
 {
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
@@ -206,12 +208,22 @@ static void write_cherry_pick_head(void)
 	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
 
 	fd = open(git_path("CHERRY_PICK_HEAD"), O_WRONLY | O_CREAT, 0666);
-	if (fd < 0)
-		die_errno(_("Could not open '%s' for writing"),
-			  git_path("CHERRY_PICK_HEAD"));
-	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
-		die_errno(_("Could not write to '%s'"), git_path("CHERRY_PICK_HEAD"));
+	if (fd < 0) {
+		int err = errno;
+		strbuf_release(&buf);
+		error(_("Could not open '%s' for writing: %s"),
+			git_path("CHERRY_PICK_HEAD"), strerror(err));
+		return -err;
+	}
+	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd)) {
+		int err = errno;
+		strbuf_release(&buf);
+		error(_("Could not write to '%s': %s"),
+			git_path("CHERRY_PICK_HEAD"), strerror(err));
+		return -err;
+	}
 	strbuf_release(&buf);
+	return 0;
 }
 
 static void advise(const char *advice, ...)
@@ -243,17 +255,22 @@ static void print_advice(void)
 	advise("and commit the result with 'git commit'");
 }
 
-static void write_message(struct strbuf *msgbuf, const char *filename)
+static int write_message(struct strbuf *msgbuf, const char *filename)
 {
 	static struct lock_file msg_file;
 
 	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
 					       LOCK_DIE_ON_ERROR);
-	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-		die_errno(_("Could not write to %s."), filename);
+	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0) {
+		int err = errno;
+		strbuf_release(msgbuf);
+		error(_("Could not write to %s: %s"), filename, strerror(err));
+		return -err;
+	}
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
-		die(_("Error wrapping up %s"), filename);
+		return error(_("Error wrapping up %s"), filename);
+	return 0;
 }
 
 static struct tree *empty_tree(void)
@@ -266,25 +283,20 @@ static struct tree *empty_tree(void)
 	return tree;
 }
 
-static NORETURN void die_dirty_index(const char *me)
+static int verify_resolution(const char *me)
 {
-	if (read_cache_unmerged()) {
-		die_resolve_conflict(me);
-	} else {
-		if (advice_commit_before_merge) {
-			if (action == REVERT)
-				die(_("Your local changes would be overwritten by revert.\n"
-					  "Please, commit your changes or stash them to proceed."));
-			else
-				die(_("Your local changes would be overwritten by cherry-pick.\n"
-					  "Please, commit your changes or stash them to proceed."));
-		} else {
-			if (action == REVERT)
-				die(_("Your local changes would be overwritten by revert.\n"));
-			else
-				die(_("Your local changes would be overwritten by cherry-pick.\n"));
-		}
-	}
+	if (!read_cache_unmerged())
+		return 0;
+
+	return error_resolve_conflict(me);
+}
+
+static int error_dirty_worktree(const char *me)
+{
+	if (advice_commit_before_merge)
+		return error(_("Your local changes would be overwritten by %s.\n"
+				"Please, commit your changes or stash them to proceed."), me);
+	return error(_("Your local changes would be overwritten by %s.\n"), me);
 }
 
 static int fast_forward_to(const unsigned char *to, const unsigned char *from)
@@ -329,10 +341,12 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 			    next_tree, base_tree, &result);
 
 	if (active_cache_changed &&
-	    (write_cache(index_fd, active_cache, active_nr) ||
-	     commit_locked_index(&index_lock)))
+		(write_cache(index_fd, active_cache, active_nr) ||
+			commit_locked_index(&index_lock))) {
+		rollback_lock_file(&index_lock);
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-		die(_("%s: Unable to write new index file"), me);
+		return error(_("%s: Unable to write new index file"), me);
+	}
 	rollback_lock_file(&index_lock);
 
 	if (!clean) {
@@ -397,19 +411,21 @@ static int do_pick_commit(void)
 		 * that represents the "current" state for merge-recursive
 		 * to work on.
 		 */
-		if (write_cache_as_tree(head, 0, NULL))
-			die (_("Your index file is unmerged."));
+		if (write_cache_as_tree(head, 0, NULL)) {
+			discard_cache();
+			return error(_("Your index file is unmerged."));
+		}
 	} else {
 		if (get_sha1("HEAD", head))
-			die (_("You do not have a valid HEAD"));
-		if (index_differs_from("HEAD", 0))
-			die_dirty_index(me);
+			return error(_("You do not have a valid HEAD"));
+		if (index_differs_from("HEAD", 0) && !verify_resolution(me))
+			return error_dirty_worktree(me);
 	}
 	discard_cache();
 
 	if (!commit->parents) {
 		if (action == REVERT)
-			die (_("Cannot revert a root commit"));
+			return error(_("Cannot revert a root commit"));
 		parent = NULL;
 	}
 	else if (commit->parents->next) {
@@ -418,19 +434,19 @@ static int do_pick_commit(void)
 		struct commit_list *p;
 
 		if (!mainline)
-			die(_("Commit %s is a merge but no -m option was given."),
-			    sha1_to_hex(commit->object.sha1));
+			return error(_("Commit %s is a merge but no -m option was given."),
+				sha1_to_hex(commit->object.sha1));
 
 		for (cnt = 1, p = commit->parents;
 		     cnt != mainline && p;
 		     cnt++)
 			p = p->next;
 		if (cnt != mainline || !p)
-			die(_("Commit %s does not have parent %d"),
+			return error(_("Commit %s does not have parent %d"),
 			    sha1_to_hex(commit->object.sha1), mainline);
 		parent = p->item;
-	} else if (0 < mainline)
-		die(_("Mainline was specified but commit %s is not a merge."),
+	} else if (mainline > 0)
+		return error(_("Mainline was specified but commit %s is not a merge."),
 		    sha1_to_hex(commit->object.sha1));
 	else
 		parent = commit->parents->item;
@@ -441,11 +457,11 @@ static int do_pick_commit(void)
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
-		die(_("%s: cannot parse parent commit %s"),
+		return error(_("%s: cannot parse parent commit %s"),
 		    me, sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit->buffer, &msg) != 0)
-		die(_("Cannot get commit message for %s"),
+		return error(_("Cannot get commit message for %s"),
 				sha1_to_hex(commit->object.sha1));
 
 	/*
@@ -484,7 +500,11 @@ static int do_pick_commit(void)
 			strbuf_addstr(&msgbuf, ")\n");
 		}
 		if (!no_commit)
-			write_cherry_pick_head();
+			if ((res = write_cherry_pick_head())) {
+				free_message(&msg);
+				free(defmsg);
+				return res;
+			}
 	}
 
 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
@@ -524,44 +544,46 @@ static int do_pick_commit(void)
 	return res;
 }
 
-static void prepare_revs(struct rev_info *revs)
+static int prepare_revs(struct rev_info *revs)
 {
-	int argc;
-
 	init_revisions(revs, NULL);
 	revs->no_walk = 1;
 	if (action != REVERT)
 		revs->reverse = 1;
 
-	argc = setup_revisions(commit_argc, commit_argv, revs, NULL);
-	if (argc > 1)
-		usage(*revert_or_cherry_pick_usage());
+	if (setup_revisions(commit_argc, commit_argv, revs, NULL) > 1)
+		return error(_("usage: %s"), *revert_or_cherry_pick_usage());
 
 	if (prepare_revision_walk(revs))
-		die(_("revision walk setup failed"));
+		return error(_("revision walk setup failed"));
 
 	if (!revs->commits)
-		die(_("empty commit set passed"));
+		return error(_("empty commit set passed"));
+	return 0;
 }
 
-static void read_and_refresh_cache(const char *me)
+static int read_and_refresh_cache(const char *me)
 {
 	static struct lock_file index_lock;
 	int index_fd = hold_locked_index(&index_lock, 0);
 	if (read_index_preload(&the_index, NULL) < 0)
-		die(_("git %s: failed to read the index"), me);
+		return error(_("%s: failed to read the index"), me);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (the_index.cache_changed) {
 		if (write_index(&the_index, index_fd) ||
-		    commit_locked_index(&index_lock))
-			die(_("git %s: failed to refresh the index"), me);
+			commit_locked_index(&index_lock)) {
+			rollback_lock_file(&index_lock);
+			return error(_("%s: failed to refresh the index"), me);
+		}
 	}
 	rollback_lock_file(&index_lock);
+	return 0;
 }
 
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	struct rev_info revs;
+	int res;
 
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
@@ -579,17 +601,15 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die(_("cherry-pick --ff cannot be used with --edit"));
 	}
 
-	read_and_refresh_cache(me);
+	if ((res = read_and_refresh_cache(me)) ||
+		(res = prepare_revs(&revs)))
+		return res;
 
-	prepare_revs(&revs);
+	while ((commit = get_revision(&revs)) &&
+		!(res = do_pick_commit()))
+		;
 
-	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit();
-		if (res)
-			return res;
-	}
-
-	return 0;
+	return res;
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
-- 
1.7.5.GIT
