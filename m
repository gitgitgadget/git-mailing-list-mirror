Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECBBA20960
	for <e@80x24.org>; Thu, 13 Apr 2017 20:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbdDMU2y (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 16:28:54 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:38652 "EHLO
        homiemail-a100.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750997AbdDMU2w (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Apr 2017 16:28:52 -0400
Received: from homiemail-a100.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a100.g.dreamhost.com (Postfix) with ESMTP id A755931A073;
        Thu, 13 Apr 2017 13:28:51 -0700 (PDT)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a100.g.dreamhost.com (Postfix) with ESMTPSA id 1676A31A070;
        Thu, 13 Apr 2017 13:28:51 -0700 (PDT)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, mfick@codeaurora.org,
        jacob.keller@gmail.com, David Turner <dturner@twosigma.com>
Subject: [PATCH] repack: respect gc.pid lock
Date:   Thu, 13 Apr 2017 16:27:12 -0400
Message-Id: <20170413202712.22192-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git gc locks the repository (using a gc.pid file) so that other gcs
don't run concurrently. Make git repack respect this lock.

Now repack, by default, will refuse to run at the same time as a gc.
This fixes a concurrency issue: a repack which deleted packs would
make a concurrent gc sad when its packs were deleted out from under
it.  The gc would fail with: "fatal: ./objects/pack/pack-$sha.pack
cannot be accessed".  Then it would die, probably leaving a large temp
pack hanging around.

Git repack learns --no-lock, so that when run under git gc, it doesn't
attempt to manage the lock itself.

Martin Fick suggested just moving the lock into git repack, but this
would leave parts of git gc (e.g. git prune) protected by only local
locks.  I worried that a prune (part of git gc) concurrent with a
repack could confuse the repack, so I decided to go with this
solution.

Signed-off-by: David Turner <dturner@twosigma.com>
---
 Documentation/git-repack.txt |  5 +++
 Makefile                     |  1 +
 builtin/gc.c                 | 72 ++----------------------------------
 builtin/repack.c             | 13 +++++++
 repack.c                     | 88 ++++++++++++++++++++++++++++++++++++++++++++
 repack.h                     |  8 ++++
 t/t7700-repack.sh            |  8 ++++
 7 files changed, 127 insertions(+), 68 deletions(-)
 create mode 100644 repack.c
 create mode 100644 repack.h

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 26afe6ed54..b347ff5c62 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -143,6 +143,11 @@ other objects in that pack they already have locally.
 	being removed. In addition, any unreachable loose objects will
 	be packed (and their loose counterparts removed).
 
+--no-lock::
+	Do not lock the repository, and do not respect any existing lock.
+	Mostly useful for running repack within git gc.  Do not use this
+	unless you know what you are doing.
+
 Configuration
 -------------
 
diff --git a/Makefile b/Makefile
index 9b36068ac5..7095f03959 100644
--- a/Makefile
+++ b/Makefile
@@ -816,6 +816,7 @@ LIB_OBJS += refs/files-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
+LIB_OBJS += repack.o
 LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
diff --git a/builtin/gc.c b/builtin/gc.c
index c2c61a57bb..9b9c27020b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -18,6 +18,7 @@
 #include "sigchain.h"
 #include "argv-array.h"
 #include "commit.h"
+#include "repack.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -45,7 +46,6 @@ static struct argv_array prune = ARGV_ARRAY_INIT;
 static struct argv_array prune_worktrees = ARGV_ARRAY_INIT;
 static struct argv_array rerere = ARGV_ARRAY_INIT;
 
-static struct tempfile pidfile;
 static struct lock_file log_lock;
 
 static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
@@ -234,70 +234,6 @@ static int need_to_gc(void)
 	return 1;
 }
 
-/* return NULL on success, else hostname running the gc */
-static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
-{
-	static struct lock_file lock;
-	char my_host[128];
-	struct strbuf sb = STRBUF_INIT;
-	struct stat st;
-	uintmax_t pid;
-	FILE *fp;
-	int fd;
-	char *pidfile_path;
-
-	if (is_tempfile_active(&pidfile))
-		/* already locked */
-		return NULL;
-
-	if (gethostname(my_host, sizeof(my_host)))
-		xsnprintf(my_host, sizeof(my_host), "unknown");
-
-	pidfile_path = git_pathdup("gc.pid");
-	fd = hold_lock_file_for_update(&lock, pidfile_path,
-				       LOCK_DIE_ON_ERROR);
-	if (!force) {
-		static char locking_host[128];
-		int should_exit;
-		fp = fopen(pidfile_path, "r");
-		memset(locking_host, 0, sizeof(locking_host));
-		should_exit =
-			fp != NULL &&
-			!fstat(fileno(fp), &st) &&
-			/*
-			 * 12 hour limit is very generous as gc should
-			 * never take that long. On the other hand we
-			 * don't really need a strict limit here,
-			 * running gc --auto one day late is not a big
-			 * problem. --force can be used in manual gc
-			 * after the user verifies that no gc is
-			 * running.
-			 */
-			time(NULL) - st.st_mtime <= 12 * 3600 &&
-			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
-			/* be gentle to concurrent "gc" on remote hosts */
-			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno == EPERM);
-		if (fp != NULL)
-			fclose(fp);
-		if (should_exit) {
-			if (fd >= 0)
-				rollback_lock_file(&lock);
-			*ret_pid = pid;
-			free(pidfile_path);
-			return locking_host;
-		}
-	}
-
-	strbuf_addf(&sb, "%"PRIuMAX" %s",
-		    (uintmax_t) getpid(), my_host);
-	write_in_full(fd, sb.buf, sb.len);
-	strbuf_release(&sb);
-	commit_lock_file(&lock);
-	register_tempfile(&pidfile, pidfile_path);
-	free(pidfile_path);
-	return NULL;
-}
-
 static int report_last_gc_error(void)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -370,7 +306,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	argv_array_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
