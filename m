From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 1/2] Submodules: Add the new "ignore" config option for
 diff and status
Date: Fri, 06 Aug 2010 00:39:25 +0200
Message-ID: <4C5B3D9D.60806@web.de>
References: <4C4DD33F.4020104@web.de> <4C4DD3CF.9070906@web.de> <7vhbjjware.fsf@alter.siamese.dyndns.org> <4C5B3D36.1060902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 00:40:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh96c-000639-VQ
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 00:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934699Ab0HEWjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 18:39:33 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:42403 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934693Ab0HEWj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 18:39:27 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 246A215CFC610;
	Fri,  6 Aug 2010 00:39:26 +0200 (CEST)
Received: from [80.128.118.249] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Oh95x-0005b1-00; Fri, 06 Aug 2010 00:39:25 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <4C5B3D36.1060902@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19pUj+NsJ130+ExrV/voDrCy/PJ7lnzlDnnFo5f
	+ZAChxBeNSq9InCok+8BFWGjtpw3WMCENhNgfkFPThr3fJZ+oh
	MJA5qc0W+F7ieELcZfNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152732>

The new "ignore" config option controls the default behavior for "git
status" and the diff family. It specifies under what circumstances they
consider submodules as modified and can be set separately for each
submodule.

The command line option "--ignore-submodules=" has been extended to accept
the new parameter "none" for both status and diff.

Users that chose submodules to get rid of long work tree scanning times
might want to set the "dirty" option for those submodules. This brings
back the pre 1.7.0 behavior, where submodule work trees were never
scanned for modifications. By using "--ignore-submodules=none" on the
command line the status and diff commands can be told to do a full scan.

This option can be set to the following values (which have the same name
and meaning as for the "--ignore-submodules" option of status and diff):

"all": All changes to the submodule will be ignored.

"dirty": Only differences of the commit recorded in the superproject and
	the submodules HEAD will be considered modifications, all changes
	to the work tree of the submodule will be ignored. When using this
	value, the submodule will not be scanned for work tree changes at
	all, leading to a performance benefit on large submodules.

"untracked": Only untracked files in the submodules work tree are ignored,
	a changed HEAD and/or modified files in the submodule will mark it
	as modified.

"none" (which is the default): Either untracked or modified files in a
	submodules work tree or a difference between the subdmodules HEAD
	and the commit recorded in the superproject will make it show up
	as changed. This value is added as a new parameter for the
	"--ignore-submodules" option of the diff family and "git status"
	so the user can override the settings in the configuration.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/config.txt       |   10 ++++
 Documentation/diff-options.txt |    6 ++-
 Documentation/git-status.txt   |    6 ++-
 diff-lib.c                     |   15 ++++--
 diff.c                         |   35 ++++++++++++--
 diff.h                         |    1 +
 submodule.c                    |   57 ++++++++++++++++++++++-
 submodule.h                    |    3 +
 t/t4027-diff-submodule.sh      |   76 ++++++++++++++++++++++++++++++
 t/t7508-status.sh              |  100 ++++++++++++++++++++++++++++++++++++++--
 wt-status.c                    |    8 ++-
 11 files changed, 297 insertions(+), 20 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f81fb91..06faa02 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1747,6 +1747,16 @@ submodule.<name>.update::
 	URL and other values found in the `.gitmodules` file.  See
 	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.

+submodule.<name>.ignore::
+	Defines under what circumstances "git status" and the diff family show
+	a submodule as modified. When set to "all", it will never be considered
+	modified, "dirty" will ignore all changes to the submodules work tree and
+	takes only differences between the HEAD of the submodule and the commit
+	recorded in the superproject into account. "untracked" will additionally
+	let submodules with modified tracked files in their work tree show up.
+	Using "none" (the default when this option is not set) also shows
+	submodules that have untracked files in their work tree as changed.
+
 tar.umask::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 2371262..9cf7506 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -330,7 +330,11 @@ endif::git-format-patch[]

 --ignore-submodules[=<when>]::
 	Ignore changes to submodules in the diff generation. <when> can be
