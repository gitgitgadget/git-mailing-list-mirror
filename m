From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v3 3/4] setup: Add 'abspath_part_inside_repo' function
Date: Fri, 31 Jan 2014 21:22:48 +0100
Message-ID: <20140131202248.GD9731@mule>
References: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: richih@debian.org, gitster@pobox.com, tboegi@web.de,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 31 21:22:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9Kc6-0006LT-1r
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 21:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbaAaUWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 15:22:54 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:65403 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbaAaUWx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 15:22:53 -0500
Received: by mail-lb0-f172.google.com with SMTP id c11so3815344lbj.17
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 12:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ThiTEJAjx2APjGzCUYvBMwzkqDKkGaK9/O3nBaO9AcI=;
        b=Fh4H+C7XlcbXvxF4kpGFhOu+9b7aLVhzwSBqbZM4uJN193vJJKlK1s6fePDlv6fkKA
         oxtAF5JlBj++OFGfFq+Rl+yZnGt0qFDJ1T3NeAD+K0yMZsd1JK1MmPEZLq746QZKHXBg
         N8lZVzSiAvkqfuwzcGYdgp6+CcrRRW9XsV/Yq1itCaeSgDmXvvJtZi3FjpyZ9C5Gy43V
         Lhcrp9VFJiDRMhE3d5nXeKWHbklVUfp7dRDL0SSx9EB8A7ufOite2TZKorxEA/IO7bib
         /RDqXYl6dhK5MVpbZxEDsmjxnEiU4LFPOrWtIQDSbCmIuhE35E7QbdqJIt2LGd+LdAHE
         iSLw==
X-Received: by 10.112.151.42 with SMTP id un10mr14232801lbb.7.1391199772625;
        Fri, 31 Jan 2014 12:22:52 -0800 (PST)
Received: from mule (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id t5sm15744437lat.6.2014.01.31.12.22.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jan 2014 12:22:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241317>

In order to extract the part of an absolute path which lies inside the
repo, it is not possible to directly use real_path, since that would
dereference symlinks both outside and inside the work tree.

Add an 'abspath_part_inside_repo' function which incrementally checks
each path level by temporarily NUL-terminating at each '/' and comparing
against the work tree path. When a match is found, it copies the
remainder (which will be the in-repo part) to a destination
buffer.

The path being the filesystem root or exactly equal to the work tree are
special cases handled separately, since then there is no directory
separator between the work tree and in-repo part.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 cache.h |  1 +
 setup.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/cache.h b/cache.h
index ce377e1..242f27d 100644
--- a/cache.h
+++ b/cache.h
@@ -426,6 +426,7 @@ extern void verify_filename(const char *prefix,
 			    int diagnose_misspelt_rev);
 extern void verify_non_filename(const char *prefix, const char *name);
 extern int path_inside_repo(const char *prefix, const char *path);
+extern int abspath_part_inside_repo(char *dst, const char *path);
 
 #define INIT_DB_QUIET 0x0001
 
diff --git a/setup.c b/setup.c
index 5432a31..e606846 100644
--- a/setup.c
+++ b/setup.c
@@ -77,6 +77,69 @@ int path_inside_repo(const char *prefix, const char *path)
 	return 0;
 }
 
+/*
+ * It is ok if dst == src, but they should not overlap otherwise.
+ * No checking if the path is in fact an absolute path is done, and it must
+ * already be normalized.
+ *
+ * Find the part of an absolute path that lies inside the work tree by
+ * dereferencing symlinks outside the work tree, for example:
+ * /dir1/repo/dir2/file   (work tree is /dir1/repo)      -> dir2/file
+ * /dir/file              (work tree is /)               -> dir/file
+ * /dir/symlink1/symlink2 (symlink1 points to work tree) -> symlink2
+ * /dir/repo              (exactly equal to work tree)   -> (empty string)
+ */
+int abspath_part_inside_repo(char *dst, const char* src)
+{
+	size_t len;
+	char *dst0;
+	char temp;
+
+	const char* work_tree = get_git_work_tree();
+	if (!work_tree)
+		return -1;
+	len = strlen(src);
+	dst0 = dst;
+
+	// check root level
+	if (has_dos_drive_prefix(src)) {
+		*dst++ = *src++;
+		*dst++ = *src++;
+		*dst++ = *src++;
+	} else {
+		*dst++ = *src++;
+	}
+	temp = *dst;
+	*dst = '\0';
+	if (strcmp(real_path(dst0), work_tree) == 0) {
+		*dst = temp;
+		memmove(dst0, src, len - (dst - dst0) + 1);
+		return 0;
+	}
+	*dst = temp;
+
+	// check each level
+	while (*dst != '\0') {
+		*dst++ = *src++;
+		if (*dst == '/') {
+			*dst = '\0';
+			if (strcmp(real_path(dst0), work_tree) == 0) {
+				memmove(dst0, src + 1, len - (dst - dst0));
+				return 0;
+			}
+			*dst = '/';
+		}
+	}
+
+	// check whole path
+	if (strcmp(real_path(dst0), work_tree) == 0) {
+		*dst0 = '\0';
+		return 0;
+	}
+
+	return -1;
+}
+
 int check_filename(const char *prefix, const char *arg)
 {
 	const char *name;
-- 
1.8.5.2
