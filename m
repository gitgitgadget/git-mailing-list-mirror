From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v6 0/6] Handling of in-tree symlinks for absolute paths
Date: Tue,  4 Feb 2014 15:25:14 +0100
Message-ID: <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
References: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 15:28:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAgwX-0002GP-D3
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 15:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbaBDOZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 09:25:38 -0500
Received: from mail-ee0-f51.google.com ([74.125.83.51]:56010 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbaBDOZg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 09:25:36 -0500
Received: by mail-ee0-f51.google.com with SMTP id b57so4328770eek.24
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1oj7RkoK25ztwtxxo0fef+yjyeS67LmWbnd+ExaRIWE=;
        b=cqnIjR9KLXVl9EgvdEmv4iw4qXSKFu47WKhIuaFVPGy0nkfGvg2LKP1JKnoEXGNUXb
         Nr9dha6QsVT913SCDuI9Z+Ffns1wm2sRleQfuSndZro7as3BLfW3SSrweSp6veGteD7I
         uUEtLCNrfgpojLn2g94S+rDkL4Je/gLkR/QQiCmq/ehpJG+1pKxaGEQPLb00nXNY5vDO
         SUzMozg14f6mCoND7rPgroZkMx+nkuR39M/j+xsp+p9gvNnydz5aB32FB2scG+MMsg5G
         eudA/hCGFUJWosWcHI1xrjaLb6PpaUs9Ea/QdZSneMyY4QXlbVhzd9l9CH1Ri9qWzj+o
         +ePg==
X-Received: by 10.15.101.201 with SMTP id bp49mr2128010eeb.110.1391523935684;
        Tue, 04 Feb 2014 06:25:35 -0800 (PST)
Received: from localhost.localdomain ([194.150.18.52])
        by mx.google.com with ESMTPSA id u7sm89446218eep.11.2014.02.04.06.25.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Feb 2014 06:25:34 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241525>

The amount of tweaks seemed deserving of a reroll, so here it is:

* Added your test Junio, with what I figured was an appropriate commit
  message describing the user-visible effect (to git-add since I think it's the
  simplest to explain), the commit message for the second commit has been
  reduced somewhat, to not duplicate the message completely.

* Duplicated quite a bit of the explanation from this first commit into
  the last commit, in order to be more obvious about the issue it fixes, I'm
  not sure if it's a bit too much?

* Reworded the last commit to not mention the full-path special case, and
  replaced all occurences of in-repo with "inside work tree" or similar.

* Content-wise compared to 'pu' I've tweaked a few comments, un-inlined and
  added the wtlen <= len check (and the ls-files test is new of course):

diff --git a/setup.c b/setup.c
index 32a6f6b..ba08885 100644
--- a/setup.c
+++ b/setup.c
@@ -6,8 +6,8 @@ static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
 /*
- * No checking if the path is in fact an absolute path is done, and it must
- * already be normalized.
+ * The input parameter must contain an absolute path, and it must already be
+ * normalized.
  *
  * Find the part of an absolute path that lies inside the work tree by
  * dereferencing symlinks outside the work tree, for example:
@@ -17,7 +17,7 @@ static int inside_work_tree = -1;
  * /dir/repolink/file     (repolink points to /dir/repo) -> file
  * /dir/repo              (exactly equal to work tree)   -> (empty string)
  */
-static inline int abspath_part_inside_repo(char *path)
+static int abspath_part_inside_repo(char *path)
 {
 	size_t len;
 	size_t wtlen;
@@ -32,7 +32,7 @@ static inline int abspath_part_inside_repo(char *path)
 	off = 0;
 
 	/* check if work tree is already the prefix */
-	if (strncmp(path, work_tree, wtlen) == 0) {
+	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
 		if (path[wtlen] == '/') {
 			memmove(path, path + wtlen + 1, len - wtlen);
 			return 0;
@@ -47,7 +47,7 @@ static inline int abspath_part_inside_repo(char *path)
 	path0 = path;
 	path += offset_1st_component(path) + off;
 
-	/* check each level */
+	/* check each '/'-terminated level */
 	while (*path) {
 		path++;
 		if (*path == '/') {


Junio C Hamano (1):
  t3004: Add test for ls-files on symlinks via absolute paths

Martin Erik Werner (5):
  t0060: Add test for prefix_path on symlinks via absolute paths
  t0060: Add test for prefix_path when path == work tree
  t0060: Add tests for prefix_path when path begins with work tree
  setup: Add 'abspath_part_inside_repo' function
  setup: Don't dereference in-tree symlinks for absolute paths

 setup.c                   | 94 +++++++++++++++++++++++++++++++++++++----------
 t/t0060-path-utils.sh     | 21 +++++++++++
 t/t3004-ls-files-basic.sh | 17 +++++++++
 3 files changed, 112 insertions(+), 20 deletions(-)

-- 
1.8.5.2