-	either "untracked", "dirty" or "all", which is the default. When
+	either "none", "untracked", "dirty" or "all", which is the default
+	Using "none" will consider the submodule modified when it either contains
+	untracked or modified files or its HEAD differs from the commit recorded
+	in the superproject and can be used to override any settings of the
+	'ignore' option in linkgit:git-config[1]. When
 	"untracked" is used submodules are not considered dirty when they only
 	contain untracked content (but they are still scanned for modified
 	content). Using "dirty" ignores all changes to the work tree of submodules,
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 2fd054c..a7a5d79 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -55,7 +55,11 @@ specified.

 --ignore-submodules[=<when>]::
 	Ignore changes to submodules when looking for changes. <when> can be
-	either "untracked", "dirty" or "all", which is the default. When
+	either "none", "untracked", "dirty" or "all", which is the default.
+	Using "none" will consider the submodule modified when it either contains
+	untracked or modified files or its HEAD differs from the commit recorded
+	in the superproject and can be used to override any settings of the
+	'ignore' option in linkgit:git-config[1]. When
 	"untracked" is used submodules are not considered dirty when they only
 	contain untracked content (but they are still scanned for modified
 	content). Using "dirty" ignores all changes to the work tree of submodules,
diff --git a/diff-lib.c b/diff-lib.c
index 8b8978a..392ce2b 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -68,11 +68,16 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 				      unsigned ce_option, unsigned *dirty_submodule)
 {
 	int changed = ce_match_stat(ce, st, ce_option);
-	if (S_ISGITLINK(ce->ce_mode)
-	    && !DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES)
-	    && !DIFF_OPT_TST(diffopt, IGNORE_DIRTY_SUBMODULES)
-	    && (!changed || DIFF_OPT_TST(diffopt, DIRTY_SUBMODULES))) {
-		*dirty_submodule = is_submodule_modified(ce->name, DIFF_OPT_TST(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES));
+	if (S_ISGITLINK(ce->ce_mode)) {
+		unsigned orig_flags = diffopt->flags;
+		if (!DIFF_OPT_TST(diffopt, OVERRIDE_SUBMODULE_CONFIG))
+			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
+		if (DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES))
+			changed = 0;
+		else if (!DIFF_OPT_TST(diffopt, IGNORE_DIRTY_SUBMODULES)
+		    && (!changed || DIFF_OPT_TST(diffopt, DIRTY_SUBMODULES)))
+			*dirty_submodule = is_submodule_modified(ce->name, DIFF_OPT_TST(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES));
+		diffopt->flags = orig_flags;
 	}
 	return changed;
 }
diff --git a/diff.c b/diff.c
index 782896d..bf6b9b1 100644
--- a/diff.c
+++ b/diff.c
@@ -141,6 +141,9 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}

+	if (!prefixcmp(var, "submodule."))
+		return parse_submodule_config_option(var, value);
+
 	return git_color_default_config(var, value, cb);
 }

@@ -3165,11 +3168,13 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, ALLOW_TEXTCONV);
 	else if (!strcmp(arg, "--no-textconv"))
 		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
-	else if (!strcmp(arg, "--ignore-submodules"))
+	else if (!strcmp(arg, "--ignore-submodules")) {
+		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(options, "all");
-	else if (!prefixcmp(arg, "--ignore-submodules="))
+	} else if (!prefixcmp(arg, "--ignore-submodules=")) {
+		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(options, arg + 20);
-	else if (!strcmp(arg, "--submodule"))
+	} else if (!strcmp(arg, "--submodule"))
 		DIFF_OPT_SET(options, SUBMODULE_LOG);
 	else if (!prefixcmp(arg, "--submodule=")) {
 		if (!strcmp(arg + 12, "log"))
@@ -4102,6 +4107,24 @@ int diff_result_code(struct diff_options *opt, int status)
 	return result;
 }

+/*
+ * Shall changes to this submodule be ignored?
+ *
+ * Submodule changes can be configured to be ignored separately for each path,
+ * but that configuration can be overridden from the command line.
+ */
+static int is_submodule_ignored(const char *path, struct diff_options *options)
+{
+	int ignored = 0;
+	unsigned orig_flags = options->flags;
+	if (!DIFF_OPT_TST(options, OVERRIDE_SUBMODULE_CONFIG))
+		set_diffopt_flags_from_submodule_config(options, path);
+	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES))
+		ignored = 1;
+	options->flags = orig_flags;
+	return ignored;
+}
+
 void diff_addremove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
