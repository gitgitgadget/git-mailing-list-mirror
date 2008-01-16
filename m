From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Improve use of lockfile API
Date: Wed, 16 Jan 2008 13:12:46 -0600
Message-ID: <478E572E.3020505@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:13:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFDho-00047f-3j
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 20:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbYAPTNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 14:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbYAPTNP
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 14:13:15 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50849 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbYAPTNN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 14:13:13 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0GJCkfQ027140;
	Wed, 16 Jan 2008 13:12:46 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 13:12:46 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 16 Jan 2008 19:12:46.0440 (UTC) FILETIME=[C7122E80:01C85873]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--1.040500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTEwNjQyMC0xMzc3?=
	=?us-ascii?B?MTctNzAxOTM3LTcwMDk3MS03MDQ0MjUtNzA4Nzk3LTEyMTU4OC03?=
	=?us-ascii?B?MDk1ODQtNzA0MjU3LTcwMjQ3NC0xMTMyODUtNzAyMDQyLTcwNzQ1?=
	=?us-ascii?B?MS03MDAzMjQtNzA1MTY3LTcwMTIwMi03MDM3MTItNzA3MDI3LTcw?=
	=?us-ascii?B?NDQyMS03MDAxNjMtNzAyMTQzLTcwMDM5OC0xODgwMTktNzA0NzQ3?=
	=?us-ascii?B?LTcwMjExOC03MDQ2NTMtNzAxMDUzLTcwMjA0NC03MDYyOTAtNzA5?=
	=?us-ascii?B?MDUwLTcwNTcxOC03MTE2MjQtNzAxMzg0LTMwMDAxNS03MDc3NTAt?=
	=?us-ascii?B?MTIxNzA5LTcwMTAwNS03MDg1NTgtMTg4MTk5LTEyMTYyNC03MDMx?=
	=?us-ascii?B?ODctNzAxNDUwLTcwMDgzOS03MDQ5MjctMTg4MTk4LTcwMjEwNi03?=
	=?us-ascii?B?MDU1MDgtMTA1NjMwLTcwMDg0NS0xMTMyMjgtNzA2NDU0LTcwNDI4?=
	=?us-ascii?B?Ny03MDQ4NTItNzAxMzM5LTE0ODAzOS0xNDgwNTEtMjk5OTc=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70725>

-Remove remaining double close(2)'s.
 i.e. close() before commit_locked_index() or commit_lock_file()
-New close_lock_file() function which will close() the lock descriptor and
 assign -1 to it, but will not remove or rename it.
-commit_lock_file() was modified to detect and return -1 on failure
 to close the lock file.
---


There are two places where we fdopen() the lock file descriptor.
In builtin-pack-refs.c and fast-import.c.
Presently, I assigned -1 to the lock->fd and added a comment.
Additionally in bundle.c we must assign -1 to the lock->fd
since it is closed by start_command().

We could do something along the lines of:

FILE* fdopen_lock_file(struct lock_file *lk)
{
	FILE* f; 
	if ((f = fdopen(lk->fd)) == NULL)
		return NULL;
	lk->fd = -1;
	return f;
}

But that may be overkill.
I'll think we'll probably catch this case since we are now
checking that the close() succeeds in commit_lock_file().

-brandon


 builtin-add.c            |    2 +-
 builtin-apply.c          |    2 +-
 builtin-checkout-index.c |    4 ++--
 builtin-commit.c         |    9 ++++++---
 builtin-diff.c           |    2 +-
 builtin-fetch-pack.c     |    1 -
 builtin-mv.c             |    1 -
 builtin-pack-refs.c      |    4 ++++
 builtin-read-tree.c      |    2 +-
 builtin-rerere.c         |    4 ++--
 builtin-reset.c          |    1 -
 builtin-revert.c         |    4 ++--
 builtin-rm.c             |    2 +-
 builtin-update-index.c   |    2 +-
 builtin-write-tree.c     |    9 +++------
 bundle.c                 |   12 ++++++++----
 cache.h                  |    1 +
 config.c                 |    8 ++------
 fast-import.c            |   10 ++++++++--
 lockfile.c               |   17 ++++++++++++++---
 merge-recursive.c        |    2 +-
 refs.c                   |   12 ++++--------
 22 files changed, 63 insertions(+), 48 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 5c29cc2..4a91e3e 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -259,7 +259,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
  finish:
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    close(newfd) || commit_locked_index(&lock_file))
+		    commit_locked_index(&lock_file))
 			die("Unable to write new index file");
 	}
 
