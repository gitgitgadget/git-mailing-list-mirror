From: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Subject: [PATCH v4 1/2] rm: better error message on failure for multiple files
Date: Tue, 11 Jun 2013 16:56:00 +0200
Message-ID: <1370962561-12519-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 11 16:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmPzc-0002QW-J4
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 16:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab3FKO4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 10:56:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38434 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529Ab3FKO4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 10:56:09 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5BEu3xg022076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 16:56:03 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5BEu4Kk015928;
	Tue, 11 Jun 2013 16:56:04 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5BEu4tg006382;
	Tue, 11 Jun 2013 16:56:04 +0200
Received: (from lienardm@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r5BEu4nh006381;
	Tue, 11 Jun 2013 16:56:04 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 11 Jun 2013 16:56:03 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227449>

When 'git rm' fails, it now displays a single message
with the list of files involved, instead of displaying
a list of messages with one file each.

As an example, the old message:
	error: 'foo.txt' has changes staged in the index
	(use --cached to keep the file, or -f to force removal)
	error: 'bar.txt' has changes staged in the index
	(use --cached to keep the file, or -f to force removal)

would now be displayed as:
	error: the following files have changes staged in the index:
	    foo.txt
	    bar.txt
	(use --cached to keep the file, or -f to force removal)

Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---

Changes since v3:
 - rename function print_error_files()
 - use of strbuf_release to avoid leaking
 - change of a forgotten message, now using print_error_files() aswell
 - removal of useless braces
 - use of Q_() to deal with plurals correctly
 - removal of spaces after redirection <<
 - use of -\EOF to indent tests better

 builtin/rm.c  |   95 +++++++++++++++++++++++++++++++++++++++++++++-----------
 t/t3600-rm.sh |   67 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+), 19 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 7b91d52..e284db3 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -36,11 +36,32 @@ static int get_ours_cache_pos(const char *path, int pos)
 	return -1;
 }
 
+static void print_error_files(struct string_list *files_list,
+			      const char *main_msg,
+			      const char *hints_msg,
+			      int *errs)
+{
+	if (files_list->nr) {
+		struct strbuf err_msg = STRBUF_INIT;
+		int i;
+		strbuf_addstr(&err_msg, main_msg);
+		for (i = 0; i < files_list->nr; i++)
+			strbuf_addf(&err_msg,
+				    "\n    %s",
+				    files_list->items[i].string);
+		strbuf_addstr(&err_msg, hints_msg);
+		*errs = error("%s", err_msg.buf);
+		strbuf_release(&err_msg);
+	}
+}
+
 static int check_submodules_use_gitfiles(void)
 {
 	int i;
 	int errs = 0;
 
+	struct string_list files = STRING_LIST_INIT_NODUP;
+
 	for (i = 0; i < list.nr; i++) {
 		const char *name = list.entry[i].name;
 		int pos;
@@ -61,11 +82,17 @@ static int check_submodules_use_gitfiles(void)
 			continue;
 
 		if (!submodule_uses_gitfile(name))
-			errs = error(_("submodule '%s' (or one of its nested "
-				     "submodules) uses a .git directory\n"
-				     "(use 'rm -rf' if you really want to remove "
-				     "it including all of its history)"), name);
+			string_list_append(&files, name);
 	}
+	print_error_files(&files,
+			  Q_("the following submodule (or one of its nested "
+			     "submodules)\n uses a .git directory:",
+			     "the following submodules (or one of its nested "
+			     "submodules)\n use a .git directory:",
+			     files.nr),
+			  _("\n(use 'rm -rf' if you really want to remove "
+			    "it including all of its history)"),
+			  &errs);
 
 	return errs;
 }
@@ -82,6 +109,11 @@ static int check_local_mod(unsigned char *head, int index_only)
 	int i, no_head;
 	int errs = 0;
 
