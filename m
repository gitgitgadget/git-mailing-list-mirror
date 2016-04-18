From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] mv submodule: respect ignore_errors for errors in submodule code
Date: Mon, 18 Apr 2016 16:41:23 -0700
Message-ID: <1461022884-30819-2-git-send-email-sbeller@google.com>
References: <1461022884-30819-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, gmane@otterhall.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 01:41:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asInT-0007Z8-Fg
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 01:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbcDRXlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 19:41:36 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35435 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbcDRXlf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 19:41:35 -0400
Received: by mail-pf0-f181.google.com with SMTP id n1so31333pfn.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 16:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oZknBtELIW3ZCte/viZmdNDByuAaVadEN40x+B6Py1c=;
        b=SRGGKBjJ9ouzPYeZbpreqWF3Gq7g0urQAkEoHUebT7H2oTVeoMnx8VJKHO5ZZsVqld
         xFIuYl5Xk96Ubx+F5PTR4H4scCs/rE9E0OLongdv+HIg4dOGhle7zrhFPtseoG/VZ/FI
         VeIcEkTWE+B3QQXhqpP3SH+ijGS6OPPcKDLf4u4HQaDkOvKZoJ+V5+YNByibOZclpj03
         lefYu7qRvJQyusZi9zVrC9dqvvsqSoAGvvQM6cKq/D/ULfTKdT8L2Yw8uPaedv+gsYRo
         gdXR3i6dc/TxBvzMDqe78NyhcgUs8SMkKStlcYvL+LXPGbpTCXeWtXgRVTTNKuITC6Le
         U/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oZknBtELIW3ZCte/viZmdNDByuAaVadEN40x+B6Py1c=;
        b=DfqoXExY68lm64g0yFy9ZNy3KTusgdGfAhvaschMOSGOISk9OHKBrtxEUHCu49hhQg
         v52WYZAApZItJELQj+oGLs5h71TMTbF6Svs/VNMjE++Ag7Ifi3+9IxsDEVLzpu2ui2/P
         I/Vi187YyUyp6qTjpAUAdnRTlba7xBez5tfce9lzHWTfnYQwN1WDYSGRgph5mxQZiCPj
         gY13A9kMXmcXjJ15UiprHcp+Al5TiMVDpeikNur3X3Qw9kU8fKJPIH4O6vkXV6zRIkJG
         1x4Z7qlTH6Bx4Kyndu3eX9lLiu4RRcm6pXZgQ5Qy8rtchpcnrMpO88c94aw4+a9Fzucy
         4DiA==
X-Gm-Message-State: AOPr4FUCYE9BzYPVeHM0jiUfdhpPAbf3MHwQD+JnRZsSg17nI9eb7oudlaN5uNnmuQMh3xSa
X-Received: by 10.98.80.78 with SMTP id e75mr53967526pfb.147.1461022894001;
        Mon, 18 Apr 2016 16:41:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6869:43f:e72f:2f19])
        by smtp.gmail.com with ESMTPSA id z28sm14994532pfi.32.2016.04.18.16.41.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Apr 2016 16:41:33 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.211.g24879d1
In-Reply-To: <1461022884-30819-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291835>

The error handling via passing around a strbuf is well exercised in the
refs code, so apply that pattern here, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/mv.c | 15 ++++++++++++---
 submodule.c  | 33 ++++++++++++++++++++++++---------
 submodule.h  |  6 ++++--
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index aeae855..74516f4 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -247,6 +247,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	}
 
 	for (i = 0; i < argc; i++) {
+		struct strbuf err = STRBUF_INIT;
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
 		int pos;
@@ -256,9 +257,17 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			if (rename(src, dst) < 0 && !ignore_errors)
 				die_errno(_("renaming '%s' failed"), src);
 			if (submodule_gitfile[i]) {
-				if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
-					connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
-				if (!update_path_in_gitmodules(src, dst))
+				if ((submodule_gitfile[i] != SUBMODULE_WITH_GITDIR &&
+				    connect_work_tree_and_git_dir(dst, submodule_gitfile[i], &err)) ||
+				    update_path_in_gitmodules(src, dst, &err)) {
+					if (err.len) {
+						if (ignore_errors) {
+							warning("%s", err.buf);
+							continue;
+						} else
+							die("%s", err.buf);
+					}
+				} else
 					gitmodules_modified = 1;
 			}
 		}
diff --git a/submodule.c b/submodule.c
index 90825e1..ed18d34 100644
--- a/submodule.c
+++ b/submodule.c
@@ -51,7 +51,8 @@ int is_staging_gitmodules_ok(void)
  * .gitmodules file. Return 0 only if a .gitmodules file was found, a section
  * with the correct path=<oldpath> setting was found and we could update it.
  */
-int update_path_in_gitmodules(const char *oldpath, const char *newpath)
+int update_path_in_gitmodules(const char *oldpath, const char *newpath,
+			      struct strbuf *err)
 {
 	struct strbuf entry = STRBUF_INIT;
 	const struct submodule *submodule;
@@ -59,8 +60,10 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
 		return -1;
 
-	if (gitmodules_is_unmerged)
-		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
+	if (gitmodules_is_unmerged) {
+		strbuf_addf(err, _("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
+		return -1;
+	}
 
 	submodule = submodule_from_path(null_sha1, oldpath);
 	if (!submodule || !submodule->name) {
@@ -1102,27 +1105,39 @@ int merge_submodule(unsigned char result[20], const char *path,
 }
 
 /* Update gitfile and core.worktree setting to connect work tree and git dir */
-void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
+int connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir,
+				  struct strbuf *err)
 {
+	int ret = 0;
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
 	const char *real_work_tree = xstrdup(real_path(work_tree));
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
-	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, real_work_tree, &rel_path));
+	if (write_file_gently(file_name.buf, "gitdir: %s",
+	    relative_path(git_dir, real_work_tree, &rel_path))) {
+		strbuf_addf(err, _("could not write .git file (%s): %s"),
+				file_name.buf, strerror(errno));
+		ret = -1;
+		goto out;
+	}
 
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
 	strbuf_addf(&file_name, "%s/config", git_dir);
-	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(real_work_tree, git_dir,
-					     &rel_path));
+	if (git_config_set_in_file_gently(file_name.buf, "core.worktree",
+	    relative_path(real_work_tree, git_dir, &rel_path))) {
+		strbuf_addf(err, _("could not set core.worktree in %s"), file_name.buf);
+		ret = -1;
+		goto out;
+	}
 
+out:
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
 	free((void *)real_work_tree);
+	return ret;
 }
 
 int parallel_submodules(void)
diff --git a/submodule.h b/submodule.h
index 7ef3775..bf816e5 100644
--- a/submodule.h
+++ b/submodule.h
@@ -30,7 +30,8 @@ struct submodule_update_strategy {
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
 int is_staging_gitmodules_ok(void);
-int update_path_in_gitmodules(const char *oldpath, const char *newpath);
+int update_path_in_gitmodules(const char *oldpath, const char *newpath,
+			      struct strbuf *err);
 int remove_path_from_gitmodules(const char *path);
 void stage_updated_gitmodules(void);
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
@@ -58,7 +59,8 @@ int merge_submodule(unsigned char result[20], const char *path, const unsigned c
 int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
 		struct string_list *needs_pushing);
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
-void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
+int connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir,
+				  struct strbuf *err);
 int parallel_submodules(void);
 
 #endif
-- 
2.8.1.211.g24879d1
