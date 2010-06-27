From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v4 1/3] Avoid conflicts when merging branches with mixed normalization
Date: Sun, 27 Jun 2010 21:43:05 +0200
Message-ID: <07a766a7972671b9e39dbca55719d024c30c7a28.1277667177.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 21:43:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSxlL-00061C-3M
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 21:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562Ab0F0TnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 15:43:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45642 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab0F0TnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 15:43:16 -0400
Received: by wyb38 with SMTP id 38so1306859wyb.19
        for <git@vger.kernel.org>; Sun, 27 Jun 2010 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=BYx0HOpc2WGHOkHoP2XMd0e7ztPp+MbxYeW9znMhEOg=;
        b=BS6y2wa8SvvZUORFOU/TMsMlf28nO33RVOLrHpTwE4rH3gtV5CH0zmPRTjV13Uvw+T
         tSeG48rQkxf4onFYoRZEFjjPqJrtRcC3103ATtZ+kGem0zgZWg1csMt4Xqxb7joAWYQz
         6SRFGnkxQAk+lhFvS1+CPaIaDmD4IUpuMB5QE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=a6Y6y9d7m1fcnzuFlEawKx8SKdGl0q4o/OXGx5Fkj3qbypqnOFTv7dZwOAJlrhYVld
         Gc9n0hlniEd1gpphaxd3frNo+adO3gl+wAbOdz6k/ptvZthd+nX+4Rf2dPkzHx6CC7nF
         wlEuVyf7L1tsknyCT9qJbJboCR9VwxIoUt5pA=
Received: by 10.216.185.78 with SMTP id t56mr2771351wem.40.1277667793638;
        Sun, 27 Jun 2010 12:43:13 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id y39sm4411401weq.3.2010.06.27.12.43.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Jun 2010 12:43:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.575.g383de
In-Reply-To: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
In-Reply-To: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149805>

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
---
 Documentation/gitattributes.txt |   27 ++++++++++++++++++
 cache.h                         |    1 +
 convert.c                       |   16 +++++++++-
 ll-merge.c                      |   13 +++++++++
 t/t6038-merge-text-auto.sh      |   58 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100755 t/t6038-merge-text-auto.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 564586b..b110082 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -317,6 +317,18 @@ command is "cat").
 	smudge = cat
 ------------------------
 
+For best results, `clean` and `smudge` commands should produce output
+that is not dependent on the corresponding command having been run.
+That is, `clean` should produce identical output whether its input has
+been run through `smudge` or not, and `smudge` should not rely on its
+input having been run through `clean`.  See the section on merging
+below for a rationale.
+
+The example "indent" filter is well-behaved in this regard: it will
+accept input that is already correctly indented without modifying it.
+In this case, the lack of a smudge filter means that the clean filter
+_must_ accept its own output without modifying it.
+
 
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -331,6 +343,21 @@ In the check-out codepath, the blob content is first converted
 with `text`, and then `ident` and fed to `filter`.
 
 
+Merging branches with differing checkin/checkout attributes
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To prevent unnecessary merge conflicts, git runs a virtual check-out
+and check-in of all three stages of a file when resolving a three-way
+merge.  This prevents changes caused by check-in conversion from
+causing spurious merge conflicts when a converted file is merged with
+an unconverted file.
+
+This strategy will break down if a `smudge` filter relies on its input
+having been processed by the corresponding `clean` filter or vice
+versa.  Such filters may otherwise work well, but will prevent
+automatic merging.
+
+
 Generating diff text
 ~~~~~~~~~~~~~~~~~~~~
 
diff --git a/cache.h b/cache.h
index ff4a7c2..5db89f9 100644
--- a/cache.h
+++ b/cache.h
@@ -1043,6 +1043,7 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
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
1.7.1.575.g383de
