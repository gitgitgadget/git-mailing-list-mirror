From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v5 1/4] Avoid conflicts when merging branches with mixed normalization
Date: Thu,  1 Jul 2010 11:09:49 +0200
Message-ID: <341c6df1dd591c54a5aa386803ea4e0c77bd0047.1277974452.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277974452.git.eyvind.bernhardsen@gmail.com>
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 11:10:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUFmw-0007IR-Jt
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 11:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509Ab0GAJKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 05:10:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64826 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab0GAJKG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 05:10:06 -0400
Received: by bwz1 with SMTP id 1so797015bwz.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qJJSuKjeyN5tsThuaTbvoMYVF1BjYNnB5V8ddKWhBGI=;
        b=Zqp3wbvYay7CnJwSA9rOsXFl+3cl+5huOLWrHrBlzBlip5+Psvq5dXVkWIxZu5ztlu
         1mzeI2KR31ZbWT6o0zxBaZCCobopxHs8f4twshSrxk/yhAsOrPfLUXunhz6kGIq/Z4+0
         JEcelmoXiI66gfhdzEN40JAR/mi6KlX5w8Vgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YJYQyNUm01m9eRLrAFwKj0Buc2WYGNmblQPYRqq2rGjuCyYwqPfHqjtRKAKLnKPaLw
         c3smkj/zO/DSCwKMR2P/uW2XhUwRJLUAfFxFbMyR6XazT8K5LKHey1bwyPKncDGpSTOu
         ThK6uBy6nHhUrS4fUKjuQbtRehkk93yVg+Tn4=
Received: by 10.204.81.153 with SMTP id x25mr7342299bkk.36.1277975404943;
        Thu, 01 Jul 2010 02:10:04 -0700 (PDT)
Received: from localhost.localdomain ([62.113.137.5])
        by mx.google.com with ESMTPS id bi18sm11444654bkb.21.2010.07.01.02.10.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 02:10:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.4.g09d06
In-Reply-To: <cover.1277974452.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150016>

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

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitattributes.txt |   33 ++++++++++++++++++++++
 cache.h                         |    1 +
 convert.c                       |   16 +++++++++-
 ll-merge.c                      |   13 +++++++++
 t/t6038-merge-text-auto.sh      |   58 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 119 insertions(+), 2 deletions(-)
 create mode 100755 t/t6038-merge-text-auto.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 564586b..22400c1 100644
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
@@ -331,6 +342,28 @@ In the check-out codepath, the blob content is first converted
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
+To prevent these unnecessary merge conflicts, git runs a virtual
+check-out and check-in of all three stages of a file when resolving a
+three-way merge.  This prevents changes caused by check-in conversion
+from causing spurious merge conflicts when a converted file is merged
+with an unconverted file.
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
 
diff --git a/cache.h b/cache.h
index c9fa3df..aa725b0 100644
--- a/cache.h
+++ b/cache.h
@@ -1054,6 +1054,7 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
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
diff --git a/ll-merge.c b/ll-merge.c
index 3764a1a..28c6f54 100644
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
@@ -334,6 +344,9 @@ int ll_merge(mmbuffer_t *result_buf,
 	const struct ll_merge_driver *driver;
 	int virtual_ancestor = flag & 01;
 
+	normalize_file(ancestor, path);
+	normalize_file(ours, path);
+	normalize_file(theirs, path);
 	if (!git_path_check_merge(path, check)) {
 		ll_driver_name = check[0].value;
 		if (check[1].value) {
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
new file mode 100755
index 0000000..44e6003
--- /dev/null
+++ b/t/t6038-merge-text-auto.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='CRLF merge conflict across text=auto change'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git config core.autocrlf false &&
+	echo first line | append_cr >file &&
+	git add file &&
+	git commit -m "Initial" &&
+	git tag initial &&
+	git branch side &&
+	echo "* text=auto" >.gitattributes &&
+	touch file &&
+	git add .gitattributes file &&
+	git commit -m "normalize file" &&
+	echo same line | append_cr >>file &&
+	git add file &&
+	git commit -m "add line from a" &&
+	git tag a &&
+	git rm .gitattributes &&
+	rm file &&
+	git checkout file &&
+	git commit -m "remove .gitattributes" &&
+	git tag c &&
+	git checkout side &&
+	echo same line | append_cr >>file &&
+	git commit -m "add line from b" file &&
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
1.7.2.rc1.4.g09d06
