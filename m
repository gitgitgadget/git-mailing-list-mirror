From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/6] write_file(): drop "fatal" parameter
Date: Mon, 24 Aug 2015 13:58:07 -0700
Message-ID: <1440449890-29490-4-git-send-email-gitster@pobox.com>
References: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
 <1440449890-29490-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 22:58:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTyp3-0006xJ-Nx
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 22:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbbHXU62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 16:58:28 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34748 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbbHXU6P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 16:58:15 -0400
Received: by pabzx8 with SMTP id zx8so14632401pab.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 13:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=dc9mHkak2JdH8Ks0C1/LdEmXlC7iYKJvq7VowOntwJQ=;
        b=t1zf47Lppn4cmJkcqyswyyWf90ZiSmBZMNFnwDq4iwxUS+nx+FsgFoW/HVGk10iu3Y
         q8QmUsAx3coym7twb5N/7N+SwnApJhecWR/A/HJGMRmSF7UEDSshzlbOswbKH1SHwccX
         HHYCPRnrpUpVbWkG4mTud88ibtFWA5smMzTgvZf9EzfrJ5DnONiLnS91BVzSodLofgqv
         cnr+sG4webZM3CKjGsd566o0qqHKQpsy47AkAuIuNet2ykI2xc0Wx7/nQzH41cCWm7f5
         HLIJRtG3cHAEJEkFAmBNMwqH0Ko58ZPVzUWvRrOvwhWrKi3CBmMwrb4HykN0phyrXpjY
         qXkA==
X-Received: by 10.67.30.161 with SMTP id kf1mr49635627pad.89.1440449894491;
        Mon, 24 Aug 2015 13:58:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id pg5sm18430726pdb.81.2015.08.24.13.58.13
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 13:58:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-568-g53a3e28
In-Reply-To: <1440449890-29490-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276486>

All callers except three passed 1 for the "fatal" parameter to ask
this function to die upon error, but to a casual reader of the code,
it was not all obvious what that 1 meant.  Instead, split the
function into two based on a common write_file_v() that takes the
flag, introduce write_file_gently() as a new way to attempt creating
a file without dying on error, and make three callers to call it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c       |  4 ++--
 builtin/branch.c   |  2 +-
 builtin/init-db.c  |  2 +-
 builtin/worktree.c | 10 +++++-----
 cache.h            |  5 +++--
 daemon.c           |  2 +-
 setup.c            |  2 +-
 submodule.c        |  2 +-
 transport.c        |  2 +-
 wrapper.c          | 28 ++++++++++++++++++++++++----
 10 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f0a046b..9c57677 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -205,13 +205,13 @@ static int write_state_text(const struct am_state *state,
 		fmt = "%s\n";
 	else
 		fmt = "%s";
-	return write_file(am_path(state, name), 1, fmt, string);
+	return write_file(am_path(state, name), fmt, string);
 }
 
 static int write_state_count(const struct am_state *state,
 			     const char *name, int value)
 {
-	return write_file(am_path(state, name), 1, "%d\n", value);
+	return write_file(am_path(state, name), "%d\n", value);
 }
 
 static int write_state_bool(const struct am_state *state,
diff --git a/builtin/branch.c b/builtin/branch.c
index 58aa84f..ff05869 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -776,7 +776,7 @@ static int edit_branch_description(const char *branch_name)
 		    "  %s\n"
 		    "Lines starting with '%c' will be stripped.\n",
 		    branch_name, comment_line_char);
