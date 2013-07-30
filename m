From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 4/5] Teach mv to update the path entry in .gitmodules for
 moved submodules
Date: Tue, 30 Jul 2013 21:51:05 +0200
Message-ID: <51F81929.1030706@web.de>
References: <51F8187F.7040603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 30 21:51:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Fww-00087Q-65
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 21:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab3G3TvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 15:51:10 -0400
Received: from mout.web.de ([212.227.17.12]:64264 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756231Ab3G3TvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 15:51:08 -0400
Received: from [192.168.178.41] ([79.193.94.161]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0LqoAk-1URKdH38R0-00eOcC for <git@vger.kernel.org>;
 Tue, 30 Jul 2013 21:51:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51F8187F.7040603@web.de>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:35R4t7zRm76vSFXcvsXUZQONfj81OJUZzSj27TpVNi5NGgqV7EX
 XmrOs/Qwd/rx9q5x0vXhwQDdIfJ4x9oGbaPqkwfMUDX0adyOiSqhcjtWFtXTk2u1iyZY2Eh
 9IK7nH8VSE+Eb0dltz/1ggkud4bu+N9TBQocj+ByGac/yksESJI/u6oPkBcmEGwLbvmEwxs
 rSfoX9HRaVvhtSbuYVT8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231386>

Currently using "git mv" on a submodule moves the submodule's work tree in
that of the superproject. But the submodule's path setting in .gitmodules
is left untouched, which is now inconsistent with the work tree and makes
git commands that rely on the proper path -> name mapping (like status and
diff) behave strangely.

Let "git mv" help here by not only moving the submodule's work tree but
also updating the "submodule.<submodule name>.path" setting from the
.gitmodules file and stage both. This doesn't happen when no .gitmodules
file is found and only issues a warning when it doesn't have a section for
this submodule. This is because the user might just use plain gitlinks
without the .gitmodules file or has already updated the path setting by
hand before issuing the "git mv" command (in which case the warning
reminds him that mv would have done that for him). Only when .gitmodules
is found and contains merge conflicts the mv command will fail and tell
the user to resolve the conflict before trying again.

Also extend the man page to inform the user about this new feature.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-mv.txt |  2 ++
 builtin/mv.c             | 10 ++++++-
 submodule.c              | 33 +++++++++++++++++++++
 submodule.h              |  1 +
 t/t7001-mv.sh            | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 1f6fce0..b1f7988 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -49,6 +49,8 @@ SUBMODULES
 Moving a submodule using a gitfile (which means they were cloned
 with a Git version 1.7.8 or newer) will update the gitfile and
 core.worktree setting to make the submodule work in the new location.
+It also will attempt to update the submodule.<name>.path setting in
+the linkgit:gitmodules[5] file and stage that file (unless -n is used).

 GIT
 ---
diff --git a/builtin/mv.c b/builtin/mv.c
index 68b7060..7dd6bb4 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -58,7 +58,7 @@ static struct lock_file lock_file;

 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
-	int i, newfd;
+	int i, newfd, gitmodules_modified = 0;
 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
 	struct option builtin_mv_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -72,6 +72,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;

+	gitmodules_config();
 	git_config(git_default_config, NULL);

 	argc = parse_options(argc, argv, prefix, builtin_mv_options,
@@ -125,6 +126,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				struct strbuf submodule_dotgit = STRBUF_INIT;
 				if (!S_ISGITLINK(active_cache[first]->ce_mode))
 					die (_("Huh? Directory %s is in index and no submodule?"), src);
+				if (!is_staging_gitmodules_ok())
+					die (_("Please, stage your changes to .gitmodules or stash them to proceed"));
 				strbuf_addf(&submodule_dotgit, "%s/.git", src);
 				submodule_gitfile[i] = read_gitfile(submodule_dotgit.buf);
 				if (submodule_gitfile[i])
@@ -229,6 +232,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				die_errno (_("renaming '%s' failed"), src);
 			if (submodule_gitfile[i])
 				connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
+			if (!update_path_in_gitmodules(src, dst))
+				gitmodules_modified = 1;
 		}

 		if (mode == WORKING_DIRECTORY)
@@ -240,6 +245,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			rename_cache_entry_at(pos, dst);
 	}

+	if (gitmodules_modified)
+		stage_updated_gitmodules();
+
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(&lock_file))
diff --git a/submodule.c b/submodule.c
index 584f7de..b210685 100644
--- a/submodule.c
+++ b/submodule.c
@@ -47,6 +47,39 @@ int is_staging_gitmodules_ok()
 	return !gitmodules_is_modified;
 }

