From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH/RFC 2/3] Teach mv to move submodules using a gitfile
Date: Wed, 03 Apr 2013 21:56:55 +0200
Message-ID: <515C8987.2060804@web.de>
References: <515C88FE.9020203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 21:57:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNTof-00047T-So
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 21:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283Ab3DCT5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 15:57:25 -0400
Received: from mout.web.de ([212.227.15.3]:56933 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932245Ab3DCT5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 15:57:24 -0400
Received: from [192.168.178.41] ([79.193.80.178]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MGRI8-1URvnD2Afg-00DYyl; Wed, 03 Apr 2013 21:56:56
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <515C88FE.9020203@web.de>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:aMctw1oZYbdDPvyRqSJtBoK1Nwy0/F5qbgCUJ9zp5H0
 gCLfV9sOxhN5/n5eXJsfyt3TgRvpEdDvaBk8y8jr62+jJcy9ek
 Z8crxSftKGfrfng1Lzxwb6p8+LTdPwcp/mfRWRJEaXyNpTyyUB
 LqMfKWV25f1ZpAutGeRqkpAl13SWKwmOHiWf8t4PMMI+6dl4kH
 tIhzveu4Sd1RCdpUPu7tA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219964>

When moving a submodule which uses a gitfile to point to the git directory
stored in .git/modules/<name> of the superproject two changes must be made
to make the submodule work: the .git file and the core.worktree setting
must be adjusted to point from work tree to git directory and back.

Achieve that by remembering which submodule uses a gitfile by storing the
result of read_gitfile() of each submodule. If that is not NULL the new
function connect_work_tree_and_git_dir() is called after renaming the
submodule's work tree which updates the two settings to the new values.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 builtin/mv.c  | 19 ++++++++++++++----
 submodule.c   | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h   |  1 +
 t/t7001-mv.sh | 19 ++++++++++++++++++
 4 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 361028d..609bbb8 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "submodule.h"

 static const char * const builtin_mv_usage[] = {
 	N_("git mv [options] <source>... <destination>"),
@@ -65,7 +66,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('k', NULL, &ignore_errors, N_("skip move/rename errors")),
 		OPT_END(),
 	};
-	const char **source, **destination, **dest_path;
+	const char **source, **destination, **dest_path, **submodule_gitfile;
 	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
@@ -84,6 +85,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	source = copy_pathspec(prefix, argv, argc, 0);
 	modes = xcalloc(argc, sizeof(enum update_mode));
 	dest_path = copy_pathspec(prefix, argv + argc, 1, 0);
+	submodule_gitfile = xcalloc(argc, sizeof(char *));

 	if (dest_path[0][0] == '\0')
 		/* special case: "." was normalized to "" */
@@ -119,8 +121,14 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		else if (src_is_dir) {
 			int first = cache_name_pos(src, length);
 			if (first >= 0) {
+				struct strbuf submodule_dotgit = STRBUF_INIT;
 				if (!S_ISGITLINK(active_cache[first]->ce_mode))
 					die (_("Huh? Directory %s is in index and no submodule?"), src);
+				strbuf_addf(&submodule_dotgit, "%s/.git", src);
+				submodule_gitfile[i] = read_gitfile(submodule_dotgit.buf);
+				if (submodule_gitfile[i])
+					submodule_gitfile[i] = xstrdup(submodule_gitfile[i]);
+				strbuf_release(&submodule_dotgit);
 			} else {
 				const char *src_w_slash = add_slash(src);
 				int last, len_w_slash = length + 1;
@@ -215,9 +223,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		int pos;
 		if (show_only || verbose)
 			printf(_("Renaming %s to %s\n"), src, dst);
-		if (!show_only && mode != INDEX &&
-				rename(src, dst) < 0 && !ignore_errors)
-			die_errno (_("renaming '%s' failed"), src);
+		if (!show_only && mode != INDEX) {
+			if (rename(src, dst) < 0 && !ignore_errors)
+				die_errno (_("renaming '%s' failed"), src);
+			if (submodule_gitfile[i])
+				connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
+		}

 		if (mode == WORKING_DIRECTORY)
 			continue;
diff --git a/submodule.c b/submodule.c
index 975bc87..eba9b42 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1001,3 +1001,67 @@ int merge_submodule(unsigned char result[20], const char *path,
 	free(merges.objects);
 	return 0;
 }
+
+/* Update gitfile and core.worktree setting to connect work tree and git dir */
+void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
+{
+	struct strbuf core_worktree_setting = STRBUF_INIT;
+	struct strbuf configfile_name = STRBUF_INIT;
+	struct strbuf gitfile_content = STRBUF_INIT;
+	struct strbuf gitfile_name = STRBUF_INIT;
+	const char *real_work_tree = real_path(work_tree);
+	const char *pathspec[] = { real_work_tree, git_dir, NULL };
+	const char *max_prefix = common_prefix(pathspec);
+	FILE *fp;
+
+	if (max_prefix) {       /* skip common prefix */
+		size_t max_prefix_len = strlen(max_prefix);
+		real_work_tree += max_prefix_len;
+		git_dir += max_prefix_len;
+	}
+
+	/*
+	 * Update gitfile
+	 */
+	strbuf_addstr(&gitfile_content, "gitdir: ");
+	if (real_work_tree[0]) {
+		const char *s = real_work_tree;
+		do {
+			strbuf_addstr(&gitfile_content, "../");
+			s++;
+		} while ((s = strchr(s, '/')));
+	}
+	strbuf_addstr(&gitfile_content, git_dir);
+	strbuf_addch(&gitfile_content, '\n');
+
+	strbuf_addf(&gitfile_name, "%s/.git", work_tree);
+	fp = fopen(gitfile_name.buf, "w");
+	if (!fp)
+		die(_("Could not create git link %s"), gitfile_name.buf);
+	fprintf(fp, gitfile_content.buf);
+	fclose(fp);
+
+	strbuf_release(&gitfile_content);
+	strbuf_release(&gitfile_name);
+
+	/*
+	 * Update core.worktree setting
+	 */
+	if (git_dir[0]) {
+		const char *s = git_dir;
+		do {
+			strbuf_addstr(&core_worktree_setting, "../");
+			s++;
+		} while ((s = strchr(s, '/')));
+	}
+	strbuf_addstr(&core_worktree_setting, real_work_tree);
+
+	strbuf_addf(&configfile_name, "%s/config", git_dir);
+	if (git_config_set_in_file(configfile_name.buf, "core.worktree",
+				   core_worktree_setting.buf))
+		die(_("Could not set core.worktree in %s"),
+		    configfile_name.buf);
+
+	strbuf_release(&core_worktree_setting);
+	strbuf_release(&configfile_name);
+}
diff --git a/submodule.h b/submodule.h
index 3dc1b3f..0c27c53 100644
--- a/submodule.h
+++ b/submodule.h
@@ -35,5 +35,6 @@ int merge_submodule(unsigned char result[20], const char *path, const unsigned c
 int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
 		struct string_list *needs_pushing);
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
+void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);

 #endif
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 4c57f61..d824464 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -289,4 +289,23 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	git diff-files --quiet
 '

+test_expect_success 'git mv moves a submodule with gitfile' '
+	rm -rf mod/sub &&
+	git reset --hard &&
+	git submodule update &&
+	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	(
+		cd mod &&
+		git mv ../sub/ .
+	) &&
+	! test -e sub &&
+	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	(
+		cd mod/sub &&
+		git status
+	) &&
+	git update-index --refresh &&
+	git diff-files --quiet
+'
+
 test_done
-- 
1.8.2.377.g1bdb7d0
