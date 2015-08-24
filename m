From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] write_file(): clean up transitional mess of flag words and terminating LF
Date: Mon, 24 Aug 2015 10:09:46 -0700
Message-ID: <1440436186-7894-6-git-send-email-gitster@pobox.com>
References: <20150824065033.GA4124@sigill.intra.peff.net>
 <1440436186-7894-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 19:10:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTvFx-000596-Ry
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 19:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbbHXRJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 13:09:54 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32924 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbbHXRJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 13:09:52 -0400
Received: by pacti10 with SMTP id ti10so28212726pac.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=afbuEUkkcG/Kv+dVE29xjHeDboe0DFMEyg6mO4lMatg=;
        b=ZZXNcDwooc2hLXjKKO4rZyXIA+mqOexj2uXQJUbB95fLkwKeYBRd5J7bCAfZW3sYGx
         zATrjKu0soqDYjOtBldtJ9rqndzkSPJsa92oxOaIWSRHStlfZEbnD/LKxoXPMsx3YJ1h
         SisR4heQUIHHo52qJePD8Xfbk/hRDss1UyiVFTrljIdQVBYy86bzbrSl+Q4O8IcvKqRH
         CfTSGMQeslFF+HJcOHcWvOUrhrnrgOH9ov6RgREI2yeh52LUSFn64Mi14g+YnyayI/2p
         2yjHUGSAsE2PeaByEyY7jpAtYgK14h/ESFhMplsVNifu3CCx2pkIYAlA4J/7P8Bg1X6S
         /FBg==
X-Received: by 10.68.178.36 with SMTP id cv4mr47221142pbc.161.1440436192084;
        Mon, 24 Aug 2015 10:09:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id dn3sm15700017pdb.66.2015.08.24.10.09.51
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 10:09:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-568-g53a3e28
In-Reply-To: <1440436186-7894-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276461>

Because the function adds necessary LF at the end of an incomplete
line for all callers that do not pass the WRITE_FILE_BINARY option,
and no caller of the function calls with that option, stop callers
to add LF at the end of the payload they pass to the function.

Also, change the callers that pass 1 to flags, that is now a no-op,
to pass 0.  In order to catch stray callers (and possible topics in
flight) that still pass 1 to ask the function to die upon error,
protect it with an assert().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c       |  4 ++--
 builtin/init-db.c  |  2 +-
 builtin/worktree.c | 10 +++++-----
 daemon.c           |  2 +-
 setup.c            |  2 +-
 submodule.c        |  2 +-
 transport.c        |  2 +-
 wrapper.c          |  7 ++++++-
 8 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3423aa3..d804b12 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -199,13 +199,13 @@ static inline const char *am_path(const struct am_state *state, const char *path
 static int write_state_text(const struct am_state *state,
 			    const char *name, const char *string)
 {
-	return write_file(am_path(state, name), 1, "%s\n", string);
+	return write_file(am_path(state, name), 0, "%s", string);
 }
 
 static int write_state_count(const struct am_state *state,
 			     const char *name, int value)
 {
-	return write_file(am_path(state, name), 1, "%d\n", value);
+	return write_file(am_path(state, name), 0, "%d", value);
 }
 
 static int write_state_bool(const struct am_state *state,
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 49df78d..84d27b1 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -378,7 +378,7 @@ static void separate_git_dir(const char *git_dir)
 			die_errno(_("unable to move %s to %s"), src, git_dir);
 	}
 
-	write_file(git_link, 1, "gitdir: %s\n", git_dir);
+	write_file(git_link, 0, "gitdir: %s", git_dir);
 }
 
 int init_db(const char *template_dir, unsigned int flags)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6a264ee..cc0981f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -213,7 +213,7 @@ static int add_worktree(const char *path, const char **child_argv)
 	 * after the preparation is over.
 	 */
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	write_file(sb.buf, 1, "initializing\n");
+	write_file(sb.buf, 0, "initializing");
 
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
@@ -223,8 +223,8 @@ static int add_worktree(const char *path, const char **child_argv)
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
-	write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
-	write_file(sb_git.buf, 1, "gitdir: %s/worktrees/%s\n",
+	write_file(sb.buf, 0, "%s", real_path(sb_git.buf));
+	write_file(sb_git.buf, 0, "gitdir: %s/worktrees/%s",
 		   real_path(get_git_common_dir()), name);
 	/*
 	 * This is to keep resolve_ref() happy. We need a valid HEAD
@@ -241,10 +241,10 @@ static int add_worktree(const char *path, const char **child_argv)
 		die(_("unable to resolve HEAD"));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, 1, "%s\n", sha1_to_hex(rev));
+	write_file(sb.buf, 0, "%s", sha1_to_hex(rev));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
-	write_file(sb.buf, 1, "../..\n");
+	write_file(sb.buf, 0, "../..");
 
 	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
 
diff --git a/daemon.c b/daemon.c
index d3d3e43..30a3fb4 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1376,7 +1376,7 @@ int main(int argc, char **argv)
 		sanitize_stdfds();
 
 	if (pid_file)
-		write_file(pid_file, 1, "%"PRIuMAX"\n", (uintmax_t) getpid());
+		write_file(pid_file, 0, "%"PRIuMAX, (uintmax_t) getpid());
 
 	/* prepare argv for serving-processes */
 	cld_argv = xmalloc(sizeof (char *) * (argc + 2));
diff --git a/setup.c b/setup.c
index 718f4e1..49675eb 100644
--- a/setup.c
+++ b/setup.c
@@ -404,7 +404,7 @@ static void update_linked_gitdir(const char *gitfile, const char *gitdir)
 
 	strbuf_addf(&path, "%s/gitfile", gitdir);
 	if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
-		write_file(path.buf, WRITE_FILE_GENTLY, "%s\n", gitfile);
+		write_file(path.buf, WRITE_FILE_GENTLY, "%s", gitfile);
 	strbuf_release(&path);
 }
 
diff --git a/submodule.c b/submodule.c
index 700bbf4..c22fd04 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1103,7 +1103,7 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
-	write_file(file_name.buf, 1, "gitdir: %s\n",
+	write_file(file_name.buf, 0, "gitdir: %s",
 		   relative_path(git_dir, real_work_tree, &rel_path));
 
 	/* Update core.worktree setting */
diff --git a/transport.c b/transport.c
index e1821a4..e5638c0 100644
--- a/transport.c
+++ b/transport.c
@@ -291,7 +291,7 @@ static int write_one_ref(const char *name, const struct object_id *oid,
 
 	strbuf_addstr(buf, name);
 	if (safe_create_leading_directories(buf->buf) ||
-	    write_file(buf->buf, WRITE_FILE_GENTLY, "%s\n", oid_to_hex(oid)))
+	    write_file(buf->buf, WRITE_FILE_GENTLY, "%s", oid_to_hex(oid)))
 		return error("problems writing temporary file %s: %s",
 			     buf->buf, strerror(errno));
 	strbuf_setlen(buf, len);
diff --git a/wrapper.c b/wrapper.c
index 4cd2ca3..4f464ea 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -626,7 +626,12 @@ int write_file(const char *path, unsigned flags, const char *fmt, ...)
 	int fatal = !(flags & WRITE_FILE_GENTLY);
 	struct strbuf sb = STRBUF_INIT;
 	va_list params;
-	int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
+	int fd;
+
+	if ((flags & WRITE_FILE_UNUSED_0))
+		die("BUG: write_file() called with bit 0 set");
+
+	fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0) {
 		if (fatal)
 			die_errno(_("could not open %s for writing"), path);
-- 
2.5.0-568-g53a3e28
