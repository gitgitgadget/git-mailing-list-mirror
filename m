From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v6 6/6] setup: Don't dereference in-tree symlinks for absolute paths
Date: Tue,  4 Feb 2014 15:25:20 +0100
Message-ID: <1391523920-26946-7-git-send-email-martinerikwerner@gmail.com>
References: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
 <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 15:28:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAgwt-0002hc-TL
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 15:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbaBDOZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 09:25:52 -0500
Received: from mail-ee0-f44.google.com ([74.125.83.44]:45135 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbaBDOZv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 09:25:51 -0500
Received: by mail-ee0-f44.google.com with SMTP id c13so4308780eek.17
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 06:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XuSza1myqu9kC3EL6dgbygdmAksRm9PauEM+tP2xshQ=;
        b=yJsHuM4Y+ybpJIE7n20VImxv+Xt0tsHUTtzx2OfIFCVnioQ2X4/5XVp9Tnc7VJdlHY
         ROuGZ8f900PrdwLwqtXkOimi6EC2F4dcW7qEx3xkbj3L1SgjxkpS9xkIqnxEW+wK7lJT
         CQuA3zhn8U2shM6f74kufsY1HIfaM+MYMweCzb4V0+41WpKwy2ztgNuiBypGKlaYwer/
         sWfgfAFpbiL6QZulNWIfOSjTRXwkHhLVde2hOVxgrsi3T2X9iLfOl0VUUXgR1mN5aRLX
         soHu9AHJDeFW2EqZBmnGuQMzuP1Ijhv6Vw3WcgdH4saKHnyU9ErOEB4TeSbTlK3h+FbB
         1zAA==
X-Received: by 10.14.0.201 with SMTP id 49mr51249380eeb.38.1391523949832;
        Tue, 04 Feb 2014 06:25:49 -0800 (PST)
Received: from localhost.localdomain ([194.150.18.52])
        by mx.google.com with ESMTPSA id u7sm89446218eep.11.2014.02.04.06.25.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Feb 2014 06:25:49 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241527>

The 'prefix_path_gently' function currently applies real_path to
everything if given an absolute path, dereferencing symlinks both
outside and inside the work tree.

This causes most high-level functions to misbehave when acting on
symlinks given via absolute paths. For example

	$ git add /dir/repo/symlink

attempts to add the target of the symlink rather than the symlink
itself, which is usually not what the user intends to do.

In order to manipulate symlinks in the work tree using absolute paths,
symlinks should only be dereferenced outside the work tree.

Modify the 'prefix_path_gently' to first normalize the path in order to
make sure path levels are separated by '/', then pass the result to
'abspath_part_inside_repo' to find the part inside the work tree
(without dereferencing any symlinks inside the work tree).

For absolute paths, 'prefix_path_gently' did not, nor does now do, any
actual prefixing, hence the result from 'abspath_part_in_repo' is
returned as-is.

Fixes t0060-82 and t3004-5.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
Reviewed-by: Duy Nguyen <pclouds@gmail.com>
---
 setup.c                   | 30 ++++++++++--------------------
 t/t0060-path-utils.sh     |  2 +-
 t/t3004-ls-files-basic.sh |  2 +-
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/setup.c b/setup.c
index 906c8e2..ba08885 100644
--- a/setup.c
+++ b/setup.c
@@ -86,11 +86,17 @@ char *prefix_path_gently(const char *prefix, int len,
 	const char *orig = path;
 	char *sanitized;
 	if (is_absolute_path(orig)) {
-		const char *temp = real_path(path);
-		sanitized = xmalloc(len + strlen(temp) + 1);
-		strcpy(sanitized, temp);
+		sanitized = xmalloc(strlen(path) + 1);
 		if (remaining_prefix)
 			*remaining_prefix = 0;
+		if (normalize_path_copy_len(sanitized, path, remaining_prefix)) {
+			free(sanitized);
+			return NULL;
+		}
+		if (abspath_part_inside_repo(sanitized)) {
+			free(sanitized);
+			return NULL;
+		}
 	} else {
 		sanitized = xmalloc(len + strlen(path) + 1);
 		if (len)
@@ -98,26 +104,10 @@ char *prefix_path_gently(const char *prefix, int len,
 		strcpy(sanitized + len, path);
 		if (remaining_prefix)
 			*remaining_prefix = len;
-	}
-	if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix))
-		goto error_out;
-	if (is_absolute_path(orig)) {
-		size_t root_len, len, total;
-		const char *work_tree = get_git_work_tree();
-		if (!work_tree)
-			goto error_out;
-		len = strlen(work_tree);
-		root_len = offset_1st_component(work_tree);
-		total = strlen(sanitized) + 1;
-		if (strncmp(sanitized, work_tree, len) ||
-		    (len > root_len && sanitized[len] != '\0' && sanitized[len] != '/')) {
-		error_out:
+		if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix)) {
 			free(sanitized);
 			return NULL;
 		}
-		if (sanitized[len] == '/')
-			len++;
-		memmove(sanitized, sanitized + len, total - len);
 	}
 	return sanitized;
 }
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index c0a14f6..f04b82d 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -190,7 +190,7 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
 '
 
-test_expect_failure SYMLINKS 'prefix_path works with absolute paths to work tree symlinks' '
+test_expect_success SYMLINKS 'prefix_path works with absolute paths to work tree symlinks' '
 	ln -s target symlink &&
 	test "$(test-path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
 '
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index e20c077..9c7adbd 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -36,7 +36,7 @@ test_expect_success 'ls-files -h in corrupt repository' '
 	test_i18ngrep "[Uu]sage: git ls-files " broken/usage
 '
 
-test_expect_failure SYMLINKS 'ls-files with absolute paths to symlinks' '
+test_expect_success SYMLINKS 'ls-files with absolute paths to symlinks' '
 	mkdir subs &&
 	ln -s nosuch link &&
 	ln -s ../nosuch subs/link &&
-- 
1.8.5.2
