From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP/PATCH 8/9] submodule: teach unpack_trees() to repopulate submodules
Date: Mon, 03 Feb 2014 20:53:43 +0100
Message-ID: <52EFF3C7.3020805@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 20:53:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPaY-0002Rz-Ie
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbaBCTxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:53:46 -0500
Received: from mout.web.de ([212.227.15.14]:61836 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbaBCTxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:53:45 -0500
Received: from [192.168.178.41] ([84.132.165.229]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MZDP6-1VpSOJ2Ijk-00KtuL for <git@vger.kernel.org>;
 Mon, 03 Feb 2014 20:53:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52EFF25E.6080306@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:zRDGUN/btWemZEcafO4v1I7tWKhAWM7RXCa6/eLiamf4EHI1Vt+
 hTeDVAQI2vNYj8p1rTp1HpjeT+mNgY0Lr9BYyRwYYE1uxSyM6NPaOifkgdXUAiAxQFrXl2s
 OHfj8XK2WcTA/ubs4rNI6AqklQmkuiiqAlikSlU/J0IhjR2y3q6DvoHxZWnL8QLvpQn4gok
 Gu/sNnimv/28bVSPmL4jA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241464>

Implement the functionality needed to enable work tree manipulating
commands so that an added submodule does not only affect the index and
creates an empty directory but it also populates the work tree of any
initialized submodule according to the SHA-1 recorded in the superproject.

That will only work for submodules that store their git directory in the
.git/modules directory of the superproject. Additionally the submodule has
to be found in the .gitmodules file before the work tree update starts as
the git directory is stored under the submodule name, not its path. This
will be fixed when the .gitmodules blob of the tree we are updating to
will be used for the path <-> name mapping in a later commit.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
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
index f292e9e..3907034 100644
--- a/submodule.c
+++ b/submodule.c
@@ -447,6 +447,42 @@ int submodule_needs_update(const char *path)
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
@@ -1242,6 +1278,7 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
+	const char *real_git_dir = xstrdup(real_path(git_dir));
 	const char *real_work_tree = xstrdup(real_path(work_tree));
 	FILE *fp;

@@ -1250,15 +1287,15 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
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
@@ -1266,4 +1303,5 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
 	free((void *)real_work_tree);
+	free((void *)real_git_dir);
 }
diff --git a/submodule.h b/submodule.h
index 2139e08..a7d09a5 100644
--- a/submodule.h
+++ b/submodule.h
@@ -28,6 +28,7 @@ int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int option_parse_update_submodules(const struct option *opt,
 		const char *arg, int unset);
 int submodule_needs_update(const char *path);
+int populate_submodule(const char *path, unsigned char sha1[20], int force);
 int depopulate_submodule(const char *path);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
diff --git a/unpack-trees.c b/unpack-trees.c
index 82c99eb..49d0a67 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1371,6 +1371,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 			      struct unpack_trees_options *o)
 {
 	const struct cache_entry *result;
+	char *name_copy, *separator;

 	/*
 	 * It may be that the 'lstat()' succeeded even though
@@ -1413,6 +1414,24 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
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
1.9.rc0.28.ge3363ff
