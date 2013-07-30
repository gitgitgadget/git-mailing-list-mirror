From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 2/5] Teach mv to move submodules using a gitfile
Date: Tue, 30 Jul 2013 21:50:03 +0200
Message-ID: <51F818EB.8010101@web.de>
References: <51F8187F.7040603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 30 21:50:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Fvw-0007Vo-Am
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 21:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174Ab3G3TuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 15:50:06 -0400
Received: from mout.web.de ([212.227.15.4]:50120 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757141Ab3G3TuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 15:50:05 -0400
Received: from [192.168.178.41] ([79.193.94.161]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MUnuu-1UYRIV2J5A-00YBHt for <git@vger.kernel.org>;
 Tue, 30 Jul 2013 21:50:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51F8187F.7040603@web.de>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:EyR6ke2OhYMb13Z7P0iRerIQQZSVngXT2bPBZ3ZHFhZGkvoqdQW
 Cy22eh2wGorgCtfyn6tDPJk2HnHDJBtjd74WQkf3fek83LkTsLYw4DwWXe6wUfd887e6MJP
 nfzT3PORc1BVtevj2JH7sSVUdhg0k6IqLaEDEzV1GPYDFfr02xxTh/oprT36XnoJtdrrrzq
 WaWBBbLxC9EylnpY2CjMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231384>

When moving a submodule which uses a gitfile to point to the git directory
stored in .git/modules/<name> of the superproject two changes must be made
to make the submodule work: the .git file and the core.worktree setting
must be adjusted to point from work tree to git directory and back.

Achieve that by remembering which submodule uses a gitfile by storing the
result of read_gitfile() of each submodule. If that is not NULL the new
function connect_work_tree_and_git_dir() is called after renaming the
submodule's work tree which updates the two settings to the new values.

Extend the man page to inform the user about that feature (and while at it
change the description to not talk about a script anymore, as mv is a
builtin for quite some time now).

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-mv.txt |  8 +++++++-
 builtin/mv.c             | 19 +++++++++++++++----
 submodule.c              | 31 +++++++++++++++++++++++++++++++
 submodule.h              |  1 +
 t/t7001-mv.sh            | 19 +++++++++++++++++++
 5 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index e93fcb4..1f6fce0 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -13,7 +13,7 @@ SYNOPSIS

 DESCRIPTION
 -----------
-This script is used to move or rename a file, directory or symlink.
+Move or rename a file, directory or symlink.

  git mv [-v] [-f] [-n] [-k] <source> <destination>
  git mv [-v] [-f] [-n] [-k] <source> ... <destination directory>
@@ -44,6 +44,12 @@ OPTIONS
 --verbose::
 	Report the names of files as they are moved.

+SUBMODULES
+----------
+Moving a submodule using a gitfile (which means they were cloned
+with a Git version 1.7.8 or newer) will update the gitfile and
+core.worktree setting to make the submodule work in the new location.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/mv.c b/builtin/mv.c
index 1d3ef63..68b7060 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "submodule.h"

 static const char * const builtin_mv_usage[] = {
 	N_("git mv [options] <source>... <destination>"),
@@ -66,7 +67,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('k', NULL, &ignore_errors, N_("skip move/rename errors")),
 		OPT_END(),
 	};
-	const char **source, **destination, **dest_path;
+	const char **source, **destination, **dest_path, **submodule_gitfile;
 	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
@@ -85,6 +86,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	source = internal_copy_pathspec(prefix, argv, argc, 0);
 	modes = xcalloc(argc, sizeof(enum update_mode));
 	dest_path = internal_copy_pathspec(prefix, argv + argc, 1, 0);
+	submodule_gitfile = xcalloc(argc, sizeof(char *));

 	if (dest_path[0][0] == '\0')
 		/* special case: "." was normalized to "" */
@@ -120,8 +122,14 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
@@ -216,9 +224,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
index 3f0a3f9..d96d187 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1004,3 +1004,34 @@ int merge_submodule(unsigned char result[20], const char *path,
 	free(merges.objects);
 	return 0;
 }
+
+/* Update gitfile and core.worktree setting to connect work tree and git dir */
+void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
+{
+	struct strbuf file_name = STRBUF_INIT;
+	struct strbuf rel_path = STRBUF_INIT;
+	const char *real_work_tree = xstrdup(real_path(work_tree));
+	FILE *fp;
+
+	/* Update gitfile */
+	strbuf_addf(&file_name, "%s/.git", work_tree);
+	fp = fopen(file_name.buf, "w");
+	if (!fp)
+		die(_("Could not create git link %s"), file_name.buf);
+	fprintf(fp, "gitdir: %s\n", relative_path(git_dir, real_work_tree,
+						  &rel_path));
+	fclose(fp);
+
+	/* Update core.worktree setting */
+	strbuf_reset(&file_name);
+	strbuf_addf(&file_name, "%s/config", git_dir);
+	if (git_config_set_in_file(file_name.buf, "core.worktree",
+				   relative_path(real_work_tree, git_dir,
+						 &rel_path)))
+		die(_("Could not set core.worktree in %s"),
+		    file_name.buf);
+
+	strbuf_release(&file_name);
+	strbuf_release(&rel_path);
+	free((void *)real_work_tree);
+}
diff --git a/submodule.h b/submodule.h
index c7ffc7c..29e9658 100644
--- a/submodule.h
+++ b/submodule.h
@@ -36,5 +36,6 @@ int merge_submodule(unsigned char result[20], const char *path, const unsigned c
 int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
 		struct string_list *needs_pushing);
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
+void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);

 #endif
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 15c18b6..b99177f 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -293,4 +293,23 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
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
1.8.4.rc0.199.g7079aac
