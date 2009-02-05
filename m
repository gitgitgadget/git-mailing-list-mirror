From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] fix t1504 on Windows
Date: Thu, 05 Feb 2009 20:35:07 +0100
Message-ID: <498B3F6B.5080002@lsrfire.ath.cx>
References: <498A1E1E.8010901@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:37:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVA1w-0000th-EK
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 20:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759934AbZBETfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 14:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760749AbZBETfO
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 14:35:14 -0500
Received: from india601.server4you.de ([85.25.151.105]:58834 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760630AbZBETfK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 14:35:10 -0500
Received: from [10.0.1.101] (p57B7D5B1.dip.t-dialin.net [87.183.213.177])
	by india601.server4you.de (Postfix) with ESMTPSA id 5A0B42F8056;
	Thu,  5 Feb 2009 20:35:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <498A1E1E.8010901@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108602>

The test t1504 crashes on Windows due to a failed assertion in
normalize_absolute_path() because this function expects absolute paths to
start with a slash, while on Windows they can start with a drive letter
or a backslash.

As suggested by Johannes, fix it by using sanitary_path_copy() instead,
which can handle Windows-style paths just fine.  This patch just exports
it for usage; a later patch may move it from setup.c to path.c where it
fits better.

Secondly, use the portability macro PATH_SEP instead of expecting colons
to be used as path list delimiter.  On Windows, semicolons are used,
while colons separate drive letter and path.

Also change the test script to help bash recognize the path list variable
for test case "first_of_two" as needing path conversion.  git expects
Windows-style paths, which bash happily creates if we turn the second
path of the list into an absolute one.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 cache.h                 |    1 +
 path.c                  |   11 ++++++-----
 setup.c                 |    2 +-
 t/t1504-ceiling-dirs.sh |    2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 45e713e..eeb774a 100644
--- a/cache.h
+++ b/cache.h
@@ -626,6 +626,7 @@ const char *make_nonrelative_path(const char *path);
 const char *make_relative_path(const char *abs, const char *base);
 int normalize_absolute_path(char *buf, const char *path);
 int longest_ancestor_length(const char *path, const char *prefix_list);
+int sanitary_path_copy(char *dst, const char *src);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index a074aea..ea1913a 100644
--- a/path.c
+++ b/path.c
@@ -438,15 +438,16 @@ int longest_ancestor_length(const char *path, const char *prefix_list)
 		return -1;
 
 	for (colon = ceil = prefix_list; *colon; ceil = colon+1) {
-		for (colon = ceil; *colon && *colon != ':'; colon++);
+		for (colon = ceil; *colon && *colon != PATH_SEP; colon++);
 		len = colon - ceil;
 		if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
 			continue;
 		strlcpy(buf, ceil, len+1);
-		len = normalize_absolute_path(buf, buf);
-		/* Strip "trailing slashes" from "/". */
-		if (len == 1)
-			len = 0;
+		if (sanitary_path_copy(buf, buf) < 0)
+			continue;
+		len = strlen(buf);
+		if (buf[len - 1] == '/')
+			buf[--len] = '\0';
 
 		if (!strncmp(path, buf, len) &&
 		    path[len] == '/' &&
diff --git a/setup.c b/setup.c
index dfda532..4fe438c 100644
--- a/setup.c
+++ b/setup.c
@@ -4,7 +4,7 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
-static int sanitary_path_copy(char *dst, const char *src)
+int sanitary_path_copy(char *dst, const char *src)
 {
 	char *dst0;
 
diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index 91b704a..9c9c4c9 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -96,7 +96,7 @@ test_prefix subdir_ceil_at_subdi_slash "sub/dir/"
 GIT_CEILING_DIRECTORIES="foo:$TRASH_ROOT/sub"
 test_fail second_of_two
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub:bar"
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub:/bar"
 test_fail first_of_two
 
 GIT_CEILING_DIRECTORIES="foo:$TRASH_ROOT/sub:bar"
-- 
1.6.1.2
