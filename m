From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v3 1/3] Avoid conflicts when merging branches with mixed normalization
Date: Thu, 24 Jun 2010 22:44:30 +0200
Message-ID: <c6365533ce03625b362fd432d1c3276d335cba89.1277408598.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277408598.git.eyvind.bernhardsen@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:44:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORtI9-0001NK-GY
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab0FXUon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 16:44:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38690 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab0FXUok (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:44:40 -0400
Received: by wyi11 with SMTP id 11so2028128wyi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=UMoJuBCYb0CXojiTTiUbeR3cmhKtzI2f1x4rSTLBqN0=;
        b=agKRmW5f/AvRPGIFTGEfiKhAIOp7S8rrDNkcmI3T9wpGcFXjGdCcfLJGEz5DaqE0SS
         615RwDx2ql4pD3ahkMfRLEIO3ceUa2aZc3fLNeaUP4oXuithE53k70LuxAI81lpq2j5L
         35i7sTvV2xPcitr7wxF/pbqn3OK0n6PNnLcR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SZGb881IcLwKEhObZt216JahOoO7RH6MEqnyTjPRiY7JUXf5hEcuxFhjbwW/bK44pa
         Bxfkr+bOxDtG1Ka1uISWlzq0obk7MQIs48xBmFfTxSHsANEjaNj+nyCbPq9/tZDI7tyf
         PDQE2gSjrhW3hP8eSZkhXIjwgJ2UcTYgBGg2A=
Received: by 10.227.134.16 with SMTP id h16mr9667355wbt.69.1277412278845;
        Thu, 24 Jun 2010 13:44:38 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id t15sm34373334wbc.17.2010.06.24.13.44.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 13:44:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.575.g383de
In-Reply-To: <cover.1277408598.git.eyvind.bernhardsen@gmail.com>
In-Reply-To: <cover.1277408598.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277408598.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149643>

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
 cache.h                    |    1 +
 convert.c                  |   11 +++++++-
 ll-merge.c                 |   12 +++++++++
 t/t6038-merge-text-auto.sh |   58 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 1 deletions(-)
 create mode 100755 t/t6038-merge-text-auto.sh

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
index e41a31e..e1561a9 100644
--- a/convert.c
+++ b/convert.c
@@ -693,7 +693,7 @@ static int git_path_check_ident(const char *path, struct git_attr_check *check)
 	return !!ATTR_TRUE(value);
 }
 
-enum action determine_action(enum action text_attr, enum eol eol_attr) {
+static enum action determine_action(enum action text_attr, enum eol eol_attr) {
 	if (text_attr == CRLF_BINARY)
 		return CRLF_BINARY;
 	if (eol_attr == EOL_LF)
@@ -773,3 +773,12 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 	}
 	return ret | apply_filter(path, src, len, dst, filter);
 }
+
+int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst) {
+	int ret = convert_to_working_tree(path, src, len, dst);
+	if (ret) {
+		src = dst->buf;
+		len = dst->len;
+	}
+	return ret | convert_to_git(path, src, len, dst, 0);
+}
diff --git a/ll-merge.c b/ll-merge.c
index 3764a1a..bdaa580 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -321,6 +321,15 @@ static int git_path_check_merge(const char *path, struct git_attr_check check[2]
 	return git_checkattr(path, 2, check);
 }
 
+static void normalize_file(mmfile_t *mm, const char *path) {
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
@@ -334,6 +343,9 @@ int ll_merge(mmbuffer_t *result_buf,
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