-	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
+	argv_array_pushl(&repack, "repack", "-d", "-l", "--no-lock", NULL);
 	argv_array_pushl(&prune, "prune", "--expire", NULL);
 	argv_array_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
@@ -426,11 +362,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	} else
 		add_repack_all_option();
 
-	name = lock_repo_for_gc(force, &pid);
+	name = lock_repo_for_pack_manipulation(force, &pid);
 	if (name) {
 		if (auto_gc)
 			return 0; /* be quiet on --auto */
-		die(_("gc is already running on machine '%s' pid %"PRIuMAX" (use --force if not)"),
+		die(_("pack operation (gc or repack) is already running on machine '%s' pid %"PRIuMAX" (use --force if not)"),
 		    name, (uintmax_t)pid);
 	}
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 677bc7c81a..619ac37a05 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "repack.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -160,6 +161,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int no_update_server_info = 0;
 	int quiet = 0;
 	int local = 0;
+	int no_lock = 0;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -194,6 +196,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("maximum size of each packfile")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
+		OPT_BOOL(0, "no-lock", &no_lock,
+				N_("Do not lock the repository, and do not respect any existing lock.  Mostly useful for operation within git gc.")),
 		OPT_END()
 	};
 
@@ -215,6 +219,15 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
 		die(_(incremental_bitmap_conflict_error));
 
+	if (!no_lock) {
+		pid_t pid;
+		const char *name = lock_repo_for_pack_manipulation(0, &pid);
+		if (name) {
+			die(_("pack operation (gc or repack) is already running on machine '%s' pid %"PRIuMAX" (use --no-lock if not)"),
+			    name, (uintmax_t)pid);
+		}
+	}
+
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
 
