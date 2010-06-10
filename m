From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [RFC] ll-merge: Normalize files before merging
Date: Thu, 10 Jun 2010 22:48:14 +0200
Message-ID: <1276202894-11805-1-git-send-email-eyvind.bernhardsen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 10 22:48:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMoft-0007Uo-GB
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 22:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111Ab0FJUsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 16:48:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45349 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434Ab0FJUsU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 16:48:20 -0400
Received: by bwz7 with SMTP id 7so86971bwz.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 13:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=9ZaKeEFbzxdy6gmcL+FAT3MqFm2nYSNk9/urc2e3dA0=;
        b=lqSh7MH1dbZy/XL6cIVR42hX46MA4X5SSzDsQNgeBY9FnhweE946w6a2SDiG6eriDK
         n+x+gGAtZlX0F59NuM8XKzzXotMPQx9SKv3ms5qLvu09ANhdkrZWmgm0tXAIMuLerJvB
         jspIFt0CuT/u94Qesl6gUgzZOUFaQBqAnAK/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=hddknbLbPMxohq2y8QqNc+iMkEJM4zzCUXNoRb4VdrQNPbcV7Pd3sbmnM3C/1zlW/K
         J+/5leI8HNjNgh/LVO7YRXojF3vkQilu5OyZkSmVY2hG0j3wiL/01q2TyMKQOuZDbeI4
         9e/rufcckhcS7ha73ydtBB8BIwEweoyAspf3Q=
Received: by 10.204.163.133 with SMTP id a5mr562345bky.17.1276202898657;
        Thu, 10 Jun 2010 13:48:18 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id v14sm1595126bkz.2.2010.06.10.13.48.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jun 2010 13:48:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.g0ed10.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148916>

Currently, merging across changes in line ending normalization is
painful since all lines containing CRLF will conflict uselessly.

Fix ll-merge so that the "base", "theirs" and "ours" files are passed
through convert_to_git() before a three-way merge.  This prevents
differences that can be normalized away from blocking an automatic
merge.
---
I have a repository that has been normalized using "* text=auto" and
need to merge un-normalized changes (ie, branches based on commits from
before the normalization) into it.  Unfortunately, this doesn't work:
every line containing a CRLF causes a conflict.  Fortunately, there is
an easy fix in the merge code.

This patch has already been useful to me, but I'm not sure it is the
best possible solution to the problem (especially in terms of
efficiency), hence the RFC.

Note that clean and ident filters will also be run, which might be a
good thing.  Also, the tests require my crlf/text series from pu.
-- 
Eyvind



 ll-merge.c                 |   12 +++++++++
 t/t6038-merge-text-auto.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100755 t/t6038-merge-text-auto.sh

diff --git a/ll-merge.c b/ll-merge.c
index f9b3d85..63835af 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -321,6 +321,15 @@ static int git_path_check_merge(const char *path, struct git_attr_check check[2]
 	return git_checkattr(path, 2, check);
 }
 
+static void normalize_file(mmfile_t *mm, const char *path) {
+	struct strbuf strbuf = STRBUF_INIT;
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