diff --git a/builtin-apply.c b/builtin-apply.c
index d57bb6e..15432b6 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2921,7 +2921,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 
 	if (update_index) {
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    close(newfd) || commit_locked_index(&lock_file))
+		    commit_locked_index(&lock_file))
 			die("Unable to write new index file");
 	}
 
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 70d619d..7e42024 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -246,8 +246,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		 * want to update cache.
 		 */
 		if (state.refresh_cache) {
-			close(newfd); newfd = -1;
 			rollback_lock_file(&lock_file);
+			newfd = -1;
 		}
 		state.refresh_cache = 0;
 	}
@@ -297,7 +297,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 
 	if (0 <= newfd &&
 	    (write_cache(newfd, active_cache, active_nr) ||
-	     close(newfd) || commit_locked_index(&lock_file)))
+	     commit_locked_index(&lock_file)))
 		die("Unable to write new index file");
 	return 0;
 }
diff --git a/builtin-commit.c b/builtin-commit.c
index 16345e9..a764053 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -237,7 +237,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 		int fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(0, also ? prefix : NULL, pathspec);
 		refresh_cache(REFRESH_QUIET);
-		if (write_cache(fd, active_cache, active_nr))
+		if (write_cache(fd, active_cache, active_nr) ||
+		    close_lock_file(&index_lock))
 			die("unable to write new_index file");
 		commit_style = COMMIT_NORMAL;
 		return index_lock.filename;
@@ -298,7 +299,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	fd = hold_locked_index(&index_lock, 1);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
-	if (write_cache(fd, active_cache, active_nr))
+	if (write_cache(fd, active_cache, active_nr) ||
+	    close_lock_file(&index_lock))
 		die("unable to write new_index file");
 
 	fd = hold_lock_file_for_update(&false_lock,
@@ -308,7 +310,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
 
-	if (write_cache(fd, active_cache, active_nr))
+	if (write_cache(fd, active_cache, active_nr) ||
+	    close_lock_file(&false_lock))
 		die("unable to write temporary index file");
 	return false_lock.filename;
 }
diff --git a/builtin-diff.c b/builtin-diff.c
index 29365a0..8d7a569 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -190,7 +190,7 @@ static void refresh_index_quietly(void)
 	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
 
 	if (active_cache_changed &&
-	    !write_cache(fd, active_cache, active_nr) && !close(fd))
+	    !write_cache(fd, active_cache, active_nr))
 		commit_locked_index(lock_file);
 
 	rollback_lock_file(lock_file);
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 807fa93..e68e015 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -783,7 +783,6 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 			unlink(shallow);
 			rollback_lock_file(&lock);
 		} else {
-			close(fd);
 			commit_lock_file(&lock);
 		}
 	}
diff --git a/builtin-mv.c b/builtin-mv.c
index a3f9ad1..990e213 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -264,7 +264,6 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		if (active_cache_changed) {
 			if (write_cache(newfd, active_cache, active_nr) ||
-			    close(newfd) ||
 			    commit_locked_index(&lock_file))
 				die("Unable to write new index file");
 		}
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 1923fb1..fbe451f 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -108,6 +108,10 @@ static int pack_refs(unsigned int flags)
 		die("failed to write ref-pack file");
 	if (fflush(cbdata.refs_file) || fsync(fd) || fclose(cbdata.refs_file))
 		die("failed to write ref-pack file (%s)", strerror(errno));
+	/* Since the lock file was fdopen()'ed and then fclose()'ed above,
+	 * assign -1 to the lock file descriptor so that commit_lock_file()
+	 * won't try to close() it. */
+	packed.fd = -1;
 	if (commit_lock_file(&packed) < 0)
 		die("unable to overwrite old ref-pack file (%s)", strerror(errno));
 	if (cbdata.flags & PACK_REFS_PRUNE)
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 43cd56a..c0ea034 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -283,7 +283,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	}
 
 	if (write_cache(newfd, active_cache, active_nr) ||
-	    close(newfd) || commit_locked_index(&lock_file))
+	    commit_locked_index(&lock_file))
 		die("unable to write new index file");
 	return 0;
 }
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 37e6248..a9e3ebc 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -61,9 +61,9 @@ static int write_rr(struct path_list *rr, int out_fd)
 		    write_in_full(out_fd, path, length) != length)
 			die("unable to write rerere record");
 	}
-	if (close(out_fd) != 0)
+	if (commit_lock_file(&write_lock) != 0)
 		die("unable to write rerere record");
