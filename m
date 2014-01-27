From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v2 2/2] setup: Don't dereference in-tree symlinks for absolute paths
Date: Mon, 27 Jan 2014 01:07:30 +0100
Message-ID: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
References: <52E5439D.7060002@web.de>
 <1390781250-20389-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, Martin Erik Werner <martinerikwerner@gmail.com>
To: tboegi@web.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 27 01:08:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7ZkY-0007k3-CM
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 01:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbaA0AIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 19:08:22 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:38617 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbaA0AIV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 19:08:21 -0500
Received: by mail-la0-f51.google.com with SMTP id c6so4048167lan.10
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 16:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nEZ1R1M7lDjd/QWVjRW5iMTkyStbZR3wKwpOX8zfUYA=;
        b=Fzdh3YpE1QXidDFYqI7w9+580dhDxNvFt82KXb9dSrlvoKPCOs+Juyf0td58HCW6DT
         uuuHbdKSn6QWQuIIaf9DN7MY2d7WG9fmNIQul17dCbra+IGnpCwtK4RLbm7RbaEh5X3P
         V238vwr+rZC6+UJALi1CxaBgYuV4zYYqyTNgNZV8gfyPQw0MQhoGhPTKfim9Taf52tnW
         kNL5PvnQhoTkBkmRCyz4TM7iOTWmnqZibJyA7TnU+r2n3s1F8CPiG05tlvfuec75M9PS
         KW7D/0QmvnCZmiX0Sd+SQh/Db970uy24sDRLOYM118lNwlLN2aTqRCCE2MQ0COWs7nGc
         YirQ==
X-Received: by 10.112.135.9 with SMTP id po9mr14947132lbb.8.1390781300356;
        Sun, 26 Jan 2014 16:08:20 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id mx3sm10067695lbc.14.2014.01.26.16.08.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jan 2014 16:08:19 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390781250-20389-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241120>

The prefix_path_gently() function currently applies real_path to
everything if given an absolute path, dereferencing symlinks both
outside and inside the work tree. In order to manipulate symliks in the
work tree using absolute paths, symlinks should only be dereferenced
outside the work tree.

Modify prefix_path_gently() to first normalize the path in order to
make sure path levels are separated by '/', then use this separator to
check the real path of each level of the path until it has found the
length that corresponds to the work tree.

For absolute paths, the function did not, nor does now do, any actual
prefixing, hence we simply remove the path corresponding to the work
tree and return the remaining in-tree part of the path.

Fixes t0060-82.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 setup.c               | 64 +++++++++++++++++++++++++++++++++++----------------
 t/t0060-path-utils.sh |  2 +-
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/setup.c b/setup.c
index 5432a31..0789a96 100644
--- a/setup.c
+++ b/setup.c
@@ -22,11 +22,51 @@ char *prefix_path_gently(const char *prefix, int len,
 	const char *orig = path;
 	char *sanitized;
 	if (is_absolute_path(orig)) {
-		const char *temp = real_path(path);
-		sanitized = xmalloc(len + strlen(temp) + 1);
-		strcpy(sanitized, temp);
+		int i, match;
+		size_t wtpartlen;
+		char *npath, *wtpart;
+		struct string_list list = STRING_LIST_INIT_DUP;
+		const char *work_tree = get_git_work_tree();
+		if (!work_tree)
+			return NULL;
+		npath = xmalloc(strlen(path) + 1);
 		if (remaining_prefix)
 			*remaining_prefix = 0;
+		if (normalize_path_copy_len(npath, path, remaining_prefix)) {
+			free(npath);
+			return NULL;
+		}
+
+		string_list_split(&list, npath, '/', -1);
+		wtpart = xmalloc(strlen(npath) + 1);
+		i = 0;
+		match = 0;
+		strcpy(wtpart, list.items[i++].string);
+		strcat(wtpart, "/");
+		if (strcmp(real_path(wtpart), work_tree) == 0) {
+			match = 1;
+		} else {
+			while (i < list.nr) {
+				strcat(wtpart, list.items[i++].string);
+				if (strcmp(real_path(wtpart), work_tree) == 0) {
+					match = 1;
+					break;
+				}
+				strcat(wtpart, "/");
+			}
+		}
+		string_list_clear(&list, 0);
+		if (!match) {
+			free(npath);
+			free(wtpart);
+			return NULL;
+		}
+
+		wtpartlen = strlen(wtpart);
+		sanitized = xmalloc(strlen(npath) - wtpartlen);
+		strcpy(sanitized, npath + wtpartlen + 1);
+		free(npath);
+		free(wtpart);
 	} else {
 		sanitized = xmalloc(len + strlen(path) + 1);
 		if (len)
@@ -34,26 +74,10 @@ char *prefix_path_gently(const char *prefix, int len,
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
index 3a0677a..03a12ac 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -190,7 +190,7 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
 '
 
-test_expect_failure SYMLINKS 'prefix_path works with work tree symlinks' '
+test_expect_success SYMLINKS 'prefix_path works with work tree symlinks' '
 
 	ln -s target symlink &&
 	test "$(test-path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
-- 
1.8.5.2
