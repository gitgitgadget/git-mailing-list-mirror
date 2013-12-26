From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/5] submodule: teach unpack_trees() to repopulate submodules
Date: Thu, 26 Dec 2013 08:14:10 -0800
Message-ID: <20131226161410.GO20443@google.com>
References: <20131226155857.GL20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 26 17:14:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwDZk-0006Kg-9n
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 17:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441Ab3LZQOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 11:14:16 -0500
Received: from mail-gg0-f173.google.com ([209.85.161.173]:42974 "EHLO
	mail-gg0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab3LZQOP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 11:14:15 -0500
Received: by mail-gg0-f173.google.com with SMTP id q4so1746993ggn.32
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uiNi0Y1KjbNXEJFINj1605KhMFEZ0lTNGHF6PgsMX8g=;
        b=Q5xHIsKrgKoz4iBeMQVN5zKtxVpfJnm1IUEApNsucaIDBEQ5fpQH5OptJsZPgN/EB4
         4qzQ2WSHQHHlRIaGUf3iCgZVAbBOLHp6q4ZMNJFUZEsIfoDmmn07IGFPvt4s7yLHIAuG
         XKkB7AJbwxcKZJXvTwr5Hza1sYwlOxlb55VFrRc1rZhv1HjqUpeYaSuHutw2lLlZ1VNX
         ImG20Em8QJddfQnxlfLenLfbKcH6Z8s3NTpdoZaxXfc63vVS66ydiUt4girk1yLixpyP
         rY9It3C8xKHDEzHEjG4VMJMGBoICWOANguB/BjEx9QyVeIha/jqIhivQy7WXXXNHhMd3
         M0CA==
X-Received: by 10.236.66.142 with SMTP id h14mr5819455yhd.74.1388074453758;
        Thu, 26 Dec 2013 08:14:13 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id m68sm42250283yhj.22.2013.12.26.08.14.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 08:14:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131226155857.GL20443@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239698>

From: Jens Lehmann <Jens.Lehmann@web.de>
Date: Mon, 18 Jun 2012 22:11:45 +0200

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Neat.  Would probably be clearer with some of the corresponding tests
squashed in to illustrate the intended behavior.

 entry.c        |  4 ++++
 submodule.c    | 44 +++++++++++++++++++++++++++++++++++++++++---
 submodule.h    |  1 +
 unpack-trees.c | 19 +++++++++++++++++++
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/entry.c b/entry.c
index 7b7aa81..d1bf6ec 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,7 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include "submodule.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -203,6 +204,9 @@ static int write_entry(struct cache_entry *ce,
 			return error("cannot create temporary submodule %s", path);
 		if (mkdir(path, 0777) < 0)
 			return error("cannot create submodule directory %s", path);
+		if (submodule_needs_update(path) &&
+		    populate_submodule(path, ce->sha1, state->force))
+			return error("cannot checkout submodule %s", path);
 		break;
 	default:
 		return error("unknown file mode for %s in index", path);
diff --git a/submodule.c b/submodule.c
index a25db46..06df5ae 100644
--- a/submodule.c
+++ b/submodule.c
@@ -412,6 +412,42 @@ int submodule_needs_update(const char *path)
 	return config_update_recurse_submodules != RECURSE_SUBMODULES_OFF;
 }
 
+int populate_submodule(const char *path, unsigned char sha1[20], int force)
+{
+	struct string_list_item *path_option;
+	const char *name, *real_git_dir;
+	struct strbuf buf = STRBUF_INIT;
+	struct child_process cp;
+	const char *argv[] = {"read-tree", force ? "--reset" : "-m", "-u", NULL, NULL};
+
+	path_option = unsorted_string_list_lookup(&config_name_for_path, path);
+	if (!path_option)
+		return 0;
+
+	name = path_option->util;
+
+	strbuf_addf(&buf, "%s/modules/%s", resolve_gitdir(get_git_dir()), name);
+	real_git_dir = resolve_gitdir(buf.buf);
+	if (!real_git_dir)
+		goto out;
+	connect_work_tree_and_git_dir(path, real_git_dir);
+
+	/* Run read-tree --reset sha1 */
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+	argv[3] = sha1_to_hex(sha1);
+	if (run_command(&cp))
+		warning(_("Checking out submodule %s failed"), path);
+
+out:
+	strbuf_release(&buf);
+	return 0;
+}
+
 int depopulate_submodule(const char *path)
 {
 	struct strbuf dot_git = STRBUF_INIT;
@@ -1207,6 +1243,7 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
+	const char *real_git_dir = xstrdup(real_path(git_dir));
 	const char *real_work_tree = xstrdup(real_path(work_tree));
 	FILE *fp;
 
@@ -1215,15 +1252,15 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 	fp = fopen(file_name.buf, "w");
 	if (!fp)
 		die(_("Could not create git link %s"), file_name.buf);
-	fprintf(fp, "gitdir: %s\n", relative_path(git_dir, real_work_tree,
+	fprintf(fp, "gitdir: %s\n", relative_path(real_git_dir, real_work_tree,
 						  &rel_path));
 	fclose(fp);
 
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
+	strbuf_addf(&file_name, "%s/config", real_git_dir);
 	if (git_config_set_in_file(file_name.buf, "core.worktree",
-				   relative_path(real_work_tree, git_dir,
+				   relative_path(real_work_tree, real_git_dir,
 						 &rel_path)))
 		die(_("Could not set core.worktree in %s"),
 		    file_name.buf);
@@ -1231,4 +1268,5 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
 	free((void *)real_work_tree);
+	free((void *)real_git_dir);
 }
diff --git a/submodule.h b/submodule.h
index df291cf..3657ca8 100644
--- a/submodule.h
+++ b/submodule.h
@@ -24,6 +24,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int submodule_needs_update(const char *path);
+int populate_submodule(const char *path, unsigned char sha1[20], int force);
 int depopulate_submodule(const char *path);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
diff --git a/unpack-trees.c b/unpack-trees.c
index 89b506a..ed48d41 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1367,6 +1367,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 			      struct unpack_trees_options *o)
 {
 	const struct cache_entry *result;
+	char *name_copy, *separator;
 
 	/*
 	 * It may be that the 'lstat()' succeeded even though
@@ -1409,6 +1410,24 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 			return 0;
 	}
 
+	/*
+	 * If the path lies inside a to be added submodule it
+	 * is ok to remove it.
+	 */
+	name_copy = xstrdup(name);
+	while ((separator = strrchr(name_copy, '/'))) {
+		int i;
+		*separator = '\0';
+		for (i = 0; i < the_index.cache_nr; i++) {
+			struct cache_entry *ce = the_index.cache[i];
+			if (!strcmp(ce->name, name_copy) && S_ISGITLINK(ce->ce_mode)) {
+				free(name_copy);
+				return 0;
+			}
+		}
+	}
+	free(name_copy);
+
 	return o->gently ? -1 :
 		add_rejected_path(o, error_type, name);
 }
-- 
1.8.5.1