-	return commit_lock_file(&write_lock);
+	return 0;
 }
 
 static int handle_file(const char *path,
diff --git a/builtin-reset.c b/builtin-reset.c
index 10dba60..7ee811f 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -108,7 +108,6 @@ static int update_index_refresh(int fd, struct lock_file *index_lock)
 		return error("Could not read index");
 	result = refresh_cache(0) ? 1 : 0;
 	if (write_cache(fd, active_cache, active_nr) ||
-			close(fd) ||
 			commit_locked_index(index_lock))
 		return error ("Could not refresh index");
 	return result;
diff --git a/builtin-revert.c b/builtin-revert.c
index 4bf8eb2..358af53 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -371,13 +371,13 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 					i++;
 			}
 		}
-		if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
+		if (commit_lock_file(&msg_file) < 0)
 			die ("Error wrapping up %s", defmsg);
 		fprintf(stderr, "Automatic %s failed.%s\n",
 			me, help_msg(commit->object.sha1));
 		exit(1);
 	}
-	if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
+	if (commit_lock_file(&msg_file) < 0)
 		die ("Error wrapping up %s", defmsg);
 	fprintf(stderr, "Finished one %s.\n", me);
 
diff --git a/builtin-rm.c b/builtin-rm.c
index a3d25e6..c0a8bb6 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -250,7 +250,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    close(newfd) || commit_locked_index(&lock_file))
+		    commit_locked_index(&lock_file))
 			die("Unable to write new index file");
 	}
 
diff --git a/builtin-update-index.c b/builtin-update-index.c
index e1a938d..c3a14c7 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -738,7 +738,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    get_index_file(), strerror(lock_error));
 		}
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    close(newfd) || commit_locked_index(lock_file))
+		    commit_locked_index(lock_file))
 			die("Unable to write new index file");
 	}
 
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index b89d02e..d16b9ed 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -35,11 +35,9 @@ int write_tree(unsigned char *sha1, int missing_ok, const char *prefix)
 				      missing_ok, 0) < 0)
 			die("git-write-tree: error building trees");
 		if (0 <= newfd) {
-			if (!write_cache(newfd, active_cache, active_nr)
-					&& !close(newfd)) {
-				commit_lock_file(lock_file);
+			if (!write_cache(newfd, active_cache, active_nr) &&
+			    !commit_lock_file(lock_file))
 				newfd = -1;
-			}
 		}
 		/* Not being able to write is fine -- we are only interested
 		 * in updating the cache-tree part, and if the next caller
@@ -60,8 +58,7 @@ int write_tree(unsigned char *sha1, int missing_ok, const char *prefix)
 		hashcpy(sha1, active_cache_tree->sha1);
 
 	if (0 <= newfd)
-		close(newfd);
-	rollback_lock_file(lock_file);
+		rollback_lock_file(lock_file);
 
 	return 0;
 }
diff --git a/bundle.c b/bundle.c
index 316aa74..61f388a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -317,6 +317,12 @@ int create_bundle(struct bundle_header *header, const char *path,
 	rls.git_cmd = 1;
 	if (start_command(&rls))
 		return error("Could not spawn pack-objects");
+
+	/* start_command closed bundle_fd if it was > 1
+	 * so set the lock fd to -1 so commit_lock_file()
+	 * won't fail trying to close it */
+	lock.fd = -1;
+
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object *object = revs.pending.objects[i].item;
 		if (object->flags & UNINTERESTING)
@@ -326,10 +332,8 @@ int create_bundle(struct bundle_header *header, const char *path,
 	}
 	if (finish_command(&rls))
 		return error ("pack-objects died");
-	close(bundle_fd);
-	if (!bundle_to_stdout)
-		commit_lock_file(&lock);
-	return 0;
+
+	return bundle_to_stdout ? close(bundle_fd) : commit_lock_file(&lock);
 }
 
 int unbundle(struct bundle_header *header, int bundle_fd)
diff --git a/cache.h b/cache.h
index 39331c2..4f4495f 100644
--- a/cache.h
+++ b/cache.h
@@ -303,6 +303,7 @@ struct lock_file {
 	char filename[PATH_MAX];
 };
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
+extern int close_lock_file(struct lock_file *);
 extern int commit_lock_file(struct lock_file *);
 
 extern int hold_locked_index(struct lock_file *, int);
diff --git a/config.c b/config.c
index 857deb6..526a3f4 100644
--- a/config.c
+++ b/config.c
@@ -955,14 +955,12 @@ int git_config_set_multivar(const char* key, const char* value,
 		munmap(contents, contents_sz);
 	}
 