+/*
+ * Try to update the "path" entry in the "submodule.<name>" section of the
+ * .gitmodules file. Return 0 only if a .gitmodules file was found, a section
+ * with the correct path=<oldpath> setting was found and we could update it.
+ */
+int update_path_in_gitmodules(const char *oldpath, const char *newpath)
+{
+	struct strbuf entry = STRBUF_INIT;
+	struct string_list_item *path_option;
+
+	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
+		return -1;
+
+	if (gitmodules_is_unmerged)
+		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
+
+	path_option = unsorted_string_list_lookup(&config_name_for_path, oldpath);
+	if (!path_option) {
+		warning(_("Could not find section in .gitmodules where path=%s"), oldpath);
+		return -1;
+	}
+	strbuf_addstr(&entry, "submodule.");
+	strbuf_addstr(&entry, path_option->util);
+	strbuf_addstr(&entry, ".path");
+	if (git_config_set_in_file(".gitmodules", entry.buf, newpath) < 0) {
+		/* Maybe the user already did that, don't error out here */
+		warning(_("Could not update .gitmodules entry %s"), entry.buf);
+		return -1;
+	}
+	strbuf_release(&entry);
+	return 0;
+}
+
 void stage_updated_gitmodules(void)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/submodule.h b/submodule.h
index 244d5f5..570d4d0 100644
--- a/submodule.h
+++ b/submodule.h
@@ -12,6 +12,7 @@ enum {
 };

 int is_staging_gitmodules_ok();
+int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 void stage_updated_gitmodules(void);
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index b99177f..d432f42 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -308,8 +308,83 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 		cd mod/sub &&
 		git status
 	) &&
+	echo mod/sub >expected &&
+	git config -f .gitmodules submodule.sub.path >actual &&
+	test_cmp expected actual &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '

+test_expect_success 'mv does not complain when no .gitmodules file is found' '
+	rm -rf mod/sub &&
+	git reset --hard &&
+	git submodule update &&
+	git rm .gitmodules &&
+	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	git mv sub mod/sub 2>actual.err &&
+	! test -s actual.err &&
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
+test_expect_success 'mv will error out on a modified .gitmodules file unless staged' '
+	rm -rf mod/sub &&
+	git reset --hard &&
+	git submodule update &&
+	git config -f .gitmodules foo.bar true &&
+	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	test_must_fail git mv sub mod/sub 2>actual.err &&
+	test -s actual.err &&
+	test -e sub &&
+	git diff-files --quiet -- sub &&
+	git add .gitmodules &&
+	git mv sub mod/sub 2>actual.err &&
+	! test -s actual.err &&
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
+test_expect_success 'mv issues a warning when section is not found in .gitmodules' '
+	rm -rf mod/sub &&
+	git reset --hard &&
+	git submodule update &&
+	git config -f .gitmodules --remove-section submodule.sub &&
+	git add .gitmodules &&
+	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	echo "warning: Could not find section in .gitmodules where path=sub" >expect.err &&
+	git mv sub mod/sub 2>actual.err &&
+	test_i18ncmp expect.err actual.err &&
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
+test_expect_success 'mv --dry-run does not touch the submodule or .gitmodules' '
+	rm -rf mod/sub &&
+	git reset --hard &&
+	git submodule update &&
+	git mv -n sub mod/sub 2>actual.err &&
+	test -f sub/.git &&
+	git diff-index --exit-code HEAD &&
+	git update-index --refresh &&
+	git diff-files --quiet -- sub .gitmodules
+'
+
 test_done
-- 
1.8.4.rc0.199.g7079aac