-	if (write_file(git_path(edit_description), 0, "%s", buf.buf)) {
+	if (write_file_gently(git_path(edit_description), "%s", buf.buf)) {
 		strbuf_release(&buf);
 		return error(_("could not write branch description template: %s"),
 			     strerror(errno));
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 49df78d..bfe1d08 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -378,7 +378,7 @@ static void separate_git_dir(const char *git_dir)
 			die_errno(_("unable to move %s to %s"), src, git_dir);
 	}
 
-	write_file(git_link, 1, "gitdir: %s\n", git_dir);
+	write_file(git_link, "gitdir: %s\n", git_dir);
 }
 
 int init_db(const char *template_dir, unsigned int flags)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6a264ee..368502d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -213,7 +213,7 @@ static int add_worktree(const char *path, const char **child_argv)
 	 * after the preparation is over.
 	 */
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	write_file(sb.buf, 1, "initializing\n");
+	write_file(sb.buf, "initializing\n");
 
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
@@ -223,8 +223,8 @@ static int add_worktree(const char *path, const char **child_argv)
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
-	write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
-	write_file(sb_git.buf, 1, "gitdir: %s/worktrees/%s\n",
+	write_file(sb.buf, "%s\n", real_path(sb_git.buf));
+	write_file(sb_git.buf, "gitdir: %s/worktrees/%s\n",
 		   real_path(get_git_common_dir()), name);
 	/*
 	 * This is to keep resolve_ref() happy. We need a valid HEAD
@@ -241,10 +241,10 @@ static int add_worktree(const char *path, const char **child_argv)
 		die(_("unable to resolve HEAD"));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, 1, "%s\n", sha1_to_hex(rev));
+	write_file(sb.buf, "%s\n", sha1_to_hex(rev));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
-	write_file(sb.buf, 1, "../..\n");
+	write_file(sb.buf, "../..\n");
 
 	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
 
diff --git a/cache.h b/cache.h
index 6bb7119..3f79e6b 100644
--- a/cache.h
+++ b/cache.h
@@ -1539,8 +1539,9 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
 {
 	return write_in_full(fd, str, strlen(str));
 }
-__attribute__((format (printf, 3, 4)))
-extern int write_file(const char *path, int fatal, const char *fmt, ...);
+
+extern int write_file(const char *path, const char *fmt, ...);
+extern int write_file_gently(const char *path, const char *fmt, ...);
 
 /* pager.c */
 extern void setup_pager(void);
diff --git a/daemon.c b/daemon.c
index d3d3e43..9154509 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1376,7 +1376,7 @@ int main(int argc, char **argv)
 		sanitize_stdfds();
 
 	if (pid_file)
-		write_file(pid_file, 1, "%"PRIuMAX"\n", (uintmax_t) getpid());
+		write_file(pid_file, "%"PRIuMAX"\n", (uintmax_t) getpid());
 
 	/* prepare argv for serving-processes */
 	cld_argv = xmalloc(sizeof (char *) * (argc + 2));
diff --git a/setup.c b/setup.c
index 5f9f07d..feb8565 100644
--- a/setup.c
+++ b/setup.c
@@ -404,7 +404,7 @@ static void update_linked_gitdir(const char *gitfile, const char *gitdir)
 
 	strbuf_addf(&path, "%s/gitfile", gitdir);
 	if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
-		write_file(path.buf, 0, "%s\n", gitfile);
+		write_file_gently(path.buf, "%s\n", gitfile);
 	strbuf_release(&path);
 }
 
diff --git a/submodule.c b/submodule.c
index 700bbf4..5519f11 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1103,7 +1103,7 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
-	write_file(file_name.buf, 1, "gitdir: %s\n",
+	write_file(file_name.buf, "gitdir: %s\n",
 		   relative_path(git_dir, real_work_tree, &rel_path));
 
 	/* Update core.worktree setting */
diff --git a/transport.c b/transport.c
index 40692f8..0254394 100644
--- a/transport.c
+++ b/transport.c
@@ -291,7 +291,7 @@ static int write_one_ref(const char *name, const struct object_id *oid,
 
 	strbuf_addstr(buf, name);
 	if (safe_create_leading_directories(buf->buf) ||
-	    write_file(buf->buf, 0, "%s\n", oid_to_hex(oid)))
+	    write_file_gently(buf->buf, "%s\n", oid_to_hex(oid)))
 		return error("problems writing temporary file %s: %s",
 			     buf->buf, strerror(errno));
 	strbuf_setlen(buf, len);
diff --git a/wrapper.c b/wrapper.c
index e451463..8c8925b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -621,19 +621,17 @@ char *xgetcwd(void)
 	return strbuf_detach(&sb, NULL);
 }
 
-int write_file(const char *path, int fatal, const char *fmt, ...)
+static int write_file_v(const char *path, int fatal,
+			const char *fmt, va_list params)
 {
 	struct strbuf sb = STRBUF_INIT;
-	va_list params;
 	int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0) {
 		if (fatal)
 			die_errno(_("could not open %s for writing"), path);
 		return -1;
 	}
-	va_start(params, fmt);
 	strbuf_vaddf(&sb, fmt, params);
-	va_end(params);
 	if (write_in_full(fd, sb.buf, sb.len) != sb.len) {
 		int err = errno;
 		close(fd);
@@ -652,6 +650,28 @@ int write_file(const char *path, int fatal, const char *fmt, ...)
 	return 0;
 }
 
+int write_file(const char *path, const char *fmt, ...)
+{
+	int status;
+	va_list params;
+
+	va_start(params, fmt);
+	status = write_file_v(path, 1, fmt, params);
+	va_end(params);
+	return status;
+}
+
+int write_file_gently(const char *path, const char *fmt, ...)
+{
+	int status;
+	va_list params;
+
+	va_start(params, fmt);
+	status = write_file_v(path, 0, fmt, params);
+	va_end(params);
+	return status;
+}
+
 void sleep_millisec(int millisec)
 {
 	poll(NULL, 0, millisec);
-- 
2.5.0-568-g53a3e28
