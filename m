From: Etienne Buira <etienne.buira@gmail.com>
Subject: [PATCH] Handle atexit list internaly fo unthreaded builds
Date: Sat, 11 Oct 2014 16:53:38 +0200
Message-ID: <1413039218-12139-1-git-send-email-etienne.buira@gmail.com>
Cc: Etienne Buira <etienne.buira@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 11 16:54:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xcy3p-0003BE-0A
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 16:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbaJKOyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 10:54:17 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:52140 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbaJKOyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 10:54:16 -0400
Received: by mail-wi0-f181.google.com with SMTP id hi2so4319336wib.8
        for <git@vger.kernel.org>; Sat, 11 Oct 2014 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4ODl5OT5Qo6DMTJAOJH2fq/dKhOVcMfA586492xwV4E=;
        b=pyOb3P5bbEYp3EfSCv/XI9yzRVjBN5Tk7kAZcVUyQEuyxh1KSWFS4BoJQS+uYP2B/F
         kh7sHtYa2yae7ZT9JdyBTXBs7/uVOL3Ms841OBbNTBYJCIzARHHJvQqhakDqobQSW/VV
         F/LrOeA2cTculapd+zW8B9OkU7UME/x+T6XtId70YEOWY1iaFdUxf2h+bDjGyAfjRj+A
         t8/a013rdhRZ+o7rWKIqGDbvsPSbagWLXTa7WnPpkubvbD50dsIxYUaIeL+G5VJ5Hl+Q
         NhFGI4vYLKoRk6E027xtOYgsDYQHg4LtflGFzJh2q3MmVXkH3XR9umiBmVq01jyBhgOR
         PsvQ==
X-Received: by 10.194.120.169 with SMTP id ld9mr11004234wjb.43.1413039255115;
        Sat, 11 Oct 2014 07:54:15 -0700 (PDT)
Received: from localhost.localdomain (sbr22-2-88-185-151-243.fbx.proxad.net. [88.185.151.243])
        by mx.google.com with ESMTPSA id i5sm11559143wjz.0.2014.10.11.07.54.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Oct 2014 07:54:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace atexit()s calls with cmd_atexit that is atexit() on threaded
builds, but handles the callbacks list internally for unthreaded builds.

This is needed because on unthreaded builds, asyncs inherits parent's
atexit() list, that gets run as soon as the async exit()s (and again at
the end of the parent process). That led to remove temporary and lock
files too early.

Fixes test 5537 (temporary shallow file vanished before unpack-objects
could open it)

Signed-off-by: Etienne Buira <etienne.buira@gmail.com>
---
 builtin/clone.c |  7 +------
 builtin/fetch.c |  2 +-
 builtin/gc.c    |  2 +-
 diff.c          |  2 +-
 lockfile.c      |  2 +-
 pager.c         |  2 +-
 read-cache.c    |  2 +-
 run-command.c   | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 shallow.c       |  7 ++-----
 trace.c         |  2 +-
 10 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bbd169c..2992ac0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -390,7 +390,6 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 
 static const char *junk_work_tree;
 static const char *junk_git_dir;
-static pid_t junk_pid;
 static enum {
 	JUNK_LEAVE_NONE,
 	JUNK_LEAVE_REPO,
@@ -417,8 +416,6 @@ static void remove_junk(void)
 		break;
 	}
 
-	if (getpid() != junk_pid)
-		return;
 	if (junk_git_dir) {
 		strbuf_addstr(&sb, junk_git_dir);
 		remove_dir_recursively(&sb, 0);
@@ -758,8 +755,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct refspec *refspec;
 	const char *fetch_pattern;
 
-	junk_pid = getpid();
-
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
@@ -843,7 +838,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		set_git_work_tree(work_tree);
 	}
 	junk_git_dir = git_dir;
-	atexit(remove_junk);
+	cmd_atexit(remove_junk);
 	sigchain_push_common(remove_junk_on_signal);
 
 	if (safe_create_leading_directories_const(git_dir) < 0)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 159fb7e..1e44d58 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1095,7 +1095,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 	}
 
 	sigchain_push_common(unlock_pack_on_signal);
-	atexit(unlock_pack);
+	cmd_atexit(unlock_pack);
 	refspec = parse_fetch_refspec(ref_nr, refs);
 	exit_code = do_fetch(gtransport, refspec, ref_nr);
 	free_refspec(ref_nr, refspec);
diff --git a/builtin/gc.c b/builtin/gc.c
index 8d219d8..cf2defa 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -254,7 +254,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 
 	pidfile = git_pathdup("gc.pid");
 	sigchain_push_common(remove_pidfile_on_signal);
-	atexit(remove_pidfile);
+	cmd_atexit(remove_pidfile);
 
 	return NULL;
 }
diff --git a/diff.c b/diff.c
index 867f034..9c6ef9a 100644
--- a/diff.c
+++ b/diff.c
@@ -2833,7 +2833,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 	}
 
 	if (!remove_tempfile_installed) {
-		atexit(remove_tempfile);
+		cmd_atexit(remove_tempfile);
 		sigchain_push_common(remove_tempfile_on_signal);
 		remove_tempfile_installed = 1;
 	}
