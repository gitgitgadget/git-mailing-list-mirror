From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH 2/2] rm: remove submodules from the index and the .gitmodules
 file
Date: Wed, 04 Jul 2012 22:44:48 +0200
Message-ID: <4FF4AB40.7000809@web.de>
References: <4FF4AAE7.40604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 22:45:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmWRe-0000Ds-Aw
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 22:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242Ab2GDUpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 16:45:00 -0400
Received: from mout.web.de ([212.227.17.12]:55808 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755651Ab2GDUpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 16:45:00 -0400
Received: from [192.168.178.48] ([91.3.155.233]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0Lvjoa-1RjXKv0oc0-01813Z; Wed, 04 Jul 2012 22:44:49
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <4FF4AAE7.40604@web.de>
X-Provags-ID: V02:K0:rLIcWsqK9x5ksu2GLfQtun6KMlqNGgmmPz39J38rEx4
 cEMJt8ZNSEhJliBPsS4mmBOwOaIZEwkFKerpb3KQGNylNWjp2V
 Z9DWbWw5LY5RiiVC2hbFdQ61Yc2cg+OQviWyD/SwvytnKhyRY7
 lOQL3XLek/0/jXrlgzZLpxio46V2i6RcCWcMMCsSKbspDOfeD0
 iqP3tfpCbBpyrXm3GCkOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201017>

Currently using "git rm" on a submodule only removes the gitlink from the
index but leaves the submodule's section in .gitmodules untouched.

It should help the user by not only removing the gitlink from the index
but by also removing the "submodule.<submodule name>" section from the
.gitmodules file and stage both.

Change "git rm" so it removes the submodule section from .gitmodules and
only issues a warning if it cannot be removed, as the user might have done
that himself.

In t7610 three uses of "git rm submod" had to be replaced with
"git update-index --remove submod" because that test expects .gitmodules
to stay untouched.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 builtin/rm.c         |  8 +++++++-
 submodule.c          | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h          |  2 ++
 t/t3600-rm.sh        | 25 ++++++++++++++++++------
 t/t7610-mergetool.sh |  6 +++---
 5 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 1c73dcf..7190dc9 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "tree-walk.h"
 #include "parse-options.h"
+#include "submodule.h"

 static const char * const builtin_rm_usage[] = {
 	"git rm [options] [--] <file>...",
@@ -149,6 +150,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	const char **pathspec;
 	char *seen;

+	gitmodules_config();
 	git_config(git_default_config, NULL);

 	argc = parse_options(argc, argv, prefix, builtin_rm_options,
@@ -246,7 +248,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 * in the middle)
 	 */
 	if (!index_only) {
-		int removed = 0;
+		int removed = 0, gitmodules_modified = 0;
 		for (i = 0; i < list.nr; i++) {
 			const char *path = list.entry[i].name;
 			if (!list.entry[i].is_submodule) {
@@ -258,8 +260,12 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 					die_errno("git rm: '%s'", path);
 			} else {
 				rmdir_or_warn(path);
+				if (!remove_path_from_gitmodules(path))
+					gitmodules_modified = 1;
 			}
 		}
+		if (gitmodules_modified)
+			stage_updated_gitmodules();
 	}

 	if (active_cache_changed) {
diff --git a/submodule.c b/submodule.c
index 959d349..f7e4b14 100644
--- a/submodule.c
+++ b/submodule.c
@@ -10,6 +10,7 @@
 #include "string-list.h"
 #include "sha1-array.h"
 #include "argv-array.h"
+#include "blob.h"

 static struct string_list config_name_for_path;
 static struct string_list config_fetch_recurse_submodules_for_name;
@@ -30,6 +31,60 @@ static struct sha1_array ref_tips_after_fetch;
  */
 static int gitmodules_is_unmerged;

+/*
+ * Try to remove the "submodule.<name>" section from .gitmodules where the
+ * given path is configured.
+ */
+int remove_path_from_gitmodules(const char *path)
+{
+	struct strbuf sect = STRBUF_INIT;
+	struct string_list_item *path_option;
+
+	path_option = unsorted_string_list_lookup(&config_name_for_path, path);
+	if (!path_option) {
+		warning("Could not find section in .gitmodules where path=%s", path);
+		return -1;
+	}
+	strbuf_addstr(&sect, "submodule.");
+	strbuf_addstr(&sect, path_option->util);
+	if (git_config_rename_section_in_file(".gitmodules", sect.buf, NULL) < 0) {
+		/* Maybe the user already did that, don't error out here */
+		warning("Could not remove .gitmodules entry for %s", path);
+		return -1;
+	}
+	strbuf_release(&sect);
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
+	if (strbuf_read_file(&buf, ".gitmodules", 0))
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
index e105b0e..1bfc2c6 100644
--- a/submodule.h
+++ b/submodule.h
@@ -10,6 +10,8 @@ enum {
 	RECURSE_SUBMODULES_ON = 2
 };

+int remove_path_from_gitmodules(const char *path);
+void stage_updated_gitmodules(void);
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 2af8bb9..4a6475f 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -263,10 +263,11 @@ test_expect_success 'rm removes subdirectories recursively' '
 '

 cat >expect <<EOF
+M  .gitmodules
 D  submod
 EOF

-test_expect_success 'rm removes empty submodules from work tree' '
+test_expect_success 'rm removes empty submodules from work tree and .gitmodules' '
 	mkdir submod &&
 	git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) submod &&
 	git config -f .gitmodules submodule.sub.url ./. &&
@@ -277,17 +278,21 @@ test_expect_success 'rm removes empty submodules from work tree' '
 	git rm submod &&
 	test ! -e submod &&
 	git status -s -uno > actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_fail git config -f .gitmodules submodule.sub.url &&
+	test_must_fail git config -f .gitmodules submodule.sub.path
 '

-test_expect_success 'rm leaves work tree of populated submodules alone' '
+test_expect_success 'rm leaves work tree of populated submodules alone but updates .gitmodules' '
 	git reset --hard &&
 	git submodule update &&
 	git rm submod &&
 	test -d submod &&
 	test -f submod/.git &&
 	git status -s -uno > actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_fail git config -f .gitmodules submodule.sub.url &&
+	test_must_fail git config -f .gitmodules submodule.sub.path
 '

 test_expect_success 'rm of a populated submodule with different HEAD requires forcing' '
@@ -298,12 +303,16 @@ test_expect_success 'rm of a populated submodule with different HEAD requires fo
 	) &&
 	test_must_fail git rm submod &&
 	git status -s -uno > actual &&
+	git config -f .gitmodules submodule.sub.url &&
+	git config -f .gitmodules submodule.sub.path &&
 	git rm --force submod &&
 	test -s actual &&
 	test -d submod &&
 	test -f submod/.git &&
 	git status -s -uno > actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_fail git config -f .gitmodules submodule.sub.url &&
+	test_must_fail git config -f .gitmodules submodule.sub.path
 '

 test_expect_success 'rm of a populated submodule with modifications succeeds' '
@@ -316,7 +325,9 @@ test_expect_success 'rm of a populated submodule with modifications succeeds' '
 	test -d submod &&
 	test -f submod/.git &&
 	git status -s -uno > actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_fail git config -f .gitmodules submodule.sub.url &&
+	test_must_fail git config -f .gitmodules submodule.sub.path
 '

 test_expect_success 'rm of a populated submodule with untracked files succeeds' '
@@ -330,6 +341,8 @@ test_expect_success 'rm of a populated submodule with untracked files succeeds'
 	test -f submod/.git &&
 	git status -s -uno > actual &&
 	test_cmp expect actual &&
+	test_must_fail git config -f .gitmodules submodule.sub.url &&
+	test_must_fail git config -f .gitmodules submodule.sub.path &&
 	rm submod/untracked
 '

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index f5e16fc..3261588 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -215,7 +215,7 @@ test_expect_success 'deleted vs modified submodule' '
     git checkout -b test6 branch1 &&
     git submodule update -N &&
     mv submod submod-movedaside &&
-    git rm submod &&
+    git update-index --remove submod &&
     git commit -m "Submodule deleted from branch" &&
     git checkout -b test6.a test6 &&
     test_must_fail git merge master &&
@@ -284,7 +284,7 @@ test_expect_success 'file vs modified submodule' '
     git checkout -b test7 branch1 &&
     git submodule update -N &&
     mv submod submod-movedaside &&
-    git rm submod &&
+    git update-index --remove submod &&
     echo not a submodule >submod &&
     git add submod &&
     git commit -m "Submodule path becomes file" &&
@@ -415,7 +415,7 @@ test_expect_success 'submodule in subdirectory' '
 test_expect_success 'directory vs modified submodule' '
     git checkout -b test11 branch1 &&
     mv submod submod-movedaside &&
-    git rm submod &&
+    git update-index --remove submod &&
     mkdir submod &&
     echo not a submodule >submod/file16 &&
     git add submod/file16 &&
-- 
1.7.11.1.105.g9f6831b
