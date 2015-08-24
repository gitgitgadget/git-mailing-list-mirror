From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/6] write_file(): drop caller-supplied LF from calls to create a one-liner file
Date: Mon, 24 Aug 2015 13:58:09 -0700
Message-ID: <1440449890-29490-6-git-send-email-gitster@pobox.com>
References: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
 <1440449890-29490-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 22:58:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTyp2-0006xJ-GS
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 22:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbbHXU6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 16:58:23 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34769 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbbHXU6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 16:58:16 -0400
Received: by pabzx8 with SMTP id zx8so14632824pab.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=tFCSXjr3h4EyRTb3FJG6NktgybGYi8xyGX3wISbergk=;
        b=RyfSryriVdaHPDajwaNNcujQ+mTCJqIk5hxtcSWFvbGZ3fhWim/nWkV155eOYP2dy+
         Xv6x1OGkJscMzFsf8eFqDXkSKP1nQPsDdtBYY8Tv4a5F1J8qxzG478Z8IAGIcgqiV06K
         +7VAS+L3gvaHV8zL1UI2EIOPOvXx28PqMMbyMmp3i8ICbsasTnxm1IXzP6sNewyn8WCe
         oZ1A5nbOlASsLW1jay/05vpLaGRBlHYEeik/OWxVoV9d53PDNi0GWr4cyATYP48mJJtY
         KOEffAzEXdQyYVfU4Ha17Y19lvQX+LfxpXCs0sRuYt5KcwWp6P9OjcOU92pwDn5xGBvv
         A89A==
X-Received: by 10.68.113.37 with SMTP id iv5mr49746192pbb.104.1440449896174;
        Mon, 24 Aug 2015 13:58:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id tq6sm16071925pbc.57.2015.08.24.13.58.15
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 13:58:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-568-g53a3e28
In-Reply-To: <1440449890-29490-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276483>

All of the callsites covered by this change call write_file() or
write_file_gently() to create a one-liner file.  Drop the caller
supplied LF and let these callees to append it as necessary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/init-db.c  |  2 +-
 builtin/worktree.c | 10 +++++-----
 daemon.c           |  2 +-
 setup.c            |  2 +-
 submodule.c        |  2 +-
 transport.c        |  2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index bfe1d08..69323e1 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -378,7 +378,7 @@ static void separate_git_dir(const char *git_dir)
 			die_errno(_("unable to move %s to %s"), src, git_dir);
 	}
 
-	write_file(git_link, "gitdir: %s\n", git_dir);
+	write_file(git_link, "gitdir: %s", git_dir);
 }
 
 int init_db(const char *template_dir, unsigned int flags)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 368502d..bbb169a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -213,7 +213,7 @@ static int add_worktree(const char *path, const char **child_argv)
 	 * after the preparation is over.
 	 */
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	write_file(sb.buf, "initializing\n");
+	write_file(sb.buf, "initializing");
 
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
@@ -223,8 +223,8 @@ static int add_worktree(const char *path, const char **child_argv)
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
-	write_file(sb.buf, "%s\n", real_path(sb_git.buf));
-	write_file(sb_git.buf, "gitdir: %s/worktrees/%s\n",
+	write_file(sb.buf, "%s", real_path(sb_git.buf));
+	write_file(sb_git.buf, "gitdir: %s/worktrees/%s",
 		   real_path(get_git_common_dir()), name);
 	/*
 	 * This is to keep resolve_ref() happy. We need a valid HEAD
@@ -241,10 +241,10 @@ static int add_worktree(const char *path, const char **child_argv)
 		die(_("unable to resolve HEAD"));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, "%s\n", sha1_to_hex(rev));
+	write_file(sb.buf, "%s", sha1_to_hex(rev));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
-	write_file(sb.buf, "../..\n");
+	write_file(sb.buf, "../..");
 
 	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
 
diff --git a/daemon.c b/daemon.c
index 9154509..f9eb296 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1376,7 +1376,7 @@ int main(int argc, char **argv)
 		sanitize_stdfds();
 
 	if (pid_file)
-		write_file(pid_file, "%"PRIuMAX"\n", (uintmax_t) getpid());
+		write_file(pid_file, "%"PRIuMAX, (uintmax_t) getpid());
 
 	/* prepare argv for serving-processes */
 	cld_argv = xmalloc(sizeof (char *) * (argc + 2));
diff --git a/setup.c b/setup.c
index feb8565..a206781 100644
--- a/setup.c
+++ b/setup.c
@@ -404,7 +404,7 @@ static void update_linked_gitdir(const char *gitfile, const char *gitdir)
 
 	strbuf_addf(&path, "%s/gitfile", gitdir);
 	if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
-		write_file_gently(path.buf, "%s\n", gitfile);
+		write_file_gently(path.buf, "%s", gitfile);
 	strbuf_release(&path);
 }
 
diff --git a/submodule.c b/submodule.c
index 5519f11..4549c1b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1103,7 +1103,7 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
-	write_file(file_name.buf, "gitdir: %s\n",
+	write_file(file_name.buf, "gitdir: %s",
 		   relative_path(git_dir, real_work_tree, &rel_path));
 
 	/* Update core.worktree setting */
diff --git a/transport.c b/transport.c
index 0254394..788cf20 100644
--- a/transport.c
+++ b/transport.c
@@ -291,7 +291,7 @@ static int write_one_ref(const char *name, const struct object_id *oid,
 
 	strbuf_addstr(buf, name);
 	if (safe_create_leading_directories(buf->buf) ||
-	    write_file_gently(buf->buf, "%s\n", oid_to_hex(oid)))
+	    write_file_gently(buf->buf, "%s", oid_to_hex(oid)))
 		return error("problems writing temporary file %s: %s",
 			     buf->buf, strerror(errno));
 	strbuf_setlen(buf, len);
-- 
2.5.0-568-g53a3e28