@@ -4109,7 +4132,7 @@ void diff_addremove(struct diff_options *options,
 {
 	struct diff_filespec *one, *two;

-	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES) && S_ISGITLINK(mode))
+	if (S_ISGITLINK(mode) && is_submodule_ignored(concatpath, options))
 		return;

 	/* This may look odd, but it is a preparation for
@@ -4156,8 +4179,8 @@ void diff_change(struct diff_options *options,
 {
 	struct diff_filespec *one, *two;

-	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES) && S_ISGITLINK(old_mode)
-			&& S_ISGITLINK(new_mode))
+	if (S_ISGITLINK(old_mode) && S_ISGITLINK(new_mode) &&
+	    is_submodule_ignored(concatpath, options))
 		return;

 	if (DIFF_OPT_TST(options, REVERSE_DIFF)) {
diff --git a/diff.h b/diff.h
index 063d10a..53ad345 100644
--- a/diff.h
+++ b/diff.h
@@ -77,6 +77,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
 #define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
 #define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
+#define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)

 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
diff --git a/submodule.c b/submodule.c
index 61cb6e2..ff28630 100644
--- a/submodule.c
+++ b/submodule.c
@@ -6,6 +6,10 @@
 #include "revision.h"
 #include "run-command.h"
 #include "diffcore.h"
+#include "string-list.h"
+
+struct string_list config_name_for_path;
+struct string_list config_ignore_for_name;

 static int add_submodule_odb(const char *path)
 {
@@ -46,6 +50,57 @@ done:
 	return ret;
 }

+void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
+					     const char *path)
+{
+	struct string_list_item *path_option, *ignore_option;
+	path_option = unsorted_string_list_lookup(&config_name_for_path, path);
+	if (path_option) {
+		ignore_option = unsorted_string_list_lookup(&config_ignore_for_name, path_option->util);
+		if (ignore_option)
+			handle_ignore_submodules_arg(diffopt, ignore_option->util);
+	}
+}
+
+int parse_submodule_config_option(const char *var, const char *value)
+{
+	int len;
+	struct string_list_item *config;
+	struct strbuf submodname = STRBUF_INIT;
+
+	var += 10;		/* Skip "submodule." */
+
+	len = strlen(var);
+	if ((len > 5) && !strcmp(var + len - 5, ".path")) {
+		strbuf_add(&submodname, var, len - 5);
+		config = unsorted_string_list_lookup(&config_name_for_path, value);
+		if (config)
+			free(config->util);
+		else
+			config = string_list_append(&config_name_for_path, xstrdup(value));
+		config->util = strbuf_detach(&submodname, NULL);
+		strbuf_release(&submodname);
+	} else if ((len > 7) && !strcmp(var + len - 7, ".ignore")) {
+		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
+		    strcmp(value, "all") && strcmp(value, "none")) {
+			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);
+			return 0;
+		}
+
+		strbuf_add(&submodname, var, len - 7);
+		config = unsorted_string_list_lookup(&config_ignore_for_name, submodname.buf);
+		if (config)
+			free(config->util);
+		else
+			config = string_list_append(&config_ignore_for_name,
+						    strbuf_detach(&submodname, NULL));
+		strbuf_release(&submodname);
+		config->util = xstrdup(value);
+		return 0;
+	}
+	return 0;
+}
+
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
@@ -55,7 +110,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 		DIFF_OPT_SET(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	else if (!strcmp(arg, "dirty"))
 		DIFF_OPT_SET(diffopt, IGNORE_DIRTY_SUBMODULES);
-	else
+	else if (strcmp(arg, "none"))
 		die("bad --ignore-submodules argument: %s", arg);
 }

diff --git a/submodule.h b/submodule.h
index 6fd3bb4..185a5ce 100644
--- a/submodule.h
+++ b/submodule.h
@@ -3,6 +3,9 @@

 struct diff_options;

+void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
+		const char *path);
+int parse_submodule_config_option(const char *var, const char *value);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 1bd8e5e..6836728 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -114,6 +114,31 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
 	! test -s actual4
 '