diff --git a/repack.c b/repack.c
new file mode 100644
index 0000000000..a6df28c7f2
--- /dev/null
+++ b/repack.c
@@ -0,0 +1,88 @@
+#include "builtin.h"
+#include "repack.h"
+#include "strbuf.h"
+#include "lockfile.h"
+#include "tempfile.h"
+
+static struct tempfile pidfile;
+
+/*
+ * Commands should call this before doing any operation which might
+ * delete a pack file (e.g. gc or repack).  We don't want to allow
+ * multiple operations of this type to operate at the same time.
+ *
+ * For historical reasons, the pid file created is called "gc.pid",
+ * even though it is also used for git-repack.
+ *
+ * The lock will persist until the process ends.
+ *
+ * If force is non-zero, any existing lock will be disregarded.
+ *
+ * return NULL on success, else hostname running the pack manipulation
+ * operation.
+ *
+ * It is safe to call this function multiple times in the same process;
+ * calls after the first successful call will always return NULL.
+ */
+const char *lock_repo_for_pack_manipulation(int force, pid_t* ret_pid)
+{
+	static struct lock_file lock;
+	char my_host[128];
+	struct strbuf sb = STRBUF_INIT;
+	struct stat st;
+	uintmax_t pid;
+	FILE *fp;
+	int fd;
+	char *pidfile_path;
+
+	if (is_tempfile_active(&pidfile))
+		/* already locked */
+		return NULL;
+
+	if (gethostname(my_host, sizeof(my_host)))
+		xsnprintf(my_host, sizeof(my_host), "unknown");
+
+	pidfile_path = git_pathdup("gc.pid");
+	fd = hold_lock_file_for_update(&lock, pidfile_path,
+				       LOCK_DIE_ON_ERROR);
+	if (!force) {
+		static char locking_host[128];
+		int should_exit;
+		fp = fopen(pidfile_path, "r");
+		memset(locking_host, 0, sizeof(locking_host));
+		should_exit =
+			fp != NULL &&
+			!fstat(fileno(fp), &st) &&
+			/*
+			 * 12 hour limit is very generous as gc should
+			 * never take that long. On the other hand we
+			 * don't really need a strict limit here,
+			 * running gc --auto one day late is not a big
+			 * problem. --force can be used in manual gc
+			 * after the user verifies that no gc is
+			 * running.
+			 */
+			time(NULL) - st.st_mtime <= 12 * 3600 &&
+			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
+			/* be gentle to concurrent "gc" on remote hosts */
+			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno == EPERM);
+		if (fp != NULL)
+			fclose(fp);
+		if (should_exit) {
+			if (fd >= 0)
+				rollback_lock_file(&lock);
+			*ret_pid = pid;
+			free(pidfile_path);
+			return locking_host;
+		}
+	}
+
+	strbuf_addf(&sb, "%"PRIuMAX" %s",
+		    (uintmax_t) getpid(), my_host);
+	write_in_full(fd, sb.buf, sb.len);
+	strbuf_release(&sb);
+	commit_lock_file(&lock);
+	register_tempfile(&pidfile, pidfile_path);
+	free(pidfile_path);
+	return NULL;
+}
diff --git a/repack.h b/repack.h
new file mode 100644
index 0000000000..bf9144ee37
--- /dev/null
+++ b/repack.h
@@ -0,0 +1,8 @@
+#ifndef REPACK_H
+#define REPACK_H
+
+#include "git-compat-util.h"
+
+const char *lock_repo_for_pack_manipulation(int force, pid_t* ret_pid);
+
+#endif /* REPACK_H */
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 6061a04147..52f19c5871 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -196,5 +196,13 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
 	git cat-file -t $H1
 	'
 
+test_expect_success 'repack respects gc.pid' '
+	test_tick &&
+	test_when_finished "rm -f .git/gc.pid" &&
+	echo -n "1234 hostname" >.git/gc.pid &&
+	test_must_fail git repack -a -d 2>err &&
+	test_i18ngrep "already running on machine .hostname. pid 1234" err
+	'
+
 test_done
 
-- 
2.11.GIT

