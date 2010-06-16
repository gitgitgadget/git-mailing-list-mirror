From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH/RFC v2] ll-merge: Normalize files before merging
Date: Wed, 16 Jun 2010 23:18:35 +0200
Message-ID: <1276723115-2869-1-git-send-email-eyvind.bernhardsen@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 23:18:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP00W-0003Wz-Ls
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 23:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525Ab0FPVSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 17:18:43 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:53136 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113Ab0FPVSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 17:18:41 -0400
Received: by mail-ww0-f46.google.com with SMTP id 18so6079246wwb.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=6Ycza1vxQMZ08BP4+baygMWwRwgzcbSCtzUGi6kQPug=;
        b=MZlkLTN6KC0sO2rhjI833ResILfY2vz4uPR2O4IXR1zpHEEDqcq8tIzcw7BlHDdP2a
         e0nJWinNQXk74NJvVCTFsDo/X7JocJSlYMcjzV3wNlqfuRew/B0pd+GwXRJ5EegHJsKB
         xUpBS11rAme15W2A1ed/JToNd0TPVPEVNJq48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nPjLSGfg9RpihJsc2x0outHJU4nKpNu1X2i59MmQRfXTNRS6WOcCJ0KnbGhYmBsMYy
         V9DLOxC6c6P4XkIFk4WYj6Z04SO6RFQ5/cVV50sMOEbJBKU1rEGwbVkepaApJb1OZgYf
         PBK+gX6ovHViE3cdJjvQYLGVtQD1pAeMR12ns=
Received: by 10.227.147.208 with SMTP id m16mr9161882wbv.53.1276723120828;
        Wed, 16 Jun 2010 14:18:40 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id y31sm57946807wby.16.2010.06.16.14.18.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jun 2010 14:18:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.g0ed10.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149276>

Currently, merging across changes in line ending normalization is
painful since all lines containing CRLF will conflict.

Fix ll-merge so that the "base", "theirs" and "ours" files are passed
through convert_to_worktree() and convert_to_git() before a three-way
merge.

This prevents differences that can be normalized away from blocking an
automatic merge, and makes real conflicts show up instead of being lost
in the noise.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
Second stab at having ll-merge automatically handle merges across text
conversion boundaries.  The previous implementation ran convert_to_git()
on already normalized data, which is potentially dangerous.  This
version runs convert_to_worktree() first.

As promised, I did some benchmarks this time.  My repository has 55617
files, all normalized with "* text=auto".  The branch to be merged
changes 16157 of them and is based on an old, pre-normalization commit.

An uncompleted merge doesn't make for a fair performance comparison, so
I ended up rebasing the topic branch on top of the first normalized
commit on master to compare performance.  I ran each merge 10 times and
averaged the user time for each run.

With the simplified merge there was no measurable difference between
running with or without normalization.  Adding core.eol=crlf when
normalizing cost about 5%.

A remaining problem is that delete/modify conflicts where the "modify"
is just normalization have to be resolved manually.  This could be fixed
by normalizing files when there is a d/m conflict and then comparing the
normalized sha1s.

- Eyvind

 ll-merge.c                 |   17 +++++++++++++
 t/t6038-merge-text-auto.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100755 t/t6038-merge-text-auto.sh

diff --git a/ll-merge.c b/ll-merge.c
index f9b3d85..264337e 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -321,6 +321,20 @@ static int git_path_check_merge(const char *path, struct git_attr_check check[2]
 	return git_checkattr(path, 2, check);
 }
 
+static void normalize_file(mmfile_t *mm, const char *path) {
+	struct strbuf strbuf = STRBUF_INIT;
+	if (convert_to_working_tree(path, mm->ptr, mm->size, &strbuf)) {
+		free(mm->ptr);
+		mm->size = strbuf.len;
+		mm->ptr = strbuf_detach(&strbuf, NULL);
+	}
+	if (convert_to_git(path, mm->ptr, mm->size, &strbuf, 0)) {
+		free(mm->ptr);
+		mm->size = strbuf.len;
+		mm->ptr = strbuf_detach(&strbuf, NULL);
+	}
+}
+
 int ll_merge(mmbuffer_t *result_buf,
 	     const char *path,
 	     mmfile_t *ancestor, const char *ancestor_label,
@@ -334,6 +348,9 @@ int ll_merge(mmbuffer_t *result_buf,
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
index 0000000..6af2c41
--- /dev/null
+++ b/t/t6038-merge-text-auto.sh
@@ -0,0 +1,54 @@
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
+	git add .gitattributes &&
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
+# Not sure if this deserves to be fixed
+test_expect_failure 'Check merging removal of text=auto' '
+	git reset --hard b &&
+	git merge c &&
+	cat file | remove_cr >file.temp &&
+	test_cmp file file.temp
+'
+
+test_done
-- 
1.7.1.5.g0ed10.dirty