diff --git a/lockfile.c b/lockfile.c
index 2564a7f..ad0d1e2 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -141,7 +141,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	if (0 <= lk->fd) {
 		if (!lock_file_list) {
 			sigchain_push_common(remove_lock_file_on_signal);
-			atexit(remove_lock_file);
+			cmd_atexit(remove_lock_file);
 		}
 		lk->owner = getpid();
 		if (!lk->on_list) {
diff --git a/pager.c b/pager.c
index 8b5cbc5..09ab2fa 100644
--- a/pager.c
+++ b/pager.c
@@ -102,7 +102,7 @@ void setup_pager(void)
 
 	/* this makes sure that the parent terminates after the pager */
 	sigchain_push_common(wait_for_pager_signal);
-	atexit(wait_for_pager);
+	cmd_atexit(wait_for_pager);
 }
 
 int pager_in_use(void)
diff --git a/read-cache.c b/read-cache.c
index 6f0057f..8b10c92 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2104,7 +2104,7 @@ static int write_shared_index(struct index_state *istate,
 		return do_write_locked_index(istate, lock, flags);
 	}
 	if (!installed_handler) {
-		atexit(remove_temporary_sharedindex);
+		cmd_atexit(remove_temporary_sharedindex);
 		sigchain_push_common(remove_temporary_sharedindex_on_signal);
 	}
 	move_cache_to_base_index(istate);
diff --git a/run-command.c b/run-command.c
index 35a3ebf..5df57b5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -45,7 +45,7 @@ static void mark_child_for_cleanup(pid_t pid)
 	children_to_clean = p;
 
 	if (!installed_child_cleanup_handler) {
-		atexit(cleanup_children_on_exit);
+		cmd_atexit(cleanup_children_on_exit);
 		sigchain_push_common(cleanup_children_on_signal);
 		installed_child_cleanup_handler = 1;
 	}
@@ -624,6 +624,48 @@ static int async_die_is_recursing(void)
 	return ret != NULL;
 }
 
+int cmd_atexit(void (*handler)(void))
+{
+	return atexit(handler);
+}
+
+#else
+
+static struct {
+	void (**handlers)(void);
+	size_t nr;
+	size_t alloc;
+} cmd_atexit_hdlrs;
+
+static int cmd_atexit_installed;
+
+static void cmd_atexit_dispatch()
+{
+	size_t i;
+
+	for (i=cmd_atexit_hdlrs.nr ; i ; i--)
+		cmd_atexit_hdlrs.handlers[i-1]();
+}
+
+static void cmd_atexit_clear()
+{
+	free(cmd_atexit_hdlrs.handlers);
+	memset(&cmd_atexit_hdlrs, 0, sizeof(cmd_atexit_hdlrs));
+	cmd_atexit_installed = 0;
+}
+
+int cmd_atexit(void (*handler)(void))
+{
+	ALLOC_GROW(cmd_atexit_hdlrs.handlers, cmd_atexit_hdlrs.nr + 1, cmd_atexit_hdlrs.alloc);
+	cmd_atexit_hdlrs.handlers[cmd_atexit_hdlrs.nr++] = handler;
+	if (!cmd_atexit_installed) {
+		if (!atexit(&cmd_atexit_dispatch))
+			return -1;
+		cmd_atexit_installed = 1;
+	}
+	return 0;
+}
+
 #endif
 
 int start_async(struct async *async)
@@ -682,6 +724,7 @@ int start_async(struct async *async)
 			close(fdin[1]);
 		if (need_out)
 			close(fdout[0]);
+		cmd_atexit_clear();
 		exit(!!async->proc(proc_in, proc_out, async->data));
 	}
 
diff --git a/shallow.c b/shallow.c
index de07709..881580b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -226,7 +226,6 @@ static void remove_temporary_shallow_on_signal(int signo)
 
 const char *setup_temporary_shallow(const struct sha1_array *extra)
 {
-	static int installed_handler;
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
@@ -237,10 +236,8 @@ const char *setup_temporary_shallow(const struct sha1_array *extra)
 		strbuf_addstr(&temporary_shallow, git_path("shallow_XXXXXX"));
 		fd = xmkstemp(temporary_shallow.buf);
 
-		if (!installed_handler) {
-			atexit(remove_temporary_shallow);
-			sigchain_push_common(remove_temporary_shallow_on_signal);
-		}
+		cmd_atexit(remove_temporary_shallow);
+		sigchain_push_common(remove_temporary_shallow_on_signal);
 
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
diff --git a/trace.c b/trace.c
index e583dc6..36c5076 100644
--- a/trace.c
+++ b/trace.c
@@ -420,7 +420,7 @@ void trace_command_performance(const char **argv)
 		return;
 
 	if (!command_start_time)
-		atexit(print_command_performance_atexit);
+		cmd_atexit(print_command_performance_atexit);
 
 	strbuf_reset(&command_line);
 	sq_quote_argv(&command_line, argv, 0);
-- 
1.8.5.5
