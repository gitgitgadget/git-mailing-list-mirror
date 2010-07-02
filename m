From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v6 1/3] Avoid conflicts when merging branches with mixed normalization
Date: Fri,  2 Jul 2010 21:20:47 +0200
Message-ID: <42dab0b23c001f3981180cc9e0069c4dbb49ae4a.1278093311.git.eyvind.bernhardsen@gmail.com>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 21:27:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUlte-0001aK-BI
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759492Ab0GBT13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 15:27:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53112 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0GBT12 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:27:28 -0400
Received: by wyf23 with SMTP id 23so1283479wyf.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SnqU3QiSOrzCboMfPt6xAcdOuDBurscUFnRzp1S0qkI=;
        b=s12Nw5ShttMMQ8q11gIBMUgXM3HWIRmcbefbWq8PHDgIPNOaWDZ8x6M31s1fltOHSz
         2yWnLEfCjDKs4/tcfiNQ9009ERo9wchJeb4eyXFm9IK+4K7Y3cYTcTMTc3puZTWFBbGa
         ksbZUCE7GVMzvAafbIJvSQmSsV2kcIL2iYs1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S1hxQ7Su1Ml7yyJDKZk0e5b85X6e1PCfqwKMBGvfBKyengG4dyaS71+zpSaRnvGZTO
         DlULIhSm7OObsrOovlArjk/XlEpnDZA5HSoe2gKpD/1BHxpIjdgWX+PFc5J93HguhGA4
         iG4YHmWilDpieSlFzgr0MIPp1Xc4CP4/3oTZE=
Received: by 10.213.32.136 with SMTP id c8mr4411921ebd.38.1278098461705;
        Fri, 02 Jul 2010 12:21:01 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id v8sm8093578eeh.14.2010.07.02.12.21.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 12:21:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.575.g383de
In-Reply-To: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150157>

Currently, merging across changes in line ending normalization is
painful since files containing CRLF will conflict with normalized files,
even if the only difference between the two versions is the line
endings.  Additionally, any "real" merge conflicts that exist are
obscured because every line in the file has a conflict.

Assume you start out with a repo that has a lot of text files with CRLF
checked in (A):

      o---C
     /     \
    A---B---D

B: Add "* text=auto" to .gitattributes and normalize all files to
   LF-only

C: Modify some of the text files

D: Try to merge C

You will get a ridiculous number of LF/CRLF conflicts when trying to
merge C into D, since the repository contents for C are "wrong" wrt the
new .gitattributes file.

Fix ll-merge so that the "base", "theirs" and "ours" stages are passed
through convert_to_worktree() and convert_to_git() before a three-way
merge.  This ensures that all three stages are normalized in the same
way, removing from consideration differences that are only due to
normalization.

This feature is optional for now since it changes a low-level mechanism
and is not necessary for the majority of users.  The "merge.renormalize"
config variable enables it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 Documentation/gitattributes.txt |   34 ++++++++++++++++++++
 Documentation/merge-config.txt  |   10 ++++++
 builtin/merge.c                 |    3 ++
 cache.h                         |    2 +
 convert.c                       |   16 ++++++++-
 environment.c                   |    1 +
 ll-merge.c                      |   15 +++++++++
 t/t6038-merge-text-auto.sh      |   64 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 143 insertions(+), 2 deletions(-)
 create mode 100755 t/t6038-merge-text-auto.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 564586b..da553ff 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -317,6 +317,17 @@ command is "cat").
 	smudge = cat
 ------------------------
 
+For best results, `clean` should not alter its output further if it is
+run twice ("clean->clean" should be equivalent to "clean"), and
+multiple `smudge` commands should not alter `clean`'s output
+("smudge->smudge->clean" should be equivalent to "clean").  See the
+section on merging below.
+
+The "indent" filter is well-behaved in this regard: it will not modify
+input that is already correctly indented.  In this case, the lack of a
+smudge filter means that the clean filter _must_ accept its own output
+without modifying it.
+
 
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -331,6 +342,29 @@ In the check-out codepath, the blob content is first converted
 with `text`, and then `ident` and fed to `filter`.
 
 
+Merging branches with differing checkin/checkout attributes
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+If you have added attributes to a file that cause the canonical
+repository format for that file to change, such as adding a
+clean/smudge filter or text/eol/ident attributes, merging anything
+where the attribute is not in place would normally cause merge
+conflicts.
+
+To prevent these unnecessary merge conflicts, git can be told to run a
+virtual check-out and check-in of all three stages of a file when
+resolving a three-way merge by setting the `merge.renormalize`
+configuration variable.  This prevents changes caused by check-in
+conversion from causing spurious merge conflicts when a converted file
+is merged with an unconverted file.
+
+As long as a "smudge->clean" results in the same output as a "clean"
+even on files that are already smudged, this strategy will
+automatically resolve all filter-related conflicts.  Filters that do
+not act in this way may cause additional merge conflicts that must be
+resolved manually.
+
+
 Generating diff text
 ~~~~~~~~~~~~~~~~~~~~
 
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index a403155..b72f533 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -15,6 +15,16 @@ merge.renameLimit::
 	during a merge; if not specified, defaults to the value of
 	diff.renameLimit.
 
+merge.renormalize::
+	Tell git that canonical representation of files in the
+	repository has changed over time (e.g. earlier commits record
+	text files with CRLF line endings, but recent ones use LF line
+	endings).  In such a repository, git can convert the data
+	recorded in commits to a canonical form before performing a
+	merge to reduce unnecessary conflicts.  For more information,
+	see section "Merging branches with differing checkin/checkout
+	attributes" in linkgit:gitattributes[5].
+
 merge.stat::
 	Whether to print the diffstat between ORIG_HEAD and the merge result
 	at the end of the merge.  True by default.
diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..b836e9c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -503,6 +503,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_octopus, k, v);
 	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary"))
 		option_log = git_config_bool(k, v);
+	else if (!strcmp(k, "merge.renormalize")) {
+		merge_renormalize = git_config_bool(k, v);
+	}
 	return git_diff_ui_config(k, v, cb);
 }
 
diff --git a/cache.h b/cache.h
index c9fa3df..ed73da8 100644
--- a/cache.h
+++ b/cache.h
@@ -551,6 +551,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int merge_renormalize;
 
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
@@ -1054,6 +1055,7 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern int convert_to_git(const char *path, const char *src, size_t len,
                           struct strbuf *dst, enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
+extern int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst);
 
 /* add */
 /*
diff --git a/convert.c b/convert.c
index e41a31e..0203be8 100644
--- a/convert.c
+++ b/convert.c
@@ -93,7 +93,8 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 	return 0;
 }
 
-static enum eol determine_output_conversion(enum action action) {
+static enum eol determine_output_conversion(enum action action)
+{
 	switch (action) {
 	case CRLF_BINARY:
 		return EOL_UNSET;
@@ -693,7 +694,8 @@ static int git_path_check_ident(const char *path, struct git_attr_check *check)
 	return !!ATTR_TRUE(value);
 }
 
-enum action determine_action(enum action text_attr, enum eol eol_attr) {
+static enum action determine_action(enum action text_attr, enum eol eol_attr)
+{
 	if (text_attr == CRLF_BINARY)
 		return CRLF_BINARY;
 	if (eol_attr == EOL_LF)
@@ -773,3 +775,13 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 	}
 	return ret | apply_filter(path, src, len, dst, filter);
 }
+
+int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst)
+{
+	int ret = convert_to_working_tree(path, src, len, dst);
+	if (ret) {
+		src = dst->buf;
+		len = dst->len;
+	}
+	return ret | convert_to_git(path, src, len, dst, 0);
+}
diff --git a/environment.c b/environment.c
index 83d38d3..81a3682 100644
--- a/environment.c
+++ b/environment.c
@@ -53,6 +53,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
+int merge_renormalize;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
diff --git a/ll-merge.c b/ll-merge.c
index 3764a1a..5068fe0 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -321,6 +321,16 @@ static int git_path_check_merge(const char *path, struct git_attr_check check[2]
 	return git_checkattr(path, 2, check);
 }
 
+static void normalize_file(mmfile_t *mm, const char *path)
+{
+	struct strbuf strbuf = STRBUF_INIT;
+	if (renormalize_buffer(path, mm->ptr, mm->size, &strbuf)) {
+		free(mm->ptr);
+		mm->size = strbuf.len;
+		mm->ptr = strbuf_detach(&strbuf, NULL);
+	}
+}
+
 int ll_merge(mmbuffer_t *result_buf,
 	     const char *path,
 	     mmfile_t *ancestor, const char *ancestor_label,
@@ -334,6 +344,11 @@ int ll_merge(mmbuffer_t *result_buf,
 	const struct ll_merge_driver *driver;
 	int virtual_ancestor = flag & 01;
 
+	if (merge_renormalize) {
+		normalize_file(ancestor, path);
+		normalize_file(ours, path);
+		normalize_file(theirs, path);
+	}
 	if (!git_path_check_merge(path, check)) {
 		ll_driver_name = check[0].value;
 		if (check[1].value) {
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
new file mode 100755
index 0000000..127baf8
--- /dev/null
+++ b/t/t6038-merge-text-auto.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='CRLF merge conflict across text=auto change'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git config merge.renormalize true &&
+	git config core.autocrlf false &&
+	echo first line | append_cr >file &&
+	echo first line >control_file &&
+	echo only line >inert_file &&
+	git add file control_file inert_file &&
+	git commit -m "Initial" &&
+	git tag initial &&
+	git branch side &&
+	echo "* text=auto" >.gitattributes &&
+	touch file &&
+	git add .gitattributes file &&
+	git commit -m "normalize file" &&
+	echo same line | append_cr >>file &&
+	echo same line >>control_file &&
+	git add file control_file &&
+	git commit -m "add line from a" &&
+	git tag a &&
+	git rm .gitattributes &&
+	rm file &&
+	git checkout file &&
+	git commit -m "remove .gitattributes" &&
+	git tag c &&
+	git checkout side &&
+	echo same line | append_cr >>file &&
+	echo same line >>control_file &&
+	git add file control_file &&
+	git commit -m "add line from b" &&
+	git tag b &&
+	git checkout master
+'
+
+test_expect_success 'Check merging after setting text=auto' '
+	git reset --hard a &&
+	git merge b &&
+	cat file | remove_cr >file.temp &&
+	test_cmp file file.temp
+'
+
+test_expect_success 'Check merging addition of text=auto' '
+	git reset --hard b &&
+	git merge a &&
+	cat file | remove_cr >file.temp &&
+	test_cmp file file.temp
+'
+
+test_expect_failure 'Test delete/normalize conflict' '
+	git checkout side &&
+	git reset --hard initial &&
+	git rm file &&
+	git commit -m "remove file" &&
+	git checkout master &&
+	git reset --hard a^ &&
+	git merge side
+'
+
+test_done
-- 
1.7.1.575.g383de