+	struct string_list files_staged = STRING_LIST_INIT_NODUP;
+	struct string_list files_cached = STRING_LIST_INIT_NODUP;
+	struct string_list files_submodule = STRING_LIST_INIT_NODUP;
+	struct string_list files_local = STRING_LIST_INIT_NODUP;
+
 	no_head = is_null_sha1(head);
 	for (i = 0; i < list.nr; i++) {
 		struct stat st;
@@ -171,29 +203,54 @@ static int check_local_mod(unsigned char *head, int index_only)
 		 */
 		if (local_changes && staged_changes) {
 			if (!index_only || !(ce->ce_flags & CE_INTENT_TO_ADD))
-				errs = error(_("'%s' has staged content different "
-					     "from both the file and the HEAD\n"
-					     "(use -f to force removal)"), name);
+				string_list_append(&files_staged, name);
 		}
 		else if (!index_only) {
 			if (staged_changes)
-				errs = error(_("'%s' has changes staged in the index\n"
-					     "(use --cached to keep the file, "
-					     "or -f to force removal)"), name);
+				string_list_append(&files_cached, name);
 			if (local_changes) {
 				if (S_ISGITLINK(ce->ce_mode) &&
-				    !submodule_uses_gitfile(name)) {
-					errs = error(_("submodule '%s' (or one of its nested "
-						     "submodules) uses a .git directory\n"
-						     "(use 'rm -rf' if you really want to remove "
-						     "it including all of its history)"), name);
-				} else
-					errs = error(_("'%s' has local modifications\n"
-						     "(use --cached to keep the file, "
-						     "or -f to force removal)"), name);
+				    !submodule_uses_gitfile(name))
+					string_list_append(&files_submodule, name);
+				else
+					string_list_append(&files_local, name);
 			}
 		}
 	}
+	print_error_files(&files_staged,
+			  Q_("the following file has staged content different "
+			     "from both the\nfile and the HEAD:",
+			     "the following files have staged content different"
+			     " from both the\nfile and the HEAD:",
+			     files_staged.nr),
+			  _("\n(use -f to force removal)"),
+			  &errs);
+	print_error_files(&files_cached,
+			  Q_("the following file has changes "
+			     "staged in the index:",
+			     "the following files have changes "
+			     "staged in the index:", files_cached.nr),
+			  _("\n(use --cached to keep the file,"
+			    " or -f to force removal)"),
+			  &errs);
+	print_error_files(&files_submodule,
+			  Q_("the following submodule (or one of its nested "
+			     "submodule)\nuses a .git directory:",
+			     "the following submodules (or one of its nested "
+			     "submodule)\nuse a .git directory:",
+			     files_submodule.nr),
+			  _("\n(use 'rm -rf' if you really "
+			    "want to remove it including all "
+			    "of its history)"),
+			  &errs);
+	print_error_files(&files_local,
+			  Q_("the following file has local modifications:",
+			     "the following files have local modifications:",
+			     files_local.nr),
+			  _("\n(use --cached to keep the file,"
+			    " or -f to force removal)"),
+			  &errs);
+
 	return errs;
 }
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0c44e9f..902993b 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -687,4 +687,71 @@ test_expect_failure SYMLINKS 'rm across a symlinked leading path (w/ index)' '
 	test_path_is_file e/f
 '
 
+test_expect_success 'setup for testing rm messages' '
+	>bar.txt &&
+	>foo.txt &&
+	git add bar.txt foo.txt
+'
+
+test_expect_success 'rm files with different staged content' '
+	cat >expect <<-\EOF &&
+	error: the following files have staged content different from both the
+	file and the HEAD:
+	    bar.txt
+	    foo.txt
+	(use -f to force removal)
+	EOF
+	echo content1 >foo.txt &&
+	echo content1 >bar.txt &&
+	test_must_fail git rm foo.txt bar.txt 2>actual &&
+	test_i18ncmp expect actual
+'
+
+
+test_expect_success 'rm file with local modification' '
+	cat >expect <<-\EOF &&
+	error: the following file has local modifications:
+	    foo.txt
+	(use --cached to keep the file, or -f to force removal)
+	EOF
+	git commit -m "testing rm 3" &&
+	echo content3 >foo.txt &&
+	test_must_fail git rm foo.txt 2>actual &&
+	test_i18ncmp expect actual
+'
+
+
+test_expect_success 'rm file with changes in the index' '
+	cat >expect <<-\EOF &&
+	error: the following file has changes staged in the index:
+	    foo.txt
+	(use --cached to keep the file, or -f to force removal)
+	EOF
+	git reset --hard &&
+	echo content5 >foo.txt &&
+	git add foo.txt &&
+	test_must_fail git rm foo.txt 2>actual &&
+	test_i18ncmp expect actual
+'
+
+
+test_expect_success 'rm files with two different errors' '
+	cat >expect <<-\EOF &&
+	error: the following file has staged content different from both the
+	file and the HEAD:
+	    foo1.txt
+	(use -f to force removal)
+	error: the following file has changes staged in the index:
+	    bar1.txt
+	(use --cached to keep the file, or -f to force removal)
+	EOF
+	echo content >foo1.txt &&
+	git add foo1.txt &&
+	echo content6 >foo1.txt &&
+	echo content6 >bar1.txt &&
+	git add bar1.txt &&
+	test_must_fail git rm bar1.txt foo1.txt 2>actual &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
1.7.8
