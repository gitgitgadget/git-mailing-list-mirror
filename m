From: Brad King <brad.king@kitware.com>
Subject: [PATCH 2/2] Handle relative paths in submodule .git files
Date: Fri,  8 Jan 2010 17:36:48 -0500
Message-ID: <1262990208-15554-3-git-send-email-brad.king@kitware.com>
References: <1262990208-15554-1-git-send-email-brad.king@kitware.com>
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 23:46:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTNb5-0004Vk-8z
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 23:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab0AHWqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 17:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754123Ab0AHWqD
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 17:46:03 -0500
Received: from public.kitware.com ([66.194.253.19]:44064 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab0AHWp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 17:45:59 -0500
Received: by public.kitware.com (Postfix, from userid 5001)
	id 1F85D17DBA; Fri,  8 Jan 2010 17:27:38 -0500 (EST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on public.kitware.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id A10AF17DC0;
	Fri,  8 Jan 2010 17:27:37 -0500 (EST)
Received: by hythloth (Postfix, from userid 1000)
	id 9D23FD0030; Fri,  8 Jan 2010 17:36:48 -0500 (EST)
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1262990208-15554-1-git-send-email-brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136488>

Commit 842abf06f36b5b31050db6406265972e3e1cc189 taught
resolve_gitlink_ref() to call read_gitfile_gently() to resolve .git
files.  However, read_gitfile_gently() needs to chdir over to the
directory containing the .git file to resolve relative paths correctly.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 setup.c                         |   17 +++++++++++++++++
 t/t2104-update-index-gitfile.sh |    2 +-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 2cf0f19..a233e01 100644
--- a/setup.c
+++ b/setup.c
@@ -255,6 +255,8 @@ const char *read_gitfile_gently(const char *path)
 	struct stat st;
 	int fd;
 	size_t len;
+	char cwd[1024] = "";
+	const char *slash;
 
 	if (stat(path, &st))
 		return NULL;
@@ -276,9 +278,24 @@ const char *read_gitfile_gently(const char *path)
 	if (len < 9)
 		die("No path in gitfile: %s", path);
 	buf[len] = '\0';
+
+	slash = strrchr(path, '/');
+	if (slash) {
+		char *dir = xstrndup(path, slash - path);
+		if (!getcwd(cwd, sizeof(cwd)))
+			die_errno ("Could not get current working directory");
+		if (chdir(dir))
+			die_errno ("Could not switch to '%s'", dir);
+		free(dir);
+	}
+
 	if (!is_git_directory(buf + 8))
 		die("Not a git repository: %s", buf + 8);
 	path = make_absolute_path(buf + 8);
+
+	if (*cwd && chdir(cwd))
+		die_errno ("Could not change back to '%s'", cwd);
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
