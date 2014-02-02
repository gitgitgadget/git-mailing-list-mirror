From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v5 4/5] setup: Add 'abspath_part_inside_repo' function
Date: Sun,  2 Feb 2014 17:35:39 +0100
Message-ID: <1391358940-17373-5-git-send-email-martinerikwerner@gmail.com>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 17:37:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA02Y-0000DW-GE
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 17:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbaBBQgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 11:36:45 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42813 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbaBBQgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 11:36:43 -0500
Received: by mail-lb0-f174.google.com with SMTP id l4so4695773lbv.19
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 08:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NbIMqrLSleU/Yud64p4FLP9hJZJD/IgoSKCbOsTtXns=;
        b=f6kzRoy8tZtpgbIh8IVt8M9M2HsOz7i/SAnV0DaI5BFSAKTyESWMzZSW5uTJS/0wIu
         GFeiUZ75pDqJztUMfHNeXgH+m2eyjoEelcs4aeNm7Ty/+1skKIdS+BEyorsxtRD92DG0
         XhnjitQva5QVTRPR5HVHpApJpQ3OAuBGURmQmJMdXQ+kZY9CvBfqwgxHM39suIDYe6Hh
         p1Y+O7lZh2wD8psL4ztbd/CeeNOmVJgYfgGQKNaH2PGxN4CmHAKYAmQgwAqs/Ee2zycC
         Od2clvsFXzKrOmXV6ZE4gjxqtvr87zDJvNthWAo2U9YakYLF9hZCDQ1AjTdJiGKWmjUs
         aQbg==
X-Received: by 10.152.234.202 with SMTP id ug10mr10278102lac.28.1391359002530;
        Sun, 02 Feb 2014 08:36:42 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id jl8sm18063514lbc.16.2014.02.02.08.36.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Feb 2014 08:36:41 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241379>

In order to extract the part of an absolute path which lies inside the
repo, it is not possible to directly use real_path, since that would
dereference symlinks both outside and inside the work tree.

Add an 'abspath_part_inside_repo' function which first checks if the
work tree is already the prefix, then incrementally checks each path
level by temporarily NUL-terminating at each '/' and comparing against
the work tree path. If a match is found, it overwrites the input path
with the remainder past the work tree (which will be the in-repo part).

The path being exactly equal to the work tree is handled separately,
since then there is no directory separator between the work tree and
in-repo part.

This function is currently only intended for use in
'prefix_path_gently'.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 setup.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/setup.c b/setup.c
index 5432a31..a2e60ab 100644
--- a/setup.c
+++ b/setup.c
@@ -6,6 +6,70 @@ static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
 /*
+ * No checking if the path is in fact an absolute path is done, and it must
+ * already be normalized.
+ *
+ * Find the part of an absolute path that lies inside the work tree by
+ * dereferencing symlinks outside the work tree, for example:
+ * /dir1/repo/dir2/file   (work tree is /dir1/repo)      -> dir2/file
+ * /dir/file              (work tree is /)               -> dir/file
+ * /dir/symlink1/symlink2 (symlink1 points to work tree) -> symlink2
+ * /dir/repolink/file     (repolink points to /dir/repo) -> file
+ * /dir/repo              (exactly equal to work tree)   -> (empty string)
+ */
+static inline int abspath_part_inside_repo(char *path)
+{
+	size_t len;
+	size_t wtlen;
+	char *path0;
+	int off;
+
+	const char* work_tree = get_git_work_tree();
+	if (!work_tree)
+		return -1;
+	wtlen = strlen(work_tree);
+	len = strlen(path);
+	off = 0;
+
+	/* check if work tree is already the prefix */
+	if (strncmp(path, work_tree, wtlen) == 0) {
+		if (path[wtlen] == '/') {
+			memmove(path, path + wtlen + 1, len - wtlen);
+			return 0;
+		} else if (path[wtlen - 1] == '/' || path[wtlen] == '\0') {
+			/* work tree is the root, or the whole path */
+			memmove(path, path + wtlen, len - wtlen + 1);
+			return 0;
+		}
+		/* work tree might match beginning of a symlink to work tree */
+		off = wtlen;
+	}
+	path0 = path;
+	path += offset_1st_component(path) + off;
+
+	/* check each level */
+	while (*path) {
+		path++;
+		if (*path == '/') {
+			*path = '\0';
+			if (strcmp(real_path(path0), work_tree) == 0) {
+				memmove(path0, path + 1, len - (path - path0));
+				return 0;
+			}
+			*path = '/';
+		}
+	}
+
+	/* check whole path */
+	if (strcmp(real_path(path0), work_tree) == 0) {
+		*path0 = '\0';
+		return 0;
+	}
+
+	return -1;
+}
+
+/*
  * Normalize "path", prepending the "prefix" for relative paths. If
  * remaining_prefix is not NULL, return the actual prefix still
  * remains in the path. For example, prefix = sub1/sub2/ and path is
-- 
1.8.5.2
