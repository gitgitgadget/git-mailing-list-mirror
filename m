From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v6 5/6] setup: Add 'abspath_part_inside_repo' function
Date: Tue,  4 Feb 2014 15:25:19 +0100
Message-ID: <1391523920-26946-6-git-send-email-martinerikwerner@gmail.com>
References: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
 <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 15:27:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAgwu-0002hc-FS
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 15:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbaBDOZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 09:25:57 -0500
Received: from mail-ee0-f49.google.com ([74.125.83.49]:43363 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbaBDOZs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 09:25:48 -0500
Received: by mail-ee0-f49.google.com with SMTP id d17so4318546eek.22
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 06:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3HZyQjF/zqKSWb5J2PBHRa+Ylrq3q4wkjnfsKjGc37U=;
        b=oFzd4QrDChQHCnMPtuAnoqzmpuwtBIYMLdEW2huprC9z2Iu4XlXeH1y+sDDibb+UBD
         wyusebAfjsokNJ/bYyYRZO/fF0WT6yXmjXw9AMywPaz5S9hYISTay2DuC2FYPByOPCRE
         PQyO3uxlfVUEcDEJ477Sz4jgZGBiXJev9QVlO92wQfbtgMySArP4nclkBe+75YQW6W5f
         odQMMFpmiVfu4opQAXYBPwYXWwlj9TrMCjaY9IKs4iaTk5rWaI6J7ohyN28W8yx9AZ9v
         29d7rgsAgFUJIGqCeFmZXSSa1Js2hiGIYysEGUK1UErGjGKGqvt/IBw7e+JtaWwTwrDq
         SXjg==
X-Received: by 10.14.69.200 with SMTP id n48mr15245236eed.54.1391523947733;
        Tue, 04 Feb 2014 06:25:47 -0800 (PST)
Received: from localhost.localdomain ([194.150.18.52])
        by mx.google.com with ESMTPSA id u7sm89446218eep.11.2014.02.04.06.25.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Feb 2014 06:25:47 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241524>

In order to extract the part of an absolute path which lies inside the
repo, it is not possible to directly use real_path, since that would
dereference symlinks both outside and inside the work tree.

Add an 'abspath_part_inside_repo' function which first checks if the
work tree is already the prefix, then incrementally checks each path
level by temporarily NUL-terminating at each '/' and comparing against
the work tree path. If a match is found, it overwrites the input path
with the remainder past the work tree (which will be the part inside the
work tree).

This function is currently only intended for use in
'prefix_path_gently'.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
Reviewed-by: Duy Nguyen <pclouds@gmail.com>
---
 setup.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/setup.c b/setup.c
index 5432a31..906c8e2 100644
--- a/setup.c
+++ b/setup.c
@@ -6,6 +6,70 @@ static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
 /*
+ * The input parameter must contain an absolute path, and it must already be
+ * normalized.
+ *
+ * Find the part of an absolute path that lies inside the work tree by
+ * dereferencing symlinks outside the work tree, for example:
+ * /dir1/repo/dir2/file   (work tree is /dir1/repo)      -> dir2/file
+ * /dir/file              (work tree is /)               -> dir/file
+ * /dir/symlink1/symlink2 (symlink1 points to work tree) -> symlink2
+ * /dir/repolink/file     (repolink points to /dir/repo) -> file
+ * /dir/repo              (exactly equal to work tree)   -> (empty string)
+ */
+static int abspath_part_inside_repo(char *path)
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
+	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
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
+	/* check each '/'-terminated level */
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
