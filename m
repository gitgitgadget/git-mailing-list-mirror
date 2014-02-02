From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v5 5/5] setup: Don't dereference in-tree symlinks for absolute paths
Date: Sun,  2 Feb 2014 17:35:40 +0100
Message-ID: <1391358940-17373-6-git-send-email-martinerikwerner@gmail.com>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 17:37:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA02a-0000DW-0d
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 17:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbaBBQgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 11:36:53 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:43082 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbaBBQgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 11:36:49 -0500
Received: by mail-lb0-f169.google.com with SMTP id q8so4808638lbi.0
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 08:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rCyoXNIpzM4H9G2OFzoUzNMwGhjJvKuIfMU5WuuKxMQ=;
        b=0qVKfwSiJYfGURTPAdZH63gYi0kGUNve+L6DZ0xFyk1YmHGJ7A1T358Yo5FSWQesfo
         JI+jf2EN2yc+ro4h+7QpuyKH/Wv9xZHeZlCeLsxm/KFId03XxDpqlWbjPTgOBiyrRtUN
         MloGiYuore9dUxf79hMBXRlPptKPRypcGyDuRV6If6BojzGUyR3KQCyy3crD7XCKpPld
         +H4k6smK28HQtXzF1rIDyM3AjgfUhn9be5szhlMvbOR5Z5Yvv1Vf+d0jIO9SHHohkO1e
         xulvQND86mP0lu2MM3NCuUV+kYnKzwmmY5XnTewyNHK8Ssi2oloYZ6a3ck+rakp815x+
         NNsg==
X-Received: by 10.112.136.36 with SMTP id px4mr1420661lbb.46.1391359008189;
        Sun, 02 Feb 2014 08:36:48 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id jl8sm18063514lbc.16.2014.02.02.08.36.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Feb 2014 08:36:47 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241376>

The 'prefix_path_gently' function currently applies real_path to
everything if given an absolute path, dereferencing symlinks both
outside and inside the work tree. In order to manipulate symlinks in the
work tree using absolute paths, symlinks should only be dereferenced
outside the work tree.

Modify the 'prefix_path_gently' to first normalize the path in order to
make sure path levels are separated by '/', then pass the result to
'abspath_part_inside_repo' to find the in-repo part (without dereferencing
any symlinks inside the work tree).

For absolute paths, 'prefix_path_gently' did not, nor does now do, any
actual prefixing, hence the result from 'abspath_part_in_repo' is
returned as-is.

Fixes t0060-82.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 setup.c               | 36 ++++++++++++++++--------------------
 t/t0060-path-utils.sh |  2 +-
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/setup.c b/setup.c
index a2e60ab..230505c 100644
--- a/setup.c
+++ b/setup.c
@@ -86,11 +86,23 @@ char *prefix_path_gently(const char *prefix, int len,
 	const char *orig = path;
 	char *sanitized;
 	if (is_absolute_path(orig)) {
-		const char *temp = real_path(path);
-		sanitized = xmalloc(len + strlen(temp) + 1);
-		strcpy(sanitized, temp);
+		char *npath;
+
+		npath = xmalloc(strlen(path) + 1);
 		if (remaining_prefix)
 			*remaining_prefix = 0;
+		if (normalize_path_copy_len(npath, path, remaining_prefix)) {
+			free(npath);
+			return NULL;
+		}
+		if (abspath_part_inside_repo(npath)) {
+			free(npath);
+			return NULL;
+		}
+
+		sanitized = xmalloc(strlen(npath) + 1);
+		strcpy(sanitized, npath);
+		free(npath);
 	} else {
 		sanitized = xmalloc(len + strlen(path) + 1);
 		if (len)
@@ -98,26 +110,10 @@ char *prefix_path_gently(const char *prefix, int len,
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
-- 
1.8.5.2
