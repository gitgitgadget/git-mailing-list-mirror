From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH/RFC 3/3] Teach mv to update the path entry in .gitmodules
 for moved submodules
Date: Wed, 03 Apr 2013 21:57:46 +0200
Message-ID: <515C89BA.9020806@web.de>
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
X-From: git-owner@vger.kernel.org Wed Apr 03 21:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNTpT-00053b-I9
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 21:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380Ab3DCT6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 15:58:14 -0400
Received: from mout.web.de ([212.227.15.3]:61720 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932325Ab3DCT6M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 15:58:12 -0400
Received: from [192.168.178.41] ([79.193.80.178]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LsQ9o-1UldQZ0RhI-012DWO; Wed, 03 Apr 2013 21:57:47
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <515C88FE.9020203@web.de>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:e8CV63BiiTuXx5Xt6EybxDFmYc5pH9JfAvrAo5rj27h
 BeQ6nSqCcP1laPy5Eqn+HnVe2LH0v7CYyfSfmy65LJH4TAS7Va
 9OEu58pyS/FPV7TBD3gYAnQcAOV8wcIo+BIYICRU/vliHMBCnD
 WDbJiWums2cZ8CiblU+lYtM17jFx38YFrN2/AKLMJxmocSw5KU
 Y06Gi/J7q87wuaNI6Wd1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219965>

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

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 builtin/mv.c  |  8 +++++++-
 submodule.c   | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h   |  2 ++
 t/t7001-mv.sh | 41 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 609bbb8..36e5605 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -57,7 +57,7 @@ static struct lock_file lock_file;

 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
-	int i, newfd;
+	int i, newfd, gitmodules_modified = 0;
 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
 	struct option builtin_mv_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -71,6 +71,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;

+	gitmodules_config();
 	git_config(git_default_config, NULL);

 	argc = parse_options(argc, argv, prefix, builtin_mv_options,
@@ -228,6 +229,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				die_errno (_("renaming '%s' failed"), src);
 			if (submodule_gitfile[i])
 				connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
+			if (!update_path_in_gitmodules(src, dst))
+				gitmodules_modified = 1;
 		}

 		if (mode == WORKING_DIRECTORY)
@@ -239,6 +242,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			rename_cache_entry_at(pos, dst);
 	}

+	if (gitmodules_modified)
+		stage_updated_gitmodules();
+
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(&lock_file))
diff --git a/submodule.c b/submodule.c
index eba9b42..fb742b4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -10,6 +10,7 @@
 #include "string-list.h"
 #include "sha1-array.h"
 #include "argv-array.h"
+#include "blob.h"

 static struct string_list config_name_for_path;
 static struct string_list config_fetch_recurse_submodules_for_name;
@@ -30,6 +31,67 @@ static struct sha1_array ref_tips_after_fetch;
  */
 static int gitmodules_is_unmerged;

+/*
+ * Try to update the "path" entry in the "submodule.<name>" section of the
+ * .gitmodules file.
+ */
+int update_path_in_gitmodules(const char *oldpath, const char *newpath)
+{
+	struct strbuf entry = STRBUF_INIT;
+	struct string_list_item *path_option;
+
+	if (!file_exists(".gitmodules")) /* Do nothing whithout .gitmodules */
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
+void stage_updated_gitmodules(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct stat st;
+	int pos;
+	struct cache_entry *ce;
+	int namelen = strlen(".gitmodules");
+
+	pos = cache_name_pos(".gitmodules", strlen(".gitmodules"));
+	if (pos < 0) {
+		warning(_("could not find .gitmodules in index"));
+		return;
+	}
+	ce = active_cache[pos];
+	ce->ce_flags = namelen;
+	if (strbuf_read_file(&buf, ".gitmodules", 0) < 0)
+		die(_("reading updated .gitmodules failed"));
+	if (lstat(".gitmodules", &st) < 0)
+		die_errno(_("unable to stat updated .gitmodules"));
+	fill_stat_cache_info(ce, &st);
+	ce->ce_mode = ce_mode_from_stat(ce, st.st_mode);
+	if (remove_file_from_cache(".gitmodules") < 0)
+		die(_("unable to remove .gitmodules from index"));
+	if (write_sha1_file(buf.buf, buf.len, blob_type, ce->sha1))
+		die(_("adding updated .gitmodules failed"));
+	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
+		die(_("staging updated .gitmodules failed"));
+}
+
 static int add_submodule_odb(const char *path)
 {
 	struct strbuf objects_directory = STRBUF_INIT;
diff --git a/submodule.h b/submodule.h
index 0c27c53..39c0321 100644
--- a/submodule.h
+++ b/submodule.h
@@ -11,6 +11,8 @@ enum {
 	RECURSE_SUBMODULES_ON = 2
 };

+int update_path_in_gitmodules(const char *oldpath, const char *newpath);
+void stage_updated_gitmodules(void);
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index d824464..c144d21 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -304,6 +304,47 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 		cd mod/sub &&
 		git status
 	) &&
+	echo mod/sub >expected &&
+	git config -f .gitmodules submodule.sub.path >actual &&
+	test_cmp expected actual &&
+	git update-index --refresh &&
+	git diff-files --quiet
+'
+
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
 	git update-index --refresh &&
 	git diff-files --quiet
 '
-- 
1.8.2.377.g1bdb7d0
