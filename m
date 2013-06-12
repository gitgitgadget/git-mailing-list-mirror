From: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Subject: [PATCH v5 1/2] rm: better error message on failure for multiple files
Date: Wed, 12 Jun 2013 10:06:43 +0200
Message-ID: <1371024404-22468-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 10:07:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umg56-00009w-62
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 10:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab3FLIGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 04:06:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54339 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab3FLIGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 04:06:50 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5C86idj013046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 10:06:44 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5C86jtP009462;
	Wed, 12 Jun 2013 10:06:45 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5C86jwK028004;
	Wed, 12 Jun 2013 10:06:45 +0200
Received: (from lienardm@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r5C86iko028003;
	Wed, 12 Jun 2013 10:06:44 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 10:06:44 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227591>

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

Changes since v4:
 -removal of useless blanks after variable declarations
 -use of string_list_clear

 builtin/rm.c  |   99 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 t/t3600-rm.sh |   67 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 19 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 7b91d52..18df253 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -36,10 +36,31 @@ static int get_ours_cache_pos(const char *path, int pos)
 	return -1;
 }
 
+static void print_error_files(struct string_list *files_list,
+			      const char *main_msg,
+			      const char *hints_msg,
+			      int *errs)
+{
+	if (files_list->nr) {
+		int i;
+		struct strbuf err_msg = STRBUF_INIT;
+
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
 
 	for (i = 0; i < list.nr; i++) {
 		const char *name = list.entry[i].name;
@@ -61,11 +82,18 @@ static int check_submodules_use_gitfiles(void)
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
+	string_list_clear(&files, 0);
 
 	return errs;
 }
@@ -81,6 +109,10 @@ static int check_local_mod(unsigned char *head, int index_only)
 	 */
 	int i, no_head;
 	int errs = 0;
+	struct string_list files_staged = STRING_LIST_INIT_NODUP;
+	struct string_list files_cached = STRING_LIST_INIT_NODUP;
+	struct string_list files_submodule = STRING_LIST_INIT_NODUP;
+	struct string_list files_local = STRING_LIST_INIT_NODUP;
 
 	no_head = is_null_sha1(head);
 	for (i = 0; i < list.nr; i++) {
@@ -171,29 +203,58 @@ static int check_local_mod(unsigned char *head, int index_only)
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
+	string_list_clear(&files_staged, 0);
+	print_error_files(&files_cached,
+			  Q_("the following file has changes "
+			     "staged in the index:",
+			     "the following files have changes "
+			     "staged in the index:", files_cached.nr),
+			  _("\n(use --cached to keep the file,"
+			    " or -f to force removal)"),
+			  &errs);
+	string_list_clear(&files_cached, 0);
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
+	string_list_clear(&files_submodule, 0);
+	print_error_files(&files_local,
+			  Q_("the following file has local modifications:",
+			     "the following files have local modifications:",
+			     files_local.nr),
+			  _("\n(use --cached to keep the file,"
+			    " or -f to force removal)"),
+			  &errs);
+	string_list_clear(&files_local, 0);
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