+test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.git/config]' '
+	git config submodule.subname.ignore none &&
+	git config submodule.subname.path sub &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual.body &&
+	git config submodule.subname.ignore all &&
+	git diff HEAD >actual2 &&
+	! test -s actual2 &&
+	git config submodule.subname.ignore untracked &&
+	git diff HEAD >actual3 &&
+	sed -e "1,/^@@/d" actual3 >actual3.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual3.body &&
+	git config submodule.subname.ignore dirty &&
+	git diff HEAD >actual4 &&
+	! test -s actual4 &&
+	git diff HEAD --ignore-submodules=none >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual.body &&
+	git config --remove-section submodule.subname
+'
+
 test_expect_success 'git diff HEAD with dirty submodule (index, refs match)' '
 	(
 		cd sub &&
@@ -146,6 +171,57 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 	! test -s actual4
 '

+test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.git/config]' '
+	git config submodule.subname.ignore all &&
+	git config submodule.subname.path sub &&
+	git diff HEAD >actual2 &&
+	! test -s actual2 &&
+	git config submodule.subname.ignore untracked &&
+	git diff HEAD >actual3 &&
+	! test -s actual3 &&
+	git config submodule.subname.ignore dirty &&
+	git diff HEAD >actual4 &&
+	! test -s actual4 &&
+	git diff --ignore-submodules=none HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual.body &&
+	git config --remove-section submodule.subname
+'
+
+test_expect_success 'git diff between submodule commits' '
+	git diff HEAD^..HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body &&
+	git diff --ignore-submodules=dirty HEAD^..HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body &&
+	git diff --ignore-submodules HEAD^..HEAD >actual &&
+	! test -s actual
+'
+
+test_expect_success 'git diff between submodule commits [.git/config]' '
+	git diff HEAD^..HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body &&
+	git config submodule.subname.ignore dirty &&
+	git config submodule.subname.path sub &&
+	git diff HEAD^..HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body &&
+	git config submodule.subname.ignore all &&
+	git diff HEAD^..HEAD >actual &&
+	! test -s actual &&
+	git diff --ignore-submodules=dirty HEAD^..HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	git config --remove-section submodule.subname
+'
+
 test_expect_success 'git diff (empty submodule dir)' '
 	: >empty &&
 	rm -rf sub/* sub/.git &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a72fe3a..57bf2ee 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -808,24 +808,38 @@ test_expect_success POSIXPERM 'status succeeds in a read-only repository' '
 	(exit $status)
 '

+(cd sm && echo > bar && git add bar && git commit -q -m 'Add bar' && cd .. && git add sm)
+new_head=$(cd sm && git rev-parse --short=7 --verify HEAD)
+touch .gitmodules
+
 cat > expect << EOF
 # On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	modified:   sm
+#
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
 #	modified:   dir1/modified
 #
+# Submodule changes to be committed:
+#
+# * sm $head...$new_head (1):
+#   > Add bar
+#
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
 #
+#	.gitmodules
 #	dir1/untracked
 #	dir2/modified
 #	dir2/untracked
 #	expect
 #	output
 #	untracked
-no changes added to commit (use "git add" and/or "git commit -a")
 EOF

 test_expect_success '--ignore-submodules=untracked suppresses submodules with untracked content' '
@@ -834,19 +848,48 @@ test_expect_success '--ignore-submodules=untracked suppresses submodules with un
 	test_cmp expect output
 '

+test_expect_success '.git/config ignore=untracked suppresses submodules with untracked content' '
+	git config --add submodule.subname.ignore untracked &&
+	git config --add submodule.subname.path sm &&
+	git status > output &&
+	test_cmp expect output &&
+	git config --remove-section submodule.subname
+'
+
 test_expect_success '--ignore-submodules=dirty suppresses submodules with untracked content' '
 	git status --ignore-submodules=dirty > output &&
 	test_cmp expect output
 '

+test_expect_success '.git/config ignore=dirty suppresses submodules with untracked content' '
+	git config --add submodule.subname.ignore dirty &&
+	git config --add submodule.subname.path sm &&
+	git status > output &&
+	test_cmp expect output &&
+	git config --remove-section submodule.subname
+'
+
 test_expect_success '--ignore-submodules=dirty suppresses submodules with modified content' '
 	echo modified > sm/foo &&
 	git status --ignore-submodules=dirty > output &&
 	test_cmp expect output
 '

+test_expect_success '.git/config ignore=dirty suppresses submodules with modified content' '
+	git config --add submodule.subname.ignore dirty &&
+	git config --add submodule.subname.path sm &&
+	git status > output &&
+	test_cmp expect output &&
+	git config --remove-section submodule.subname
+'
+
 cat > expect << EOF
 # On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	modified:   sm
+#
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
@@ -855,16 +898,21 @@ cat > expect << EOF
 #	modified:   dir1/modified
 #	modified:   sm (modified content)
 #
+# Submodule changes to be committed:
+#
+# * sm $head...$new_head (1):
+#   > Add bar
+#
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
 #
+#	.gitmodules
 #	dir1/untracked
 #	dir2/modified
 #	dir2/untracked
 #	expect
 #	output
 #	untracked
-no changes added to commit (use "git add" and/or "git commit -a")
 EOF

 test_expect_success "--ignore-submodules=untracked doesn't suppress submodules with modified content" '
@@ -872,10 +920,23 @@ test_expect_success "--ignore-submodules=untracked doesn't suppress submodules w
 	test_cmp expect output
 '

+test_expect_success ".git/config ignore=untracked doesn't suppress submodules with modified content" '
+	git config --add submodule.subname.ignore untracked &&
+	git config --add submodule.subname.path sm &&
+	git status > output &&
+	test_cmp expect output &&
+	git config --remove-section submodule.subname
+'
+
 head2=$(cd sm && git commit -q -m "2nd commit" foo && git rev-parse --short=7 --verify HEAD)

 cat > expect << EOF
 # On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	modified:   sm
+#
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
@@ -883,21 +944,26 @@ cat > expect << EOF
 #	modified:   dir1/modified
 #	modified:   sm (new commits)
 #
+# Submodule changes to be committed:
+#
+# * sm $head...$new_head (1):
+#   > Add bar
+#
 # Submodules changed but not updated:
 #
-# * sm $head...$head2 (1):
+# * sm $new_head...$head2 (1):
 #   > 2nd commit
 #
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
 #
+#	.gitmodules
 #	dir1/untracked
 #	dir2/modified
 #	dir2/untracked
 #	expect
 #	output
 #	untracked
-no changes added to commit (use "git add" and/or "git commit -a")
 EOF

 test_expect_success "--ignore-submodules=untracked doesn't suppress submodule summary" '
@@ -905,11 +971,28 @@ test_expect_success "--ignore-submodules=untracked doesn't suppress submodule su
 	test_cmp expect output
 '

+test_expect_success ".git/config ignore=untracked doesn't suppress submodule summary" '
+	git config --add submodule.subname.ignore untracked &&
+	git config --add submodule.subname.path sm &&
+	git status > output &&
+	test_cmp expect output &&
+	git config --remove-section submodule.subname
+'
+
 test_expect_success "--ignore-submodules=dirty doesn't suppress submodule summary" '
 	git status --ignore-submodules=dirty > output &&
 	test_cmp expect output
 '

+test_expect_success ".git/config ignore=dirty doesn't suppress submodule summary" '
+	git config --add submodule.subname.ignore dirty &&
+	git config --add submodule.subname.path sm &&
+	git status > output &&
+	test_cmp expect output &&
+	git config --remove-section submodule.subname
+'
+
+
 cat > expect << EOF
 # On branch master
 # Changed but not updated:
@@ -921,6 +1004,7 @@ cat > expect << EOF
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
 #
+#	.gitmodules
 #	dir1/untracked
 #	dir2/modified
 #	dir2/untracked
@@ -935,4 +1019,12 @@ test_expect_success "--ignore-submodules=all suppresses submodule summary" '
 	test_cmp expect output
 '

+test_expect_failure '.git/config ignore=all suppresses submodule summary' '
+	git config --add submodule.subname.ignore all &&
+	git config --add submodule.subname.path sm &&
+	git status > output &&
+	test_cmp expect output &&
+	git config --remove-section submodule.subname
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 2f9e33c..54b6b03 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -313,8 +313,10 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
 	if (!s->show_untracked_files)
 		DIFF_OPT_SET(&rev.diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
-	if (s->ignore_submodule_arg)
+	if (s->ignore_submodule_arg) {
+		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
+    }
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.prune_data = s->pathspec;
@@ -331,8 +333,10 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);

-	if (s->ignore_submodule_arg)
+	if (s->ignore_submodule_arg) {
+		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
+	}

 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_collect_updated_cb;
-- 
1.7.2.1.54.g6bed1
