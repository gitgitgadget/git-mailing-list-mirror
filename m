From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v3 4/4] setup: Don't dereference in-tree symlinks for
 absolute paths
Date: Fri, 31 Jan 2014 21:23:13 +0100
Message-ID: <20140131202313.GE9731@mule>
References: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: richih@debian.org, gitster@pobox.com, tboegi@web.de,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 31 21:23:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9KcW-0006ce-RH
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 21:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbaAaUXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 15:23:21 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:64240 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbaAaUXU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 15:23:20 -0500
Received: by mail-la0-f54.google.com with SMTP id y1so3937206lam.27
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 12:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=emD1Nqo13v8pnBwiUido+qfFsYSOKMrL6uj1YL6EIy8=;
        b=ZKVnZcesSzS8jvLT6nJNeCa5HJn0NQgr05kLBuyYAoUqaNTK9QfOpWDui6ZsYUvcMV
         jPq8knG+/aDrPXTlSBWCEq2+ywPdlstC2RCPBY4wGx8S9FqxtAI6jal7Kcjdg9HqVIEv
         Ec2OEJ28u65kMMHIuHHughAiNIwuC6fRH066vMH2AzsEfEWfFi93TtkjaVfBvCJOsQB1
         lnGTg8FVP/rfAjfcXIjDsUBXEdEvswD1DPh9UEtdQoxDjLkcXgczgCtKx7K3AaF9Grla
         bPFTux+sHDGr3QExOUIeb4CK9zeFGKFh9ju6yhbjgjSxGnt7F9UM5aFuv2d9KQBUQUcJ
         CGFQ==
X-Received: by 10.152.9.65 with SMTP id x1mr14982567laa.6.1391199799008;
        Fri, 31 Jan 2014 12:23:19 -0800 (PST)
Received: from mule (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id gi5sm11386145lbc.4.2014.01.31.12.23.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jan 2014 12:23:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241318>

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
index e606846..2e65b48 100644
--- a/setup.c
+++ b/setup.c
@@ -22,11 +22,23 @@ char *prefix_path_gently(const char *prefix, int len,
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
+		if (abspath_part_inside_repo(npath, npath)) {
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
@@ -34,26 +46,10 @@ char *prefix_path_gently(const char *prefix, int len,
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
index b8e92e1..f6f378b 100755
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