-	if (close(fd) || commit_lock_file(lock) < 0) {
+	if (commit_lock_file(lock) < 0) {
 		fprintf(stderr, "Cannot commit config file!\n");
 		ret = 4;
 		goto out_free;
 	}
 
-	/* fd is closed, so don't try to close it below. */
-	fd = -1;
 	/*
 	 * lock is committed, so don't try to roll it back below.
 	 * NOTE: Since lockfile.c keeps a linked list of all created
@@ -973,8 +971,6 @@ int git_config_set_multivar(const char* key, const char* value,
 	ret = 0;
 
 out_free:
-	if (0 <= fd)
-		close(fd);
 	if (lock)
 		rollback_lock_file(lock);
 	free(config_filename);
@@ -1072,7 +1068,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 	}
 	fclose(config_file);
  unlock_and_out:
-	if (close(out_fd) || commit_lock_file(lock) < 0)
+	if (commit_lock_file(lock) < 0)
 			ret = error("Cannot commit config file!");
  out:
 	free(config_filename);
diff --git a/fast-import.c b/fast-import.c
index 82e9161..1ce631c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1546,10 +1546,16 @@ static void dump_marks(void)
 	}
 
 	dump_marks_helper(f, 0, marks);
-	fclose(f);
-	if (commit_lock_file(&mark_lock))
+	if (ferror(f) || fclose(f))
 		failure |= error("Unable to write marks file %s: %s",
 			mark_file, strerror(errno));
+	/* Since the lock file was fdopen()'ed and then fclose()'ed above,
+	 * assign -1 to the lock file descriptor so that commit_lock_file()
+	 * won't try to close() it. */
+	mark_lock.fd = -1;
+	if (commit_lock_file(&mark_lock))
+		failure |= error("Unable to write commit file %s: %s",
+			mark_file, strerror(errno));
 }
 
 static int read_next_command(void)
diff --git a/lockfile.c b/lockfile.c
index f45d3ed..bcc4786 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -13,7 +13,8 @@ static void remove_lock_file(void)
 	while (lock_file_list) {
 		if (lock_file_list->owner == me &&
 		    lock_file_list->filename[0]) {
-			close(lock_file_list->fd);
+			if (lock_file_list->fd >= 0)
+				close(lock_file_list->fd);
 			unlink(lock_file_list->filename);
 		}
 		lock_file_list = lock_file_list->next;
@@ -159,11 +160,20 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int die_on
 	return fd;
 }
 
+int close_lock_file(struct lock_file *lk)
+{
+	if (close(lk->fd))
+		return -1;
+	lk->fd = -1;
+	return 0;
+}
+
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
 	int i;
-	close(lk->fd);
+	if (lk->fd >= 0 && close_lock_file(lk))
+		return -1;
 	strcpy(result_file, lk->filename);
 	i = strlen(result_file) - 5; /* .lock */
 	result_file[i] = 0;
@@ -196,7 +206,8 @@ int commit_locked_index(struct lock_file *lk)
 void rollback_lock_file(struct lock_file *lk)
 {
 	if (lk->filename[0]) {
-		close(lk->fd);
+		if (lk->fd >= 0)
+			close(lk->fd);
 		unlink(lk->filename);
 	}
 	lk->filename[0] = 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index b34177d..c292a77 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1753,7 +1753,7 @@ int main(int argc, char *argv[])
 
 	if (active_cache_changed &&
 	    (write_cache(index_fd, active_cache, active_nr) ||
-	     close(index_fd) || commit_locked_index(lock)))
+	     commit_locked_index(lock)))
 			die ("unable to write %s", get_index_file());
 
 	return clean ? 0: 1;
diff --git a/refs.c b/refs.c
index 58f6d17..2c78956 100644
--- a/refs.c
+++ b/refs.c
@@ -864,7 +864,6 @@ static int repack_without_ref(const char *refname)
 			die("too long a refname '%s'", list->name);
 		write_or_die(fd, line, len);
 	}
-	close(fd);
 	return commit_lock_file(&packlock);
 }
 
@@ -1021,12 +1020,9 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 
 void unlock_ref(struct ref_lock *lock)
 {
-	if (lock->lock_fd >= 0) {
-		close(lock->lock_fd);
-		/* Do not free lock->lk -- atexit() still looks at them */
-		if (lock->lk)
-			rollback_lock_file(lock->lk);
-	}
+        /* Do not free lock->lk -- atexit() still looks at them */
+        if (lock->lk)
+        	rollback_lock_file(lock->lk);
 	free(lock->ref_name);
 	free(lock->orig_ref_name);
 	free(lock);
@@ -1132,7 +1128,7 @@ int write_ref_sha1(struct ref_lock *lock,
 	}
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
 	    write_in_full(lock->lock_fd, &term, 1) != 1
-		|| close(lock->lock_fd) < 0) {
+	    	|| close_lock_file(lock->lk) < 0) {
 		error("Couldn't write %s", lock->lk->filename);
 		unlock_ref(lock);
 		return -1;
-- 
1.5.4.rc3.14.g44397-dirty
