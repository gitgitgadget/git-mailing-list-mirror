From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2 2/2] Handle relative paths in submodule .git files
Date: Fri,  8 Jan 2010 22:36:41 -0500
Message-ID: <1263008201-27429-3-git-send-email-brad.king@kitware.com>
References: <32541b131001081524g43d54a44i582dd286c1dfe7a5@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 04:36:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTS8C-0008Ik-M1
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 04:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab0AIDgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 22:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754502Ab0AIDgu
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 22:36:50 -0500
Received: from public.kitware.com ([66.194.253.19]:39433 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab0AIDgq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 22:36:46 -0500
Received: by public.kitware.com (Postfix, from userid 5001)
	id 6375E17EAE; Fri,  8 Jan 2010 22:27:32 -0500 (EST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on public.kitware.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id DEB7117EA7;
	Fri,  8 Jan 2010 22:27:31 -0500 (EST)
Received: by hythloth (Postfix, from userid 1000)
	id 33F16CFFE9; Fri,  8 Jan 2010 22:36:41 -0500 (EST)
X-Mailer: git-send-email 1.6.5
In-Reply-To: <32541b131001081524g43d54a44i582dd286c1dfe7a5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136513>

Commit 842abf06f36b5b31050db6406265972e3e1cc189 taught
resolve_gitlink_ref() to call read_gitfile_gently() to resolve .git
files.  In this commit teach read_gitfile_gently() to interpret a
relative path in a .git file with respect to the file location.

This change allows update-index to recognize a submodule that uses a
relative path in its .git file.  It previously failed because the
relative path was wrongly interpreted with respect to the superproject
directory.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 setup.c                         |   22 +++++++++++++++++++---
 t/t2104-update-index-gitfile.sh |    2 +-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 2cf0f19..f10e2dd 100644
--- a/setup.c
+++ b/setup.c
@@ -252,6 +252,8 @@ static int check_repository_format_gently(int *nongit_ok)
 const char *read_gitfile_gently(const char *path)
 {
 	char *buf;
+	char* dir;
+	const char *slash;
 	struct stat st;
 	int fd;
 	size_t len;
@@ -276,9 +278,23 @@ const char *read_gitfile_gently(const char *path)
 	if (len < 9)
 		die("No path in gitfile: %s", path);
 	buf[len] = '\0';
-	if (!is_git_directory(buf + 8))
-		die("Not a git repository: %s", buf + 8);
-	path = make_absolute_path(buf + 8);
+	dir = buf + 8;
+
+	if (!is_absolute_path(dir) && (slash = strrchr(path, '/'))) {
+		size_t pathlen = slash+1 - path;
+		size_t dirlen = pathlen + len - 8;
+		dir = xmalloc(dirlen + 1);
+		strncpy(dir, path, pathlen);
+		strncpy(dir + pathlen, buf + 8, len - 8);
+		dir[dirlen] = '\0';
+		free(buf);
+		buf = dir;
+	}
+
+	if (!is_git_directory(dir))
+		die("Not a git repository: %s", dir);
+	path = make_absolute_path(dir);
+
 	free(buf);
 	return path;
 }
diff --git a/t/t2104-update-index-gitfile.sh b/t/t2104-update-index-gitfile.sh
index ba71984..641607d 100755
--- a/t/t2104-update-index-gitfile.sh
+++ b/t/t2104-update-index-gitfile.sh
@@ -31,7 +31,7 @@ test_expect_success 'submodule with relative .git file' '
 	 test_commit first)
 '
 
-test_expect_failure 'add gitlink to relative .git file' '
+test_expect_success 'add gitlink to relative .git file' '
 	git update-index --add -- sub2
 '
 
-- 
1.6.5
